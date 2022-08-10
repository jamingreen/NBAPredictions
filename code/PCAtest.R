library(ggplot2)

all <- read.csv("C:/Users/jamin/Documents/DS_AI_ML_projects/NBAPredictions/dataset/normalized_data.csv")
name <- all$name
all <- dplyr::select(all, !c(name, X, salary))
all <- t(as.matrix(all))
colnames(all) <- name
pca <- prcomp(t(all), scale = TRUE)
plot(pca$x[,1], pca$x[,2])
pca.var <- pca$sdev^2
pca.var.per <- round(pca.var/sum(pca.var)*100, 1)
barplot(pca.var.per)

pca.data <- data.frame(Sample = rownames(pca$x), X = pca$x[,1], Y = pca$x[,2], id = 1:nrow(pca$x))

ggplot(pca.data, aes(x = X, y = Y, label = id))+
  geom_text()+
  xlab(paste("PC1 - ", pca.var.per[1], "%", sep = ""))+
  ylab(paste("PC2 - ", pca.var.per[2], "%", sep = ""))+
  theme_minimal() +
  ggtitle("My PCA Graph")


loading_score <- pca$rotation[,1]
gene_scores <- abs(loading_score)

ggplot(data.frame(score = loading_score, var = names(loading_score)), aes(x = reorder(var, abs(score)), y = abs(score), fill = ifelse(loading_score > 0, "blue", "red")))+ 
  geom_bar(stat = "identity")+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 5))

ggplot(data.frame(score = pca$rotation[,2], var = names(pca$rotation[,2])), aes(x = reorder(var, abs(score)), y = abs(score), fill = ifelse(loading_score > 0, "blue", "red")))+ 
  geom_bar(stat = "identity")+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 5))