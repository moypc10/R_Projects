library(igraph)
library(stringr)
library(magrittr)

## Input user example
string <- "S -> aA
B -> a
S -> bB  
A -> bB
A -> c
B -> c"

string2 <- "A -> aB
A -> bB
A -> a
B -> aA
B -> bA"

# Formatted data
string <- str_replace_all(string, "(\n)|([:space:]*\n)", " ")

## Extract the edges
edgesCompleted <- str_extract_all(string, "[A-Z] -> [a-z][A-Z]")[[1]]
edgesFinal  <- str_extract_all(string, "([A-Z] -> [a-z][^A-Z])|[A-Z] -> [a-z](?!.*[A-Z])")[[1]]
edgesFinalZ <- str_replace_all(edgesFinal, "(?<=[a-z])(?!$)|(?<=[a-z])$", "Z")

stringUpdated <- append(edgesCompleted, edgesFinalZ)

nodes <- unlist(str_extract_all(stringUpdated, "[A-Z]"))
edge.labels <- unlist(str_extract_all(stringUpdated, "[a-z]"))
g <- graph(nodes, directed = TRUE)

uniqueNodes <- unique(nodes)
nodeTypes <- c()

for(node in uniqueNodes){
  if(node == "S"){
    nodeTypes <- nodeTypes %>% append(1)
  } else if (node == "Z"){
    nodeTypes <- nodeTypes %>% append(3)
  }
  else {
    nodeTypes <- nodeTypes %>% append(2) 
  }
}

if (!("S" %in% uniqueNodes)) {
  nodeTypes <- nodeTypes[-1]
  nodeTypes <- append(nodeTypes, 1, after= 0)
}

node.types <- nodeTypes
mapping.colors <- c("green","white", "red")
node.colors <- mapping.colors[node.types]

curves <- curve_multiple(g, start = 0.9)
set.seed(12)
plot(g, edge.arrow.size = 0.5, vertex.label.cex = 0.8, vertex.size = 35,
     vertex.frame.color = "gray", vertex.label.color = "black",
     edge.label = edge.labels, vertex.color = node.colors, edge.curved = curves)


# Clear
rm(list = ls())
