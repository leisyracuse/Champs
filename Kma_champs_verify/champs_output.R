library("ggplot2")

getwd()
setwd("C:/Users/Allen/Desktop/Kma_champs_verify/dual chamber reference/140219_DualChamber_Toluene.results")

output_read <- function(fname){
  df <- read.csv(fname,sep="\t", skip = 10, skipNul = TRUE)
  Time <- as.numeric(rownames(df))
  df$Time <- Time
  colnames(df) <- c("Value","Time")
  return(df)
}
  

temp <- output_read("chamber_temp.out")
str(temp)
View(temp)
VOC_flux_A <- output_read("VOC_flux_A.out")
View(VOC_flux_A)
VOC_flux_B <- output_read("VOC_flux_B.out")
View(VOC_flux_B)


p1 <- ggplot(temp,aes(Time,Value)) + geom_line()
p1

p2 <- ggplot(VOC_flux_A, aes(x=Time,y=Value,,colour = "1")) + geom_line()
p2 <- p2 + geom_line(data = VOC_flux_B, aes(x=Time,y=Value,colour = "2"))
p2 <- p2 + scale_colour_discrete(name =" ", breaks = c("1","2"),labels = c("chamberA","chamberB"))
p2

figure_2df <- function(VOC_flux_A,VOC_flux_B){
  p <- ggplot(VOC_flux_A, aes(x=Time,y=Value,,colour = "1")) + geom_line()
  p <- p + geom_line(data = VOC_flux_B, aes(x=Time,y=Value,colour = "2"))
  p <- p + scale_colour_discrete(name =" ", breaks = c("1","2"),labels = c("chamberA","chamberB"))
  return(p)
}

VOC_bot_air_A <- output_read("VOC_bottom_layer_air_A.out")
View(VOC_bot_air_A)
VOC_bot_air_B <- output_read("VOC_bottom_layer_air_B.out")
View(VOC_bot_air_B)
p3 <- figure_2df(VOC_bot_air_A,VOC_bot_air_B)
p3

VOC_bot_mat_A <- output_read("VOC_bottom_layer_mat_A.out")
str(VOC_bot_mat_A)
VOC_bot_mat_B <- output_read("VOC_bottom_layer_mat_B.out")
str(VOC_bot_mat_B)
p4 <- figure_2df(VOC_bot_mat_A,VOC_bot_mat_B)
p4

Kma_A <- data.frame(VOC_bot_mat_A$Time,VOC_bot_mat_A$Value/VOC_bot_air_A$Value)
colnames(Kma_A) <- c("Time","Value")
str(Kma_A)
Kma_B <- data.frame(VOC_bot_mat_B$Time,VOC_bot_mat_B$Value/VOC_bot_air_B$Value)
colnames(Kma_B) <- c("Time","Value")
str(Kma_B)
p5 <- figure_2df(Kma_A,Kma_B)
p5