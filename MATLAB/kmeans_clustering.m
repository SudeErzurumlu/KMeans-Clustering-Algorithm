function [centroids, labels] = k_means(X, k, max_iters)
    % K-means clustering on dataset X
    % Parameters:
    % X: Dataset (n_samples x n_features)
    % k: Number of clusters
    % max_iters: Maximum number of iterations

    % Randomly initialize centroids
    rng(42);
    centroids = X(randperm(size(X, 1), k), :);

    for iter = 1:max_iters
        % Compute the distance between each point and the centroids
        D = pdist2(X, centroids);

        % Assign each point to the nearest centroid
        [~, labels] = min(D, [], 2);

        % Update centroids
        new_centroids = arrayfun(@(i) mean(X(labels == i, :), 1), 1:k, 'UniformOutput', false);
        new_centroids = cell2mat(new_centroids');

        % Check for convergence
        if isequal(new_centroids, centroids)
            break;
        end
        centroids = new_centroids;
    end
end
