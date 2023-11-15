library(igraph)

g = graph(c("S","A","B","A","B", "A","Z","B","C","B"), directed = TRUE) #Conexiones
#S -> A
#B -> A
#B -> A
#Z -> B
#C -> B

edge.labels = c("a","b","c","d","e") #Nombre de Aristas
colors = c("green","red","red","red","red") #Color de Vertices

plot(g,edge.label = edge.labels,vertex.color = colors)

