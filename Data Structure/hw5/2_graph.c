#include <stdio.h>
#include <stdlib.h>

#define INVALID 3456

typedef struct node {
    char level;
    int vul;  // vulnerabilities
} node;

int cycle(int v, node v_graph[v], int e_graph[v][v], int visit[v], int current, int exist) {
    if (!visit[current])
        visit[current] = 1;

    for (int next = 0; next < v; next++) {
        if (e_graph[current][next]) {
            if (visit[next] == 1) {
                return 1;
            }
            exist = cycle(v, v_graph, e_graph, visit, next, exist);
        }
    }

    visit[current] = 0;
    return exist;
}

char level_frequency(int* path) {
    
}

int* find_path(int v, int current,int path[v], int path_length, int path_vul, int best_path[v], int best_vul; node v_graph[v], int e_graph[v][v]) {

    for (int next = 0; next < v; next++) {
        if (e_graph[current][next]) {
            path[path_length++] = next;
            path_vul += v_graph[next].vul;
            find_path();
        } else if (!e_graph[current][next] && next == v - 1) {  // the path end
            if (path_vul > best_vul) {  // max vulnerabilities
                best_vul = path_vul;
                for (int i = 0; i < v; i++) {
                    best_path[i] = path[i];
                }
            } else if (path_vul == best_vul) {  // case: same vulnerabilities
                char path_fre, best_fre;
                for (int i = 0, i < v && path[i] != INVALID, i++) {
                    int fre[26] = {0};
                    v_graph[i].level
                }
            } 
        }
    }


}

int main() {
    int vertex, edge;
    while (scanf("%d %d", &vertex, &edge) == 2 && (vertex || edge)) {
        node graph_v[vertex];
        for (int i = 0; i < vertex; i++) {
            getchar();
            scanf("%c %d", &graph_v[i].level, &graph_v[i].vul);
        }
        int graph_e[vertex][vertex];
        for (int i = 0; i < vertex; i++) {
            for (int j = 0; j < vertex; j++)
                graph_e[i][j] = 0;
        }
        for (int i = 0; i < edge; i++) {
            int from, to;
            scanf("%d %d", &from, &to);
            graph_e[from][to] = 1;
        }

        // check if cycle exists or not
        int visit[vertex];
        for (int i = 0; i < vertex; i++) visit[i] = 0;
        if (cycle(vertex, graph_v, graph_e, visit, 0, 0)) {
            printf("Cyclic dependency detected. Infinite attack loop possible.\n");
        } else {
            // find path
            int answer_path[vertex], temp_path[vertex];
            for (int i = 0; i < vertex; i++) answer_path[i] = INVALID;
            for (int i = 0; i < vertex; i++) temp_path[i] = INVALID;

        }

    }
    return 0;
}