library(readxl)
library(dplyr)
library(ggplot2)
library(ggforce)

dat <- read_xlsx("data/data_mean.xlsx")


## データの集計
res <- dat |>
    group_by(group) |>                 ## 変数groupで群分け
    summarise(n = n(),                 ## サンプルサイズ
              Mean = mean(value),      ## 平均値
              SD = sd(value),          ## 標準偏差
              Median = median(value))  ## 中央値
print(res)



## 棒グラフとエラーバー（標準偏差）を表示
## 生データも同時にプロット
set.seed(1)
p1 <- ggplot(res, aes(x = group, y = Mean)) +
    geom_col(fill = "gray60") +                ## 棒グラフ
    geom_errorbar(aes(ymin = Mean - SD,
                      ymax = Mean + SD),
                  width = 0.3) +               ## エラーバー (+- SD)
    geom_sina(data = dat, aes(y = value),
              maxwidth = 0.2) +                ## 生データ
    labs(x = "Group", y = "Value") +           ## 軸タイトルの設定
    theme_bw()                                 ## 外見の設定（白黒）
print(p1)


## 箱ヒゲ図を表示
## 生データも同時にプロット
set.seed(1)
p2 <- ggplot(dat, aes(x = group, y = value)) +
    geom_boxplot() +                           ## 箱ヒゲ図
    geom_sina(data = dat, aes(y = value),
              maxwidth = 0.2) +                ## 生データ
    coord_cartesian(ylim = c(0, NA)) +         ## 軸目盛の設定（0から開始）
    labs(x = "Group", y = "Value") +           ## 軸タイトルの設定
    theme_bw()                                 ## 外見の設定（白黒）
print(p2)


## バイオリンプロットを表示
## 生データも同時にプロット
set.seed(1)
p3 <- ggplot(dat, aes(x = group, y = value)) +
    geom_violin() +                            ## バイオリンプロット
    geom_sina(data = dat, aes(y = value),
              maxwidth = 0.2) +                ## 生データ
    coord_cartesian(ylim = c(0, NA)) +         ## 軸目盛の設定（0から開始）
    labs(x = "Group", y = "Value") +           ## 軸タイトルの設定
    theme_bw()                                 ## 外見の設定（白黒）
print(p3)

