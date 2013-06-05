source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")

typeNames <- vector()
typeCounters <- vector()
nQueries <- 0

#numero de queries modificadas
modifiedQueries <- 0
#vector que guarda, em cada posição, o numero de queries com diferença de n termos em relação à query anterior
numberTermsChanged <- vector()

#query overlap
queryOverlap <- rep(0,10)
dataFrame <- data.frame(x= numeric(0), y= integer(0))

state <- 0

processOverlap <- function(overlap){
  index <- 0
  if(overlap >= 0.1){
    index <- 1
    queryOverlap[index] <<- queryOverlap[index]+1
  } 
  if(overlap >= 0.2){
    index <- 2
    queryOverlap[index] <<- queryOverlap[index]+1
  } 
  if(overlap >= 0.3){
    index <- 3
    queryOverlap[index] <<- queryOverlap[index]+1
  }
  if(overlap >= 0.4){
    index <- 4
    queryOverlap[index] <<- queryOverlap[index]+1
  }
  if(overlap >= 0.5){
    index <- 5
    queryOverlap[index] <<- queryOverlap[index]+1
  }
  if(overlap >= 0.6){
    index <- 6
    queryOverlap[index] <<- queryOverlap[index]+1
  }
  if(overlap >= 0.7){
    index <- 7
    queryOverlap[index] <<- queryOverlap[index]+1
  }
  if(overlap >= 0.8){
    index <- 8
    queryOverlap[index] <<- queryOverlap[index]+1
  }
  if(overlap >= 0.9){
    index <- 9
    queryOverlap[index] <<- queryOverlap[index]+1
  }
  if(overlap == 1){
    index <- 10
    queryOverlap[index] <<- queryOverlap[index]+1
  }
}

parseString <- function(str){
  if(state == 0){
    if(str == "ModifiedLengthDiff"){
      state <<- 1
    } else {
      aLine <- strsplit(str,separator)
      sType <- aLine[[1]][1]
      iCounter <- as.integer(aLine[[1]][2])
      if(sType == "Modified"){
        modifiedQueries <<- iCounter
      }
      
      typeNames <<- append(typeNames,sType)
      typeCounters <<- append(typeCounters, iCounter)
      nQueries <<- nQueries + iCounter
    }
  } else if(state == 1) {
    if(str == "overlap"){
      state <<- 2
    } else {
      aLine <- strsplit(str,separator)
      numberTermsChanged <<- append(numberTermsChanged,as.integer(aLine[[1]][2]))
    }
  } else {
    currentOverlap <- as.numeric(str)
    processOverlap(currentOverlap)
  }
  
}

printToFile <- function(filename){
  write("QUERY TYPES", file=filename, append=FALSE)
  for(i in 1:length(typeNames)){
    write(paste(typeNames[i],paste(typeCounters[i],percent(typeCounters[i]/nQueries),sep=" -> "),sep=" -> "),
          file=filename, append=TRUE)
  }
  
  #modified terms
  write("NUMBER OF TERMS CHANGED PER MODIFIED QUERY", file=filename, append=TRUE)
  for(i in 1:length(numberTermsChanged)){
    write(paste(i-6,paste(numberTermsChanged[i],percent(numberTermsChanged[i]/modifiedQueries),sep=" -> "),sep=" -> "),
          
          file=filename, append=TRUE)
  }
  
  #query overlap
  write("QUERY OVERLAP",file=filename, append=TRUE)
  for(i in 1:length(queryOverlap)){
    write(paste(i,paste(queryOverlap[i],percent(queryOverlap[i]/modifiedQueries),sep=" - >"),sep=" -> "),file=filename,append=TRUE)
  }
  
}

drawGraphics <- function(){
  plot <- ggplot(data=dataFrame, aes(x=dataFrame[[1]], y=dataFrame[[2]]))
  plot <- plot + geom_line() + geom_point(shape=0, fill="white",size=3)
  plot <- plot + scale_x_continuous(breaks=c(0.10,0.20,0.30,0.40,0.50,0.60,0.70,0.80,0.90,1.00), labels=c(">=0.1",">=0.2",">=0.3",">=0.4",">=0.5",">=0.6",">=0.7",">=0.8",">=0.9","1"))
  plot <- plot + scale_y_continuous(breaks=c(0.2,0.4,0.6,0.8,1.0), 
                                    labels=c("20%","40%","60%","80%","100%"))
  plot <- plot + xlab("Similarity thresholds") + ylab("% of similar queries")
  ggsave(paste(graphicsPath,"QueryOverlap.pdf", sep = "/"))
}

main <- function(){
  print("Initiating QueryTypes.R")
  readFromStdin();
  filename <- paste(outputPath,"QueryTypes.txt", sep = "/")
  printToFile(filename)
  thresholds <- c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0)
  dataFrame <<- data.frame(thresholds, queryOverlap/modifiedQueries)
  print(dataFrame)
  drawGraphics()
}

main();