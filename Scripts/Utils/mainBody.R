library(lubridate)
library(ggplot2)

separator <- ">>>"
outputPath <- "/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/OutputFiles"
graphicsPath <- "/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Graphics"

percent <- function(x, digits = 2, format = "f", ...)
{
  paste(formatC(100 * x, format = format, digits = digits, ...), "%", sep = "")
}

rawPercent <- function(x, digits=2, format="f",...){
  return(formatC(100*x, format=format, digits=digits,...))
}

readFromStdin <- function(){
  stop = FALSE
  f <- file("stdin")
  open(f)
  while(!stop) {
    next_line = readLines(f, n = 1)
    ## Insert some if statement logic here
    if(length(next_line) == 0) {
      stop = TRUE
      close(f)
    } else {
      next_line <- gsub("\n","",next_line)
      next_line <- gsub("\xe3","a",next_line)
      next_line <- gsub("\xe7","c",next_line)
      next_line <- gsub("?","",next_line)
      parseString(next_line)
    }
  }
}