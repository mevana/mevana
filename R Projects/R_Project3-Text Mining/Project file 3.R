setwd('C:/Users/madha/Desktop/BigDataAnalytics/chapters')
getwd()
install.packages("tm")
library("tm")
text = VCorpus(DirSource(".",ignore.case = TRUE,mode = "text"))
str(text)
text
# Extracting text ffrom corpus
text_data = text[[1]]
text_data
#Chapter one number of lines
text_data[1]

#A document term matrix (DTM) is one of the most common formats for representing a text corpus (i.e. a collection of texts) in a bag-of-words format.

#A DTM is a matrix in which rows are documents, columns are terms, and cells indicate how often each term occurred in each document.

#The advantage of this representation is that it allows the data to be analyzed with vector and matrix algebra, effectively moving from text to numbers.
#DTM
dtm = DocumentTermMatrix(text)
dtm

#The output signifies that DTM has 10 entries which has over 5145 terms which have appeared at least once.

#Now you are removing those terms which don't appear too often in your data. We will remove any element that doesn't appear in atleast 3% of the entries (or documents).
sparse = removeSparseTerms(dtm, 0.79)
sparse
inspect(dtm)
str(dtm)
#Term document matrix::
tdm = TermDocumentMatrix(text_data)
tdm
sparse = removeSparseTerms(tdm, 0.09)#to make the sparsityof the document 0 
sparse

inspect(tdm)



#Let us make a dataframe
text_df = data.frame(text_data[1])
text_df

#to remove punctuation

removePunctuation(text_data)
removeNumbers(text_data)


removepunct = function(x) gsub("[^[:alpha:][:space:]]*","",x)
removepunct

textcl = tm_map(text,content_transformer(removepunct))

textcl[[1]]

#removed characters from 9687 to 9362 removed 325

#lower case removal
text_Low<-tm_map(textcl, tm::content_transformer(tolower))
tm ::inspect(text_Low)

tm::inspect(text_Low[[1]])
#stopwords
mystopwords = c(tm::stopwords("english"))
mystopwords
str(text_data)

text_stop = tm::tm_map(text_Low,tm::removeWords,mystopwords)
tm::inspect(text_stop[[1]])
#from 7439 it has come down to 6951


textstop_TDM = tm::TermDocumentMatrix(text_stop)
textstop_TDM

freq_terms= tm::findFreqTerms(textstop_TDM,lowfreq = 6)
freq_terms

texttf = tm::termFreq(text_stop[[1]])
texttf

tm::inspect(textstop_TDM)




#dendrogram

textdf = as.data.frame((textstop_TDM[[1]]))
textdist = dist(textdf)
textdg   = hclust(textdist,method = "ward.D2")
str(textdg)
plot(textdg)





