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


###EXAMPLE 1
###An Example of the Benjamini-Hochberg Method 

##pvalues entered from smallest to largest
pvals<-c(.0008,.009,.165,.19,.205,.396,.450,.641,.781,.900, 0.993)##THERE ARE SORTING ALGORITHMS EVEN IN EXCEL
#enter the target FDR
sigma<-.05
#calculate the threshold for each p-value
threshold<-sigma*(1:length(pvals))/length(pvals)
#compare the p-value against its threshold and display results
cbind(pvals,threshold,pvals<=threshold)

#################################################
##################################################
###EXAMPLE 2
###An Example of the Benjamini-Hochberg Method 

##pvalues entered from smallest to largest
pvals<-c(.01,.013,.014,.19,.35,.5,.63,.67,.75,.81)
#enter the target FDR
sigma<-.05
#calculate the threshold for each p-value
threshold<-sigma*(1:length(pvals))/length(pvals)
#compare the p-value against its threshold and display results
cbind(pvals,threshold,pvals<=threshold)

#calculate the term that appears in the innermost minimum function
test.p<-length(pvals)/(1:length(pvals))*pvals
test.p
length(test.p)

#use a loop to run through each p-value and carry out the adjustment
adj.p<-numeric(10)
for(i in 1:10) {
adj.p[i]<-min(test.p[i:length(test.p)])##THE MINIMUM VALUE OF THE SET OF VECTOR VALUES FROM i ONWARDS
ifelse(adj.p[i]>1,1,adj.p[i]) ##IF THE ADJUSTED_p>1, THEN SET THE ADJUSTED_p TO 1, OTHERWISE SET IT TO adj.p
}
adj.p

#################################################
##################################################


###EXAMPLE 2 - ALTERNATIVE

p.adjust(pvals, method = "BH",     n = length(pvals))
p.adjust(pvals, method = "fdr", n = length(pvals))

cbind(pvals,test.p, threshold,pvals<=threshold, adj.p)



###A Graphical Approach to the Benjamini-Hochberg Method

P_valuesRdata <-read.table("P_values_data_coma.txt", header=T,sep=",")
P_valuesRdata

real.p<-P_valuesRdata$real.p
#generate the values to be plotted on x-axis
x.values<-(1:length(real.p))/length(real.p)
#widen right margin to make room for labels
par(mar=c(4.1,4.1,1.1,4.1))
#plot points
plot(x.values,real.p,xlab=expression(k/m),ylab="p-value")
#add FDR line
abline(0,.05,col=2,lwd=2)
#add naive a line
abline(h=.05,col=4,lty=2)
#add Bonferroni-corrected a line
abline(h=.05/length(real.p),col=4,lty=2)
#label lines
mtext(c('naive','Bonferroni'),side=4,at=c(.05,.05/length(real.p)),las=1,line=0.2)
#select observations that are less than threshold
for.test<-cbind(1:length(real.p),real.p)
pass.test<-for.test[real.p<=.05*x.values,]
pass.test

#use largest k to color points that meet Benjamini-Hochberg FDR test
last<-ifelse(is.vector(pass.test),pass.test[1],pass.test[nrow(pass.test),1])
points(x.values[1:last],real.p[1:last],pch=19,cex=1.5)
###Adjusted p-values



################
###################
###p.adjust IN R
help(p.adjust)

p.adjust(pvals, method = "BH",     n = length(pvals))
p.adjust(pvals, method = "fdr",    n = length(pvals))


###a strong control of the family-wise error rate
p.adjust(pvals, method = "holm",     n = length(pvals))
p.adjust(pvals, method = "hochberg", n = length(pvals))
p.adjust(pvals, method = "hommel", n = length(pvals))
p.adjust(pvals, method = "bonferroni", n = length(pvals))



p.adjust(pvals, method = "BY", n = length(pvals))
p.adjust(pvals, method = "none", n = length(pvals))

