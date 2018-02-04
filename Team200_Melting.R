#Inpiut Dataset
setwd("C:/Users/user/Downloads")
myFile <- "melt_mf.csv"
x <- read.table(file=myFile, header=T, sep=",")
summary(x)

head(x,n=5)
colnames(x)
#Melting the  dataset into long-format. id-vars has those variables which you do not want to pivot-down
aql <- melt(x,id.vars = c('ï..Company_Tickr')) # [a]ir [q]uality [l]ong format


head(aql)
#Writing out the new dataset
write.table(aql, "C:/Users/user/Downloads/mf_melt_out.csv", sep=",")
?write.table
