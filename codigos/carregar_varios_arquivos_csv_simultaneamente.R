# Importando vários arquivos simultaneamente
list.files()
lista_arquivos <- list.files('~/git/previsaoGastosNubank/data', full.names = TRUE)
class(lista_arquivos)
lista_arquivos
lista_arquivos2 <- lapply(lista_arquivos, read_csv)
class(lista_arquivos2)
i = 1
while(i <= length(lista_arquivos2)){
  if(i == 1){
    contasJohn1 <- as.data.frame(lista_arquivos2[1])
    contasJohn2 <- as.data.frame(lista_arquivos2[2])
    contasJohn <- rbind(contasJohn1, contasJohn2)
    i = 2
  }else{
    contasJohn3 <- as.data.frame(lista_arquivos2[i])
    contasJohn <- rbind(contasJohn, contasJohn3)
  }
  i = i + 1;
}

