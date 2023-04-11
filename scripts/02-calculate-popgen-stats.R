#### Calculate basic popgen stats about Ecic populations using genepop ####
# Andrew Latimer 

library(genepop)

basic_info(inputFile = "./data/ecicdata.txt", outputFile = "./working-data/ecic-basic-info.txt")

Fst(inputFile = "./data/ecicdata.txt", outputFile = "./working-data/ecic-Fst.txt", verbose = FALSE, pairs = TRUE)
