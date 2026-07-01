# R já vem com bases de dados de teste embutidas. 
# A 'mtcars' é uma base famosa com dados de carros.
head(mtcars) # Mostra as 6 primeiras linhas da tabela

#reinicia o moto gráfico
dev.off()

# Vamos criar um gráfico de dispersão com apenas uma linha de código,
# relacionando o peso do carro (wt) com o consumo (mpg)
plot(mtcars$wt, mtcars$mpg, 
     main = "Peso vs Consumo de Combustível",
     xlab = "Peso (1000 lbs)", ylab = "Milhas/Galão",
     col = "blue", pch = 16)

