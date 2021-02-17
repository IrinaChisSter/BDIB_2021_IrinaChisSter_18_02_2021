##THIS ROUTINE WILL BRING YOU TO THE DIRECTORY WHERE THIS FILE IS - THE WORKING DIRECTORY
##YOU CAN IGNORE getwd() AND setwd(WORKING_DIR)
##########
if (!require("rstudioapi")) install.packages("rstudioapi")
library(rstudioapi)
(adc <- rstudioapi::getActiveDocumentContext())
help(package="rstudioapi")
(pfad <- strsplit(adc$path, split="/")[[1]])
(this.script <- pfad[length(pfad)])
(wd <- paste(pfad[-length(pfad)], collapse="/"))
setwd (wd)
rm(adc, pfad)
list.files()
##################################
#################################


mydata <-read.table("OneSampleTest1.txt", header=T, sep="/")
mydata
help(t.test)

##two sided test
t.test(mydata$weight_loss, alternative = "two.sided",mu = 0, paired = FALSE, var.equal = FALSE,conf.level = 0.95)

##one sided test
t.test(mydata$weight_loss, alternative = "greater",mu = 0, paired = FALSE, var.equal = FALSE,conf.level = 0.95)

##one sided test
t.test(mydata$weight_loss, alternative = "less",mu = 0, paired = FALSE, var.equal = FALSE,conf.level = 0.95)


##one proportion tests
help(prop.test)
prop.test(12, 15, p=0.6, alternative="two.sided", conf.level=0.95, correct=TRUE)

##one proportion tests
prop.test(12, 15, p=0.9, alternative="less", conf.level=0.95, correct=TRUE)

##one proportion tests
prop.test(12, 15, p=0.9, alternative="greater", conf.level=0.95, correct=TRUE)

