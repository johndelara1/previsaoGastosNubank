rf_model_sales <-train(somaValorDiaria ~., # Standard formula notation
                         data=base[,-1],  # Excluir  'data'
                         method="rf",              # randomForest
                         nodesize= 10,              # 10 data-points/node. Speeds modeling
                         ntree =500,               # Default 500. Reduced to speed up modeling
                         importance = TRUE,
                         trControl=trainControl(method="repeatedcv", number=2,repeats=1),  # cross-validation strategy
                         tuneGrid = expand.grid(mtry = c(123))
  )
