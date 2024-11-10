require 'matrix'

def k_means(points, k, max_iters=100)
  # Randomly initialize centroids
  centroids = points.sample(k)

  max_iters.times do
    # Assign each point to the nearest centroid
    labels = points.map do |point|
      centroids.each_with_index.min_by { |c, _| (Vector.elements(point) - Vector.elements(c)).magnitude }[1]
    end

    # Recalculate centroids as the mean of assigned points
    new_centroids = Array.new(k) { |i| points.select.with_index { |_, j| labels[j] == i }.transpose.map { |dim| dim.sum / dim.size } }

    # Check for convergence
    break if centroids == new_centroids
    centroids = new_centroids
  end

  [centroids, labels]
end
