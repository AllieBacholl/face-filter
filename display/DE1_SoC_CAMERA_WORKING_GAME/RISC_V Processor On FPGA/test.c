#define SUM_ADDR 0x00001000
volatile int *sum = (volatile int *)SUM_ADDR;

int main(void) {
  for (int i = 1; i <= 5; i++)
    *sum += i;
  while (1);
}
