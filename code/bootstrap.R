library(ggplot2)
library(caret)
library(glmnet)
library(MASS)


alldata <- read.csv("dataset/normalized_data.csv")

# alldata <- dplyr::select(alldata, !c(name, player_id, X, team_2021, team_2022, Position))

alldata <- dplyr::select(alldata, !c(X, PTS, FGM, FT, possLost, MP, OBPM, OWS, ASTpct, X3P))

all_boot <- 1:1000

for (i in 1:ncol(alldata))
{
  row <- sample(alldata[,i], size = 1000, replace = TRUE)
  all_boot <- rbind(all_boot, row)
}
all_boot <- t(all_boot)
colnames(all_boot) <- c("index", names(alldata))

# mod_rft_lcurve <- learning_curve_dat(dat = all_boot, method = "rf", outcome = "salary", ntree = 500, tuneGrid = data.frame(.mtry = 36), metric = "RMSE", proportion = (1:10)/10)
# 
# ggplot(mod_rft_lcurve, aes(x = Training_Size, y = RMSE, color = Data))+     geom_smooth(method = loess, span = .8)  + scale_x_continuous(expand = c(0, 0)) + 
#   scale_y_continuous(expand = c(0, 0))

# train_control <- trainControl(method = "cv", number = 10)
# param_grid <- expand.grid(alpha = 1, lambda = seq(0.001,0.5, by = 0.0005))
# 
mod_lm_lcurve <- learning_curve_dat(dat = alldata, method = "lm", outcome = "salary", tuneLength = 20, trControl = train_control, metric = "RMSE", proportion = (1:10)/10)

ggplot(mod_lm_lcurve, aes(x = Training_Size, y = RMSE, color = Data))+     geom_smooth(method = loess, span = .8)  + scale_x_continuous(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0))

mod_lm <- readRDS("rds/mod_lm.RDS")

# mod_step_lcurve <- learning_curve_dat(dat = alldata, object = mod_lm, method = "stepAIC", outcome = "salary",scope = list(upper = ~., lower = ~1),trace = FALSE,direction = "both", trControl = train_control, metric = "RMSE", proportion = (1:10)/10)
# 
# ggplot(mod_step_lcurve, aes(x = Training_Size, y = RMSE, color = Data))+     geom_smooth(method = loess, span = .8)  + scale_x_continuous(expand = c(0, 0)) +
#   scale_y_continuous(expand = c(0, 0))
# 
# 
#   
#   