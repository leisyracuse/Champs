library("ggplot2")
library("export")

output_read <- function(fname){
  df <- read.csv(fname,sep = "\t", skip = 10, skipNul = TRUE)
  Time <- as.numeric(rownames(df))
  df$Time <- Time
  colnames(df) <- c("Value","Time")
  return(df)
}
  
figure_2df <- function(VOC_flux_A,VOC_flux_B){
  p <- ggplot(VOC_flux_A, aes(x=Time,y=Value,colour = "1")) + geom_line()
  p <- p + geom_line(data = VOC_flux_B, aes(x=Time,y=Value,colour = "2"))
  # p <- p + scale_colour_discrete(name =" ", breaks = c("1","2"),labels = c("chamberA","chamberB"))
  p <- p + scale_colour_discrete(name =" ", breaks = c("1","2"),labels = c("reference T","High T"))
  return(p)
}

figure_3df <- function(df1,df2,df3){
  p <- ggplot(df1, aes(x=Time,y=Value,colour = "1")) + geom_line()
  p <- p + geom_line(data = df2, aes(x=Time,y=Value,colour = "2"))
  p <- p + geom_line(data = df3, aes(x=Time,y=Value,colour = "3"))
  p <- p + scale_colour_discrete(name =" ", breaks = c("1","2","3"),labels = c("reference T","High T","Fluctuation T"))
  return(p)
}

getwd()
setwd("C:/Users/Allen/ownCloud/chamber_verify/Kma_champs_verify/dual chamber reference/140219_DualChamber_Toluene.results")
setwd("C:/Users/Allen/ownCloud/chamber_verify/Kma_champs_verify/dual chamber reference fine grid/140219_DualChamber_Toluene.results")
setwd("C:/Users/Allen/ownCloud/chamber_verify/Kma_champs_verify/dual chamber highT/140219_DualChamber_Toluene.results")
setwd("C:/Users/Allen/ownCloud/chamber_verify/Kma_champs_verify/dual chamber flucT/140219_DualChamber_Toluene.results")

temp <- output_read("chamber_temp.out")
str(temp)
# View(temp)
VOC_flux_A <- output_read("VOC_flux_A.out")
# View(VOC_flux_A)
VOC_flux_B <- output_read("VOC_flux_B.out")
# View(VOC_flux_B)


p1 <- ggplot(temp,aes(Time,Value)) + geom_line()
p1
graph2ppt(file = "C:/Users/Allen/Desktop/rplot.pptx", append = TRUE)

p2 <- ggplot(VOC_flux_A, aes(x=Time,y=Value,colour = "1")) + geom_line()
p2 <- p2 + geom_line(data = VOC_flux_B, aes(x=Time,y=Value,colour = "2"))
p2 <- p2 + scale_colour_discrete(name =" ", breaks = c("1","2"),labels = c("chamberA","chamberB"))
p2
graph2ppt(file = "C:/Users/Allen/Desktop/rplot.pptx", append = TRUE)

VOC_bot_air_A <- output_read("VOC_bottom_layer_air_A.out")
# View(VOC_bot_air_A)
VOC_bot_air_B <- output_read("VOC_bottom_layer_air_B.out")
# View(VOC_bot_air_B)
p3 <- figure_2df(VOC_bot_air_A,VOC_bot_air_B)
p3
graph2ppt(file = "C:/Users/Allen/Desktop/rplot.pptx", append = TRUE)

VOC_bot_mat_A <- output_read("VOC_bottom_layer_mat_A.out")
str(VOC_bot_mat_A)
VOC_bot_mat_B <- output_read("VOC_bottom_layer_mat_B.out")
str(VOC_bot_mat_B)
p4 <- figure_2df(VOC_bot_mat_A,VOC_bot_mat_B)
p4
graph2ppt(file = "C:/Users/Allen/Desktop/rplot.pptx", append = TRUE)

