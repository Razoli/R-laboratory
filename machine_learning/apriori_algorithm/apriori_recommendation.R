
# Pacotes utilizados
library(arules)
library(dplyr)
library(readxl)

# Este é um conjunto de dados transnacionais que contém todas as transações
# que ocorreram entre 01/12/2010 e 09/12/2011 para um varejo on-line; 

# Link dísponivel em: https://archive.ics.uci.edu/ml/datasets/Online+Retail

transaction <- read_excel("online_retail.xlsx")

#Vamos observar a fatura e os itens comprados
transaction$InvoiceNo <- factor(transaction$InvoiceNo)

transaction <- transaction %>% select(Description, InvoiceNo)

# Vamos explorar apenas os itens vendidos se baseando em cada transação.

M <- table(transaction$InvoiceNo,transaction$Description)
M <- as.data.frame.matrix(M)

#Verificando se existe alguma transação com 0's
which(rowSums(M)==0)
M=ifelse(M>0,1,0) # Comprou = 1, não comprou = 0 (Independente do número comprado)
M=as.matrix(M)

# Gerando a matriz de transações para pode rodar o algoritmo
library(arules)

cbc.tr = as(M,"transactions")
inspect(cbc.tr) 
summary(cbc.tr)

#analisando os produtos graficamente
itemFrequency(cbc.tr) # suporte de cada item 
itemFrequencyPlot(cbc.tr, col=rainbow(2)) #não ordena
itemFrequencyPlot(cbc.tr,topN=9, main="item support", col=rainbow(2));grid(col=3)

#geração das regras
rules=apriori(data = cbc.tr, parameter = list(supp=.01,conf=0.5, minlen=2, maxlen=5, maxtime=25, target="rules"), control = list(verbose=F))

inspect(sort(rules, by="lift")) #ordenado pelo lift
rules #dá o número de regras

#poderíamos criar um conjunto de regras já ordenado. 
rules.sorted=sort(rules, by="support")
inspect(rules.sorted[1:5])