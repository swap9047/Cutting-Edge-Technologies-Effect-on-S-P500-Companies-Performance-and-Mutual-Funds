####import libraries
library("wordcloud")
library("RColorBrewer")
library(reshape2)
library(dplyr)


###Read file
myFile <- "final_data.csv"
data <- read.table(file=myFile, header=T, sep=",")



###Transforming data to prepare for word_cloud
colnames(data)
cloud_data<-data[,colnames(data) %in% colnames(data)[5:40]]
cloud_data<-melt(cloud_data)
cloud_data1<-cloud_data%>%group_by(variable)%>%summarise(sum(value))
colnames(cloud_data1)<-c('Words','Freq')
cloud_data1$Words<-as.character(cloud_data1$Words)
cloud_data1$Words[c(17,26,28,29,31,32,35)]<-c('cloud computing','data warehouse','data processing',
                                          'scalable technology','customer analytics','data science',"virtualization technology")

cloud_data1$Words<- gsub('\\.', ' ', cloud_data1$Words)




####Using the table to prepare word_cloud
set.seed(1234)
wordcloud(words = cloud_data1$Words, freq = cloud_data1$Freq, min.freq = 1,
          max.words=50, random.order=FALSE, rot.per=0.2, 
          colors=brewer.pal(8, "Dark2"))

