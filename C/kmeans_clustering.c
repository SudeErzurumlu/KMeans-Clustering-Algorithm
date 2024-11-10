#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void k_means(double** data, int num_points, int dimensions, int k, int max_iters, double** centroids, int* labels) {
    // Initialize centroids
    srand(42);
    for (int i = 0; i < k; i++) {
        for (int j = 0; j < dimensions; j++) {
            centroids[i][j] = data[rand() % num_points][j];
        }
    }

    for (int iter = 0; iter < max_iters; iter++) {
        // Assign labels
        for (int i = 0; i < num_points; i++) {
            double min_dist = INFINITY;
            for (int j = 0; j < k; j++) {
                double dist = 0;
                for (int d = 0; d < dimensions; d++) {
                    dist += pow(data[i][d] - centroids[j][d], 2);
                }
                if (dist < min_dist) {
                    min_dist = dist;
                    labels[i] = j;
                }
            }
        }

        // Update centroids
        double** new_centroids = calloc(k, sizeof(double*));
        for (int i = 0; i < k; i++) {
            new_centroids[i] = calloc(dimensions, sizeof(double));
        }
        
        int* counts = calloc(k, sizeof(int));
        for (int i = 0; i < num_points; i++) {
            for (int d = 0; d < dimensions; d++) {
                new_centroids[labels[i]][d] += data[i][d];
            }
            counts[labels[i]]++;
        }
        for (int j = 0; j < k; j++) {
            if (counts[j] > 0) {
                for (int d = 0; d < dimensions; d++) {
                    centroids[j][d] = new_centroids[j][d] / counts[j];
                }
            }
        }

        // Clean up
        for (int i = 0; i < k; i++) {
            free(new_centroids[i]);
        }
        free(new_centroids);
        free(counts);
    }
}
