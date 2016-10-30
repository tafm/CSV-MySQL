#----------------------------------------------------------#
# Este script de povoamento deve ser rodado apenas uma vez #
#----------------------------------------------------------#

library(RMySQL)

baseGeral <- read.csv2(file = "data/BaseGeral/base_geral.csv", encoding = "UTF-8")
baseEvasao <- read.csv2(file = "data/BaseEvasão/base_evasao.csv", encoding = "UTF-8")
baseDesempenho <- baseDesempenho <- read.csv2(file = "data/BaseDesempenho/base_desempenho.csv", encoding ="UTF-8")

#Conexao SQL

con <- dbConnect(MySQL(),
  user="root",
  password="casa",
  dbname="dashboard",
  host="127.0.0.1")
on.exit(dbDisconnect(con))

dbSendQuery(con, "SET NAMES utf8")

#Cursos

cursos <- levels(as.factor(c(as.character(baseGeral$Curso), as.character(baseDesempenho$Curso), as.character(baseEvasao$Curso))))

for(c in cursos) {
  query <- paste("INSERT INTO Curso (nome) VALUES ('", c, "');", sep = "")
  print(query)
  dbSendQuery(con, query)
}

#Módulo

novoModulo <- function(descricao) {
  query <- paste("INSERT INTO Modulo (nome) VALUES ('", descricao, "');", sep = "")
  print(query)
  dbSendQuery(con, query)
}

novoModulo("Visão geral dos dados")
novoModulo("Análise de desempenho")
novoModulo("Análise de Evasão")

#