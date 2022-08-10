all <- read.csv("C:/Users/jamin/Documents/DS_AI_ML_projects/NBAPredictions/dataset/normalized_data.csv")

mod_step_st <- lm(salary~1, data = all)

mod_step_fn <- lm(salary~.-X, data = all)

x <- step(mod_step_st, direction = "both", scope = formula(mod_step_fn))

coef(x)