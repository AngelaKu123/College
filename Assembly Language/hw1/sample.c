#include <stdio.h>
#include <stdlib.h>

int main(void)
{
   int i, sum, A[200];
   
   sum = 0;

   for (i=0; i<200; i++)
      A[i] = rand();

   for (i=0; i<=100; i++)
      sum = sum + A[i];
   
   printf("%d\n", sum);
   
   return 0;
}