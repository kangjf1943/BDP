library(RMeCab)
library(pdftools)
library(wordcloud)
library(tm)

# set computer "Language for non-Unicode programs settings" and Japanese without "Use Unicode UTF-8 for worldwide language support": Settings > Region > Additional date, time & regional > Change date, time, or number format > Administrative > Language for non-Unicode programs settings
Sys.setlocale(category = "LC_ALL", locale = "Japanese")
setwd("C:/Users/kangj/Documents/R/BDP/Policy_pdf")
for (i in list.files("C:/Users/kangj/Documents/R/BDP/Policy_pdf")) {
  Policy_txt <- pdf_text(i)
  write(Policy_txt, paste("C:/Users/kangj/Documents/R/BDP/Policy_txt/", 
                           gsub(".pdf", "", i),".txt", sep = ""))
}
setwd("C:/Users/kangj/Documents/R/BDP")

# 建立语料库
policy_corpus <- VCorpus(DirSource("Policy_txt"))
# 数据清理
func_clean_corpus <- function(var_corpus){
  var_corpus <- tm_map(var_corpus, removePunctuation)
  var_corpus <- tm_map(var_corpus, removeNumbers)
  # 批量替换特定字符的函数是？
  # 如何删除停止词？
  return(var_corpus)
}
policy_corpus <- func_clean_corpus(policy_corpus)
if(!file.exists("Policy_corpus")){dir.create("Policy_corpus")}
if(length(list.files("Policy_corpus")) != 0)
  {file.remove(paste0("Policy_corpus/", list.files("Policy_corpus")))}
writeCorpus(policy_corpus, "Policy_corpus")
file.rename(from = paste0("Policy_corpus/",list.files("Policy_corpus")),
            to = paste0("Policy_corpus/",
                        gsub("txt", "", list.files("Policy_corpus"))))


