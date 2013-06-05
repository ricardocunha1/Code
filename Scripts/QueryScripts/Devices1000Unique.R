source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")

tabletPercentQueries <- vector()
smartphonePercentQueries <- vector()
cellphonePercentQueries <- vector()

dataFrame <- data.frame(x= numeric(0), y= integer(0))

tabletTop1000unique <- 0
nTabletQueries <- 0

smartphoneTop1000unique <- 0
nSmartphoneQueries <- 0

cellphoneTop1000unique <- 0
nCellphoneQueries <- 0

state <- 0

parseString <- function(str){
  if(state == 0){
    aLine <- strsplit(str,separator)
    nTabletQueries <<- as.integer(aLine[[1]][1])
    nSmartphoneQueries <<- as.integer(aLine[[1]][2])
    nCellphoneQueries <<- as.integer(aLine[[1]][3])
    state <<- 1
  } else if(state == 1){
    #tablet queries
    if(str == "smartphone"){
      state <<- 2
    } else {
      aLine <- strsplit(str,separator)
      tabletTop1000unique <<- tabletTop1000unique + as.integer(aLine[[1]][2])
      tabletPercentQueries <<- append(tabletPercentQueries, as.numeric(rawPercent(tabletTop1000unique/nTabletQueries)))
    }
  } else if(state == 2){
    #smartphone queries
    if(str == "cellphone"){
      state <<- 3
    } else {
      aLine <- strsplit(str,separator)
      smartphoneTop1000unique <<- smartphoneTop1000unique + as.integer(aLine[[1]][2])
      smartphonePercentQueries <<- append(smartphonePercentQueries, as.numeric(rawPercent(smartphoneTop1000unique/nSmartphoneQueries)))
    }
  } else {
    #cellphone queries
    aLine <- strsplit(str,separator)
    cellphoneTop1000unique <<- cellphoneTop1000unique + as.integer(aLine[[1]][2])
    cellphonePercentQueries <<- append(cellphonePercentQueries, as.numeric(rawPercent(cellphoneTop1000unique/nCellphoneQueries)))
  }
}

drawGraphics <- function(){
  plot <- ggplot(data=dataFrame, aes(x=dataFrame[[1]], y=dataFrame[[2]], colour=dataFrame[[3]]))
  plot <- plot + geom_line(stat="identity")
  plot <- plot + scale_x_continuous(breaks=c(100,200,300,400,500,600,700,800,900,1000))
  plot <- plot + scale_y_continuous(breaks=c(0.00,10.00,20.00,30.00,40.00,50.00), labels=c("0%", "10%","20%","30%","40%","50%"))
  plot <- plot + xlab("Query rank") + ylab("% of all queries")
  plot <- plot + labs(colour="Categories") + theme(legend.position="top")
  ggsave(paste(graphicsPath,"Devices1000unique.jpg", sep = "/"))
}

main <- function(){
  print("Initiating DevicesPC1000Unique.R ...")
  readFromStdin()
  dataFrame <<- data.frame(c(1:1000,1:1000,1:1000), c(tabletPercentQueries, smartphonePercentQueries, cellphonePercentQueries),
                           c(rep("Tablet",1000), rep("Smartphone",1000), rep("Traditional", 1000)))
  drawGraphics()
}

main();