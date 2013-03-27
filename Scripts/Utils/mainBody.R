library(lubridate)
library(ggplot2)

percent <- function(x, digits = 2, format = "f", ...)
{
  paste(formatC(100 * x, format = format, digits = digits, ...), "%", sep = "")
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
      removeNewline <- gsub("\n","",next_line)
      parseString(removeNewline)
    }
  }
}