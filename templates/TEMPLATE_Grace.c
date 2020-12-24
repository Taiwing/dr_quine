#define FT(x) int main(){x;FILE*fp;if(!(fp=fopen(STR(Grace_kid.c),STR(w))))return(1);char**w=t;fprintf(fp,t[0],0);while(*w)fprintf(fp,STR(%c%s%c%c),34,*w++,34,44);fprintf(fp,STR(%s%c),t[1],10);w=t+2;while(*w)fprintf(fp,STR(%s%c),*w++,10);fclose(fp);return(0);}
#define STR(EXP) #EXP
/*
	mandatory 3-line comment
*/
FT(TEXT)
