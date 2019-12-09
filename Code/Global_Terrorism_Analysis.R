#INFM600
#AbracaData
#Analysis of Global Terrorism 

#load the 2010 Survey - Student Data - 437 responses.csv
gtd <- read.csv(file.choose())

#number of variables and observations
dim(gtd)

#View the first 10 rows of thedataset
head(gtd, 10)

#Create a subset (Cleaning)
gtd2001 <- subset(gtd,gtd$iyear>=2001) 

#View the first 5 rows of the subset 
head(gtd2001, 5)

#Write the subset to a csv file
write.csv(gtd2001,"gtd2001.csv")

#Attaching a dataset
attach(gtd2001)

#Columns for subset
columns <- c("iyear","country","country_txt","region","region_txt","provstate","city","latitude","longitude","summary","success","suicide","attacktype1","attacktype1_txt","targtype1","targtype1_txt","targsubtype1","targsubtype1_txt","natlty1","natlty1_txt","gname","claimed","claimmode","guncertain1", "motive","weaptype1","weaptype1_txt","nkill", "nwound", "property","propextent","propextent_txt")

#new dataset for selected columns
newgtd2001 <- gtd2001[columns]

View(newgtd2001) 
head(newgtd2001, 10)

#Writing to a new csv file
write.csv(newgtd2001,"newgtd2001.csv") 

grp <- subset(newgtd2001, gname == 'Taliban')
grp1 <- subset(grp, grp$country_txt == 'Afghanistan')
grp1 <- subset(grp, grp$country_txt != 'Afghanistan')

#Analysing incidents in Iraq
install.packages('plyr')
library(plyr)
iraq <- subset(newgtd2001, country_txt == 'Iraq')
count(iraq, 'gname')

#correlation test between number of people killed and property damaged
cor.test(newgtd2001$nkill, newgtd2001$propextent)
plot(newgtd2001$nkill, newgtd2001$propextent)
abline(lm(newgtd2001$nkill~newgtd2001$propextent))

#Factoring
newgtd2001$attacktype1 <- factor(newgtd2001$attacktype1)
newgtd2001$success <- factor(newgtd2001$success)
newgtd2001$weaptype1 <- factor(newgtd2001$weaptype1)
newgtd2001$targtype1 <- factor(newgtd2001$targtype1)
newgtd2001$suicide <- factor(newgtd2001$suicide)


#South Asia
South_Asia <- newgtd2001[newgtd2001$region_txt == "South Asia",]
India <- newgtd2001[newgtd2001$country_txt == "India",]
Bangladesh <- newgtd2001[newgtd2001$country_txt == "Bangladesh",]

#Adjustments
Bangladesh <- Bangladesh[Bangladesh$targtype1!=11,]


#Factoring
India$guncertain1 <- factor(India$guncertain1)
India$claimed<- factor(India$claimed)
India$suicide<- factor(India$suicide)
India$claimmode<- factor(India$claimmode)
Bangladesh$suicide<- factor(Bangladesh$suicide)
Bangladesh$claimed<- factor(Bangladesh$claimed)
Bangladesh$claimmode<- factor(Bangladesh$claimmode)


#train the model to predict the number of people killed
linear_model <- glm(nkill ~ attacktype1*claimed + suicide, data=India)
summary(fitted.values(linear_model))
hist(fitted.values(linear_model), breaks = 20, main ="Linear Regression Prediction")

#test the model
linear_prediction <- predict(linear_model, data=Bangladesh,type="response")
summary(linear_prediction)
hist(linear_prediction, breaks = 20, main="Linear Regression Prediction") 

