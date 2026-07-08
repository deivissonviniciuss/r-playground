# Script para o Roteiro "Instalando epinemo e carregando banco de dados"

## Como instalar o pacote *epinemo* ----
# O pacote *epinemo* pode ser instalado no R utilizando as linhas de comando abaixo:
  
install.packages('devtools')
library(devtools)
install_github(repo='leb-fmvz-usp/epinemo', force = TRUE)


## Carregando um banco de GTA's ----

# tabela <- read.csv('base_gta.csv', fileEncoding="WINDOWS-1252", 
                      # sep=';', as.is=T)

USP <- read.csv('base_gta.csv', fileEncoding="WINDOWS-1252",
                   sep=';', as.is=T)

str(USP, width=80, strict.width="cut")


## TRANSITO INTRAESTADUAL(TR)

#adabinTR <- read.csv('traninTR 2022.csv', fileEncoding="WINDOWS-1252", 
#                sep=';', as.is=T)


#length(adabinTR[,1])
#[1] 433992
#str(adabinTR, width=80, strict.width="cut")



## Visao geral do banco ----

str(USP)

#str(adabinTR)

View(USP)
#View(adabinTR)

# View(adabinTR)



## FILTRO POR ESPÉCIE ( OU TIPO) -----

# O banco que temos em maos pode conter movimentacoes que nao nos interessam. # Por exemplo, se estivermos apenas interessados 
# em movimentacoes de bovinos, temos que selecionar apenas essas movimentacoes. Vamos ver, atraves da coluna "especie", 
# quais especies estao presentes no banco. 
# A funcao 'unique' nos traz todos os valores encontrados em uma determinada coluna:

# names(USP)
names(USP)
unique(USP$Especie)
USP$Especie


#names(adabinTR)
#unique(adabinTR$Espécie)
#adabinTR$Espécie

# unique(adabinTR$ESPECIE)

# Como vemos, o banco traz movimentacoes de várias especies diferentes. 
# Para selecionar apenas os bovinos, vamos criar um filtro. 
# O nome da coluna que vamos utilizar no filtro e 'Espeécie', 
# e dentro dessa coluna queremos apenas as linhas que apresentem o texto 'Bovinos'. 
# Para isso, vamos usar os colchetes, que sao a forma padrao de indexar linhas ou colunas no R.



## FILTRO POR ESPÉCIE


USP <- USP[ USP$Especie == 'Bovinos', ]


##  TRANSITO INTRAESTADUAL

#adabinTR <- adabinTR[ adabinTR$Espécie == 'Bovina', ]
#View(adabinTR)

#length(adabinTR[,1])
#[1] 330707

## USANDO A FUNÇÃO "unique"

# Dentro dos colchetes, a virgula separa a indexacao das linhas e das colunas. 
# Os termos que vem antes da virgula indicam quais linhas queremos 
# (no caso, todas as linhas na qual a coluna 'especie' e igual a 'Bovinos'), 
# e os termos que vem depois da virgula indicam quais colunas queremos da tabela. 
# Como deixamos em branco, o R mantem todas as colunas na tabela. 
# Para verificar se o filtro funcionou, vamos utilizar a funcao 'unique' novamente:

unique(USP$Especie)

#unique(adabinTR$Espécie)



# Como vemos, agora apenas movimentacoes referentes a bovinos estao na tabela.



## NUMERO DE ANIMAIS

# No banco de dados USP, temos a quantidade de animais de cada sexo 
# (colunas "Machos" e "Femeas") separadas. Entao, se quisermos 
# utilizar o numero total de animais, em cada movimentacao, primeiro teremos que calcular 
# o total movimentado em cada GTA. 
# No banco, as colunas que contem essa informacao sao as colunas "Machos" e "Femeas". 
# Utilizando essa informacao, vamos somar o total de animais movimentados em cada GTA. 
# A funcao '+' calcula a soma, linha a linha, 
# de dois vetores. Entao basta aplicar essa funcao nas colunas "Machos" e "Femeas" da tabela, criando uma nova coluna chamada de "animais":

USP$animais <- USP$Machos + USP$Femeas

## NO CASO DA ADAB, NÃO É NECESSÁRIO FAZER ESSA OPERAÇÃO DE SOMA.AS TABELAS  "adabinTR" JÁ POSSUI A COLUNA COM A SOMA DOS ANIMAIS

