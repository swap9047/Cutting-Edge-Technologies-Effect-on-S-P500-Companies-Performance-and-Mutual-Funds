##import libraries
library(reshape2)
library(corrplot)

##This is the file that consists of freq of words across industries
myFile <- "final_data.csv"
Q1 <- read.table(file=myFile, header=T, sep=",")

##Transforming the imported dataset and preparing for Chi-Square test of independence
Q2<-Q1[,!colnames(Q1) %in% c('Company',"PricePerc",'Year')]
Q3<-melt(Q2,id='GICS.Sector')
colnames(Q3)[2]<-'Words'
Q3$value<-ifelse(Q3$value>0,'Yes','No')##Coding words eithers as 'appeared' or 'not appeared'

var<-as.character(unique((Q3$Words))[c(1,9,4,7,10,12,14,15,17,18,19,25,27,34)])##important variables that needs
                                                                              ## to be considered for analysis

lst=list()


###printing all chisquare test results in a loop for all variables 
i=var[1]
for (i in var )
{
  print(paste('ChiSquare test of Independence of',i))
 print(chisq.test(table(Q3$GICS.Sector[Q3$Words==i],Q3$value[Q3$Words==i])))
 
}

tbl<-table(Q3$GICS.Sector,Q3$Words)
sum(tbl)

