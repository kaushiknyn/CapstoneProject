library(tm)
library(dplyr)
library(stringr)
library(caTools)

# Load the data

en_US_blog <- readLines("./Coursera-SwiftKey/final/en_US/en_US.blogs.txt", encoding = 'UTF-8')
en_US_news <- readLines("./Coursera-SwiftKey/final/en_US/en_US.news.txt", encoding = 'UTF-8')
en_US_twitter <- readLines("./Coursera-SwiftKey/final/en_US/en_US.twitter.txt", encoding = 'UTF-8')

combinedRaw <- c(en_US_blog, en_US_news, en_US_twitter)

# Sample the data

set.seed(4567)

n = 1/50

combinedSample <- sample(combinedRaw, length(combinedRaw) * n)


# Initial cleaning

# Remove profanity

profanity <- readLines("./ProfanityList.txt", encoding = 'UTF-8')

sampleClean <- removeWords(combinedSample, profanity)

# Remove stop words

sampleClean <- removeWords(sampleClean, stopwords())

# Rmove non alpha neumeric characters and numbers

sampleClean <- gsub('[^[:alnum:]]', ' ', sampleClean)

sampleClean <- gsub('[[:digit:]]+', ' ', sampleClean)

# Remove white space

sampleClean <- str_squish(sampleClean)

rm(en_US_blog, en_US_news, en_US_twitter, combinedRaw, combinedSample)


# Split into training and validation datasets

split <- sample.split(sampleClean, 0.8)
train <- subset(sampleClean, split == T)
valid <- subset(sampleClean, split == F)

saveRDS(train, file = 'train.rds')
saveRDS(valid, file = 'valid.rds')