Kma_A <- data.frame(VOC_bot_mat_A$Time,VOC_bot_mat_A$Value/VOC_bot_air_A$Value)
colnames(Kma_A) <- c("Time","Value")
str(Kma_A)
Kma_B <- data.frame(VOC_bot_mat_B$Time,VOC_bot_mat_B$Value/VOC_bot_air_B$Value)
colnames(Kma_B) <- c("Time","Value")
str(Kma_B)
p5 <- figure_2df(Kma_A,Kma_B)
p5
graph2ppt(file = "C:/Users/Allen/Desktop/rplot.pptx", append = TRUE)

######################
setwd("C:/Users/Allen/ownCloud/chamber_verify/Kma_champs_verify/single chamber reference/120305_single_chamber_with_0.5 inch calcium silicate.results")
temp_r <- output_read("temperature_average.out")
Ca_r <- output_read("Concentration in chamber.out")
Cm_r <- output_read("concentration in top surface.out")
Ci_r <- output_read("concentration in interface.out")
flux_r <- output_read("VOC_flux_average.out")

setwd("C:/Users/Allen/ownCloud/chamber_verify/Kma_champs_verify/single chamber highT/120305_single_chamber_with_0.5 inch calcium silicate.results")
temp_h <- output_read("temperature_average.out")
Ca_h <- output_read("Concentration in chamber.out")
Cm_h <- output_read("concentration in top surface.out")
Ci_h <- output_read("concentration in interface.out")
flux_h <- output_read("VOC_flux_average.out")

setwd("C:/Users/Allen/ownCloud/chamber_verify/Kma_champs_verify/single chamber flucT/120305_single_chamber_with_0.5 inch calcium silicate.results")
temp_f <- output_read("temperature_average.out")
Ca_f <- output_read("Concentration in chamber.out")
Cm_f <- output_read("concentration in top surface.out")
Ci_f <- output_read("concentration in interface.out")
flux_f <- output_read("VOC_flux_average.out")

p1 <- figure_3df(temp_r,temp_h,temp_f)
p1
graph2ppt(file = "C:/Users/Allen/Desktop/rplot.pptx", append = TRUE)

p2 <- figure_3df(Ca_r,Ca_h,Ca_f)
p2
graph2ppt(file = "C:/Users/Allen/Desktop/rplot.pptx", append = TRUE)

Kma_r <- data.frame(Ci_r$Time,Cm_r$Value/Ci_r$Value)
colnames(Kma_r) <- c("Time","Value")
Kma_h <- data.frame(Ci_h$Time,Cm_h$Value/Ci_h$Value)
colnames(Kma_h) <- c("Time","Value")
Kma_f <- data.frame(Ci_f$Time,Cm_f$Value/Ci_f$Value)
colnames(Kma_f) <- c("Time","Value")
p3 <- figure_3df(Kma_r,Kma_h,Kma_f)
p3

p3 <- p3 + xlim(2,6)+ylim(124,125)
p3
graph2ppt(file = "C:/Users/Allen/Desktop/rplot.pptx", append = TRUE)

p4 <- figure_3df(flux_r,flux_h,flux_f)
p4
graph2ppt(file = "C:/Users/Allen/Desktop/rplot.pptx", append = TRUE)

p4 <- p4 + xlim(100,300)+ylim(0.01,0.03)
p4
graph2ppt(file = "C:/Users/Allen/Desktop/rplot.pptx", append = TRUE)
#############################################
setwd("C:/Users/Allen/ownCloud/chamber_verify/Kma_champs_verify/material only reference/New project.results")
temp_r <- output_read("temperature_average.out")
VOC_flux_r <- output_read("VOC flux.out")

setwd("C:/Users/Allen/ownCloud/chamber_verify/Kma_champs_verify/material only HighT/New project.results")
temp_h <- output_read("temperature_average.out")
VOC_flux_h <- output_read("VOC flux.out")

p1 <- figure_2df(temp_r,temp_h)
p1
graph2ppt(file = "C:/Users/Allen/Desktop/rplot.pptx", append = TRUE)

p2 <- figure_2df(VOC_flux_r,VOC_flux_h)
p2
graph2ppt(file = "C:/Users/Allen/Desktop/rplot.pptx", append = TRUE)
