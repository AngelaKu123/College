#include <stdio.h>
#include <string.h>
#include <stdbool.h>

#define MAX_STACK_SIZE 100
#define MAX_TAG_LENGTH 100

// Stack structure
typedef struct {
    char tags[MAX_STACK_SIZE][MAX_TAG_LENGTH];
    int top;
} Stack;

void extract_tag_space(char* tag) { // e.g. `div class="container"` -> `div`
    char *tag_index = tag;
    while (*tag_index && *tag_index != ' ') tag_index++;
    *tag_index = '\0';
}

bool is_self_closing_tag(const char* tag) { // e.g. `br/`
    return (strcmp(tag, "br/") == 0 || strcmp(tag, "br") == 0 || strcmp(tag, "img") == 0 || strcmp(tag, "img/") == 0);
}

bool is_opening_tag_begin(const char* tag) { // e.g. `div`
    return tag[0] != '/';
}

void push(Stack *html_stack, char *tag) {
    strcpy(html_stack->tags[++html_stack->top], tag);
    printf("Push to stack: %s\n", tag);
}

void pop(Stack *html_stack, char *tag, bool *valid) {
    printf("Pop from stack: %s\n", html_stack->tags[html_stack->top]);
    if (*valid == true) {
        memset(html_stack->tags[html_stack->top--], 0, sizeof(char) * MAX_TAG_LENGTH);
    } else { // don't have to top-- because it's time to end program
        printf("Error: Unclose tag - <%s>\n", tag);
    }
}

void extract_tag_end(char* tag) { // `/div` -> `div`
    char *tag_new = tag + 1;
    while(*tag) {
        *tag = *tag_new;
        tag++;
        tag_new++;
    }
}

int main() {
    Stack html;
    memset(&html, 0, sizeof(Stack));
    html.top = -1;
    char input[MAX_STACK_SIZE * MAX_TAG_LENGTH];
    memset(input, 0, sizeof(char) * MAX_STACK_SIZE * MAX_TAG_LENGTH);
    scanf("%[^\n]", input);

    bool html_valid = true; // default
    char temp_tag[MAX_TAG_LENGTH]; // store tag in input temporarily
    int tag_length; // count length of one tag
    char *ptr = input;
    while (*ptr) { // index of input
        if (*ptr == '<') {
            memset(temp_tag, 0, sizeof(char) * MAX_TAG_LENGTH); // initialize
            tag_length = 0;
            ptr++;
            while (*ptr && *ptr != '>') { // retrieve tag
                temp_tag[tag_length] = *ptr;
                tag_length++;
                ptr++;
            }
            temp_tag[tag_length] = '\0'; // the tag
            extract_tag_space(temp_tag);

            if (is_self_closing_tag(temp_tag) == true) {
                printf("Self-closing tag: %s\n", temp_tag);
            } else if (is_opening_tag_begin(temp_tag) == true) { // push
                push(&html, temp_tag);
            } else { // pop
                extract_tag_end(temp_tag);
                if (strcmp(temp_tag, html.tags[html.top]) == 0) {
                    pop(&html, html.tags[html.top], &html_valid);
                } else { // temp_tag != stack[top]
                    html_valid = false;
                    pop(&html, html.tags[html.top], &html_valid);
                    break;
                }
            }
        }
        ptr++; // to next tag...
    }

    if (html.top != -1) // not empty
        html_valid = false;
    
    printf("HTML code is valid: %s\n", html_valid ? "true" : "false");
    return 0;
}