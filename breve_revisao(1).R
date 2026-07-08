# AQUI VAI O SEU CODIGO
variavel <- rnorm(n = 10, mean = 0, sd = 1) # função rnorm() sorteia números provenientes de uma 
# distribuição normal
hist(variavel, main = 'rnorm(n=10, sd=1, main=0)') # Função hist() cria o histograma de uma 
# variável
# O código acima cria  o histograma de uma variável com 1.000 observações sorteadas de uma distribuição normal

#CRIANDO VETORES

#cria um vetor com o nome "inteiro"
inteiro <- 1:5
#mostra o vetor
inteiro
#verifica a classe do vetor criado
class(inteiro)

numerico <- rnorm(n = 5)
numerico
hist(numerico)
hist(inteiro)
class(numerico)
logico <- c(TRUE, FALSE, TRUE, FALSE, TRUE)
logico
class(logico)
texto <- c('Branco', 'Azul', 'Branco', 'Azul', 'Azul')
texto
class(texto)
fator <- factor(texto)
fator
class(fator)

#CRIANDO DATA.FRAME
tabela <- data.frame(inteiro, numerico, logico, texto, fator, stringsAsFactors = F)
tabela
class(tabela)

#INDEXACAO
numerico
numerico[ 1 ] #primeira observacao do vetor numerico
numerico[ 5 ] #quinta observacao do vetor numerico
numerico[   ] #todas observacoes do vetor numerico

texto
texto[ 2 ] #segunda observacao do vetor texto

tabela
tabela[1,1]
tabela[ ,2]
tabela[3, ]

tabela[ , 'fator']
tabela[ , 'numerico']
tabela$numerico

#ESTATISTICA DESCRITIVA
mean(tabela$numerico)
sd(tabela$numerico)
summary(tabela$numerico)
median(tabela$numerico)
IQR(tabela$numerico)

#GRAFICOS
hist(tabela$numerico, main='hist(tabela$numerico)')
boxplot(tabela$numerico, main='boxplot(tabela$numerico)')
plot(x = tabela$inteiro, y = tabela$numerico, main = 'plot(x = tabela$inteiro, y = tabela$numerico)')

