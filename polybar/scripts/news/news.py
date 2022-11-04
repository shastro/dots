#!/usr/bin/python

import requests
import os.path

# path where news are saved in txt (default current directory)
save_path = "/home/shastro/.config/polybar/scripts/news"

# get your api key at https://newsapi.org/
api_key = "cf5c4c612332432e96345f54d2187448"

# find sources & country codes at https://newsapi.org/sources
sources = ""
country = ""
category = "science"

# save_url saves URL so that it is possible to open the news in the browser
# the url will always be the most recent, enable if number_news = 1
save_url = True
number_news = 3


def makestr(data, num_news):

    news_string = ""
    for x in range(number_news):
        sourceName = data["articles"][x]["source"]["name"]
        title = data["articles"][x]["title"]
        news_string += "[" + sourceName + "] " + title + " "

    return news_string


try:
    data = requests.get(
        "https://newsapi.org/v2/top-headlines?apiKey="
        + api_key
        + "&sources="
        + sources
        + "&country=us"
        + country
        + "&category="
        + category
    ).json()

    data2 = requests.get(
        "https://newsapi.org/v2/top-headlines?apiKey="
        + api_key
        + "&sources=hacker-news"
        + sources
    ).json()

    news_string = ""

    news_string += makestr(data, number_news)
    news_string += makestr(data2, 2)

    path = os.path.join(save_path, "current_news.txt")
    f = open(path, "w")
    f.write(news_string)
    f.close()

    if save_url == True:
        url = data["articles"][0]["url"]
        path = os.path.join(save_path, "current_url.txt")
        f = open(path, "w")
        f.write(url)
        f.close()


except requests.exceptions.RequestException as e:
    print("Something went wrong!")
