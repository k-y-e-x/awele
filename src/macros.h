#ifndef MACROS_H
#define MACROS_H
/*
*	divers #define utiles
*/

#define MAX(a,b)    ((a)>(b)?(a):(b))
#define MIN(a,b)    ((a)<(b)?(a):(b))
#define ABS(x)	    ((x<0)?(-(x)):(x))

#define PEEK(addr)          ((unsigned char*)addr)[0]
#define POKE(addr, val)     {((unsigned char*)addr)[0] = val;}
#define DEEK(addr)          ((unsigned int*)addr)[0]
#define DOKE(addr, val)     {((unsigned int*)addr)[0] = val;}
#define UNSUED(x)           (void)(x)


#endif	/* MACROS_H */