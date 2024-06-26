## 割合の差の検定（独立性の検定）
## カイ二乗検定

###############################
## 集計済みのデータを使用してカイ二乗検定を行う場合（非推奨）
###############################

## データの準備
## matrix関数で 2 x 2 のデータに変換する
dat <- matrix(c(36, 54, 14, 46), 2, 2, byrow = TRUE)

## カイ二乗検定
## （重要）**連続性の補正を行わない**ために correct = FALSE を指定する
res <- chisq.test(dat, correct = FALSE)
print(res)


###############################
## 生データを使用してカイ二乗検定を行う場合
###############################

## Excelファイルからデータを読み込み
library(readxl)
dat <- read_xlsx("data/data_prop.xlsx")

####################
## 集計表（クロス表）の作成
####################

## xtabs関数を使用してクロス表を作成することができる
## ただし、各要因（ここでは exposure, onset）内の順序が
## 期待しているものと異なることが多い
tbl1 <- xtabs(~ exposure + onset, data = dat)
print(tbl1)

## このデータを使用してカイ二乗検定を行うことも可能である
res <- chisq.test(tbl1, correct = FALSE)
print(res)


###############################
## クロス表を作成せずに生データを使用してカイ二乗検定を行う場合
###############################

## coin パッケージの chisq_test 関数を使用する
## （注意点）
## この関数は2変数ともカテゴリカル変数であることが必要である
## - factor (fct)
##
## 元データは数字 (0, 1) として入力されており、
## このままでは解析することができない
## そのため
## カテゴリカル変数に変換したものを元のデータに追加する
## （元のデータに上書きしてもよいが、残しておきたい）
##
## （解説）
## factor関数で変数の内容をカテゴリカルデータに変換する
## - levels でカテゴリー内の順序を指定することができる
## - labels で名前をつけることができる
##
dat$exposureF <- factor(dat$exposure, levels = c(1, 0), labels = c("+", "-"))
dat$onsetF <- factor(dat$onset, levels = c(1, 0), labels = c("+", "-"))

## （発展的内容）
## dplyrパッケージのmutate関数を使用することで
## このように書くことも可能
dat <- dat |>
    mutate(exposureF = factor(exposure, levels = c(1, 0), labels = c("+", "-")),
           onsetF = factor(onset, levels = c(1, 0), labels = c("+", "-")))

####################
## カイ二乗検定
####################
library(coin)
res <- chisq_test(onsetF ~ exposureF, data = dat)
print(res)

