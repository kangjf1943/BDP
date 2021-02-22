library(RMeCab)
library(pdftools)
library(wordcloud)

setwd("C:/Users/kangj/Documents/R/BDP/Policy_pdf")
for (i in list.files("C:/Users/kangj/Documents/R/BDP/Policy_pdf")) {
  Sys.setlocale(category = "LC_ALL", locale = "Japanese")
  policy_text <- pdf_text(i)
  # 文本显示为日语吗？
  nchar(policy_text)
  
  # 文本处理
  class(policy_text)
  length(policy_text)
  # 删除特殊字符
  policy_text <- gsub("\r", "", policy_text)
  policy_text <- gsub("\n", "", policy_text)
  policy_text <- gsub("@", "", policy_text)
  policy_text
  # 删除数字
  
  # 日语分词怎么做？
  # 消除停止词之后直接分析词频吧
  # 先写入该文档
  write(policy_text, paste("C:/Users/kangj/Documents/R/BDP/Policy_text/",i,".txt", sep = ""))
}

# 写入的文档是ANSI编码，但直接用RMecab分析的话有时会显示乱码？
policy_freq <- RMeCabFreq("Policy.txt")
policy_freq
head(policy_freq)
policy_freq_sort <- policy_freq[order(policy_freq$Freq, decreasing = TRUE),]
head(policy_freq_sort, 20)
tail(policy_freq_sort)
policy_freq_sort_non <- subset(policy_freq_sort, Info1 == "名詞")
nrow(policy_freq_sort_non)
head(policy_freq_sort_non, 20)
policy_freq_sort_non <- subset(policy_freq_sort_non, Info2 != "非自立")
policy_freq_sort_non <- subset(policy_freq_sort_non, Info2 != "接尾")
nrow(policy_freq_sort_non)
head(policy_freq_sort_non, 20)
