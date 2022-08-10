library(corrplot)

load("rds/split.RData")
alldata <- read.csv("dataset/normalized_data.csv")

corP <- function(all)
{
  cor_Mat <- cor(all, use = "pairwise.complete.obs")
  
  cor_names <- names(sort(cor_Mat[,"salary"], decreasing = TRUE))
  
  cor_Mat <- cor_Mat[cor_names, cor_names]
  print(which(cor_Mat[,"AST"] > 0.75))
  
  png(filename = "imgs/corrplot_test.png", width = 1500, height = 1500)
  corrplot.mixed(cor_Mat, tl.pos = "lt")
  dev.off()
}

# alldata <- select(alldata, !c(X, PTS, FGM, FT, possLost, MP, OBPM, OWS, ASTpct, X3P))
corP(alldata[,-1])
