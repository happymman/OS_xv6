#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "xem.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}


int
sys_getlev(void)
{
	return getlev();
}

int
sys_yield(void)
{
	return yield();
}

int
sys_set_cpu_share(void)
{
	int cpu_share;
	if (argint(0, &cpu_share) < 0)
		return -1;
	return set_cpu_share(cpu_share);
}

int
sys_thread_create(void){
	int first_arg, second_arg, third_arg;

	if(argint(0, &first_arg) <0) return -1;
	if(argint(1, &second_arg) <0) return -1;
	if(argint(2, &third_arg) <0) return -1;

	return thread_create((thread_t *)first_arg, (void*(*)(void*))second_arg, (void*)third_arg);
}

int
sys_thread_exit(void){
	int arg;
	if(argint(0, &arg) <0) return -1;
	thread_exit((void*)arg);
	return 0;
}

int sys_thread_join(void){
	int first_arg, second_arg;

	if(argint(0, &first_arg) < 0) return -1;
	if(argint(1, &second_arg) < 0) return -1;
	return thread_join((thread_t)first_arg, (void**)second_arg);
}

int sys_xem_init(void){
	xem_t arg;
	return xem_init(&arg);
}

int sys_xem_wait(void){
	xem_t arg;
	return xem_wait(&arg);
}

int sys_xem_unlock(void){
	xem_t arg;
	return xem_unlock(&arg);
}

int sys_pread(void)
{
	struct file *f =0;
	int n;
	char *p;
	int off;

	if( argint(2, &n) < 0 || argint(3, &off) < 0 || argptr(1, &p, n) < 0)
		return -1;
	return pfileread(f, p, n, off);
}

int sys_pwrite(void)
{
	struct file* f=0;
	int n, off;
	char *p;

	if( argint(2, &n) < 0 || argint(3, &off) < 0 || argptr(1, &p, n) < 0)
		return -1;

	return pfilewrite(f,p,n,off);
}
