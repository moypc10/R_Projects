install.packages("randomForest")

runif(10) #10 numeros aleatorios entre 0-1

set.seed(123) #Siempre de el mismo resultado
runif(3)

sample(10,size=3) #3 numeros aleatorios del 1 al 10
sample(10,size=15, replace=TRUE) #15 numeros aleatorios del 1-10 repetibles

my.strings = c("a","b","c","d")
sample(my.strings, size = 2) #2 elementos aleatorios

#---------------------------------------------------------------------
source("Funciones.R") #Llamar funciones y variables de otros archivos

sum.and.power(5,4) #Usar Función
#---------------------------------------------------------------------
a=10;b=2

if (a<b){
  print("a menor que b")
} else { #Else siempre donde cierra if
  print("a mayor que b")
}

#Ejemplo 2
size = "S"

if (size=="S"){
  print("small")
}else if(size =="M"){
  print("medium")
}else{
  print("large")
}

#Loops
arr = 1:10

for (i in arr){ #Del 1 a la variable
  print(i)
}

for(i in 1:5){ #Del 1 al 5
  if(i==5){
    next #Salto de Variable
  }
  print(i)
}

for(i in 1:10){
  if(i==5){
    break #Romper Ciclo
  }
  print(i)
}  

for(i in my.strings){
  print(i) #Imprimir elementos
}

#Apply--------------------------------------------------------------
M = matrix(1:9,nrow = 3)

apply(M,1,mean) #Promedio por filas (1,4,7) (2,5,8) (3,6,9)

apply(M,2,function(x){
  max(x)^2 #Max por Columnas y Elevarlo al Cuadrado
})

#Strings-----------------------------------------------------------
my.string = "Hola Mundo"
substr(my.string,1,4) #Del dígito 1 a 4
gsub("l","*",my.string) #Sustituir l por *

res = strsplit("s->a","->")#Borra ->     #Te devuelve una lista
res[[1]] [[2]] #2do elemento en la lista
strsplit("s->a","->")[]


#Plots

data = iris #Documento
plot(data$Sepal.Length, data $Sepal.Width,
     main = "mi titulo",
     xlab = "x",
     ylab = "y",
     pch = 15) #Figura

dev.off()

#Line plot.s----------
x = 1:50
x = x + rnorm(50, sd = 2)
plot (x, type = "l", col="blue")

#Grid 4 Gráficas
par(mfrow = c(2,2)) #Grid 2x2
plot(x,type="l", col="blue")
plot(x,type="l", col="red")
plot(x,type="l", col="yellow")
plot(x,type="l", col="green")

par(mfrow = c(1,1)) #Restablecer Grid