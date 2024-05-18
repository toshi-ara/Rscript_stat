## 割合の差の検定（独立性の検定）
## カイ二乗検定


## 集計済みのデータでカイ二乗検定を行う場合
## データの準備
dat <- matrix(c(36, 54, 14, 46), 2, 2, byrow = TRUE)

## カイ二乗検定
## **連続性の補正を行わない**ために correct = FALSE を指定する
res <- chisq.test(dat, correct = FALSE)
print(res)


## 生データからカイ二乗検定を行う場合
## Excelファイルからデータを読み込み
library(readxl)
dat <- read_xlsx("data/data_prop.xlsx")

## カテゴリカル変数に変換したものを元のデータに追加
dat$exposureF <- factor(dat$exposure, levels = c(1, 0), labels = c("+", "-"))
dat$onsetF <- factor(dat$onset, levels = c(1, 0), labels = c("+", "-"))

library(coin)
res <- chisq_test(onsetF ~ exposureF, data = dat)
print(res)


## 集計表の確認
tbl1 <- xtabs(~ exposureF + onsetF, data = dat)
print(tbl1)

