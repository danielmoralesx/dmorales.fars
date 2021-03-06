% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fars_functions.R
\name{fars_read}
\alias{fars_read}
\title{Read FARS data into data frame}
\usage{
fars_read(filename)
}
\arguments{
\item{filename}{A string indicating the path to the wanted file}
}
\value{
A data frame with the data from the file. If file is not found,
returns an error.
}
\description{
Read downloaded data from US National Highway Traffic Safety Administration's
Fatality Analysis Reporting System into a data frame, with header and correct
formats for each column.
}
\examples{
\dontrun{
accident_2013 <- fars_read("data/accident_2013.csv.bz2")
}

}
