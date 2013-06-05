source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")

dataFrame <- data.frame(x= numeric(0), y= integer(0))

devices <- vector()

percentAllMobileQueries <- vector()
percentUniqueMobileQueries <- vector()

percentAllPCQueries <- vector()
percentUniquePCQueries <- vector()

allMobileQueriesCounter <- 0
uniqueMobileQueriesCounter <- 0

allPCQueriesCounter <- 0
uniquePCQueriesCounter <- 0

nTotalMobileQueries <- 0
nUniqueMobileQueries <- 0

nTotalPCQueries <- 0
nUniquePCQueries <- 0

i<-0
counter <-0
parseString <- function(str){
  aLine <- strsplit(str,separator)                           
 # print(counter)
 # counter <<- counter+1
  
  if(i==0){
    if(aLine[[1]][1] == "mobilequeries"){
      nTotalMobileQueries <<- as.integer(aLine[[1]][2])
      nUniqueMobileQueries <<- as.integer(aLine[[1]][3])
    }
    else {
      if(aLine[[1]][1] == "desktopqueries"){
        nTotalPCQueries <<- as.integer(aLine[[1]][2])
        nUniquePCQueries <<- as.integer(aLine[[1]][3])
        i <<- i+1
      } else {
        uniqueMobileQueriesCounter <<- uniqueMobileQueriesCounter+1
        percentUniqueMobileQueries <<- append(percentUniqueMobileQueries, as.numeric(rawPercent(uniqueMobileQueriesCounter/nUniqueMobileQueries)))
        allMobileQueriesCounter <<- allMobileQueriesCounter + as.integer(aLine[[1]][2])
        percentAllMobileQueries <<- append(percentAllMobileQueries, as.numeric(rawPercent(allMobileQueriesCounter/nTotalMobileQueries)))
        devices <<- append(devices, "Mobile")
        print(rawPercent(allMobileQueriesCounter/nTotalMobileQueries))
      }
    }
  } else {
    uniquePCQueriesCounter <<- uniquePCQueriesCounter+1
    percentUniquePCQueries <<- append(percentUniquePCQueries, as.numeric(rawPercent(uniquePCQueriesCounter/nUniquePCQueries)))
    allPCQueriesCounter <<- allPCQueriesCounter + as.integer(aLine[[1]][2])
    percentAllPCQueries <<- append(percentAllPCQueries, as.numeric(rawPercent(allPCQueriesCounter/nTotalPCQueries)))
    devices <<- append(devices, "Desktop")
    print(rawPercent(allPCQueriesCounter/nTotalPCQueries))
  }
}

drawGraphics <- function(){
  plot <- ggplot(data=dataFrame, aes(x=dataFrame[[1]], y=dataFrame[[2]], colour=dataFrame[[3]]))
  plot <- plot + geom_line(stat="identity")
  plot <- plot + scale_x_continuous(breaks=c(0.00,20.00,40.00,60.00,80.00,100.00), labels=c("0%", "20%","40%","60%","80%","100%"))
  plot <- plot + scale_y_continuous(breaks=c(0.00,20.00,40.00,60.00,80.00,100.00), labels=c("0%", "20%","40%","60%","80%","100%"))
  plot <- plot + xlab("% of unique queries") + ylab("% of all queries")
  plot <- plot + labs(colour="Categories") + theme(legend.position="top")
  ggsave(paste(graphicsPath,"MobilePCQueryDistribution.jpg", sep = "/"))
}

main <- function(){
  print("Initiating Query Distribution...")
  readFromStdin()
  #create data frame
  dataFrame <<- data.frame(c(percentUniqueMobileQueries,percentUniquePCQueries), 
                           c(percentAllMobileQueries,percentAllPCQueries),
                           devices)
  #dataFrame <<- data.frame(c(10,20,30,40,50,60,70,80,90,100,
 #                            10,20,30,40,50,60,70,80,90,100),
  #                         c(10,20,30,40,50,60,70,80,90,100,
  #                           10.34,20.2,30.4,40.6,50,55,76,83,99,100),
  #                         c("Mobile","Mobile","Mobile","Mobile","Mobile","Mobile","Mobile","Mobile","Mobile","Mobile",
  #                           "Desktop","Desktop","Desktop","Desktop","Desktop","Desktop","Desktop","Desktop","Desktop","Desktop"))
 #  print(dataFrame)
  drawGraphics()
}

main();