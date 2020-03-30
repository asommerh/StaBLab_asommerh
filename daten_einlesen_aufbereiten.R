###############################################
####### Daten einlesen und aufarbeiten ########
###############################################

# falls die Packete haven und xlsx nicht installiert sind,
# werden sie hier installiert
for (package in c("haven", "xlsx", "dplyr")) {
  if (!(package %in% dimnames(installed.packages())[[1]])) {
    install.packages(package)
  }
}

library(haven)
library(xlsx)
library(dplyr)
#------------
# Daten einlesen
mobile <- read.xlsx("mobileQ_data_example.xlsx", 1)
t0 <- read_spss("Unipark_t0_example.sav")
t1 <- read_spss("Unipark_t1_example.sav")

# Versuchspersonencodebenennung vereinheitlichen, Benennung aus mobile als Standard
names(t0)[1] <- names(t1)[1] <- "Participant"
fragebogen_daten <- full_join(t0, t1, by = "Participant")
# Warum gibt es in t0 auch eine Variable deren Name bereits auf t1 ended?

