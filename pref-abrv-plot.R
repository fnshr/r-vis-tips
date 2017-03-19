library("tidyverse")
library("ggrepel")
library("stringr")

# 準備
##########################
# 
# 都道府県別の進学率データの読み込み
ent_rate <- read_csv("data/entrance-rate-by-prefs.csv")

# 都道府県名を一覧したデータフレームを作る
pref_df <- read_csv("pref-names.csv")

# 統合
ent_rate <- full_join(ent_rate, pref_df, by = "Code")

# plot を使って同県内進学率と卒業者進学率の散布図を作成
##########################
# 「神奈川」のように県名を普通に表記する
# plot の枠組みを作る
plot(ent_rate$Same_pref_rate, ent_rate$Univ_ent_rate, type="n")
# 県名をプロットする
text(ent_rate$Same_pref_rate, ent_rate$Univ_ent_rate,
     labels = ent_rate$Name_kanji)

# 「神」のように県名を1文字で表記する
# plot の枠組みを作る
plot(ent_rate$Same_pref_rate, ent_rate$Univ_ent_rate, type="n")
# 県名をプロットする
text(ent_rate$Same_pref_rate, ent_rate$Univ_ent_rate,
     labels = ent_rate$Name_one_char)



# ggplot2 を使って同県内進学率と卒業者進学率の散布図を作成
##########################
# ggplot オブジェクトの作成
g <- ggplot(ent_rate, 
            aes(x = Same_pref_rate, y = Univ_ent_rate))
# 「神奈川」のように県名を普通に表記する
g + geom_text(aes(label = Name_kanji))
# 「神」のように県名を1文字で表記する
g + geom_text(aes(label = Name_one_char))

# もう少し色々な要素があるようにする
g2 <- g + geom_point() +
  xlab("出身高校所在地県の大学への入学者割合（対大学入学者数）") +
  ylab(stringr::str_wrap("高等学校卒業者の進学率", width=1)) +
  theme_bw() +
  theme(axis.title.y = element_text(angle = 0, vjust= 0.5))

# 点＋県名（1文字）
g2 + geom_text_repel(aes(label = Name_one_char))

