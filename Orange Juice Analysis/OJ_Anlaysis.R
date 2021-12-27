## Import data
oj<-read.csv('OJ.csv')

## Exploratory data analysis
### Purchase
library(MASS) 
oj.freq = table(oj[,1])  # Make it into a table first
bp<-barplot(oj.freq,main="Distribution of Purchase", ylab='Frequency', xlab='Brand') # With plot title
text(bp, 5, digit.freq,cex=1,pos=3) # For including the data in plot

## Method
### (a) Split
set.seed(123)
flag <-sort(sample(dim(oj)[1],800, replace = FALSE))
oj_train<-oj[flag,]
oj_test<-oj[-flag,]

### (b) Fit a classification tree
library(rpart)
rpart.gini <-rpart(Purchase ~ .,data=oj_train, method="class", parms=list(split="gini"))
summary(rpart.gini)
print(rpart.gini)

## Training Error 
y1hatc <-ifelse(predict(rpart.gini,oj_train)[,2] < 0.5, 0, 1)
sum(y1hatc != oj_train[,1])/length(oj_train[,1])  #Output the training error

### (c) Visualize the tree
install.packages(rpart.plot)
library(rpart.plot)
rpart.plot(rpart.gini, box.palette="RdBu", shadow.col="gray", nn=TRUE)

### (d) Predict
##(di) Testing error
pred<-predict(rpart.gini,oj_test[,-1], type="class")
sum(pred!=oj_test[,1])/length(oj_test[,1])
##(dii) Confusion matrix
con_mat<-table(pred, oj_test[,1])
#### Accuracy
(con_mat[1,1]+con_mat[2,2])/(con_mat[1,1]+con_mat[1,2]+con_mat[2,2]+con_mat[2,1])

### (e) Optimal tree size
plotcp(rpart.gini)
print(rpart.gini$cptable)
opt <- which.min(rpart.gini$cptable[, "xerror"])

### (f) Tree pruning
## (fi) Tree growing with negative cp
rpart.gini_negcp <-rpart(Purchase ~ .,data=oj_train, method="class", parms=list(split="gini"),cp=-0.1)
summary(rpart.gini_negcp)
print(rpart.gini_negcp)


### (fii) Optimal tree size
plotcp(rpart.gini_negcp)
print(rpart.gini_negcp$cptable)
opt_neg <- which.min(rpart.gini_negcp$cptable[, "xerror"])
opt_neg
cp2 <- rpart.gini_negcp$cptable[opt_neg, "CP"]
cp2

### (fiii) Optimal tree size
rpart.pruned1 <- prune(rpart.gini,cp=cp2)
#### Plot
rpart.plot(rpart.pruned1, box.palette="RdBu", shadow.col="gray")

## Training Error 
y2hatc <-ifelse(predict(rpart.pruned1,oj_train)[,2] < 0.5, 0, 1)
sum(y2hatc != oj_train[,1])/length(oj_train[,1])  #Output the training error
### (d) Predict
##(di) Testing error
pred2<-predict(rpart.pruned1,oj_test[,-1], type="class")
sum(pred2!=oj_test[,1])/length(oj_test[,1])
##(dii) Confusion matrix
con_mat2<-table(pred2, oj_test[,1])
#### Accuracy
(con_mat2[1,1]+con_mat2[2,2])/(con_mat2[1,1]+con_mat2[1,2]+con_mat2[2,2]+con_mat2[2,1])


