source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")

#query overlap
tabletQueryOverlap <- rep(0,10)
tabletModifiedQueries <- 0

smartphoneQueryOverlap <- rep(0,10)
smartphoneModifiedQueries <- 0

cellphoneQueryOverlap <- rep(0,10)
cellphoneModifiedQueries <- 0

dataFrame <- data.frame(x= numeric(0), y= integer(0))

i <- 0

processTabletOverlap <- function(overlap){
  index <- 0
  if(overlap >= 0.1){
    index <- 1
    tabletQueryOverlap[index] <<- tabletQueryOverlap[index]+1
  } 
  if(overlap >= 0.2){
    index <- 2
    tabletQueryOverlap[index] <<- tabletQueryOverlap[index]+1
  } 
  if(overlap >= 0.3){
    index <- 3
    tabletQueryOverlap[index] <<- tabletQueryOverlap[index]+1
  }
  if(overlap >= 0.4){
    index <- 4
    tabletQueryOverlap[index] <<- tabletQueryOverlap[index]+1
  }
  if(overlap >= 0.5){
    index <- 5
    tabletQueryOverlap[index] <<- tabletQueryOverlap[index]+1
  }
  if(overlap >= 0.6){
    index <- 6
    tabletQueryOverlap[index] <<- tabletQueryOverlap[index]+1
  }
  if(overlap >= 0.7){
    index <- 7
    tabletQueryOverlap[index] <<- tabletQueryOverlap[index]+1
  }
  if(overlap >= 0.8){
    index <- 8
    tabletQueryOverlap[index] <<- tabletQueryOverlap[index]+1
  }
  if(overlap >= 0.9){
    index <- 9
    tabletQueryOverlap[index] <<- tabletQueryOverlap[index]+1
  }
  if(overlap == 1){
    index <- 10
    tabletQueryOverlap[index] <<- tabletQueryOverlap[index]+1
  }
}

processSmartphoneOverlap <- function(overlap){
  index <- 0
  if(overlap >= 0.1){
    index <- 1
    smartphoneQueryOverlap[index] <<- smartphoneQueryOverlap[index]+1
  } 
  if(overlap >= 0.2){
    index <- 2
    smartphoneQueryOverlap[index] <<- smartphoneQueryOverlap[index]+1
  } 
  if(overlap >= 0.3){
    index <- 3
    smartphoneQueryOverlap[index] <<- smartphoneQueryOverlap[index]+1
  }
  if(overlap >= 0.4){
    index <- 4
    smartphoneQueryOverlap[index] <<- smartphoneQueryOverlap[index]+1
  }
  if(overlap >= 0.5){
    index <- 5
    smartphoneQueryOverlap[index] <<- smartphoneQueryOverlap[index]+1
  }
  if(overlap >= 0.6){
    index <- 6
    smartphoneQueryOverlap[index] <<- smartphoneQueryOverlap[index]+1
  }
  if(overlap >= 0.7){
    index <- 7
    smartphoneQueryOverlap[index] <<- smartphoneQueryOverlap[index]+1
  }
  if(overlap >= 0.8){
    index <- 8
    smartphoneQueryOverlap[index] <<- smartphoneQueryOverlap[index]+1
  }
  if(overlap >= 0.9){
    index <- 9
    smartphoneQueryOverlap[index] <<- smartphoneQueryOverlap[index]+1
  }
  if(overlap == 1){
    index <- 10
    smartphoneQueryOverlap[index] <<- smartphoneQueryOverlap[index]+1
  }
}

processCellphoneOverlap <- function(overlap){
  index <- 0
  if(overlap >= 0.1){
    index <- 1
    cellphoneQueryOverlap[index] <<- cellphoneQueryOverlap[index]+1
  } 
  if(overlap >= 0.2){
    index <- 2
    cellphoneQueryOverlap[index] <<- cellphoneQueryOverlap[index]+1
  } 
  if(overlap >= 0.3){
    index <- 3
    cellphoneQueryOverlap[index] <<- cellphoneQueryOverlap[index]+1
  }
  if(overlap >= 0.4){
    index <- 4
    cellphoneQueryOverlap[index] <<- cellphoneQueryOverlap[index]+1
  }
  if(overlap >= 0.5){
    index <- 5
    cellphoneQueryOverlap[index] <<- cellphoneQueryOverlap[index]+1
  }
  if(overlap >= 0.6){
    index <- 6
    cellphoneQueryOverlap[index] <<- cellphoneQueryOverlap[index]+1
  }
  if(overlap >= 0.7){
    index <- 7
    cellphoneQueryOverlap[index] <<- cellphoneQueryOverlap[index]+1
  }
  if(overlap >= 0.8){
    index <- 8
    cellphoneQueryOverlap[index] <<- cellphoneQueryOverlap[index]+1
  }
  if(overlap >= 0.9){
    index <- 9
    cellphoneQueryOverlap[index] <<- cellphoneQueryOverlap[index]+1
  }
  if(overlap == 1){
    index <- 10
    cellphoneQueryOverlap[index] <<- cellphoneQueryOverlap[index]+1
  }
}

parseString <- function(str){
  if(i == 0){
    if(str == "smartphone"){
      i <<- i+1
    } 
    else {
      currentOverlap <- as.numeric(str)
      processTabletOverlap(currentOverlap)
      tabletModifiedQueries <<- tabletModifiedQueries+1
    }
  } else if(i == 1){
    if(str == "cellphone"){
      i <<- i+2
    } else {
      currentOverlap <- as.numeric(str)
      processSmartphoneOverlap(currentOverlap)
      smartphoneModifiedQueries <<- smartphoneModifiedQueries+1
    }
  } else {
    currentOverlap <- as.numeric(str)
    processCellphoneOverlap(currentOverlap)
    cellphoneModifiedQueries <<- cellphoneModifiedQueries+1
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
  print("Initiating DevicesQueryOverlap.R")
  readFromStdin();
  
  thresholds <- c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0)
  dataFrame <<- data.frame(c(thresholds,thresholds,thresholds), 
                           c(tabletQueryOverlap/tabletModifiedQueries, smartphoneQueryOverlap/smartphoneModifiedQueries, cellphoneQueryOverlap/cellphoneModifiedQueries),
                           c("Tablet","Tablet","Tablet","Tablet","Tablet","Tablet","Tablet","Tablet","Tablet","Tablet",
                             "Smartphone","Smartphone","Smartphone","Smartphone","Smartphone","Smartphone","Smartphone","Smartphone","Smartphone","Smartphone",
                             "Traditional","Traditional","Traditional","Traditional","Traditional","Traditional","Traditional","Traditional","Traditional","Traditional"))
  drawGraphics()
}

main()