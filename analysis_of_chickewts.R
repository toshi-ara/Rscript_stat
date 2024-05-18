## 多重比較法
##
## Tukey-Kramer法（等分散を仮定する方法）
## Games-Howell法（等分散・不等分散を考慮する必要のない方法：推奨）

library(rstatix)

## Tukey-Kramer法（等分散を仮定する方法）
res <- tukey_hsd(chickwts, weight ~ feed)
print(res)


## Games-Howell法（等分散・不等分散を考慮する必要のない方法：推奨）
res <- games_howell_test(chickwts, weight ~ feed)
print(res)

## パイプ (|>) を使用した場合（こちらでも同じ）
res <- chickwts |>
    games_howell_test(weight ~ feed)
print(res)

