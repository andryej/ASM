#include <cstdio>
#include <algorithm>

using namespace std;

int main()
{
  unsigned long count;
  scanf("%lu", &count);
  long data[count];
  for (int i=0; i<count; ++i)
    scanf("%ld", &data[i]);
  sort(data, data+count);
  for (int i=0; i<count; ++i)
    printf("%ld ", data[i]);
  printf("\n");
  return 0;
}
