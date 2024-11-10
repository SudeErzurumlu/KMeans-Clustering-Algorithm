using Random, Statistics

function k_means(X, k, max_iters=100)
    # Randomly initialize centroids
    Random.seed!(42)
    centroids = X[sample(1:size(X, 1), k; replace=false), :]

    for _ in 1:max_iters
        # Assign each data point to the nearest centroid
        labels = [argmin([norm(x - c) for c in eachrow(centroids)]) for x in eachrow(X)]

        # Recalculate centroids as the mean of assigned points
        new_centroids = [mean(X[labels .== i, :], dims=1) for i in 1:k]

        # Check for convergence
        if all(centroids .== new_centroids)
            break
        end
        centroids = new_centroids
    end
    centroids, labels
end
