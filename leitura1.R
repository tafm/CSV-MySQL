baseGeral <- read.csv2(file = "data/BaseGeral/base_geral.csv", encoding = "latin1")

baseEvasao <- read.csv2(file = "data/BaseEvasão/base_evasao.csv", encoding = "UTF-8")

baseDesempenho <- baseDesempenho <- read.csv2(file = "data/BaseDesempenho/base_desempenho.csv", encoding ="UTF-8", dec=",")


#consistencia de interseção de alunos -------------------

alunosE <- c()
for(i in 1:nrow(baseEvasao)) {
  alunosE <- c(alunosE, as.character(baseEvasao$Aluno[i]))
}

alunosD <- c()
for(i in 1:nrow(baseDesempenho)) {
  alunosD <- c(alunosD, as.character(baseDesempenho$Aluno[i]))
}

alunosG <- c()
for(i in 1:nrow(baseGeral)) {
  alunosG <- c(alunosG, as.character(baseGeral$Aluno[i]))
}

print("quantidade de alunos que pertencem às 3 bases")
print(length(intersect(intersect(alunosE, alunosD), alunosG)))

#consistencia de intersecção de alunos nas respectivas cadeiras

alunoscadE <- c()
for(i in 1:nrow(baseEvasao)) {
  alunoscadE <- c(alunoscadE, paste(as.character(baseEvasao$Aluno[i]), as.character(baseEvasao$Disciplina[i]), sep = " - "))
}

alunoscadD <- c()
for(i in 1:nrow(baseDesempenho)) {
  alunoscadD <- c(alunoscadD, paste(as.character(baseDesempenho$Aluno[i]), as.character(baseDesempenho$Disciplina[i]), sep = " - "))
}

alunoscadG <- c()
for(i in 1:nrow(baseGeral)) {
  alunoscadG <- c(alunoscadG, paste(as.character(baseGeral$Aluno[i]), as.character(baseGeral$Disciplina[i]), sep = " - "))
}

print("quantidade de alunos que pertencem às 3 bases com a mesma disciplina")
inter <- intersect(intersect(alunoscadE, alunoscadD), alunoscadG)
print(length(inter))

a <- strsplit(inter, " - ")
x <- c()
for(i in 1:length(inter)) {
  x <- c(x, a[[i]][1])
}
alunos <- levels(factor(x))
length(levels(factor(x)))

#---Análise de disciplinas-----------------------

disciplinasG <- c()
for(i in 1:nrow(baseGeral)) {
  if(as.character(baseGeral$Aluno[i]) %in% alunos) {
    disciplinasG <- c(disciplinasG, as.character(baseGeral$Disciplina[i]))
  }
}

z <- c()
for(i in 1:length(inter)) {
  z <- c(z, a[[i]][2])
}

print(levels(as.factor(z))) #disciplinas finais

cursos <- c()
for(i in 1:nrow(baseGeral)) {
  if(as.character(baseGeral$Disciplina[i]) %in% levels(as.factor(z))) {
    cursos <- c(cursos, as.character(baseGeral$Curso[i]))
  }
}

print(levels(as.factor(cursos)))