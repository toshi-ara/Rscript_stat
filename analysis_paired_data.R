## 対応のある2群の検定
##
## 対応のあるt検定
## Wilcoxonの符号付順位検定（正確版）

library(readxl)
library(dplyr)
library(tidyr)

## Excelファイルからデータを読み込む場合
## 個体識別のための変数（この例では ID）が必須
dat <- read_xlsx("data/data_mean_paired.xlsx")

## データを直接入力する場合
x <- c(15, 16, 17, 21, 21, 22, 25, 26, 27, 29)
y <- c(26, 21, 24, 23, 20, 24, 29, 31, 29, 28)
dat <- data.frame(
    ID = rep(seq_len(length(x)), 2),
    group = c(rep("x", length(x)), rep("y", length(y))),
    value = c(x, y)
)


## 対応のあるt検定
## この場合には横広形式に変換する
## 各個体のデータを対応させるためにIDが必要になる
dat_w <- dat |>
    pivot_wider(names_from = group, values_from = value)

res <- t.test(dat_w$x, dat_w$y, paired = TRUE)
print(res)



## Wilcoxonの符号付順位検定（正確版）
## IDと群分け変数 (group) をカテゴリカル変数に変換（この関数を使用するときは必須）
dat <- dat |>
    mutate(ID = factor(ID), group = factor(group))

library(coin)
res <- wilcoxsign_test(value ~ group | ID, distribution = "exact", data = dat)
print(res)

## 0がある場合にSPSSと同じ結果にする場合
wilcoxsign_test(value ~ group | ID, distribution = "exact", zero.method = "Wilcoxon", data = dat)

