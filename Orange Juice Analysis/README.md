# Orange Juice Analysis

For details, please check the report [HERE](https://github.com/yovalishere/Supply-Chain/blob/main/Orange%20Juice%20Analysis/OJ_Report.pdf)
### Project description
This project uses **decision tree** to classify whether customer purchase
Citrus Hill or Minute Maid Orange Juice. The model will be optimised with tree pruning
methods and their respective performance will be compared. 

### Data description
The [OJ dataset](https://rdrr.io/cran/ISLR/man/OJ.html) is part of the ISLR package in R. It consists of 1070 rows of purchase
record. There are 17 attributes including the predicting variable (ie. Purchase).

### Project findings.
The classification tree is pruned to 4 as suggested graphically.<br><br>
<img src="https://github.com/yovalishere/Supply-Chain/blob/main/Orange%20Juice%20Analysis/Tree%20size%20optimised.jpg" width="600" height="350" />

However, the performance of the unpruned tree is slightly better than the pruned one in terms of accuracy and testing errors. <br>
<img src="https://github.com/yovalishere/Supply-Chain/blob/main/Orange%20Juice%20Analysis/Summary%20table.jpg" width="400" height="150" />
