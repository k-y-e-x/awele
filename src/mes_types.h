#ifndef	MES_TYPES_H
#define	MES_TYPES_H
/*
 ** SOURCE EXEC_TYPES.H DE L'AMIGA
**	$Filename: exec/types.h $
**	$Release: 2.04 Includes, V37.4 $
**	$Revision: 36.14 $
**	$Date: 91/11/08 $
**
**	Data typing.  Must be included before any other Amiga include.
**
**	(C) Copyright 1985-1999 Amiga, Inc.
**	    All Rights Reserved
*/



#define GLOBAL	extern	    /* the declaratory use of an external */
#define IMPORT	extern	    /* reference to an external */
#define STATIC	static	    /* a local static variable */
#define REGISTER register   /* a (hopefully) register variable */


#ifndef VOID
#define VOID		void
#endif


/* Types with specific semantics */
typedef float		FLOAT;
typedef short		BOOL;
typedef unsigned char	TEXT;

/*  WARNING: APTR was redefined for the V36 Includes!  APTR is a   */
/*  32-Bit Absolute Memory Pointer.  C pointer math will not	   */
/*  operate on APTR --	use "ULONG *" instead.			           */
#ifndef APTR_TYPEDEF
#define APTR_TYPEDEF
typedef void	       *APTR;	    /* 32-bit untyped pointer */
#endif
typedef long		LONG;	    /* signed 32-bit quantity */
typedef unsigned long	ULONG;	    /* unsigned 32-bit quantity */
typedef unsigned long	LONGBITS;   /* 32 bits manipulated individually */
#ifndef ASM_TYPES_INCLUDE			/* pour compat gbdk */
//#define TYPES_INCLUDE
typedef short		WORD;	    /* signed 16-bit quantity */
typedef unsigned short	UWORD;	    /* unsigned 16-bit quantity */
typedef unsigned short	WORDBITS;   /* 16 bits manipulated individually */
typedef BOOL		BOOLEAN;
#endif
#ifndef GB
typedef double		DOUBLE;			/* pas de double sur GB */
#else
typedef float		DOUBLE;
#endif
#if __STDC__
typedef signed char	BYTE;	    /* signed 8-bit quantity */
#else
typedef char		BYTE;	    /* signed 8-bit quantity */
#endif
typedef unsigned char	UBYTE;	    /* unsigned 8-bit quantity */
typedef unsigned char	BYTEBITS;   /* 8 bits manipulated individually */
typedef unsigned short	RPTR;	    /* signed relative pointer */
typedef unsigned char  *STRPTR;     /* string pointer (NULL terminated) */


/* For compatibility only: (don't use in new code) */
typedef short		SHORT;	    /* signed 16-bit quantity (use WORD) */
typedef unsigned short	USHORT;     /* unsigned 16-bit quantity (use UWORD) */
typedef short		COUNT;
typedef unsigned short	UCOUNT;
typedef ULONG		CPTR;



#ifndef TRUE
#define TRUE		1
#endif
#ifndef FALSE
#define FALSE		0
#endif
#ifndef NULL
#define NULL		0L
#endif


#define BYTEMASK	0xFF


/* #define LIBRARY_VERSION is now obsolete.  Please use LIBRARY_MINIMUM */
/* or code the specific minimum library version you require.		*/
#define LIBRARY_MINIMUM	33 /* Lowest version supported by Amiga, Inc. */


#endif	/* MES_TYPES_H */