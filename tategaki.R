# 縦書きのために、1行1文字にする函数の定義
tategaki <- function(x){
  x <- chartr("ー", "丨", x) # 長音符の処理
  x <- strsplit(split="", x)
  sapply(x, paste, collapse="\n")
}

# plot() でY軸タイトルを縦書きにする例
plot(rnorm(100), rnorm(100),
     xlab = "これは横書きがうれしいでーす", ylab = "", las = 1)
mtext(tategaki("これは縦書きがうれしいでーす"),
      side = 2, las = 1, line = 3)


# ggplot2 パッケージでY軸タイトルを縦書きにする例
library("ggplot2")
g <- ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point()

g + xlab("ダイアモンドの重さ") +
  ylab(tategaki("ダイアモンドの価格")) +
  theme(axis.title.y = element_text(angle = 0, vjust= 0.5))

# 縦書きのために、1行1文字にする別の函数
# （stringr パッケージを使用）
tategaki_alt <- function(x){
  x <- stringr::str_replace_all(x, "ー", "丨") # 長音符の処理
  stringr::str_wrap(x, width = 1)
}
