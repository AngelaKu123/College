#include <stdio.h>
#include <stdlib.h>

typedef struct node {
    int data;
    struct node *link;
} node;

void insert(int new_data, node** list) {
    node *new_node = (node*)calloc(1, sizeof(node));  // new_node->link = NULL
    new_node->data = new_data;
    
    if (*list == NULL) {
        *list = new_node;
    } else {
        node *current = *list;  // traverse
        while (current->link) {
            current = current->link;
        }
        current->link = new_node;
    }
}

void print_list(node* list) {
    node *current = list;
    while (current) {
        printf("%d", current->data);
        if (current->link)
            printf("->");
        
        current = current->link;
    }
    printf("\n");
}

void free_list(node* list) {
    while (list) {
        node *current = list;
        list = list->link;
        free(current);
    }
}

void merge_list(node* list1, node* list2, node** merge, int cut) {
    if (!list1 || !list2) return;

    for (int i = 0; i < cut; i++) {
        if (!list1) break;
        insert(list1->data, merge);
        list1 = list1->link;
    }
    
    for (int i = 0; i < 2 * cut; i++) {
        if (!list2) break;
        insert(list2->data, merge);
        list2 = list2->link;
    }
    if (list1) {
        for (int i = 0; i < cut; i++) {
            if (!list1) break;
            insert(list1->data, merge);
            list1 = list1->link;
        }
    }
    if (list1 && list2) {
        merge_list(list1, list2, merge, cut);
    } else if (list1 && !list2) {
        while (list1) {
            insert(list1->data, merge);
            list1 = list1->link;
        }
    } else if (!list1 && list2) {
        while (list2) {
            insert(list2->data, merge);
            list2 = list2->link;
        }
    }
}

int main() {
    int cut;
    scanf("%d", &cut);
    node *head_1 = NULL;  // empty head
    int new_data;
    while (scanf("%d", &new_data) == 1 && new_data != -1) {
        insert(new_data, &head_1);
    }

    node *head_2 = NULL;  // empty head
    while (scanf("%d", &new_data) == 1 && new_data != EOF) {  // end: EOF
        insert(new_data, &head_2);
    }

    node *merge_head = NULL;  // empty head
    merge_list(head_1, head_2, &merge_head, cut);
    print_list(merge_head);  // empty head

    // find peak and delete non-peak values
    // for convenience, create new list
    node *index = merge_head;
    node *peak_list = NULL;
    while (index) {
        if (index->link && index == merge_head && index->data > index->link->data) {  // boundary
            insert(index->data, &peak_list);
        } else if (index->link && !index->link->link && index->data < index->link->data) { // boundary
            insert(index->link->data, &peak_list);
            break;
        } else if (index->link && index->link->link && index->data < index->link->data && index->link->data > index->link->link->data) {
            insert(index->link->data, &peak_list);
        }
        index = index->link;
    }
    print_list(peak_list);

    free_list(head_1);
    free_list(head_2);
    free_list(merge_head);
    free_list(peak_list);

    return 0;
}