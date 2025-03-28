library(dplyr)
library(ggplot2)
library(ggforce)


## 例としてアヤメのデータを使用して
## Sepal.Length（がくの長さ）を集計する

# > head(iris)
#   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
# 1          5.1         3.5          1.4         0.2  setosa
# 2          4.9         3.0          1.4         0.2  setosa
# 3          4.7         3.2          1.3         0.2  setosa
# 4          4.6         3.1          1.5         0.2  setosa
# 5          5.0         3.6          1.4         0.2  setosa
# 6          5.4         3.9          1.7         0.4  setosa


## データの集計（例としてSepal.Lengthの値を集計する）
res <- iris |>
    group_by(Species) |>                      ## 変数Speciesで群分け
    summarise(n = n(),                        ## 各群のサンプルサイズ
              Mean = mean(Sepal.Length),      ## 平均値
              SD = sd(Sepal.Length),          ## 標準偏差
              Min = min(Sepal.Length),        ## 最小値
              Median = median(Sepal.Length),  ## 中央値
              Max = max(Sepal.Length))        ## 最大値
print(res)



## 棒グラフとエラーバー（標準偏差）を表示
## 生データも同時にプロット
set.seed(1)
p1 <- ggplot(res, aes(x = Species, y = Mean)) +
    geom_errorbar(aes(ymin = Mean - SD,
                      ymax = Mean + SD),
                  width = 0.3) +               ## エラーバー (+- SD)
    geom_col(fill = "gray60") +                ## 棒グラフ
    geom_sina(data = iris,
              aes(y = Sepal.Length),
              maxwidth = 0.2, alpha = 0.7) +   ## 生データ（透明度0.7）
    labs(y = "Sepal.Length") +                 ## 軸タイトルの設定
    theme_bw()                                 ## 外見の設定（白黒）
print(p1)


## 箱ヒゲ図を表示
## 生データも同時にプロット
set.seed(1)
p2 <- ggplot(iris, aes(x = Species, y = Sepal.Length)) +
    geom_boxplot() +                           ## 箱ヒゲ図
    geom_sina(maxwidth = 0.2, alpha = 0.7) +   ## 生データ（透明度0.7）
    coord_cartesian(ylim = c(0, NA)) +         ## 軸目盛の設定（0から開始）
    theme_bw()                                 ## 外見の設定（白黒）
print(p2)


## バイオリンプロットを表示
## 生データも同時にプロット
set.seed(1)
p3 <- ggplot(iris, aes(x = Species, y = Sepal.Length)) +
    geom_violin() +                            ## バイオリンプロット
    geom_sina(maxwidth = 0.2, alpha = 0.7) +   ## 生データ（透明度0.7）
    coord_cartesian(ylim = c(0, NA)) +         ## 軸目盛の設定（0から開始）
    theme_bw()                                 ## 外見の設定（白黒）
print(p3)

