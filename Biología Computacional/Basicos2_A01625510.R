print ("Ejercicio 1")
n <- readline(prompt="Dime el tamaño del ADN: ")
bases = c("T", "A", "C", "G")
Ej1_ADN = function(x,y){
  adn = sample(x,y,replace = TRUE)
}
Ej1 = Ej1_ADN(bases,n)

print ("Ejercicio 2")
Ej2_Tam = function (x){
  l = length(x)
}
Ej2 = Ej2_Tam(Ej1)

print ("Ejercicio 3")
AD = 0
TI = 0
GU = 0
CI = 0

Ej3_Porc = function (a, b, c, d, N,ADENE){

  for (i in 1:n){
    if (ADENE[i] == "A")
      a = a + 1
  
    if (ADENE[i] == "T")
      b = b + 1
  
    if (ADENE[i] == "C")
      c = c + 1
  
    if (ADENE[i] == "G")
      d = d + 1
  }
  
print(paste("Adenina: ", ((a)/10)*100, "%"))
print(paste("Timina: ", ((b)/10)*100, "%"))
print(paste("Citosina: ", ((c)/10)*100, "%"))
print(paste("Guanina: ", ((d)/10)*100, "%"))
}

Ej4= Ej3_Porc(AD, TI, CI, GU, n, Ej1)

print ("Ejercicio 4")

Ej5_ARN = function(x){
  replace(x,x=="T","U")
}
Ej5 = Ej5_ARN(Ej1)

