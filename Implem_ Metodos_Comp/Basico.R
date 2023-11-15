a = 1
b = 5

#Comentarios
# 1
# 2
# 3

for (a in edge.labels) {
  print("hOLA")
}

my.string = "Hola"
my.string #Imprimir Hola
class(my.string) #Decirme clase del variable
nchar(my.string) #Contar caracteres

x=10
class (x) #Numerico

y = 5L
class (y) #Entero

z = TRUE
class(z) #Logical

print("Hola")

#Concatenar
paste("RESULTADO =",x, "!",sep ="--") #JUntar 3 varibales y la separacion
paste0("x=",x) #Sin separación

#Borrar consola = Ctrl + L

as.numeric("4.56") #String a Numerico
as.character(5.34) #Numero a String

#Factor
gender = factor(c("male","female","female", "male")) #Crear vector y factor
levels (gender) #Ver niveles
str(gender) #Ver id del factor

my.var = NULL #Declararlo NULL
is.null(my.var) #Comprobar si es nulo

#Vector
numeric() #Vector Númerico Vacío
v = numeric(5) #Vector de 5 espacios Vacíos
v2 = c(1,2,3,4,5)
length(v2) #Cantidad en vector
v2 = c(v2,77) #Agregar elementos al final
v2[3] #Ver 3er elemento del vector
v2[1:3] #Ver elementos del 1 al 3
v2[2] = 11 #Reemplazar elemento 2
v2[1:2] = c(10,12) #Reemplazar primer y segundo elemento

v3 = 1:100 #Crear del 1 al 100
v4 = seq(0,100,2) #Sumar de 2 en 2

v2 + v2 #Suma de Vectores Númericos // No hay suma de vectores de string
a = c("a","b"); b = c("c", "d") #Declarar doble en misma linea


#Matrices
M = matrix(nrow = 3, ncol = 3) #3x3
dim(M) #Dimension Matriz
ncol(M) #Numero Columnas
nrow(M) #Número Filas
M = matrix(1:9, nrow = 3, ncol = 3, byrow=TRUE) #Meter valores en filas

cbind(M,rep(11,3)) #Agregar columnas
rbind(M,rep(12,3)) #Agregar fila
M[2,1] #Fila,Columa
M[2,] #Toda la 2da Fila
M*2 #Multiplica toda la matriz por 2

#Listas
x = list("a", c(1,2,3), TRUE, list("b"))
x[[1]] #Primer elemento de la lista
x[[2]][2] #Segunda posición del segundo elemento de la lista

x$years = c(2020,2021,2022) #Agregar elementos a la lista
x$years #Llamarlo
x[[5]] #Llamarlo
x[["years"]] #years

#DATA FRAMES
df = data.frame(name = c("pulpo", "delfin", "tiburon"),
                longitud = c(0.7,2.3,3.1)) #Crear DF
df[1,] #Primer Fila
df$name #Solo nombres
head(df,2) #Primeros 2 filas
tail(df,2) #Ultimas 2 filas
df[order(df$name),] #Ordenar Alfabeticamente
summary[data] #Resumen de la tabla
boxplot(data$Petal.Length ~ data$Species, col=c(1,2,3)+1) #Graficar con colores
write.csv(data,"prueba.csv") #Alterar tu csv
getwd() #Ver donde se guardan tus documentos
