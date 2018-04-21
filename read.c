
void read(array*[], int diff)
{
  if(diff == 1)
   FILE *file = fopen("hot_cross.txt", "r");
  else if(diff == 2)
    FILE *file = fopen("smoke.txt", "r");

  int i=0;
  int num;
  while(fscanf(file, "%d", &num) > 0)
    {
      integers[i] = num;
      i++;
    }
  fclose(file);
}

