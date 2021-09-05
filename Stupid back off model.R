library(sbo)

train <- readRDS(file = "./train.rds")
# valid <- readRDS(file = "./valid.rds")

# head(train,3)

# Create prediction object using the 'sbo' library

predictorTable <- sbo_predtable(object = train,
                   N = 5,
                   dict = target ~ 1,
                   .preprocess = sbo::preprocess,
                   EOS = ".?!:;",
                   lambda = 0.4,
                   L = 5L,
                   filtered = "<UNK>")



predictor <- sbo_predictor(predictorTable)



rm(train, predictorTable)

saveRDS(predictor, file = "predictor.rds")


