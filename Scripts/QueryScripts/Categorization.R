source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")
#11 categorias

dataFrame <- data.frame(x= numeric(0), y= integer(0))

#computers or internet
#people, places and things
#commerce, travel, employment or economy
#entertainment and recreation
#society, culture, ethnicity or religion
#unknown or other
#sex or pornography
#education or humanities
#health or sciences
#government
#performing or fine arts

categories <- c("Computers or Internet","People,places and things","Commerce,travel,employment and economy",
                "Entertainment and recreation", "Society, culture, ethnicity or religion", "Unknown or other",
                "Sex or pornography", "Education or humanities", "Health or sciences", "Government", "Performing or fine arts")

desktopCat <- c(74,58,104,46,99,46,28,10,19,13,4)
mobileCat <- c(43,81,85,30,127,26,39,9,20,7,22)

smartphonesCat <- c(75,91,57,39,132,30,38,2,17,5,15)
tabletsCat <- c(30,95,123,33,110,17,40,9,15,4,17)
cellphonesCat <- c(36,41,22,67,181,61,37,9,5,2,31)

#informational - reading an information but no further interaction needed
#navigational - immediate intent is to reach a particular site
#transactional - visit a site where additional interactions will occur (i.e. shopping, downloading files, gaming,etc.)

desktopTax <- c(130,166,150)
mobileTax <- c(140,199,108)
smartphonesTax <- c(120,197,137)
tabletsTax <- c(146,162,154)
cellphonesTax <- c(86,247,88)

#lingua utilizada na pesquisa
# 0 - lingua portuguesa
# 1 - lingua inglesa
# 2 - outra lingua
desktopLang <- c(312,67,13)

mobileLang <- c(223,26,6)

smartphonesLang <- c(200,32,8)
tabletsLang <- c(274,22,4)
cellphonesLang <- c(147,15,0)

drawDatasetGraphics <- function() {
  plot <- ggplot(data=dataFrame, aes(x=dataFrame[[1]], y=dataFrame[[2]],group=dataFrame[[3]], colour=dataFrame[[3]]))
  plot <- plot + geom_line() + geom_point()
  plot <- plot + xlab("Categories") + ylab("% in the retrieved sample")
  ggsave(paste(graphicsPath,"MobilePCCategorization.jpg", sep = "/"))
}

main <- function(){
  categories <- c("Computers or Internet","People,places and things","Commerce,travel,employment and economy",
                  "Entertainment and recreation", "Society, culture, ethnicity or religion", "Unknown or other",
                  "Sex or pornography", "Education or humanities", "Health or sciences", "Government", "Performing or fine arts")
 # dataFrame <<- data.frame(c(categories,categories), c(desktopCat/501, mobileCat/489), c(rep("Desktop", 11), rep("Mobile", 11)))
  #print(dataFrame)
  #drawDatasetGraphics()
#  dataFrame <<- data.frame(c(categories,categories,categories), c(tabletsCat/493, smartphonesCat/501, cellphonesCat/492), c(rep("Tablets", 11), rep("Smartphones", 11),rep("Cellphones", 11)))
  #print(dataFrame)
  print(desktopLang/392)
  print(mobileLang/255)
  print(tabletsLang/300)
  print(smartphonesLang/240)
  print(cellphonesLang/162)
}

main();