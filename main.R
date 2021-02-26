# Title     : TODO
# Objective : TODO
# Created by: zulqa
# Created on: 2/25/2021
library(clustMD)

set.seed(0)

data <- read.csv(file = 'data_compiled/2_compiled.csv', header = FALSE)
maxClust <- 10
modelTypes <- list('EII', 'VII', 'EEI', 'VEI', 'EVI', 'VVI')
bic_matrix <- matrix(0L, nrow = length(modelTypes), ncol = maxClust)
for (m in 1:length(modelTypes)){
  for (g in 1:maxClust){
    model <- clustMD(X = data, G = g, CnsIndx = 8, OrdIndx = 9, Nnorms = 2000000,
            MaxIter = 5, model = modelTypes[m], store.params = FALSE, scale = TRUE, startCL = "kmeans" )
    bic_matrix[m, g] <- model[['BIChat']]
  }
}

M <- which(bic_matrix == max(bic_matrix), arr.ind = TRUE)[1]
G <- which(bic_matrix == max(bic_matrix), arr.ind = TRUE)[2]
model <- clustMD(X = data, G = G, CnsIndx = 8, OrdIndx = 9, Nnorms = 100000,
            MaxIter = 500, model = modelTypes[M], store.params = FALSE, scale = TRUE, startCL = "kmeans" )
save(bic_matrix, file = 'models/2_bic_matrix.Rdata')
save(model, file = 'models/2_best_model.Rdata')

r = 3


