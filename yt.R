library(tuber)
library(tidyverse)
library(lubridate)
library(stringi)
library(wordcloud)
library(gridExtra)
library(googlesheets)

yt_oauth(app_id = "Your app id", app_secret = "Your app secret", token = '')

gs_upload("C:/Users/urszula.krol/Desktop/List.xlsx", "channels")
gs <- gs_title("channels")
ws <- gs_read(gs, ws = "Sheet1", col_names = FALSE)

for(i in 1:nrow(ws)){
  channel_name <- ws[i,2]
  channel_name <- gsub("[[:blank:]]","", channel_name)
  channel_name <- as.character(channel_name)
  channel_ID <- ws[i,1]
  channel_ID <- as.character(channel_ID)
  stats <- get_all_channel_video_stats(channel_id = channel_ID, force = "TRUE") 
  stats <- stats %>% mutate(date = as.Date(publication_date)) %>% filter(date > "2018-01-01") %>% arrange(date)
  gs2 <- gs_title("stats")
  gs_ws_new(gs2, ws_title = channel_name, input = stats)
}