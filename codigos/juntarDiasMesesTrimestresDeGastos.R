contasPositivas <- contasPositivas %>%  mutate(trimestre = quarter(ymd(date)), valor = amount) 
valorDiario <- contasPositivas %>% select(date, valor, trimestre) %>%
  group_by(date) %>% 
  summarise(somaValorDiaria = sum(valor), mediaValorDiaria = mean(valor)) %>% 
  mutate(month = format(date, "%m"), year = format(date, "%Y"))
valorMensal <- contasPositivas %>% mutate(month = format(date, "%m"), year = format(date, "%Y")) %>% 
  group_by(month, year) %>% 
  summarise(somaValorMensal = sum(valor), mediaValorMensal = mean(valor)) %>%
  arrange(year)
valorTrimestre <- contasPositivas %>% mutate(month = format(date, "%m"), year = format(date, "%Y")) %>% 
  select(date, trimestre, year, month, valor) %>%
  group_by(trimestre, year) %>%
  mutate(data = date) %>%
  summarise(somaValorTrimestre = sum(valor), mediaValorTrimestre = mean(valor)) %>%
  arrange(year)

DiariaEMensal <- valorDiario %>% left_join(valorMensal)
DiariaMensalETrimestral <- DiariaEMensal %>% left_join(valorTrimestre)
names(DiariaMensalETrimestral)

valorDiario <- DiariaMensalETrimestral %>% select(date, somaValorDiaria, mediaValorDiaria, month, year, somaValorMensal, mediaValorMensal, trimestre, somaValorTrimestre, mediaValorTrimestre) %>%
  arrange(date)