# Com isso, acabamos de criar uma nova variavel (coluna) na tabela. 
# Essa variavel traz a soma de animais em cada GTA. 
# Podemos verifica-la no final da lista de variaveis:

str(USP)
View(USP)
#View(adabinTR)

## CONFIGURAÇÃO DA DATA NO R 

## Data das GTA's para rastrear movimentacoes
# Para fazer analises que utilizem a data das movimentacoes, 
# e necessario que o R entenda a coluna que indica a data. 
# Em cada base essa coluna pode estar em um formato diferente, por exemplo primeiro de janeiro de 2015 pode estar escrito como `"01-01-15"` ou `"2015/01/01"` e assim por diante, 
# sendo a ordem de dia, mes e ano e os separadores diferentes em cada base. 

# Para que o R entenda o nosso formato, utilizaremos a funcao 'as.Date'. 
# Na nossa base de dados, a data esta na coluna 'Data', 
# indicando a data de emissao de cada GTA, e olhando a tabela vemos 
# que uma das GTA's esta no formato "21/09/2012", 
# indicando portanto que a nossa data esta no formato "dia/mes/ano", 
# e que o ano esta descrito com quatro numeros. 
# A opcao 'format' da funcao 'as.Date' no nosso caso ficara 
# assim "%d/%m/%Y", onde '%d' indica dia, '%m' indica o mes, e '%Y' 
# indica o ano com quatro digitos, todos separados por barras. 

# Caso nossas datas possuissem o formato "01-01-15", 
# escreveriamos "%d-%m-%y" ("y" minusculo para ano com dois digitos, 
# numeros separados por hifen), e caso fosse "2015/01/01", escreveriamos "%Y/%m/%d" 
# (trocando a ordem):

USP$data <- as.Date(USP$Data, format= "%d/%m/%Y")

str(USP)


#adabinTR$data <- as.Date(adabinTR$Data.de.emissão.da.GTA, format= "%d/%m/%Y")

#str(adabinTR)


# Com isso, criamos uma nova variavel no banco, de nome 'data' 
# indicando a data da GTA no formato do R.

str(USP)
#str(adabinTR)

# VERIFICANDO EM CADA BANCO DE DADOS A QUANTIDADE TOTALEM CADA COLUNA, NO CASO DESSE EXEMPLO É A FINALIDADE

# USP

table(USP$Finalidade)

# ABATE    ENGORDA    ESPORTE     LEILAO REPRODUCAO 
# 8586       4006          4        119       2458 

#ADAB

#table(adabinTR$Finalidade)

# Abate                        Engorda 
# 106196                         152947 
# Esportes                      Exposição 
# 429                            391 
# Feira de Animais                Leilão 
# 3641                            116 
# PESAGEM                         RECRIA 
# 28                               522 
# Reprodução                     RETORNO A ORIGEM 
# 65921                                385 
# SAÍDA DE FRIGORÍFICO/ABATEDOUR  TRAÇÃO/LIDA/TRABALHO 
# 97                                    34 



## CRIANDO A REDE DE MOVIMENTAÇÃO

## Criando os identificadores de cada nÓ na rede ----

library(epinemo)

banco <- createUniqueIds(USP, 
                         from = 'Codigo_Propriedade_Origem' ,
                         to = 'Codigo_Propriedade_Destino')


banco 
names(banco)
str(banco, width=80, strict.width="cut")

#bancoadabinTR <- createUniqueIds(adabinTR, 
#                         from = 'COD.ORIGEM' ,
#                         to = 'COD.DESTINO')

#bancoadabinTR
#names(bancoadabinTR)

#str(adabinTR,width=80, strict.width="cut")
#names(adabinTR)

#str(bancoadabinTR, width=80, strict.width="cut")




# O arquivo criado é uma lista ('list') composta de dois objetos. 
# O primeiro, de nome 'movements' e uma tabela ('data.frame') igual a tabela original, 
# mas acrescido de duas colunas: 'From' e 'To'. 
# Essas duas colunas serao o identificador de cada no na rede de movimentacao. 
# O segundo objeto, de nome 'correspondence' e uma tabela que traz a 
# correspondencia entre a identificacao do no na rede e a identificacao do no no banco de GTA's, 
# para que possamos cruzar informacoes da analise de redes com informacoes do banco de GTA's.




## CRIANDO A MATRIZ DE ADJACNCIA
## Criando a matriz de adjacencia -----

