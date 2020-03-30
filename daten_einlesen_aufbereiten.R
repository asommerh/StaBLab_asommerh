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
t0$Time <- "t0"
t1$Time <- "t1"
# Problem: dieses Datenformat ist nicht dasjenige, welches für die Modellberechnung 
# benötigt wird. Stattdessen wäre gut, zuerst die Datensätze t0/t1 auf die wichtigen 
# Variablen zu reduzieren um den Überblick  behalten zu können und die Variablennamen
# anpassen. Danach sollte ein Merging möglich sein, indem nur die Zeilen 
# aneinandergereiht werden

# An welchen Tagen haben die Teilnehmer wie oft teilgenommen?
table(substr(mobile$ScheduledTime, 6, 10), mobile$Participant)  

# Wie viel Prozent einer Zielvariablen sind NA?
sum(is.na(mobile$SleepQuality_1))/nrow(mobile)
sum(is.na(mobile$SleepQuality_2))/nrow(mobile)
sum(is.na(mobile$SleepQuality_3))/nrow(mobile)
sum(is.na(mobile$SleepQuality_4))/nrow(mobile)
# 82 % der Schlafqualität in diesem Beispieldatensatz NA
# Wird schwierig Modell zu berechnen bei so wenigen Daten, 
# wohl eher deskriptive Analyse




