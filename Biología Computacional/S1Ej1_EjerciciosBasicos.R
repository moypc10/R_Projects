#Moisés Hiram Pineda Campos
#A01625510

print("Ejercicio 1")
Ej1_x = c(10, 11, 13, -1, 6, 3)

print("Ejercicio 2")
Ej2_est.x = c(0, 0, 0)
Ej2_est.x[1] = mean(Ej1_x)
Ej2_est.x[2] = var(Ej1_x)
Ej2_est.x[3] = sd(Ej1_x)

print("Ejercicio 3")
Ej3 = c(20:50)
Ej3_2 = mean(20:60)
Ej3_3 = sum(51:91)

print("Ejercicio 4")
Ej4_Num = -100:50
Ej4 = sample(Ej4_Num, 10)

print("Ejercicio 5")
Ej5 = c(1, 1:9)
for (i in 3:10) {
  Ej5[i] = Ej5[i-2] + Ej5[i-1]
} 

print("Ejercicio 6")
Ej6_Num1 = c(10, 20, 30, 4, 50, 60)
Ej6_Max1 = max(Ej6_Num1)
Ej6_Min1 = min(Ej6_Num1)

Ej6_Num2 = c(10, 20, 30, 4, 50, -60)
Ej6_Max2 = max(Ej6_Num2)
Ej6_Min2 = min(Ej6_Num2)

print("Ejercicio 7")
Ej7_Vec1 = c(10,20)
Ej7_Vec2 = c(3,4)
Ej7_Mult = function(x,y){x*y}
Ej7_Resultado = Ej7_Mult(Ej7_Vec1, Ej7_Vec2)

print("Ejercicio 8")
Ej8_Vec = c(10, 20, 10, 7, 24, 7, 5)
Ej8_Cont = function(x, y, z){
  for (i in 1:7){
    X=x[i]
    if (X == y){
      z = z+1
    }
  }
  print(z)
}
Ej8_Cont(Ej8_Vec, 7, 0)

print("Ejercicio 9")
Ej9_Vec = 1:100
Ej9_En= function(x,y){
i=y+1
c=2
Ej9_res = 100/y
Ej9_N=c(1:Ej9_res)
  while(i < 100){
    Ej9_N[c]= x[i]
    i=i+y
    c=c+1
  }
print(Ej9_N)
}
Ej9_NuevoVec= Ej9_En(Ej9_Vec, 5)