### Matriz de vizinhos

# Para criar a matriz que representa a rede de movimentacao, 
# utilizaremos o pacote 'Matrix', e a funcao 'sparseMatrix' 
# que e capaz de criar matrizes grandes sem ocupar muita memoria do computador

library(Matrix)


matriz_USP <- sparseMatrix(i = banco$movements$From, j=banco$movements$To,  
                                dims = rep(max(banco$movements$From, banco$movements$To) , 2))

matriz_USP
matriz_USP[115:120,1:5]


## VALOR MÁXIMO

max(banco$From, banco$movements$To)
## [1] 3395



#matriz_adabinTR <- sparseMatrix(i = bancoadabinTR$movements$From, j=bancoadabinTR$movements$To,  
#                              dims = rep(max(bancoadabinTR$movements$From, bancoadabinTR$movements$To) , 2))

#matriz_adabinTR
#matriz_adabinTR[1:5,1:5] 

#max(bancoadabinTR$From, bancoadabinTR$movements$To)
## [1] 149037




## Matriz de vizinhos ----Calculando o grau total( de vizinhos ) de cada nó


matriz_vizUSP <- sparseMatrix(i = banco$movements$From, j=banco$movements$To,
                                dims = rep(max(banco$correspondence$network.id) , 2))


matriz_nao_direcionadaUSP <- matriz_vizUSP + t(matriz_vizUSP)
matriz_vizinhos_nao_direcionadaUSP <- ((matriz_nao_direcionadaUSP > 0) * 1)
kvizinhosUSP <- rowSums(matriz_vizinhos_nao_direcionadaUSP)# terá o mesmo resultado
kvizinhosUSP <- colSums(matriz_vizinhos_nao_direcionadaUSP)# terá o mesmo resultado

summary(kvizinhosUSP)


#matriz_vizadabinTR <- sparseMatrix(i = bancoadabinTR$movements$From, j=bancoadabinTR$movements$To,
#                              dims = rep(max(bancoadabinTR$correspondence$network.id) , 2))


#matriz_nao_direcionadaADAB <- matriz_vizadabinTR + t(matriz_vizadabinTR)
#matriz_vizinhos_nao_direcionadaADAB <- ((matriz_nao_direcionadaADAB > 0) * 1)
#kvizinhoadabinTR <- rowSums(matriz_vizinhos_nao_direcionadaADAB)# terá o mesmo resultado
#kvizinhoadabinTR <- colSums(matriz_vizinhos_nao_direcionadaADAB)# terá o mesmo resultado

#summary(kvizinhoadabinTR)



### Matriz de lotes

# Se quisermos uma matriz ponderada pelo numero de movimentacoes entre os nos, 
# adicionamos a opcao 'x=1' na funcao 'sparseMatrix':

library(Matrix)


matriz_lotes <- sparseMatrix(i = banco$movements$From, j=banco$movements$To, x=1, 
                             dims = rep(max(banco$movements$From, banco$movements$To) , 2))


matriz_lotes[115:120,1:5]


#matriz_lotadabinTR <- sparseMatrix(i = bancoadabinTR$movements$From, j=bancoadabinTR$movements$To, x=1, 
#                             dims = rep(max(bancoadabinTR$movements$From, bancoadabinTR$movements$To) , 2))

#matriz_lotadabinTR[1:5,1:5] 



### Matriz de animais

# Se quisermos uma matriz ponderada pelo numero de animais movimentados entre os nos, 
# adicionamos na funcao 'sparseMatrix' a opcao x='animais' onde 'animais' 
# indica a variavel no banco de dados que indica o total de animais em cada movimentacao. 

library(Matrix)

#bancoadabinTR

matriz_animais <- sparseMatrix(i = banco$movements$From, j=banco$movements$To, 
                               x=banco$movements$animais,
                               dims = rep(max(banco$movements$From, banco$movements$To) , 2))

matriz_animais[115:120,1:5] 




#matriz_animadabTR <- sparseMatrix(i = bancoadabinTR$movements$From, j=bancoadabinTR$movements$To, 
#                               x=bancoadabinTR$movements$Total.de.Bovinos,
#                               dims = rep(max(bancoadabinTR$movements$From, bancoadabinTR$movements$To) , 2))
#names(adabinTR)



#matriz_animadabTR[1:5,1:5] 






