source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")

desktopPercentQueries <- vector()
mobilePercentQueries <- vector()

dataFrame <- data.frame(x= numeric(0), y= integer(0))

desktopTop1000unique <- 0
nDesktopQueries <- 0

mobileTop1000unique <- 0
nMobileQueries <- 0

state <- 0

parseString <- function(str){
  if(state == 0){
    aLine <- strsplit(str,separator)
    nDesktopQueries <<- as.integer(aLine[[1]][1])
    nMobileQueries <<- as.integer(aLine[[1]][2])
    state <<- 1
  } else if(state == 1){
    #desktop queries
    if(str == "mobile"){
      state <<- 2
    } else {
      aLine <- strsplit(str,separator)
      desktopTop1000unique <<- desktopTop1000unique + as.integer(aLine[[1]][2])
      desktopPercentQueries <<- append(desktopPercentQueries, as.numeric(rawPercent(desktopTop1000unique/nDesktopQueries)))
    }
  } else {
    #mobile queries
    aLine <- strsplit(str,separator)
    mobileTop1000unique <<- mobileTop1000unique + as.integer(aLine[[1]][2])
    mobilePercentQueries <<- append(mobilePercentQueries, as.numeric(rawPercent(mobileTop1000unique/nMobileQueries)))
  }
}

drawGraphics <- function(){
  plot <- ggplot(data=dataFrame, aes(x=dataFrame[[1]], y=dataFrame[[2]], colour=dataFrame[[3]]))
  plot <- plot + geom_line(stat="identity")
  plot <- plot + scale_x_continuous(breaks=c(100,200,300,400,500,600,700,800,900,1000))
  plot <- plot + scale_y_continuous(breaks=c(0.00,10.00,20.00,30.00,40.00,50.00), labels=c("0%", "10%","20%","30%","40%","50%"))
  plot <- plot + xlab("Query rank") + ylab("% of all queries")
  plot <- plot + labs(colour="Categories") + theme(legend.position="top")
  ggsave(paste(graphicsPath,"MobilePC1000unique.jpg", sep = "/"))
}

main <- function(){
  print("Initiating MobilePC1000Unique.R ...")
  readFromStdin()
  dataFrame <<- data.frame(c(1:1000,1:1000), c(desktopPercentQueries, mobilePercentQueries), c(rep("Desktop",1000), rep("Mobile",1000)))
  drawGraphics()
}

main();