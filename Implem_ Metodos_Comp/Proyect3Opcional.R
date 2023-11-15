library(igraph)
library(stringr)
# Input user example
string <- "(S,A,b)
(S,E,c)
(B,A,b)
(B,C.,-)
(B,C.,a)
(A,B,a)
(A,C,b)
(A,E,c)
(C,B,c)
(C,B,b)
(C,A,a)
(E,S.,-)
"
string2 <- "(S,B,a)
(S,A,b)
(B,A,b)
(B,C.,-)
(C,B,a)
(C,B,b)"

# Formatted data
string <- str_replace_all(string, "(\n)|([:space:]*\n)", " ")
string <- str_replace_all(string, "(\n)|([:space:]*\n)", " ")
string <- str_replace_all(string, "(\n)|([:space:]*\n)", " ")

## Extract edges
edgesCompleted <- str_extract_all(string, "\\([A-Z],[A-Z],[a-z]\\)")[[1]]
edgesFinal <- str_extract_all(string, "\\([A-Z],[A-Z]\\.,([a-z]|.)\\)")[[1]]
string <- append(edgesCompleted, edgesFinal)

## Extract nodes
coupleNodesCompleted <- unlist(str_extract_all(edgesCompleted, "[A-Z]"))
coupleNodesFinal <- unlist(str_extract_all(edgesFinal, "(?!S)[A-Z]"))
nodesFinal <- gsub("\\.","",unique(unlist(str_extract_all(edgesFinal, "(?!S)[A-Z]\\."))))
nodes <- append(coupleNodesCompleted, coupleNodesFinal)
uniqueNodes <- unique(nodes)

## Number of nodes
nNodesCompleted <- length(unique(unlist(str_extract_all(edgesCompleted, "(?!S)[A-Z]"))))
nNodesFinal <- length(gsub("\\.","",unique(unlist(str_extract_all(edgesFinal, "(?!S)[A-Z]\\.")))))

## Alphabet
uniqueAlphabet <- unique(unlist(str_extract_all(string, "[a-z]")))
nAlphabet <- length(uniqueAlphabet)

nodeTypes <- c()
for(node in uniqueNodes){
  if(node == "S"){
    nAlphabetCheck = 0
    for(alphabet in uniqueAlphabet){
      if((sum(grepl(paste("S,[A-Z].?,[", alphabet, "]", sep = ""), string))) == TRUE){
        nAlphabetCheck = nAlphabetCheck + 1  
      } 
    }
    if(nAlphabetCheck == nAlphabet){
      nodeTypes <- nodeTypes %>% append(1)
    } else {
      nodeTypes <- nodeTypes %>% append(4)  
    } 
    
  } else if (node %in% nodesFinal){
    nAlphabetCheck = 0
    for(alphabet in uniqueAlphabet){
      if(sum(grepl(paste(node, ",[A-Z].?,[", alphabet, "]", sep = ""), string)) == TRUE){
        nAlphabetCheck = nAlphabetCheck + 1
      }
    }
    if(nAlphabetCheck == nAlphabet){
      nodeTypes <- nodeTypes %>% append(3)  
    } else {  
      nodeTypes <- nodeTypes %>% append(4)
    }
  }
  else {
    nAlphabetCheck = 0
    for(alphabet in uniqueAlphabet){
      if(sum(grepl(paste(node, ",[A-Z].?,[", alphabet, "]", sep = ""), string)) == TRUE){
        nAlphabetCheck = nAlphabetCheck + 1
      }
    }
    if(nAlphabetCheck == nAlphabet){
      nodeTypes <- nodeTypes %>% append(2) 
    } else {  
      nodeTypes <- nodeTypes %>% append(4)
    }
  }
}

node.types <- nodeTypes
g <- graph(nodes, directed = TRUE)

edge.labels <- gsub("-","λ",unlist(str_extract_all(string, "[a-z]|-")))

#if λ
if ("λ" %in% edge.labels) {
  posiciones <- which(edge.labels == "λ")  # Obtener las posiciones de "λ"
  
  for (pos in posiciones) {
    pos <- (pos * 2) - 1  # Calcular la nueva posición
    
    poss <- 1  # Reiniciar la variable poss
    
    for (poss in 1:length(uniqueNodes)) {
      if (nodes[pos] == uniqueNodes[poss]) {
        break
      }
      poss <- poss + 1
    }
    
    # Checar si el nodo en esa posición es igual a 4
    if (nodeTypes[poss] == 4) {
      # Si es así, cambiarlo a 5
      nodeTypes <- nodeTypes[-poss]
      nodeTypes <- append(nodeTypes, 5, after = poss - 1)
    } else {
      # Si no, cambiarlo a 4
      nodeTypes <- nodeTypes[-poss]
      nodeTypes <- append(nodeTypes, 4, after = poss - 1)
    }
  }
}

node.types <- nodeTypes
g <- graph(nodes, directed = TRUE)

mapping.colors <- c("green","white", "red", "yellow", "orange")
node.colors <- mapping.colors[node.types]

curves <- curve_multiple(g, start = 0.8)
set.seed(10)
plot(g, edge.arrow.size=.3, vertex.label.cex=0.8, vertex.size=35,vertex.frame.color="gray", vertex.label.color="black",  edge.label = edge.labels, vertex.color = node.colors, edge.curved=curves )

# Clear
rm(list = ls())

