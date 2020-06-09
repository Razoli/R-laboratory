
rm(list = ls())

#carrega o pacote de projecao
library(forecast)
library(readxl)

getwd()
dados_sales <- read_excel("dados/DepartmentStoreSales_V2.xls")
# São dados trimestrais

boxplot(dados_sales$Sales, col = "lightblue", main = "Distribuição de vendas no período de 2005-2010")

dados_sales_ts <- ts(dados_sales$Sales, start=c(2005,1), frequency = 4)

# Variância dos dados de venda
var(dados_sales$Sales)
#analise estatistica
summary(dados_sales_ts)

#plot da série temporal
plot(dados_sales_ts, xlab="Tempo (t)", ylab="Sales", ylim=c(40000, 150000), bty="l")

tam_amostra_teste <- 4 
#define o tamanho da amostra de treinamento
tam_amostra_treinamento <- length(dados_sales_ts) - tam_amostra_teste


treinamento_ts <- window(dados_sales_ts, start=c(2005, 1), end=c(2005,tam_amostra_treinamento))
validacao_ts <- window(dados_sales_ts, start=c(2005, tam_amostra_treinamento + 1), end=c(2005,tam_amostra_treinamento+tam_amostra_teste))
plot(treinamento_ts, xlab="Tempo (t)", ylab="Sales", xaxt="n" , ylim=c(40000, 150000), xlim=c(2005, 2011), bty="l")
axis(1, at=seq(2005, 2010, 1), labels=format(seq(2005, 2010, 1)))
lines(validacao_ts, bty="l", col="red", lwd=2)

# Modelos

## Naive model
modelo_naive <- naive(treinamento_ts, level = 0, h=tam_amostra_teste)
accuracy(modelo_naive, validacao_ts)
plot(modelo_naive, xlab="Tempo", ylab="Sales", xaxt="n" ,ylim=c(40000, 150000), xlim=c(2005, 2011), bty="l", flty=2, main = "Forecast para Naive")
axis(1, at=seq(2005, 2011, 1), labels=format(seq(2005, 2011,1)))
lines(validacao_ts, col = "red")


## Regression model 
modelo_tendencia_linear <- tslm(treinamento_ts ~ trend)
summary(modelo_tendencia_linear)

#Verificando resíduos
checkresiduals(modelo_tendencia_linear, test = "LB")

plot(treinamento_ts, xlab="Tempo", ylab="Sales", bty="l")
lines(modelo_tendencia_linear$fitted.values, lwd=2)
modelo_tendencia_linear_proj <- forecast(modelo_tendencia_linear, h = tam_amostra_teste, level=0.95)
plot(modelo_tendencia_linear_proj, xlab="Tempo (t)", ylab="Sales", xaxt="n", xlim=c(2005, 2011), bty="l", flty=2,main="Forecast - modelo de regressão de tendência")
axis(1, at=seq(2005,2011, 1), labels=format(seq(2005,2011,1)))
lines(validacao_ts)
lines(modelo_tendencia_linear_proj$fitted, lwd=2, col="blue")
accuracy(modelo_tendencia_linear_proj, validacao_ts)

# Model Poly
modelo_tendencia_poli <- tslm(treinamento_ts ~ trend + I(trend^2))
summary(modelo_tendencia_poli)
checkresiduals(modelo_tendencia_poli, test="LB")

#plot modelo com tendencia

plot(treinamento_ts, xlab="Tempo", ylab="Sales", bty="l")
lines(modelo_tendencia_poli$fitted.values, lwd=2)
modelo_tendencia_poli_proj <- forecast(modelo_tendencia_poli, h = tam_amostra_teste, level=0.95)
plot(modelo_tendencia_poli_proj, xlab="Tempo (t)", ylab="Sales", xaxt="n", xlim=c(2005, 2011), bty="l", flty=2,main="Forecast - modelo polinomial p = 2")
axis(1, at=seq(2005,2011, 1), labels=format(seq(2005,2011,1)))
lines(validacao_ts)
lines(modelo_tendencia_poli_proj$fitted, lwd=2, col="blue")
accuracy(modelo_tendencia_poli_proj, validacao_ts)


#modelo com tendencia sazonal

#Estima o modelo de tendência linear
modelo_sazonal_tend_linear <- tslm(treinamento_ts ~ season)
summary(modelo_sazonal_tend_linear)
#verifica os resíduos com teste de Ljung-Box
checkresiduals(modelo_sazonal_tend_linear, test="LB")

#projeta o modelo durante o período de validação
modelo_sazonal_tend_linear_proj <- forecast(modelo_sazonal_tend_linear, h = tam_amostra_teste, level=0.95)
plot(modelo_sazonal_tend_linear_proj, xlab="Tempo (t)", ylab="Sales", xaxt="n", xlim=c(2005, 2011), bty="l", flty=2,main="Forecast - modelo sazonal")
axis(1, at=seq(2005,2011, 1), labels=format(seq(2005,2011,1)))
lines(validacao_ts)
lines(modelo_sazonal_tend_linear_proj$fitted, lwd=2, col="blue")
accuracy(modelo_sazonal_tend_linear_proj, validacao_ts)


#modelo com tendencia sazonal + tendencia

modelo_sazonal_tend_linear <- tslm(treinamento_ts ~ season+trend)
summary(modelo_sazonal_tend_linear)
#verifica os resíduos com teste de Ljung-Box
checkresiduals(modelo_sazonal_tend_linear, test="LB")

#projeta o modelo durante o período de validação
modelo_sazonal_tend_linear_proj <- forecast(modelo_sazonal_tend_linear, h = tam_amostra_teste, level=0.95)
plot(modelo_sazonal_tend_linear_proj, xlab="Tempo (t)", ylab="Sales", xaxt="n", xlim=c(2005, 2011), bty="l", flty=2,main="Forecast - modelo sazonal")
axis(1, at=seq(2005,2011, 1), labels=format(seq(2005,2011,1)))
lines(validacao_ts)
lines(modelo_sazonal_tend_linear_proj$fitted, lwd=2, col="blue")
accuracy(modelo_sazonal_tend_linear_proj, validacao_ts)


#modelo com tendencia sazonal + quadratico

modelo_sazonal_tend_linear <- tslm(treinamento_ts ~ season + trend+I(trend^2))
summary(modelo_sazonal_tend_linear)
#verifica os resíduos com teste de Ljung-Box
checkresiduals(modelo_sazonal_tend_linear, test="LB")

#projeta o modelo durante o período de validação
modelo_sazonal_tend_linear_proj <- forecast(modelo_sazonal_tend_linear, h = tam_amostra_teste, level=0.95)
plot(modelo_sazonal_tend_linear_proj, xlab="Tempo (t)", ylab="Sales", xaxt="n", xlim=c(2005, 2011), bty="l", flty=2,main="Forecast - modelo sazonal")
axis(1, at=seq(2005,2011, 1), labels=format(seq(2005,2011,1)))
lines(validacao_ts)
lines(modelo_sazonal_tend_linear_proj$fitted, lwd=2, col="blue")
accuracy(modelo_sazonal_tend_linear_proj, validacao_ts)

