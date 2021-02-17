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

##install.packages("metafor")

library(metafor)


##BCG_data <-write.table(dat.bcg, "BCG.txt", sep=",")
dat.bcg<-read.table("BCG.txt", sep=",")
dat.bcg


help(escalc)
dat1 <- escalc(measure="OR", ai=tpos, bi=tneg, ci=cpos, di=cneg, data=dat.bcg)
dat1

help(rma)
res1 <- rma(yi, vi, data=dat1)
res1



predict(res1, transf=exp, digits=2)

forest(res1) ##the default at log scale
forest(res1, atransf = exp) ##the default back transformed

forest(res1, slab = paste(dat1$author, dat1$year, sep = ", "), 
xlim = c(-16, 6), at = log(c(0.05, 0.25, 1, 4)), atransf = exp,
ilab = cbind(dat1$tpos, dat1$tneg, dat1$cpos, dat1$cneg),
ilab.xpos = c(-9.5, -8, -6, -4.5), cex = 0.75)
op <- par(cex = 0.75, font = 2)
text(c(-9.5, -8, -6, -4.5), 15, c("Exp+", "Exp-", "Exp+", "Exp-"))
text(c(-8.75, -5.25), 16, c("Cases", "Controls"))
text(-16, 15, "Author(s) and Year", pos = 4)
text(6, 15, "Odds Ratios [95% CI]", pos = 2)
text(-14, -1, pos=4, cex=0.75, 
bquote(paste(" (Q = ",.(formatC(res1$QE, digits=2, format="f")), 
                        ", p = ", .(formatC(res1$QEp, digits=2, format="f")), "; 
             ", I^2, " = ", .(formatC(res1$I2, digits=1, format="f")), "%)")))
par(op)

##some departure from normality
qqnorm(res1, main = "Random-Effects Model")

rtf <- trimfill(res1)
funnel(rtf)






