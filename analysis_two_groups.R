## 対応のない2群の検定
##
## 対応のないt検定（非推奨）
## Welch検定（推奨）
##
## Wilcoxonの順位和検定（Mann-Whitny検定）（正確版）
## （注意点）**2群の母集団の形状が同じである**という仮定が必要であるため非推奨

library(readxl)
library(dplyr)


## Excelファイルからデータを読み込む場合
library(readxl)
dat <- read_xlsx("data/data_mean.xlsx")

## データを直接入力する場合
x <- c(15, 16, 17, 21, 21, 22, 25, 26, 29, 31)
y <- c(20, 21, 24, 27, 28, 29, 29, 31, 33, 34)
dat <- data.frame(
    group = c(rep("x", length(x)), rep("y", length(y))),
    value = c(x, y)
)


## Welch検定
## 2群の母分散が等しい（等分散）あるいは異なる（不等分散）を考慮する必要がない
res <- t.test(value ~ group, data = dat)
print(res)

## 対応のないt検定
## 2群の母分散が等しい（等分散）という仮定が必要
res <- t.test(value ~ group, var.equal = TRUE, data = dat)
print(res)


## Wilcoxonの順位和検定
library(coin)

## wilcox_test関数は群分け変数がカテゴリカル変数の必要があるため変換
dat$group <- factor(dat$group)
res <- wilcox_test(value ~ group, distribution = "exact", data = dat)
print(res)

