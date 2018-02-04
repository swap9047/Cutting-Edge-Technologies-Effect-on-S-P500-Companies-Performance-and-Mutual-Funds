#####Set directory######
setwd("C:/Users/rai16/Downloads/drive-download-20171204T012501Z-001")




########Data Transformation---------------#######

##File that needs to be read
myFile <- "final_data.csv"
Q1 <- read.table(file=myFile, header=T, sep=",")




##Performing data cleaning and transformation operations
summary(Q1)
Q1$industrial.internet.of.things = NULL
Q1$computer.vision = NULL
Q1$scalable.technolo = NULL
Q1$decision.science = NULL
Q1$customer.analytic = NULL
Q1$Year = as.factor(Q1$Year)
str(Q1)
Q1$ï..Company = NULL

Q1$Price = NULL
Q1$Profit = NULL


Q1$Ticker = NULL

Q1_Profit = Q1
Q1_Roe = Q1
Q1_Roe = subset(x = Q1_Roe, Roe !=0)
Q1$Roe = NULL
Q1_Profit$Roe = NULL


Q1$ProfPerc = NULL
Q1$RoePerc = NULL

Q1_2016 = subset(x = Q1, Year=="2016")
str(Q1_2016)


Q1_2015 = subset(x = Q1, Year=="2015")
str(Q1_2015)

Q1_2016$Year = NULL
Q1_2015$Year = NULL


Q1_Profit$PricePerc = NULL
Q1_Profit$RoePerc = NULL

Q1_Roe$PricePerc = NULL
Q1_Roe$ProfPerc = NULL
summary(Q1)

sum(Q1_2016$PricePerc>100)





##Visualizing all count of words variables and their log transformations
log_var<-colnames(Q1)[!colnames(Q1) %in% c("Company","GICS.Sector","Year",'PricePerc' )]
par(mfrow=c(1,2))
for ( i in log_var){
  
  hist(Q1$cloud.comput,main=paste('Histpgram of',i))
  hist(log(Q1$cloud.comput+1),main=paste('Histpgram of log(',i,')'))
}




#####log_transformed regression#####



##Regression Stock Price% change on log transformed count of words##

  #Year=2016,2015
  Q1_2016_log=log(Q1_2016[,!colnames(Q1_2016) %in% c("Company","GICS.Sector",'PricePerc')]+1)
  Q1_2016_log<-cbind(Q1_2016_log,Q1_2016[,colnames(Q1_2016) %in% c("Company","GICS.Sector",'PricePerc')])
  
  Q1_2015_log=log(Q1_2015[,!colnames(Q1_2015) %in% c("Company","GICS.Sector",'PricePerc')]+1)
  Q1_2015_log<-cbind(Q1_2015_log,Q1_2015[,colnames(Q1_2015) %in% c("Company","GICS.Sector",'PricePerc')])
  
  price_2016_log <- lm(PricePerc~(GICS.Sector * big.data)+(GICS.Sector *predictive.analytics)+(GICS.Sector *internet.of.things)+(GICS.Sector *data.analytics)+(GICS.Sector *business.analytics)+(GICS.Sector *augmented.reality)+(GICS.Sector *artificial.intelligence)+(GICS.Sector *virtual.reality)+(GICS.Sector *machine.learning)+(GICS.Sector *business.intelligence)+(GICS.Sector *data.science)+(GICS.Sector *hadoop)+(GICS.Sector *software.as.a.service)+(GICS.Sector *cloud.comput)+(GICS.Sector *platform.as.a.service)+(GICS.Sector *infrastructure.as.a.service)+(GICS.Sector *data.center)+(GICS.Sector *optimization)+(GICS.Sector *data.security)+(GICS.Sector *data.mining)+(GICS.Sector *private.cloud)+(GICS.Sector *hybrid.cloud)+(GICS.Sector *data.warehous)+(GICS.Sector *natural.language.processing)+(GICS.Sector *data.proces)+(GICS.Sector *data.stream)+(GICS.Sector *intelligent.system)+(GICS.Sector *virtualization.technolog)+(GICS.Sector *cloud) ,data = Q1_2016_log[Q1_2016_log$PricePerc<100,])
  summary(price_2016_log)
  
  summary(Q1_2015_log)
  price_2015_log <- lm(PricePerc~(GICS.Sector * big.data)+(GICS.Sector *predictive.analytics)+(GICS.Sector *internet.of.things)+(GICS.Sector *data.analytics)+(GICS.Sector *business.analytics)+(GICS.Sector *augmented.reality)+(GICS.Sector *artificial.intelligence)+(GICS.Sector *virtual.reality)+(GICS.Sector *machine.learning)+(GICS.Sector *business.intelligence)+(GICS.Sector *data.science)+(GICS.Sector *hadoop)+(GICS.Sector *software.as.a.service)+(GICS.Sector *cloud.comput)+(GICS.Sector *platform.as.a.service)+(GICS.Sector *infrastructure.as.a.service)+(GICS.Sector *data.center)+(GICS.Sector *optimization)+(GICS.Sector *data.security)+(GICS.Sector *data.mining)+(GICS.Sector *private.cloud)+(GICS.Sector *hybrid.cloud)+(GICS.Sector *data.warehous)+(GICS.Sector *natural.language.processing)+(GICS.Sector *data.proces)+(GICS.Sector *data.stream)+(GICS.Sector *intelligent.system)+(GICS.Sector *virtualization.technolog)+(GICS.Sector *cloud) ,data = Q1_2015_log[Q1_2015_log$PricePerc<100,])
  summary(price_2015_log)


