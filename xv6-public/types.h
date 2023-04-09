typedef unsigned int   uint;
typedef unsigned short ushort;
typedef unsigned char  uchar;
typedef uint pde_t;
typedef int thread_t;


typedef struct xem_t{
	int value;
	int guard;
	int queue[64];
	int front;
	int rear;
}xem_t;

