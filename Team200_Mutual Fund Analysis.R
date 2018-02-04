##################Q4
#Loading the Bag of Words file for SP 500 companies
setwd("C:/Users/user/Downloads")
myFile <- "Q1.csv"
Q1 <- read.table(file=myFile, header=T, sep=",")
summary(Q1)

#Uploading the mutual funds file with holding changes
setwd("C:/Users/user/Downloads")
myFile <- "mf_melt_out.csv"
MF <- read.table(file=myFile, header=T, sep=",")
summary(MF)

colnames(Q1)
Q1$Key = Q1$ï..Key
Q1$ï..Key = NULL
#Merging the two datasets on a key made at company_tickr-Year level
Q1 = merge(Q1,MF, by = "Key") 

summary(Q1)
#Eliminating columns with low total occurences(<10) and character variables to make a regression model
Q1$industrial.internet.of.things = NULL
Q1$computer.vision = NULL
Q1$scalable.technolo = NULL
Q1$decision.science = NULL
Q1$customer.analytic = NULL
Q1$Ticker.y = NULL
Q1$Year.y = NULL
Q1$Year = as.factor(Q1$Year.x)
str(Q1)
Q1$ï..Company = NULL
Q1$Ticker = NULL
Q1$Price = NULL
Q1$Profit = NULL
Q1$Roe = NULL
Q1$PricePerc = NULL
Q1$ProfPerc = NULL
Q1$RoePerc = NULL
colnames(Q1)
Q1$Year.x = NULL
Q1$Company = NULL
Q1$Ticker.x = NULL
Q1$Key = NULL
colnames(Q1)
Q1$data.scien = NULL

colnames(Q1)

#We need to reduce the skewness and variance of the words variable, hence we apply a log transofrm on them
Q1$big.data = log(1 + Q1$big.data)
Q1$predictive.analytics = log(1 + Q1$predictive.analytics)
Q1$predictive.model = log(1 + Q1$predictive.model)
Q1$internet.of.things = log(1 + Q1$internet.of.things)
Q1$data.analytics = log(1 + Q1$data.analytics)
Q1$business.analytics = log(1 + Q1$business.analytics)
Q1$augmented.reality = log(1 + Q1$augmented.reality)
Q1$artificial.intelligence = log(1 + Q1$artificial.intelligence)
Q1$virtual.reality = log(1 + Q1$virtual.reality)
Q1$machine.learning = log(1 + Q1$machine.learning)
Q1$business.intelligence = log(1 + Q1$business.intelligence)
Q1$data.science = log(1 + Q1$data.science)
Q1$hadoop = log(1 + Q1$hadoop)
Q1$software.as.a.service = log(1 + Q1$software.as.a.service)
Q1$cloud.comput = log(1 + Q1$cloud.comput)
Q1$platform.as.a.service = log(1 + Q1$platform.as.a.service)
Q1$infrastructure.as.a.service = log(1 + Q1$infrastructure.as.a.service)
Q1$data.center = log(1 + Q1$data.center)
Q1$optimization = log(1 + Q1$optimization)
Q1$data.security = log(1 + Q1$data.security)
Q1$data.mining = log(1 + Q1$data.mining)
Q1$private.cloud = log(1 + Q1$private.cloud)
Q1$hybrid.cloud = log(1 + Q1$hybrid.cloud)
Q1$data.warehous = log(1 + Q1$data.warehous)
Q1$natural.language.processing = log(1 + Q1$natural.language.processing)
Q1$data.proces = log(1 + Q1$data.proces)
Q1$data.stream = log(1 + Q1$data.stream)
Q1$intelligent.system = log(1 + Q1$intelligent.system)
Q1$virtualization.technolog = log(1 + Q1$virtualization.technolog)
Q1$cloud = log(1 + Q1$cloud)
Q1$Company_Tickr = NULL
Q1$Share_Change = as.numeric(Q1$Share_Change)

