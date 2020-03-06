library(reshape2)

##2013 PSA Data
#setwd("~/Desktop/Aus_Salt_2013/")
PSA=read.csv("PSA.cleaned.csv")
PSA=PSA[PSA$Treatment == "Control" ,]
PSA=PSA[PSA$DayOfImaging < 16 ,]
PSA=PSA[PSA$DayOfImaging > 7 ,]

PSA$Treatment=NULL

###Pad dataset with NA's
####This is jus to make sure there is an equal number of obervations, reps, experiments for each line.
####Required for fitting residual variance structures in ASREML 
PSA=dcast(PSA, NSFTV.ID + Exp + Rep ~ DayOfImaging, value.var="PSA")
PSA=melt(PSA, id.vars=c("NSFTV.ID", "Exp", "Rep"))
colnames(PSA)[4:5]=c("DayOfImaging", "PSA")

PSA=dcast(PSA, NSFTV.ID + Exp + DayOfImaging ~ Rep, value.var="PSA")
PSA=melt(PSA, id.vars=c("NSFTV.ID", "Exp", "DayOfImaging"))
colnames(PSA)[4:5]=c("Rep", "PSA")

PSA=dcast(PSA, NSFTV.ID + Rep + DayOfImaging ~ Exp, value.var="PSA")
PSA=melt(PSA, id.vars=c("NSFTV.ID", "Rep", "DayOfImaging"))
colnames(PSA)[4:5]=c("Exp", "PSA")

PSA=PSA[order(PSA$NSFTV.ID, PSA$Exp, PSA$Rep, PSA$DayOfImaging) ,]

write.csv(PSA, "~/Desktop/Stat892/Phenotypes/Aus2013_PSA.csv", row.names = F)
rm(PSA)

##2014 PSA data
#setwd("~/Desktop/Aus_2014/")
PSA=read.csv("AllExp_cleaned.csv")
PSA=PSA[PSA$Treatment == "Control" ,]
PSA=PSA[PSA$DayOfImaging < 10 ,]
PSA$Treatment=NULL

###Pad dataset with NA's
####This is jus to make sure there is an equal number of obervations, reps, experiments for each line.
####Required for fitting residual variance structures in ASREML 
PSA=dcast(PSA, NSFTV.ID + Exp + Rep ~ DayOfImaging, value.var="PSA")
PSA=melt(PSA, id.vars=c("NSFTV.ID", "Exp", "Rep"))
colnames(PSA)[4:5]=c("DayOfImaging", "PSA")

PSA=dcast(PSA, NSFTV.ID + Exp + DayOfImaging ~ Rep, value.var="PSA")
PSA=melt(PSA, id.vars=c("NSFTV.ID", "Exp", "DayOfImaging"))
colnames(PSA)[4:5]=c("Rep", "PSA")

PSA=dcast(PSA, NSFTV.ID + Rep + DayOfImaging ~ Exp, value.var="PSA")
PSA=melt(PSA, id.vars=c("NSFTV.ID", "Rep", "DayOfImaging"))
colnames(PSA)[4:5]=c("Exp", "PSA")

PSA=PSA[order(PSA$NSFTV.ID, PSA$Exp, PSA$Rep, PSA$DayOfImaging) ,]

write.csv(PSA, "~/Desktop/Stat892/Phenotypes/Aus2014_PSA.csv", row.names = F)


###PSA from Plant Genome
PSA=read.csv("~/Desktop/Stat892/Phenotypes/PSA_PG_LSMeans.csv")
PSA.2013=PSA[, colnames(PSA) %in% c("NSFTV.ID", colnames(PSA)[grep("_2013", colnames(PSA) )] ) ]
PSA.2014=PSA[, colnames(PSA) %in% c("NSFTV.ID", colnames(PSA)[grep("_2014", colnames(PSA) )] ) ]



write.csv(PSA.2013, "~/Desktop/Stat892/Phenotypes/PG2013_PSA.csv", row.names = F)
write.csv(PSA.2014, "~/Desktop/Stat892/Phenotypes/PG2014_PSA.csv", row.names = F)
