#include <stdio.h>
#include <stdlib.h>

void loading(int city, int truck, int* collect, int* deliver) {
    int loading_success = 0; // check if output exist
    for (int i = 0; i < city; i++) {
        int city_count = 0;
        int truck_load = 0;
        int city_index = i;
        while (city_count <= city) {
            if (city_count == city && truck_load - deliver[i] <= truck) { // back to start city
                printf("%d ", i);
                loading_success++; // output exist
                break;
            }

            truck_load += collect[city_index];
            if (truck_load > truck) break;
            if (city_index != i) {
                truck_load -= deliver[city_index];
                if (truck_load < 0) // avoid load < 0
                    break;
            }

            city_index + 1 < city ? city_index++ : (city_index = 0);

            city_count++;
        }
    }
    if (!loading_success)
        printf("-1");
    return;
}

int main() {
    int cities, capacity;
    while (scanf("%d %d", &cities, &capacity) == 2 && (cities || capacity)) {
        int collection[cities];
        for (int i = 0; i < cities; i++)
            scanf("%d", &collection[i]);
        int delivery[cities];
        for (int i = 0; i < cities; i++)
            scanf("%d", &delivery[i]);

        loading(cities, capacity, collection, delivery);
        printf("\n");
    }
}
