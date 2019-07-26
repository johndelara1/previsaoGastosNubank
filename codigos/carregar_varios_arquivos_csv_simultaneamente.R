# Importando vários arquivos simultaneamente
list.files()
lista_arquivos <- list.files('~/git/previsaoGastosNubank/data', full.names = TRUE)
class(lista_arquivos)
lista_arquivos
lista_arquivos2 <- lapply(lista_arquivos, read_csv)
class(lista_arquivos2)