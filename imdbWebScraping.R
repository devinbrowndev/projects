#load in packages
library(rvest)
library(stringr)

#assign url
url <- "http://www.imdb.com/chart/top"
#read_html() on the url
webpage <- read_html(url)

#rating value
ratingHtml <- html_nodes(webpage,'.imdbRating')
ratingVal <- html_text(ratingHtml)
ratingVal <- as.numeric(ratingVal)


#movie title
titleHtml <- html_nodes(webpage,'.titleColumn')
titleVal <- html_text(titleHtml)
#clean front half of string
titleVal <- gsub("\n      ","", titleVal)
titleVal <- gsub("\n","", titleVal)
titleVal <- trimws(titleVal)

#select the movie year data
movieYear <- str_sub(titleVal, start = -5, end = -2)

#create data frame
movies <- data.frame(titleVal,ratingVal, movieYear)


#simple EDA
?hist
#histogram of rating freq
hist(ratingVal, xlab = 'Ratings', main = 'Ratings of top 250 movies of all time (IMDB)', col='lightblue')
#We see here that there are many more movies with a rating of 8.0 than any other rating > 8.0 and extremely few with ratings above 8.6

#examine yearly average
yearlyAvg <- as.data.frame(aggregate(ratingVal ~ movieYear, data = movies, FUN = mean))
head(yearlyAvg)

#year with the highest aggregate movie rating (1972)
print(yearlyAvg[yearlyAvg$ratingVal == max(yearlyAvg$ratingVal),])

