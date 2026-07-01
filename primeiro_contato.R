# Limpa todo o Environment e garante que a memória esteja vazia
rm(list = ls())

idade <- 21
nome <- 'Carlos Alberto'
cargo <- "Engenheiro"
cidade <- "Salvador"

notas <- c(8.5, 8.7, 3.2, 5.6)

notas
nome
cargo

nota_primeira <- notas[1]
nota_primeira

notas_sem_primeira_e_segunda <- notas[3:4]
notas_sem_primeira_e_segunda

#multplica todo o vetor sem a necessidade loop
nota_com_peso <- notas * 1.5
nota_com_peso 

#realiza comparação e retorna booleano, sem necessidade de condicional
acima_da_media <- notas > 7
acima_da_media
