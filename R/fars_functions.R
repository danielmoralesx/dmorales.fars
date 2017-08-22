#' Read FARS data into data frame
#'
#' Read downloaded data from US National Highway Traffic Safety Administration's
#' Fatality Analysis Reporting System into a data frame, with header and correct
#' formats for each column.
#'
#' @param filename A string indicating the path to the wanted file
#'
#' @return A data frame with the data from the file. If file is not found,
#' returns an error.
#'
#' @importFrom readr read_csv
#' @importFrom dplyr tbl_df
#'
#' @examples
#' \dontrun{
#' accident_2013 <- fars_read("data/accident_2013.csv.bz2")
#' }
#'
#' @export
fars_read <- function(filename) {
        if(!file.exists(filename))
                stop("file '", filename, "' does not exist")
        data <- suppressMessages({
                readr::read_csv(filename, progress = FALSE)
        })
        dplyr::tbl_df(data)
}

#' FARS filename
#'
#' Get the standard filename format for data from US National Highway Traffic
#' Safety Administration's Fatality Analysis Reporting System, with the
#' according year.
#'
#' @param year Wanted year in the format yyyy (four digits). Will be coerced to
#' integer.
#'
#' @return A string ready with the filename to be used as input to
#' \code{fars_read}.
#'
#' @examples
#' accident_2014 <- make_filename(make_filename(2014))
#'
#' @export
make_filename <- function(year) {
        year <- as.integer(year)
        sprintf("accident_%d.csv.bz2", year)
}

#' Read FARS data into list of months
#'
#' Read downloaded data from US National Highway Traffic Safety Administration's
#' Fatality Analysis Reporting System into a list of months available per year.
#'
#' @param years A list of wanted years in the format yyyy (four digits)
#'
#' @return A list of data frames, with one entry per year. Each data frame has a
#' column with the month of each row from the original file and a column year.
#'
#' If the file for a year is not found, a warning will be issued, and the
#' corresponding entry in the list is set to NULL.
#'
#' @importFrom dplyr mutate
#' @importFrom magrittr %>%
#'
#' @examples
#' \dontrun{
#' fars_read_years(2013:2016)
#' }
#'
#' @export
fars_read_years <- function(years) {
        MONTH <- NULL # Avoiding notes from devtools::check()
        lapply(years, function(year) {
                file <- make_filename(year)
                tryCatch({
                        dat <- fars_read(file)
                        dplyr::mutate(dat, year = year) %>%
                                dplyr::select(MONTH, year)
                }, error = function(e) {
                        warning("invalid year: ", year)
                        return(NULL)
                })
        })
}

#' FARS data number of entries per year and month
#'
#' Read downloaded data from US National Highway Traffic Safety Administration's
#' Fatality Analysis Reporting System and delivers a summary with number of
#' entries per year and month.
#'
#' @param years A list of wanted years in the format yyyy (four digits)
#'
#' @return A data frame, with the number of entries for the matching year
#' (columns) and month (rows).
#'
#' If the file for a year is not found, a warning will be issued and there will
#' be no column for the year.
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr bind_rows
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom tidyr spread
#'
#' @examples
#' \dontrun{
#' fars_summarize_years(2012:2015)
#' }
#'
#' @export
fars_summarize_years <- function(years) {
        year <- NULL  # Avoiding notes from devtools::check()
        MONTH <- NULL # Avoiding notes from devtools::check()
        n <- NULL     # Avoiding notes from devtools::check()
        dat_list <- fars_read_years(years)
        dplyr::bind_rows(dat_list) %>%
                dplyr::group_by(year, MONTH) %>%
                dplyr::summarize(n = n()) %>%
                tidyr::spread(year, n)
}

#' Map FARS accidents in a state
#'
#' Plot the state's map with dots locating the year's accidents.
#'
#' @param state.num Code for the wanted state
#' @param year Wanted year in the format yyyy (four digits)
#'
#' @return A plot of the state with dots locating each accident.
#'
#' Errors are issued for invalid state numbers. A message is issued when there
#' are no accidents to plot.
#'
#' @importFrom dplyr filter
#' @importFrom tidyr spread
#' @importFrom maps map
#' @importFrom graphics points
#'
#' @examples
#' \dontrun{
#' fars_map_state(1, 2015)
#' }
#'
#' @export
fars_map_state <- function(state.num, year) {
        STATE <- NULL # Avoiding notes from devtools::check()
        filename <- make_filename(year)
        data <- fars_read(filename)
        state.num <- as.integer(state.num)

        if(!(state.num %in% unique(data$STATE)))
                stop("invalid STATE number: ", state.num)
        data.sub <- dplyr::filter(data, STATE == state.num)
        if(nrow(data.sub) == 0L) {
                message("no accidents to plot")
                return(invisible(NULL))
        }
        is.na(data.sub$LONGITUD) <- data.sub$LONGITUD > 900
        is.na(data.sub$LATITUDE) <- data.sub$LATITUDE > 90
        with(data.sub, {
                maps::map("state", ylim = range(LATITUDE, na.rm = TRUE),
                          xlim = range(LONGITUD, na.rm = TRUE))
                graphics::points(LONGITUD, LATITUDE, pch = 46)
        })
}
