#### Read microsat data in and convert to genepop format ####
# Andrew Latimer

library(tidyverse)


d <- read.csv("./data/Moleculargenetic data clean 20180221 with general info.csv", skip = 2)
head(d)
names(d)

# get rid of extra columns 
d <- d[ ,c(1, 14:29)]

# extract dimension info
loci <- names(d)[seq(2, 16, by = 2)]
n_loci <- length(loci)
pops <- unique(d$source.pop)
n_pops <- length(pops)

# put zeros (missing data) in genepop format
for (i in 1:ncol(d)) d[,i] <- as.character(d[,i])
d[d=="0"] <- "000"

# combine digits from the two allele columns for each locus 
d_loci <- d %>% unite("locus1", M1Pet, M1Pet.1, sep="") %>%
  unite("locus2", M1Ned, M1Ned.1, sep="") %>%
  unite("locus3", M1Fam, M1Fam.1, sep="") %>%
  unite("locus4", M1Vic, M1Vic.1, sep="") %>%
  unite("locus5", M2Pet, M2Pet.1, sep="") %>%
  unite("locus6", M2Ned, M2Ned.1, sep="") %>%
  unite("locus7", M2Fam, M2Fam.1, sep="") %>%
  unite("locus8", M2Vic, M2Vic.1, sep="")

names(d_loci)


# Write the file 
sink("./data/ecicdata.txt")
cat("This file contains the Erodium cicutarium microsat data for Tina Heger's populations", "\n")
cat("\t", paste(as.character(loci), collapse = ", "), "\n")
for (i in 1:n_pops) {
  cat("Pop", "\n")
  tmp <- filter(d_loci, source.pop == pops[i])
  for (j in 1:nrow(tmp)) {
    cat(pops[i], ", ", as.character(tmp[j, 2:ncol(tmp)]), "\n")
  }
}
sink()
