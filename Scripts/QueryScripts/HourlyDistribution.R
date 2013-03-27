source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")

hours <- 0:23
queryCounter <- rep(0,24)
dataFrame <- data.frame(x= numeric(0), y= integer(0))

parseString <- function(str){
  aQuery <- strsplit(str, ">>>")
  sDate <- aQuery[[1]][1]
  oDate <- ymd_hms(sDate);
  
  #add to the vectors
  iIndex <- hour(oDate) + 1
  queryCounter[iIndex] <<- queryCounter[iIndex] + 1
}



#draw graphics
drawGraphics <- function(){
  plot <- ggplot(data=dataFrame, aes(x=dataFrame[[1]], y=dataFrame[[2]], group=1))
  plot <- plot + geom_line() + geom_point()
  plot <- plot + scale_x_continuous(breaks=c(0,4,8,12,16,20,23))
  plot <- plot + geom_hline(yintercept=mean(dataFrame[[2]]), colour="blue")
  plot <- plot + xlab("Hours of the day") + ylab("Number of queries per hour")
  ggsave("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Graphics/HourlyDistribution.pdf")
}

main <- function(){
  readFromStdin()
  #create data frame
  dataFrame <<- data.frame(hours, queryCounter)
  print(dataFrame)
  drawGraphics()
}

main()
