#membaca data
miopi <- read.csv("D:/myopia.csv")
head(miopi)


#membagi data menjadi dua bagian
library(caret)
acak <- createDataPartition(miopi$myopic, p=0.7, list=FALSE)
data.tr <- miopi[acak,]
data.ts <- miopi[-acak,]

#membuat model menggunakan data training
model.reglog <- glm(myopic ~ spheq + sporthr + readhr +
                      mommy + dadmy, family="binomial",
                    data = data.tr)

#mengukur ketepatan prediksi menggunakan data testing
prediksi.peluang <- predict(model.reglog, newdata=data.ts, 
                    type="response")
prediksi <- ifelse(prediksi.peluang > 0.3, "Yes", "No")
confusionMatrix(as.factor(prediksi), data.ts$myopic,
                positive="Yes")

#ketepatan prediksi jika cut-off diganti 0.2
prediksi <- ifelse(prediksi.peluang > 0.2, "Yes", "No")
confusionMatrix(as.factor(prediksi), data.ts$myopic,
                positive="Yes")

#menggambar plot ROC curve
library(ROCR)
pred <- prediction( prediksi.peluang, data.ts$myopic)
perf <- performance(pred,"tpr","fpr")
plot(perf)
#plot(perf@x.values[[1]], perf@y.values[[1]],type="l")


library(pROC)
roc(data.ts$myopic,prediksi.peluang,
                plot=TRUE, auc.polygon=TRUE, max.auc.polygon=TRUE, grid=TRUE,
                print.auc=TRUE)
