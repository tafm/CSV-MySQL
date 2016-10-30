#----------------------------------------------------------#
# Este script de povoamento deve ser rodado apenas uma vez #
#----------------------------------------------------------#

library(RMySQL)

baseGeral <- read.csv2(file = "data/BaseGeral/base_geral.csv", encoding = "UTF-8")
baseEvasao <- read.csv2(file = "data/BaseEvasão/base_evasao.csv", encoding = "UTF-8")
baseDesempenho <- baseDesempenho <- read.csv2(file = "data/BaseDesempenho/base_desempenho.csv", encoding ="UTF-8")

dicionarioGeral <- read.csv2(file = "data/BaseGeral/Novo_dicionario_dadosGeral.csv", encoding = "UTF-8", sep = ",")
dicionarioDesempenho <- read.csv2(file = "data/BaseDesempenho/dicionario_dadosDesempenho.csv", encoding = "latin1")
dicionarioEvasao <- read.csv(file = "data/BaseEvasão/dicionario_dadosEvasao.csv", encoding = "UTF-8")

#Padronização dos dados

varCaps <- function(x) {
  ignore <- c("do", "de", "da", "e")
  x <- tolower(x)
  s <- strsplit(x, " ")[[1]]
  n <- c()
  for(v in s) {
    if(!v %in% ignore) {
      n <- c(n, paste(toupper(substring(v, 1,1)), substring(v, 2), sep="", collapse=" "))
    } else {
      n <- c(n, v)
    }
  }
  paste(n, sep="", collapse=" ")
}

#-> Dicionário geral
colnames(dicionarioGeral) <- c("Variável", "Descrição")
dicionarioGeral[["Construto"]] <- rep("Geral", nrow(dicionarioGeral))

#-> Dicionário desempenho
colnames(dicionarioDesempenho) <- c("Variável", "Descrição", "Construto")

#-> Dicionário evasão
colnames(dicionarioEvasao) <- c("Variável", "Descrição", "Construto")
dicionarioEvasao$Variável <- toupper(dicionarioEvasao$Variável)
dicionarioEvasao$Construto <- sapply(dicionarioEvasao$Construto, varCaps)

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
novoModulo("Análise de evasão")

#Construtos

novoConstruto <- function(modulo, construto) {
  queryModulo <- paste("SELECT id FROM Modulo WHERE nome = '", modulo, "';", sep = "")
  #print(queryModulo)
  idModulo <- dbGetQuery(con, queryModulo)[1,1]
  #print(idModulo)
  queryConstruto <- paste("INSERT INTO Construto (id_modulo, nome) VALUES (", idModulo, ", '", construto, "');", sep = "")
  print(queryConstruto)
  dbSendQuery(con, queryConstruto)
}

#-> Geral

construtosGeral <- levels(as.factor(dicionarioGeral$Construto))
for(construto in construtosGeral) {
  novoConstruto("Visão geral dos dados", construto)
}

#-> Desempenho

construtosDesempenho <- levels(as.factor(dicionarioDesempenho$Construto))
for(construto in construtosDesempenho) {
  novoConstruto("Análise de desempenho", construto)
}

#-> Evasão

construtosEvasao <- levels(as.factor(dicionarioEvasao$Construto))
for(construto in construtosEvasao) {
  novoConstruto("Análise de evasão", construto)
}