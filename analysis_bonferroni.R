## 多重比較法
##
## 得られたP値を補正する方法
## Bonferroni法およびその改変法

## 検定で得られたP値（例）
pval <- c(0.015, 0.040, 0.001, 0.030)

## Bonferroni法
res <- p.adjust(pval, method = "bonferroni")
print(res)

## Holm法（デフォルト）
res <- p.adjust(pval)
print(res)

