miopi <- read.csv("D:/myopia.csv")

#install.packages("Information")
library(Information)

#kelas target diubah jadi binary
miopi$miopi <- ifelse(miopi$myopic == "Yes", 1, 0)

#membuang kolom yang yang tidak digunakan
miopi <- miopi[,-c(1, 2, 3, 4)]

#menghitung WoE dan IV
IV <- create_infotables(data=miopi, y="miopi", bins=8, parallel=FALSE)

#menampilkan IV
IV_Value = data.frame(IV$Summary)
IV_Value

#menampilkan WoE variabel "MOMMY"
print(IV$Tables$mommy, row.names=FALSE)





