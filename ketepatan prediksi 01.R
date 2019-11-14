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
