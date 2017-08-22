## Coursera's Building R Packages - Final Project

The releasing of this package is the final project for Coursera's 
Building R Packages course. The functions are for treatment and analysis of
data from US National Highway Traffic Safety Administration's Fatality 
Analysis Reporting System, and were documented in a previous assessment.

The original file with the functions can be downloaded [here](https://d3c33hcgiwev3.cloudfront.net/_d4d3eb5980180587403780aa36de9f2c_fars_functions.R?Expires=1503532800&Signature=HEAN4kO65sTiH5GUbCw9YR8Rm8jD3L-q3t3eS6oCHkaBQMKGBsdqkGE-VKjdj33N4AkeM85KhxWKFwe6WWmE1iIxlWS-JYcXC01XNQM0mrZ9N4DPuIdFnRn4Kxn~7pnhYfVe9NPeoDPT3WqbVj-PwJ-vb3SEfr~Z5usfvxjEp6c_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A) and some data examples are
[here](https://d3c33hcgiwev3.cloudfront.net/_e1adac2a5f05192dc8780f3944feec13_fars_data.zip?Expires=1503532800&Signature=Oc7pvDbWSGHdyhp1HhRmZCS5~3MS0v~lYLQfwASQM4y-4gIFXa7oT6ZgPgV-rvJlPVvhJ1bOPUBvtUOU7K3JlHZGsxKalTGQIqzFTsDKKvwKHGfyCWCN7DV78jzpeBjHF~1ACXk1rCSuCYfjfXf7QuL4dMDimHRC1GBEZbvGFQA_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A).

Now you will find the instructions for the assessment.

### Instructions

The purpose of this assessment is for you to combine your skills of creating, writing, documenting, and testing an R package with releasing that package on GitHub. In this assessment you'll be taking the R files from Week 2's assessment about documentation and putting that file in an R package.

For this assessment you must

1. write a vignette to include in your package using knitr and R Markdown
2. write at least one test written using testthat
3. put your package on GitHub
4. set up the repository so that the package can be checked and built on Travis
5. Once your package has built on Travis and the build is passing with no errors, warnings, or notes you should add your Travis badge to the README.md file of your package repository.

### Review criteria 
For this assignment you'll submit a link to the GitHub repository which contains your package. This assessment will ask reviewers the following questions:

1. Does this package contain the correct R file(s) under the R/ directory?
2. Does this package contain a man/ directory with corresponding documentation files?
3. Does this package contain a vignette which provides a meaningful description of the package and how it should be used?
4. Does this package have at least one test included in the tests/ directory?
5. Does this package have a NAMESPACE file?
6. Does the README.md file for this directory have a Travis badge?
7. Is the build of this package passing on Travis?
8. Are the build logs for this package on Travis free of any errors, warnings, or notes?
