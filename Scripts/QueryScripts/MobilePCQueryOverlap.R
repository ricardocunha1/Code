source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")

#query overlap
mobileQueryOverlap <- rep(0,10)
mobileModifiedQueries <- 0

pcQueryOverlap <- rep(0,10)
pcModifiedQueries <- 0
dataFrame <- data.frame(x= numeric(0), y= integer(0))

i <- 0

processMobileOverlap <- function(overlap){
  index <- 0
  if(overlap >= 0.1){
    index <- 1
    mobileQueryOverlap[index] <<- mobileQueryOverlap[index]+1
  } 
  if(overlap >= 0.2){
    index <- 2
    mobileQueryOverlap[index] <<- mobileQueryOverlap[index]+1
  } 
  if(overlap >= 0.3){
    index <- 3
    mobileQueryOverlap[index] <<- mobileQueryOverlap[index]+1
  }
  if(overlap >= 0.4){
    index <- 4
    mobileQueryOverlap[index] <<- mobileQueryOverlap[index]+1
  }
  if(overlap >= 0.5){
    index <- 5
    mobileQueryOverlap[index] <<- mobileQueryOverlap[index]+1
  }
  if(overlap >= 0.6){
    index <- 6
    mobileQueryOverlap[index] <<- mobileQueryOverlap[index]+1
  }
  if(overlap >= 0.7){
    index <- 7
    mobileQueryOverlap[index] <<- mobileQueryOverlap[index]+1
  }
  if(overlap >= 0.8){
    index <- 8
    mobileQueryOverlap[index] <<- mobileQueryOverlap[index]+1
  }
  if(overlap >= 0.9){
    index <- 9
    mobileQueryOverlap[index] <<- mobileQueryOverlap[index]+1
  }
  if(overlap == 1){
    index <- 10
    mobileQueryOverlap[index] <<- mobileQueryOverlap[index]+1
  }
}

processDesktopOverlap <- function(overlap){
  index <- 0
  if(overlap >= 0.1){
    index <- 1
    pcQueryOverlap[index] <<- pcQueryOverlap[index]+1
  } 
  if(overlap >= 0.2){
    index <- 2
    pcQueryOverlap[index] <<- pcQueryOverlap[index]+1
  } 
  if(overlap >= 0.3){
    index <- 3
    pcQueryOverlap[index] <<- pcQueryOverlap[index]+1
  }
  if(overlap >= 0.4){
    index <- 4
    pcQueryOverlap[index] <<- pcQueryOverlap[index]+1
  }
  if(overlap >= 0.5){
    index <- 5
    pcQueryOverlap[index] <<- pcQueryOverlap[index]+1
  }
  if(overlap >= 0.6){
    index <- 6
    pcQueryOverlap[index] <<- pcQueryOverlap[index]+1
  }
  if(overlap >= 0.7){
    index <- 7
    pcQueryOverlap[index] <<- pcQueryOverlap[index]+1
  }
  if(overlap >= 0.8){
    index <- 8
    pcQueryOverlap[index] <<- pcQueryOverlap[index]+1
  }
  if(overlap >= 0.9){
    index <- 9
    pcQueryOverlap[index] <<- pcQueryOverlap[index]+1
  }
  if(overlap == 1){
    index <- 10
    pcQueryOverlap[index] <<- pcQueryOverlap[index]+1
  }
}

parseString <- function(str){
  if(i == 0){
    if(str == "desktop"){
      i <<- i+1
    } else {
      currentOverlap <- as.numeric(str)
      processMobileOverlap(currentOverlap)
      mobileModifiedQueries <<- mobileModifiedQueries+1
    }
  } else {
    currentOverlap <- as.numeric(str)
    processDesktopOverlap(currentOverlap)
    pcModifiedQueries <<- pcModifiedQueries+1
  }
}

drawGraphics <- function(){
  plot <- ggplot(data=dataFrame, aes(x=dataFrame[[1]], y=dataFrame[[2]], colour=dataFrame[[3]]))
  plot <- plot + geom_line() + geom_point(shape=0, fill="white",size=3)
  plot <- plot + scale_x_continuous(breaks=c(0.10,0.20,0.30,0.40,0.50,0.60,0.70,0.80,0.90,1.00), labels=c(">=0.1",">=0.2",">=0.3",">=0.4",">=0.5",">=0.6",">=0.7",">=0.8",">=0.9","1"))
  plot <- plot + scale_y_continuous(breaks=c(0.2,0.4,0.6,0.8,1.0), 
                                    labels=c("20%","40%","60%","80%","100%"))
  plot <- plot + xlab("Similarity thresholds") + ylab("% of similar queries")
  plot <- plot + labs(colour="Categories") + theme(legend.position="top")
  ggsave(paste(graphicsPath,"QueryOverlap.jpg", sep = "/"))
}

main <- function(){
  print("Initiating MobilePCQueryOverlap.R")
  readFromStdin();
  
  thresholds <- c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0)
  dataFrame <<- data.frame(c(thresholds,thresholds), 
                           c(mobileQueryOverlap/mobileModifiedQueries, pcQueryOverlap/pcModifiedQueries),
                           c("Mobile","Mobile","Mobile","Mobile","Mobile","Mobile","Mobile","Mobile","Mobile","Mobile",
                             "Desktop","Desktop","Desktop","Desktop","Desktop","Desktop","Desktop","Desktop","Desktop","Desktop"))
  drawGraphics()
}

main()