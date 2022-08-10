library(Metrics)

all <- read.csv("C:/Users/jamin/Documents/DS_AI_ML_projects/NBAPredictions/dataset/cleaned_data.csv")

str(all)

all <- all %>% dplyr::select(!c(X, player_id, team_2021,team_2022, FG,FGA,X3P,X3PA, X2P, X2PA,, FT, FTA, TRB, X3PAr)) %>% mutate(salary = log(salary))

fit_st<- lm(salary~1, data = all)

fit_fn <- lm(salary~.-name, data = all)
summary(fit_fn)
rmse(predict(fit_fn), all$salary)

x <- step(fit_st, direction = "both", scope = formula(fit_fn))
x$residuals
rmse(x$fitted.values, all$salary)