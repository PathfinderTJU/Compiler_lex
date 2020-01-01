%{
        #include <stdio.h>
	#include <stdlib.h> 
	int count = 1;
%} 

whitespace [ \t]+
enter \n
keyword while|break|continue|for|if|else|float|int|void|return|main
identifier [a-zA-Z_][a-zA-Z0-9_]*
delimiter \(|\)|\{|\}|\;
operator \+|-|\*|\/|=|>=|==|<=
bin_integer (-|\+)?0b(0|1[0-1]*)
oct_integer (-|\+)?0(0|[1-7][0-7]*)
hex_integer (-|\+)?0x(0|(([1-9]|[a-f])([0-9]|[a-f])*))
dec_integer (-|\+)?0|([1-9][0-9]*)
floating_num (-|\+)?[0-9]+\.[0-9]+[E|e]?(-)?[1-9]?[0-9]*
constant {bin_integer}|{hex_integer}|{oct_integer}|{dec_integer}|{floating_num}

note \/\/.*
%%

{keyword} {
	printf("line %d 关键字：%s\n", count, yytext);
}

{identifier} {
	printf("line %d 标识符：%s\n", count, yytext);
}

{delimiter} {
	printf("line %d 界  符：%s\n", count, yytext);
}

{operator} {
	printf("line %d 算  符：%s\n", count, yytext);
}

{constant} {
	printf("line %d 常  数：%s\n", count, yytext);
}

{whitespace} {

}

{enter} {
	count++;	
}

{note} {
	printf("line %d 注 释: %s\n", count, yytext);
}

. {
	printf("line %d error未识别符号：%s\n", count, yytext);
}

%% 
int main(int argc , char* argv[]) 
{
	int i;	
	if(argc < 2){
		printf("参数错误,请输入至少一个文件路径(./a example.txt)\n");
		return -1;
	}else{
		for(i=1;i<argc;i++){
			count=1;
			yyin=fopen(argv[i],"r");
			if (yyin == NULL){
				printf("%s文件不存在\n", argv[i]);
				continue;
			} 
			printf("------------%s------------------\n",argv[i]);
    			yylex(); /* start the analysis*/ 
			fclose(yyin);
			printf("--------------------------------\n");
		}
	}
} 
 
int yywrap() 
{ 
	return 1; 
}

