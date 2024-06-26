## 複数の列で同じ解析を行う場合の例
## 今回は3列のデータでWelch検定を行う

library(dplyr)
library(tidyr)
library(purrr)
library(readxl)


## Excelファイルからデータを読み込み
dat <- read_xlsx("data/data_multiple_column.xlsx")


## 地道に1列ずつ解析を行う場合（慣れるまではこの方法で行う方がよい）
resA <- t.test(A ~ group, data = dat)
resB <- t.test(B ~ group, data = dat)
resC <- t.test(C ~ group, data = dat)
print(resA)
print(resB)
print(resC)


## まとめて解析を行う場合
## 縦長形式に変換 → 元の列ごとにデータ分割 → それぞれWelch検定、P値取り出し

res <- dat |>
    pivot_longer(A:C, names_to = "item", values_to = "value") |>
    group_by(item) |>
    nest() |>
    mutate(pval = map_dbl(data, ~
                          t.test(value ~ group, data = .)$p.value))
print(res)

