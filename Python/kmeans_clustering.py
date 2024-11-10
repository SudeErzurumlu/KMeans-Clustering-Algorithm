import numpy as np
import matplotlib.pyplot as plt
from sklearn.datasets import make_blobs

def k_means(X, k, max_iters=100):
    """
    Perform K-Means clustering on a dataset X.
    
    Parameters:
    X (array-like): Dataset with shape (n_samples, n_features)
    k (int): Number of clusters
    max_iters (int): Maximum number of iterations
    
    Returns:
    centroids (array-like): Centroids of the clusters
    labels (array-like): Cluster assignments for each data point
    """
    # Randomly initialize centroids
    np.random.seed(42)
    centroids = X[np.random.choice(X.shape[0], k, replace=False)]

    for _ in range(max_iters):
        # Assign each data point to the nearest centroid
        labels = np.array([np.argmin([np.linalg.norm(x - c) for c in centroids]) for x in X])

        # Recalculate centroids as the mean of assigned points
        new_centroids = np.array([X[labels == i].mean(axis=0) for i in range(k)])

        # Check for convergence
        if np.all(centroids == new_centroids):
            break
        centroids = new_centroids

    return centroids, labels

# Generate sample data and apply K-means
X, _ = make_blobs(n_samples=300, centers=4, random_state=42)
centroids, labels = k_means(X, k=4)