##Regression Profit% change on log transformed count of words##

  #Year=2016,2015
  Q1_Profit_2016 = subset(x = Q1_Profit, Year=="2016")
  summary(Q1_Profit_2016)


  Q1_Profit_2015 = subset(x = Q1_Profit, Year=="2015")
  summary(Q1_Profit_2015)
  
  Q1_Profit_2016$Year = NULL
  Q1_Profit_2015$Year = NULL
  Q1_Profit_2016_log=log(Q1_Profit_2016[,!colnames(Q1_Profit_2016) %in% c("Company","GICS.Sector",'ProfPerc')]+1)
  Q1_Profit_2016_log<-cbind(Q1_Profit_2016_log,Q1_Profit_2016[,colnames(Q1_Profit_2016) %in% c("Company","GICS.Sector",'ProfPerc')])
  
  profit_2016_log = lm(ProfPerc~(GICS.Sector * big.data)+(GICS.Sector *predictive.analytics)+(GICS.Sector *internet.of.things)+(GICS.Sector *data.analytics)+(GICS.Sector *business.analytics)+(GICS.Sector *augmented.reality)+(GICS.Sector *artificial.intelligence)+(GICS.Sector *virtual.reality)+(GICS.Sector *machine.learning)+(GICS.Sector *business.intelligence)+(GICS.Sector *data.science)+(GICS.Sector *hadoop)+(GICS.Sector *software.as.a.service)+(GICS.Sector *cloud.comput)+(GICS.Sector *platform.as.a.service)+(GICS.Sector *infrastructure.as.a.service)+(GICS.Sector *data.center)+(GICS.Sector *optimization)+(GICS.Sector *data.security)+(GICS.Sector *data.mining)+(GICS.Sector *private.cloud)+(GICS.Sector *hybrid.cloud)+(GICS.Sector *data.warehous)+(GICS.Sector *natural.language.processing)+(GICS.Sector *data.proces)+(GICS.Sector *data.stream)+(GICS.Sector *intelligent.system)+(GICS.Sector *virtualization.technolog)+(GICS.Sector *cloud),data=Q1_Profit_2016_log)
  summary(profit_2016)
  
  profit_2015_log = lm(ProfPerc~(GICS.Sector * big.data)+(GICS.Sector *predictive.analytics)+(GICS.Sector *internet.of.things)+(GICS.Sector *data.analytics)+(GICS.Sector *business.analytics)+(GICS.Sector *augmented.reality)+(GICS.Sector *artificial.intelligence)+(GICS.Sector *virtual.reality)+(GICS.Sector *machine.learning)+(GICS.Sector *business.intelligence)+(GICS.Sector *data.science)+(GICS.Sector *hadoop)+(GICS.Sector *software.as.a.service)+(GICS.Sector *cloud.comput)+(GICS.Sector *platform.as.a.service)+(GICS.Sector *infrastructure.as.a.service)+(GICS.Sector *data.center)+(GICS.Sector *optimization)+(GICS.Sector *data.security)+(GICS.Sector *data.mining)+(GICS.Sector *private.cloud)+(GICS.Sector *hybrid.cloud)+(GICS.Sector *data.warehous)+(GICS.Sector *natural.language.processing)+(GICS.Sector *data.proces)+(GICS.Sector *data.stream)+(GICS.Sector *intelligent.system)+(GICS.Sector *virtualization.technolog)+(GICS.Sector *cloud) ,data = Q1_Profit_2015_log)
  Q1_Profit_2015_log=log(Q1_Profit_2015[,!colnames(Q1_Profit_2015) %in% c("Company","GICS.Sector",'ProfPerc')]+1)
  Q1_Profit_2015_log<-cbind(Q1_Profit_2015_log,Q1_Profit_2015[,colnames(Q1_Profit_2015) %in% c("Company","GICS.Sector",'ProfPerc')])
  
  summary(profit_2015)




