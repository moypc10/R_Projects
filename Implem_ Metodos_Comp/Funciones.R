suma = function(a,b){ #Crear función suma
  a+b
}

suma(5,6) #Usar función


sum.and.power = function(a,b){ #Regresar varios resultados
  res1= a + b
  
  res2= a ^ b
  
  l = list(suma = res1, potencia = 2)
  
  return(l) 
}

sum.and.power(4,5)
