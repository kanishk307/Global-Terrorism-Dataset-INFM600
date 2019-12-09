grp <- subset(data, gname == 'Taliban')
grp1 <- subset(grp, grp$country_txt == 'Afghanistan')
grp1 <- subset(grp, grp$country_txt != 'Afghanistan')

#Analysing Iraq
iraq <- subset(data, country_txt == 'Iraq')
count(iraq, 'gname')