##Regression Profit% change on log transformed count of words##

  #Year=2016,2015
  Q1_Roe_2016 = subset(x = Q1_Roe, Year=="2016")
  str(Q1_Roe_2016)
  
  
  Q1_Roe_2015 = subset(x = Q1_Roe, Year=="2015")
  str(Q1_Roe_2015)
  
  Q1_Roe_2016$Year = NULL
  Q1_Roe_2015$Year = NULL
  
  Q1_Roe_2016_log=log(Q1_Roe_2016[,!colnames(Q1_Roe_2016) %in% c("Company","GICS.Sector",'ProfPerc')]+1)
  Q1_Roe_2016_log<-cbind(Q1_Roe_2016_log,Q1_Roe_2016_log[,colnames(Q1_Roe_2016_log) %in% c("Company","GICS.Sector",'ProfPerc')])
  
  roe_2016_log = lm(RoePerc~(GICS.Sector * big.data)+(GICS.Sector *predictive.analytics)+(GICS.Sector *internet.of.things)+(GICS.Sector *industrial.internet.of.things)+(GICS.Sector *data.analytics)+(GICS.Sector *business.analytics)+(GICS.Sector *augmented.reality)+(GICS.Sector *artificial.intelligence)+(GICS.Sector *virtual.reality)+(GICS.Sector *computer.vision)+(GICS.Sector *machine.learning)+(GICS.Sector *business.intelligence)+(GICS.Sector *data.science)+(GICS.Sector *hadoop)+(GICS.Sector *software.as.a.service)+(GICS.Sector *cloud.comput)+(GICS.Sector *platform.as.a.service)+(GICS.Sector *infrastructure.as.a.service)+(GICS.Sector *data.center)+(GICS.Sector *optimization)+(GICS.Sector *data.security)+(GICS.Sector *data.mining)+(GICS.Sector *private.cloud)+(GICS.Sector *hybrid.cloud)+(GICS.Sector *data.warehous)+(GICS.Sector *natural.language.processing)+(GICS.Sector *data.proces+scalable.technolo)+(GICS.Sector *decision.science)+(GICS.Sector *customer.analytic)+(GICS.Sector *data.scien)+(GICS.Sector *data.stream)+(GICS.Sector *intelligent.system)+(GICS.Sector *virtualization.technolog)+(GICS.Sector *cloud) ,data = Q1_Roe_2016_log)
  summary(roe_2016_log)
  
  roe_2015_log = lm(RoePerc~(GICS.Sector * big.data)+(GICS.Sector *predictive.analytics)+(GICS.Sector *internet.of.things)+(GICS.Sector *industrial.internet.of.things)+(GICS.Sector *data.analytics)+(GICS.Sector *business.analytics)+(GICS.Sector *augmented.reality)+(GICS.Sector *artificial.intelligence)+(GICS.Sector *virtual.reality)+(GICS.Sector *computer.vision)+(GICS.Sector *machine.learning)+(GICS.Sector *business.intelligence)+(GICS.Sector *data.science)+(GICS.Sector *hadoop)+(GICS.Sector *software.as.a.service)+(GICS.Sector *cloud.comput)+(GICS.Sector *platform.as.a.service)+(GICS.Sector *infrastructure.as.a.service)+(GICS.Sector *data.center)+(GICS.Sector *optimization)+(GICS.Sector *data.security)+(GICS.Sector *data.mining)+(GICS.Sector *private.cloud)+(GICS.Sector *hybrid.cloud)+(GICS.Sector *data.warehous)+(GICS.Sector *natural.language.processing)+(GICS.Sector *data.proces+scalable.technolo)+(GICS.Sector *decision.science)+(GICS.Sector *customer.analytic)+(GICS.Sector *data.scien)+(GICS.Sector *data.stream)+(GICS.Sector *intelligent.system)+(GICS.Sector *virtualization.technolog)+(GICS.Sector *cloud) ,data = Q1_Roe_2015_log)
  
  summary(roe_2015_log)


