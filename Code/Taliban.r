newgtd = read.csv(file.choose()) #Load the dataset
taliban = subset(newgtd,newgtd$gname=="Taliban") #Create a subset
plot(taliban$country_txt) #A bar graph (Later made in Tableau)
write.csv(taliban,"taliban.csv") #Exporting to csv
