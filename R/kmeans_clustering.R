k_means <- function(X, k, max_iters=100) {
  # Perform K-means clustering on a dataset X
  #
  # Parameters:
  # X: Dataset with samples in rows
  # k: Number of clusters
  # max_iters: Maximum number of iterations
  
  # Randomly initialize centroids
  set.seed(42)
  centroids <- X[sample(1:nrow(X), k),]
  
  for (iter in 1:max_iters) {
    # Assign each data point to the nearest centroid
    labels <- apply(X, 1, function(x) {
      which.min(sapply(1:k, function(i) sum((x - centroids[i,])^2)))
    })
    
    # Recalculate centroids as the mean of assigned points
    new_centroids <- sapply(1:k, function(i) colMeans(X[labels == i, , drop=FALSE]))
    
    # Check for convergence
    if (all(centroids == t(new_centroids))) break
    centroids <- t(new_centroids)
  }
  
  list(centroids = centroids, labels = labels)
}
