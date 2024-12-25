#include <stdio.h>
#include <stdlib.h>

int dfs(int n_vertex, int* graph_v, int graph_e[n_vertex][n_vertex], int start, int time_limit, int current_vertex, int total_vertex_now, int max_value, int time_spent, int* visit) {
    if (time_spent > time_limit) return max_value;

    int visited = 0;
    if (!visit[current_vertex]) {
        visited = graph_v[current_vertex];
        total_vertex_now += visited;
        visit[current_vertex] = 1;
    }

    if (current_vertex == start && time_spent > 0) {
        if (total_vertex_now > max_value) {
            max_value = total_vertex_now;
            return max_value;
        }
    }

    for (int next_vertex = 0; next_vertex < n_vertex; next_vertex++) {
        if (graph_e[current_vertex][next_vertex]){
            max_value = dfs(n_vertex, graph_v, graph_e, start, time_limit, next_vertex, total_vertex_now, max_value, time_spent + graph_e[current_vertex][next_vertex], visit);
        }
    }

    if (visited > 0) {
        visit[current_vertex] = 0;
    }

    return max_value;
}

int main() {
    int n_vertex;
    scanf("%d", &n_vertex);
    int graph_vertex[n_vertex];
    for (int i = 0; i < n_vertex; i++) {
        scanf("%d", &graph_vertex[i]);
    }
    int n_edge;
    scanf("%d", &n_edge);
    int graph_edge[n_vertex][n_vertex];
    for (int i = 0; i < n_vertex; i++) {
        for (int j = 0; j < n_vertex; j++)
            graph_edge[i][j] = 0;
    }
    for (int i = 0; i < n_edge; i++) {
        int from, to, time;
        scanf("%d %d %d", &from, &to, &time);
        graph_edge[from][to] = time;
        graph_edge[to][from] = time;
    }
    int start;
    scanf("%d", &start);
    int time_limit;
    scanf("%d", &time_limit);
    int signal;  // -1
    scanf("%d", &signal);
    if (signal == -1) {
        int visit[n_vertex];  // 
        for (int i = 0; i < n_vertex; i++) visit[i] = 0;
        int answer = dfs(n_vertex, graph_vertex, graph_edge, start, time_limit, start, 0, 0, 0, visit);
        printf("%d", answer);
    }

    return 0;
}