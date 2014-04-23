## Part 1 starts from here
xte <- read.table("./test/X_test.txt", header=FALSE)
yte <- read.table("./test/y_test.txt", header=FALSE)
ste <- read.table("./test/subject_test.txt", header=FALSE)
xtr <- read.table("./train/X_train.txt", header=FALSE)
ytr <- read.table("./train/y_train.txt", header=FALSE)
str <- read.table("./train/subject_train.txt", header=FALSE)
dfte <- cbind(ste, xte, yte)     ## Generate the testing data frame
dftr <- cbind(str, xtr, ytr)     ## Generate the training data frame
df <- rbind(dfte, dftr)          ## combine the two data frames into a giant one, 'df'
ncol(df)
nrow(df)                         ## Check the dimensions of the giant data frame, 'df'



all(colSums(is.na(df)))==0       ## check the existance of NAs in 'df'

## Part 1 ends up here
## Part 2 through Part 4 starts from here

fea <- read.table("./features.txt", header=FALSE)
coln <- fea[,2]                 ## Read the features names as 'coln'
coln <- as.character(coln)
coln[c(1,2)] = c("AA","BB")
length(coln)

names(df) <- coln               ## Assign 'coln' as column names of 'df'
df[1:10,1:6]

a <- seq(203,255,length=5)
b <- seq(505,544,length=4)
c <- c(a,b)
d <- c 1
e <- c(c,d)
e                               ## Manually select names of variables, within which there are both "Mag" and "mean()/std()"

coln2 <- coln[e]
coln2

df2 <- df[,coln2]               ## Subset 'df', leaving only the foreametioned variables
Activity_No. <- df[,563]        ## Subset the column of numbers representing activity features

Activity_Name2<-character()
for(i in 1:10299){
  if(Activity_No.[i]=="1"){Activity_Name2[i]<-"WALKING"}
  if(Activity_No.[i]=="2"){Activity_Name2[i]<-"WALKING_UPSTAIRS"}
  if(Activity_No.[i]=="3"){Activity_Name2[i]<-"WALKING_DOWNSTAIRS"}
  if(Activity_No.[i]=="4"){Activity_Name2[i]<-"SITTING"}
  if(Activity_No.[i]=="5"){Activity_Name2[i]<-"STANDING"}
  else{Activity_Name2[i]<-"LAYING"}  ## Interpret activity numbers into activity names, which are more readable and understandable
}


df2 <- cbind(Activity_Name2, df2)
df2 <- cbind(Activity_No., df2)


Subject <- df[,1]                    ## Subset the column representing subjects
CleanData <- cbind(Subject, df2)     ## Generate the alleged "clean data frame"
ncol(CleanData)
nrow(CleanData)                      ## Check its dimensions

## Part 2 through Part 4 ends up here
## Part 5 starts from here

library(reshape2)
CleanData_Melt1 <- melt(CleanData, id=c("Subject","Activity_Name2"), measure.vars=Measure.Vars)
CleanData_Means1 <- dcast(CleanData_Melt1, Subject ~ variable, mean)
nrow(CleanData_Means1)
ncol(CleanData_Means1)

CleanData_Melt2 <- melt(CleanData, id=c("Subject","Activity_Name2"), measure.vars=Measure.Vars)
CleanData_Means2 <- dcast(CleanData_Melt2, Activity_Name2 ~ variable, mean)
nrow(CleanData_Means2)
ncol(CleanData_Means2)               ## Get the clean data with the average of each variable for each activity and each subject

write.table(df, file = "./Merged_Data Frame.txt", row.names = FALSE, quote = TRUE)
write.table(CleanData, file = "./CleanData.txt", row.names = FALSE, quote = TRUE)
write.table(CleanData_Means1, file = "./CleanData_Means_Subject.txt", row.names = FALSE, quote = TRUE)
write.table(CleanData_Means2, file = "./CleanData_Means_Activity_Name.txt", row.names = FALSE, quote = TRUE)
                                     ## Save as .txt files to the working directory

## Part 5 ends up here

