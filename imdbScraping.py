#Practice project w/ basic web scraping

from bs4 import BeautifulSoup
from requests import get
import pandas as pd
import numpy as np
import re

#set url
url = 'http://www.imdb.com/chart/top'
response = get(url)
html_soup = BeautifulSoup(response.text, 'html.parser')

#constructing the title column
titleCol = html_soup.find_all('td', class_='titleColumn')
titles = [title.get_text() for title in titleCol]
titles = np.array(titles)
titles = pd.Series(titles, name = 'MovieTitle')
titles = titles.str.replace('\n','')
titles = titles.str.replace('[0-9]','')
titles.head()

#data clean
titles = titles.str.replace('(','')
titles = titles.str.replace(')','')
titles = titles.str.replace('.','')
titles = titles.str.replace('^\s+','')

titles = pd.Series(titles)
titles.head()

#construct rating column
ratingCol = html_soup.find_all('td', class_='imdbRating')
ratingCol = [rating.get_text() for rating in ratingCol]
ratingCol = np.array(ratingCol)
ratingCol = pd.to_numeric(ratingCol)
ratingCol = pd.Series(ratingCol, name = 'Rating')

#construct title + rating dataframe
imdbRatings = pd.DataFrame({'title': titles, 'rating':ratingCol})
imdbRatings = imdbRatings[['title','rating']]
imdbRatings.head()
