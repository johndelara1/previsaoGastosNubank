contasPositivas <- contasPositivas %>% mutate(valor = amount)
valorDiario <- contasPositivas %>% select(date, valor) %>%
  group_by(date) %>% 
  summarise(somaValorDiaria = sum(valor), mediaValorDiaria = mean(valor)) %>% 
  mutate(month = format(date, "%m"), year = format(date, "%Y"))
valorMensal <- contasPositivas %>% mutate(month = format(date, "%m"), year = format(date, "%Y")) %>% 
  group_by(month, year) %>% 
  summarise(somaValorMensal = sum(valor), mediaValorMensal = mean(valor)) %>%
  arrange(year)
valorTrimestre <- contasPositivas %>% mutate(month = format(date, "%m"), year = format(date, "%Y")) %>% 
  mutate(trimestre = quarter(ymd(date))) %>%
  select(date, trimestre, year, month, valor) %>%
  group_by(trimestre, year) %>%
  summarise(somaValorTrimestre = sum(valor), mediaValorTrimestre = mean(valor)) %>%
  arrange(year)

DiariaEMensal <- valorDiario %>% left_join(valorMensal)
DiariaMensalETrimestral <- DiariaEMensal %>% left_join(valorTrimestre)
names(DiariaMensalETrimestral)
DiariaMensalETrimestral <- DiariaMensalETrimestral %>% mutate(trimestre = quarter(ymd(date)))
DiariaMensalETrimestral <- sqldf::sqldf("SELECT DiariaMensalETrimestral.* 
FROM DiariaMensalETrimestral 
             GROUP BY date 
             ORDER BY date DESC")
primeiroDiaDoMes = cut(ymd(DiariaMensalETrimestral$date[1])-1, "month")

DiariaMensalETrimestral <- DiariaMensalETrimestral %>% filter(date < paste0(primeiroDiaDoMes))