#Full Model for every year combined
mf <- lm(Share_Change~(GICS.Sector * big.data)+(GICS.Sector*predictive.model)+(GICS.Sector *predictive.analytics)+(GICS.Sector *internet.of.things)+(GICS.Sector *data.analytics)+(GICS.Sector *business.analytics)+(GICS.Sector *augmented.reality)+(GICS.Sector *artificial.intelligence)+(GICS.Sector *virtual.reality)+(GICS.Sector *machine.learning)+(GICS.Sector *business.intelligence)+(GICS.Sector *data.science)+(GICS.Sector *hadoop)+(GICS.Sector *software.as.a.service)+(GICS.Sector *cloud.comput)+(GICS.Sector *platform.as.a.service)+(GICS.Sector *infrastructure.as.a.service)+(GICS.Sector *data.center)+(GICS.Sector *optimization)+(GICS.Sector *data.security)+(GICS.Sector *data.mining)+(GICS.Sector *private.cloud)+(GICS.Sector *hybrid.cloud)+(GICS.Sector *data.warehous)+(GICS.Sector *natural.language.processing)+(GICS.Sector *data.proces)+(GICS.Sector *data.stream)+(GICS.Sector *intelligent.system)+(GICS.Sector *virtualization.technolog)+(GICS.Sector *cloud) ,data = Q1)
summary(mf)

#Evaluating the result, we observe only a few significant words impacting hte mutual fund share's change. Hence, we segment the data by year and run individual models.

#For 2016
Q1_2016 = subset(x = Q1, Year=="2016")
str(Q1_2016)

#For 2015
Q1_2015 = subset(x = Q1, Year=="2015")
str(Q1_2015)

#Eliminating Year Variables
Q1_2016$Year = NULL
Q1_2015$Year = NULL


#Using interaction term of industry and words to evaluate the impact of words among differentindustries
#Multiple Regression for 2016 data. Here, your mutual fund share's change is the dependent variable
str(Q1_2016)
colnames(Q1_2016)
mf_2016 <- lm(Share_Change~(GICS.Sector * big.data)+(GICS.Sector*predictive.model)+(GICS.Sector *predictive.analytics)+(GICS.Sector *internet.of.things)+(GICS.Sector *data.analytics)+(GICS.Sector *business.analytics)+(GICS.Sector *augmented.reality)+(GICS.Sector *artificial.intelligence)+(GICS.Sector *virtual.reality)+(GICS.Sector *machine.learning)+(GICS.Sector *business.intelligence)+(GICS.Sector *data.science)+(GICS.Sector *hadoop)+(GICS.Sector *software.as.a.service)+(GICS.Sector *cloud.comput)+(GICS.Sector *platform.as.a.service)+(GICS.Sector *infrastructure.as.a.service)+(GICS.Sector *data.center)+(GICS.Sector *optimization)+(GICS.Sector *data.security)+(GICS.Sector *data.mining)+(GICS.Sector *private.cloud)+(GICS.Sector *hybrid.cloud)+(GICS.Sector *data.warehous)+(GICS.Sector *natural.language.processing)+(GICS.Sector *data.proces)+(GICS.Sector *data.stream)+(GICS.Sector *intelligent.system)+(GICS.Sector *virtualization.technolog)+(GICS.Sector *cloud) ,data = Q1_2016)
summary(mf_2016)


#Using interaction term of industry and words to evaluate the impact of words among differentindustries
#Multiple Regression for 2015 data. Here, your mutual fund's share is the dependent variable.
mf_2015 <- lm(Share_Change~(GICS.Sector * big.data)+(GICS.Sector*predictive.model)+(GICS.Sector *predictive.analytics)+(GICS.Sector *internet.of.things)+(GICS.Sector *data.analytics)+(GICS.Sector *business.analytics)+(GICS.Sector *augmented.reality)+(GICS.Sector *artificial.intelligence)+(GICS.Sector *virtual.reality)+(GICS.Sector *machine.learning)+(GICS.Sector *business.intelligence)+(GICS.Sector *data.science)+(GICS.Sector *hadoop)+(GICS.Sector *software.as.a.service)+(GICS.Sector *cloud.comput)+(GICS.Sector *platform.as.a.service)+(GICS.Sector *infrastructure.as.a.service)+(GICS.Sector *data.center)+(GICS.Sector *optimization)+(GICS.Sector *data.security)+(GICS.Sector *data.mining)+(GICS.Sector *private.cloud)+(GICS.Sector *hybrid.cloud)+(GICS.Sector *data.warehous)+(GICS.Sector *natural.language.processing)+(GICS.Sector *data.proces)+(GICS.Sector *data.stream)+(GICS.Sector *intelligent.system)+(GICS.Sector *virtualization.technolog)+(GICS.Sector *cloud) ,data = Q1_2015)
summary(mf_2015)


#We see that 2016 has many significant industries and words with respect to the 2015 year data

#Evaluating hte summaries, we c