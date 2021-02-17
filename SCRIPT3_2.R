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


#####GENOTYPE EXAMPLE


##Aggregated data format  -THAT GIVEN ON THE SLIDES
disease<-c(109, 118, 26) ##create the disease vectors
non_disease<-c(138, 88, 21) ##create the disease vectors
total<-disease+non_disease ##create the total vectors
total
two_by_two_table<-rbind(disease, non_disease) ##bind them in a table so chi squared R command would understand
two_by_two_table ##read the table
chisq.test(two_by_two_table) ##test for independence in proportions
prop.trend.test(disease, total) ##test for linear trend in proportions


##Expanded data format
 gen_data_expanded<-read.table("GenotypeChiSqAssoc_expanded_coma.txt", header=T,sep=",")
 gen_data_expanded ##visualise the data
 table(gen_data_expanded)
 names(gen_data_expanded) ##check variables? names
 two_by_two_table_exp<-table(gen_data_expanded$disease,gen_data_expanded$genotype) ## CREATE A TABLE
 two_by_two_table_exp ##visualise the table
 chisq.test(two_by_two_table_exp) ##test for independence in proportions
 
 ##for trends best to create data
 vector_cases<-c(109, 118, 26)
 vector_non_cases<-c(138, 88, 21)
 vector_total<-vector_cases+vector_non_cases
 prop.trend.test(vector_cases,vector_total)
 