gtd = read.csv(file.choose()) #Read the main file
View(gtd) #View the dataset
gtd2001=subset(gtd,gtd$iyear>=2001) #Create a subset (Cleaning)
View(gtd2001)
write.csv(gtd2001,"gtd2001.csv") #Write the subset to a csv file
attach(gtd2001) #Attaching a dataset
#Columns for subset
columns <- c("iyear","country","country_txt","region","region_txt","provstate","city","latitude","longitude","summary","success","suicide","attacktype1","attacktype1_txt","targtype1","targtype1_txt","targsubtype1","targsubtype1_txt","natlty1","natlty1_txt","gname","motive","weaptype1","weaptype1_txt","nkill","property","propextent","propextent_txt")
newgtd2001 <- gtd2001[columns] #new dataset for selected columns
View(newgtd2001) 
write.csv(newgtd2001,"newgtd2001.csv") #Writing to a new csv file

