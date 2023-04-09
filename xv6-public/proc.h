// Per-CPU state
struct cpu {
  uchar apicid;                // Local APIC ID
  struct context *scheduler;   // swtch() here to enter scheduler
  struct taskstate ts;         // Used by x86 to find stack for interrupt
  struct segdesc gdt[NSEGS];   // x86 global descriptor table
  volatile uint started;       // Has the CPU started?
  int ncli;                    // Depth of pushcli nesting.
  int intena;                  // Were interrupts enabled before pushcli?
  struct proc *proc;           // The process running on this cpu or null
};

extern struct cpu cpus[NCPU];
extern int ncpu;

//PAGEBREAK: 17
// Saved registers for kernel context switches.
// Don't need to save all the segment registers (%cs, etc),
// because they are constant across kernel contexts.
// Don't need to save %eax, %ecx, %edx, because the
// x86 convention is that the caller has saved them.
// Contexts are stored at the bottom of the stack they
// describe; the stack pointer is the address of the context.
// The layout of the context matches the layout of the stack in swtch.S
// at the "Switch stacks" comment. Switch doesn't save eip explicitly,
// but it is on the stack and allocproc() manipulates it.
struct context {
  uint edi;
  uint esi;
  uint ebx;
  uint ebp;
  uint eip;
};

struct d_storage{
	int sp[NPROC];
	int size;
};

enum procstate { UNUSED, EMBRYO, SLEEPING, RUNNABLE, RUNNING, ZOMBIE };

// Per-process state
struct proc {
  uint sz;                     // Size of process memory (bytes)
  pde_t* pgdir;                // Page table
  char *kstack;                // Bottom of kernel stack for this process
  enum procstate state;        // Process state
  int pid;                     // Process ID
  struct proc *parent;         // Parent process
  struct trapframe *tf;        // Trap frame for current syscall
  struct context *context;     // swtch() here to run process
  void *chan;                  // If non-zero, sleeping on chan
  int killed;                  // If non-zero, have been killed
  struct file *ofile[NOFILE];  // Open files
  struct inode *cwd;           // Current directory
  char name[16];               // Process name (debugging)
	
	int lev;										 // Priority level
	uint tick_cnt;						 	 // 소모한 tick cnt, 해당 프로세스의 작업중 Timer interrupt가 발생할때마다 증가하여, 속한 priority level의 할당 tick을 채웠는지 검사할때 쓰임
	int is_stride;							 // If non-zero, stride process
	int stride;									 // If non-zero, stride value
	uint pass_value;						 // Pass value
	int	ticket;									 // Number of ticket 

	int tid; //0초기화, 0 = normal process
	int lwpGroupid;
	int lwpstack;
	void *retval;
	struct d_storage d_storage;
	
};


/*
int xem_init(xem_t* xem);
int xem_wait(xem_t* xem);
int xem_unlock(xem_t* xem);
*/

// Process memory is laid out contiguously, low addresses first:
//   text
//   original data and bss
//   fixed-size stack
//   expandable heap

#define UINT_MAX (0xffffffff)
#define MAX_PASS (0x0fffffff)

#define TOTAL_TICKET (100)
#define MAX_STRIDE_TICKET (80)
#define BOOST_LIMIT (200)

#define LARGENUM (10000)
