#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_CASHIERS 10
#define MAX_CUSTOMERS 100
#define NAME_LENGTH 3

// Program structure:
// customer is in queue,
// Use cashiers[i].time_remaining to record how much time the current cashier still needs to work.
// Use the while loop as a code table,
// At the end of each loop, all cashier[i].time_remaining -1,
// Represents a unit of time in the past.

// In order to save program calculation work,
// Partial reduction of queue, retaining only front and rear,
// Except for the initial value, the front value must always be greater than or equal to the rear value.

struct cashier {
    int time_need;
    int time_remaining;
    char customer[NAME_LENGTH]; // VA'\0'
};

struct customer {
    char name[NAME_LENGTH];
    int priority; // 1 for priority, 0 for normal
};

int main() {
    int cashier_num;
    scanf("%d", &cashier_num);
    struct cashier cashiers[cashier_num];
    memset(cashiers, 0, sizeof(struct cashier) * cashier_num);
    struct customer queue[MAX_CUSTOMERS];
    memset(queue, 0, sizeof(struct customer) * MAX_CUSTOMERS);
    // index: cashier's id
    for (int i = 0; i < cashier_num; i++) {
        scanf("%d", &cashiers[i].time_need);
        cashiers[i].time_remaining = cashiers[i].time_need;
    }

    int customer_num = 0;
    char temp_customer[NAME_LENGTH];
    memset(temp_customer, 0, sizeof(char) * NAME_LENGTH);
    while (scanf("%s", temp_customer) && temp_customer[0] != '0') {
        strcpy(queue[customer_num].name, temp_customer);
        temp_customer[0] == 'V' ? (queue[customer_num].priority = 1) : (queue[customer_num].priority = 0);
        customer_num++;
    }

    // re-sort queue, make priorities in front of normal
    struct customer queue_sort[customer_num];
    memset(queue_sort, 0, sizeof(struct customer) * customer_num);
    int index = 0; // for queue_sort
    for (int i = 0; i < customer_num; i++) {
        if (queue[i].priority == 1) {
            queue_sort[index] = queue[i];
            index++;
        }
    }
    for (int i = 0; i < customer_num; i++) {
        if (queue[i].priority == 0) {
            queue_sort[index] = queue[i];
            index++;
        }
    }

    int front = 0;
    int rear = 0;
    
    while (rear < customer_num) {
        for (int i = 0; i < cashier_num; i++) {
            if ((cashiers[i].time_remaining == cashiers[i].time_need) && (front < customer_num)) {
                strcpy(cashiers[i].customer, queue_sort[front].name);
                // question acquire no. but not index
                printf("Cashier %d is checking out Customer %s\n", i + 1, cashiers[i].customer);
                // front++ represent the customer index go into cashier system
                front++;
            }
        }
        for (int i = 0; i < cashier_num; i++) {
            if (cashiers[i].time_remaining == 0) {
                printf("Cashier %d has finished checking out for Customer %s\n", i + 1, cashiers[i].customer);
                cashiers[i].customer[0] = '\0';
                rear++;
                cashiers[i].time_remaining = cashiers[i].time_need;
            } else if (cashiers[i].time_remaining != 0 && cashiers[i].customer[0] != '\0')
                cashiers[i].time_remaining--;
        }
        // printf(":<\n"); // time check
    }
    printf("Finish\n");
    return 0;
}