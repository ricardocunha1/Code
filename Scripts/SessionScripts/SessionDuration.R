source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")

numberSessions <- 0
sessionIntervals <- vector()
numberSessionsPerInterval<- vector()

#vector que guarda todas as horas e minutos de duração das sessoes (para média)
minutes <- vector()
seconds <- vector()

state <- 0


parseString <- function(str){
  if(state == 0){
    if(str == "intervals"){
      state <<- 1
    } else {
      aTime <- strsplit(str, separator)
      minutes <<- append(minutes, as.integer(aTime[[1]][1]))
      seconds <<- append(seconds, as.integer(aTime[[1]][2]))
    }
  } else {
    aInterval <- strsplit(str, separator)
    sessionIntervals <<- append(sessionIntervals, aInterval[[1]][1])
    numberSessionsPerInterval <<- append(numberSessionsPerInterval, as.integer(aInterval[[1]][2]))
    numberSessions <<- numberSessions + as.integer(aInterval[[1]][2])
  }

}

getDurationMean <- function(){
  #divide minutes by 60
  seconds <<- seconds/60
  #add hours and minutes all together
  total <- 0.00
  for(i in 1:length(minutes)){
    total <- total + minutes[i] + as.numeric(formatC(seconds[i]%%1, format = "f", digits = 2))
  }
  
  #divide by total number of sessions
  total <- as.numeric(formatC(total/length(minutes),format="f",digits=2))
  
  #multiply the decimal by 60
  decimal <- total%%1*60
  #divide by 100 to return to decimal form
  decimal <- as.numeric(formatC(decimal/100, format="f",digits=2))
  #add the new decimal form to the integer part
  total <- as.integer(total) + decimal
  
  return(total)
  
  
}

printToFile <- function(filename){
  for(i in 1:length(sessionIntervals)){
    if(i == 1) appendVar <- FALSE else appendVar <- TRUE
    write(paste(sessionIntervals[i],paste(numberSessionsPerInterval[i],percent(numberSessionsPerInterval[i]/numberSessions),sep=" -> "), sep=" -> "),
          file=filename, append=appendVar)
  }
  
  #sessiong duration mean
  mean <- getDurationMean()
  write(paste("MEAN SESSION DURATION",mean,sep=":"),file=filename, append=TRUE)
}

main <- function(){
  readFromStdin()
  filename <- paste(outputPath,"SessionDuration.txt", sep = "/")
  printToFile(filename)
}

main();
