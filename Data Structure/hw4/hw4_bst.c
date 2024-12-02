#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#define PI 3.1415926

typedef struct node {
    char *building;
    double distance;  // double for cooperating <math.h>
    int monitor;  // 0 for not monitored, 1 for monitored, 2 for camera place
    struct node *left;
    struct node *right;
} node;

// formula from internet
double haversine_distance (double c_la, double c_lo, double la, double lo) {
    // angle to radian
    double dla = (la - c_la) * PI / 180;
    double dlo = (lo - c_lo) * PI / 180;
    la = la * PI / 180;
    c_la = c_la * PI / 180;

    // a = sin^2(dla/2) + cos(la) * cos(c_la) * sin^2(dlo/2)
    double a = pow(sin(dla / 2), 2) + cos(la) * cos(c_la) * pow(sin(dlo / 2), 2);
    // a = 2 * earth radius * asin(sqrt(a))
    a = 2 * 6371 * asin(sqrt(a));
    return a;
}

node *create_node (char *name, double dis) {
    node *new_node = (node*)calloc(1, sizeof(node));
    new_node->building = strdup(name);
    new_node->distance = dis;
    return new_node;
}

node *create_tree (node *root, char *name, double dis) {
    if (root == NULL) 
        return create_node(name, dis);

    if (dis < root->distance) {
        root->left = create_tree(root->left, name, dis);
    } else if (dis >= root->distance) {
        root->right = create_tree(root->right, name, dis);
    }

    return root;
}

// dfs
int camera_check (node *root) {
    if (root == NULL)
        return 1;

    int temp_l = 0;  // initialize for every recursize round
    temp_l = camera_check(root->left);
    int temp_r = 0;  // initialize for every recursize round
    temp_r = camera_check(root->right);

    if (temp_l == 1 && temp_r == 1) {
        root->monitor = 0;
        return 0;
    } else if (temp_l == 0 || temp_r == 0) {
        root->monitor = 2;
        return 2;
    }

    root->monitor = 1;
    return 1;
}

node *camera_update (node *root) {
    // pre-order
    if (root != NULL) {
        // printf(":<\n%s %.3lf\n", root->building, root->distance);
        root->monitor = camera_check(root);
    }
    return root;
}

// pre-order
int camera_count (const node *root) {
    if (root == NULL) return 0;
    int camera = (root->monitor == 2 ) ? 1 : 0;
    camera += camera_count(root->left);
    camera += camera_count(root->right);

    return camera;
}

void camera_building (const node *root) {
    if (root == NULL) return;
    if (root->monitor == 2) {
        printf ("%s\n", root->building);
    }
    camera_building(root->left);
    camera_building(root->right);
}

void free_tree (node *root) {
    if (root != NULL) {
        free_tree(root->left);
        free_tree(root->right);
        free(root->building);
        free(root);
    }
}

/* debug
void print_tree (const node *root) {
    // pre-order
    if (root != NULL) {
        printf("%s %d\n", root->building, root->monitor);
        print_tree(root->left);
        print_tree(root->right);
    }
} */

int main() {
    int n;
    scanf("%d", &n);
    node *root = create_node("Center", 0);
    double c_latitude, c_longtitude;  // of center
    scanf("%lf %lf", &c_latitude, &c_longtitude);

    for (int i = 0; i < n; i++) {
        char *build = (char*)calloc(1, sizeof(char) * 100);
        double latitude, longitude;
        scanf("%s %lf %lf", build, &latitude, &longitude);
        double h_dis = haversine_distance(c_latitude, c_longtitude, latitude, longitude);

        root = create_tree(root, build, h_dis);
    }

    // minimum
    root = camera_update(root);

    /* debug
    printf(":<\n");
    print_tree(root); */

    printf("%d\n", camera_count(root));
    camera_building(root);

    free_tree(root);

    return 0;
}