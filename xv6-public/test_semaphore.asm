
_test_semaphore:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  void *ret;
  const int N = 10;
  thread_t t[N];

  printf(1, "1. Test without any synchronization\n");
  for(int i = 0; i < N; ++i) {
  11:	31 db                	xor    %ebx,%ebx
{
  13:	83 ec 40             	sub    $0x40,%esp
  printf(1, "1. Test without any synchronization\n");
  16:	68 a4 0a 00 00       	push   $0xaa4
  1b:	6a 01                	push   $0x1
  1d:	e8 8e 06 00 00       	call   6b0 <printf>
  22:	83 c4 10             	add    $0x10,%esp
  25:	8d 76 00             	lea    0x0(%esi),%esi
    if(thread_create(&t[i], test_without_sem, (void*)(i)) < 0) {
  28:	8d 44 9d c0          	lea    -0x40(%ebp,%ebx,4),%eax
  2c:	83 ec 04             	sub    $0x4,%esp
  2f:	53                   	push   %ebx
  30:	68 20 02 00 00       	push   $0x220
  35:	50                   	push   %eax
  36:	e8 8f 05 00 00       	call   5ca <thread_create>
  3b:	83 c4 10             	add    $0x10,%esp
  3e:	85 c0                	test   %eax,%eax
  40:	0f 88 b2 01 00 00    	js     1f8 <main+0x1f8>
  for(int i = 0; i < N; ++i) {
  46:	83 c3 01             	add    $0x1,%ebx
  49:	83 fb 0a             	cmp    $0xa,%ebx
  4c:	75 da                	jne    28 <main+0x28>
  4e:	8d 75 e8             	lea    -0x18(%ebp),%esi
  51:	8d 5d c0             	lea    -0x40(%ebp),%ebx
  54:	8d 7d bc             	lea    -0x44(%ebp),%edi
  57:	89 f6                	mov    %esi,%esi
  59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      printf(1, "panic at thread create\n");
      exit();
    }
  }
  for(int i = 0; i < N; ++i) {
    if(thread_join(t[i], &ret) < 0) {
  60:	83 ec 08             	sub    $0x8,%esp
  63:	57                   	push   %edi
  64:	ff 33                	pushl  (%ebx)
  66:	e8 6f 05 00 00       	call   5da <thread_join>
  6b:	83 c4 10             	add    $0x10,%esp
  6e:	85 c0                	test   %eax,%eax
  70:	0f 88 95 01 00 00    	js     20b <main+0x20b>
  76:	83 c3 04             	add    $0x4,%ebx
  for(int i = 0; i < N; ++i) {
  79:	39 f3                	cmp    %esi,%ebx
  7b:	75 e3                	jne    60 <main+0x60>
      printf(1, "panic at thread join\n");
      exit();
    }
  }
  printf(1, "\nIts sequence could be mixed\n");
  7d:	50                   	push   %eax
  7e:	50                   	push   %eax
  printf(1, "before init : sem address == %p\n", &sem);
  xem_init(&sem);
  printf(1, "after init : sem address == %p\n", &sem);
  printf(1, "sem.value == %d\n", sem.value);
  xem_wait(&sem);
  for(int i = 0; i < N; ++i) {
  7f:	31 f6                	xor    %esi,%esi
  printf(1, "\nIts sequence could be mixed\n");
  81:	68 39 0a 00 00       	push   $0xa39
  86:	6a 01                	push   $0x1
  88:	e8 23 06 00 00       	call   6b0 <printf>
  printf(1, "2. Test with synchronization of a binary semaphore\n");
  8d:	58                   	pop    %eax
  8e:	5a                   	pop    %edx
  8f:	68 cc 0a 00 00       	push   $0xacc
  94:	6a 01                	push   $0x1
  96:	e8 15 06 00 00       	call   6b0 <printf>
  printf(1, "before init : sem address == %p\n", &sem);
  9b:	83 c4 0c             	add    $0xc,%esp
  9e:	68 c0 0e 00 00       	push   $0xec0
  a3:	68 00 0b 00 00       	push   $0xb00
  a8:	6a 01                	push   $0x1
  aa:	e8 01 06 00 00       	call   6b0 <printf>
  xem_init(&sem);
  af:	c7 04 24 c0 0e 00 00 	movl   $0xec0,(%esp)
  b6:	e8 27 05 00 00       	call   5e2 <xem_init>
  printf(1, "after init : sem address == %p\n", &sem);
  bb:	83 c4 0c             	add    $0xc,%esp
  be:	68 c0 0e 00 00       	push   $0xec0
  c3:	68 24 0b 00 00       	push   $0xb24
  c8:	6a 01                	push   $0x1
  ca:	e8 e1 05 00 00       	call   6b0 <printf>
  printf(1, "sem.value == %d\n", sem.value);
  cf:	83 c4 0c             	add    $0xc,%esp
  d2:	ff 35 c0 0e 00 00    	pushl  0xec0
  d8:	68 57 0a 00 00       	push   $0xa57
  dd:	6a 01                	push   $0x1
  df:	e8 cc 05 00 00       	call   6b0 <printf>
  xem_wait(&sem);
  e4:	c7 04 24 c0 0e 00 00 	movl   $0xec0,(%esp)
  eb:	e8 fa 04 00 00       	call   5ea <xem_wait>
  f0:	83 c4 10             	add    $0x10,%esp
  f3:	90                   	nop
  f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(thread_create(&t[i], test_with_sem, (void*)(i)) < 0) {
  f8:	8d 44 b5 c0          	lea    -0x40(%ebp,%esi,4),%eax
  fc:	83 ec 04             	sub    $0x4,%esp
  ff:	56                   	push   %esi
 100:	68 60 02 00 00       	push   $0x260
 105:	50                   	push   %eax
 106:	e8 bf 04 00 00       	call   5ca <thread_create>
 10b:	83 c4 10             	add    $0x10,%esp
 10e:	85 c0                	test   %eax,%eax
 110:	0f 88 e2 00 00 00    	js     1f8 <main+0x1f8>
  for(int i = 0; i < N; ++i) {
 116:	83 c6 01             	add    $0x1,%esi
 119:	83 fe 0a             	cmp    $0xa,%esi
 11c:	75 da                	jne    f8 <main+0xf8>
      printf(1, "panic at thread create\n");
      exit();
    }
  }
  xem_unlock(&sem);
 11e:	83 ec 0c             	sub    $0xc,%esp
 121:	8d 75 c0             	lea    -0x40(%ebp),%esi
 124:	68 c0 0e 00 00       	push   $0xec0
 129:	e8 c4 04 00 00       	call   5f2 <xem_unlock>
 12e:	83 c4 10             	add    $0x10,%esp
 131:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(int i = 0; i < N; ++i) {
    if(thread_join(t[i], &ret) < 0) {
 138:	83 ec 08             	sub    $0x8,%esp
 13b:	57                   	push   %edi
 13c:	ff 36                	pushl  (%esi)
 13e:	e8 97 04 00 00       	call   5da <thread_join>
 143:	83 c4 10             	add    $0x10,%esp
 146:	85 c0                	test   %eax,%eax
 148:	0f 88 bd 00 00 00    	js     20b <main+0x20b>
 14e:	83 c6 04             	add    $0x4,%esi
  for(int i = 0; i < N; ++i) {
 151:	39 de                	cmp    %ebx,%esi
 153:	75 e3                	jne    138 <main+0x138>
      printf(1, "panic at thread join\n");
      exit();
    }
  }
  printf(1, "\nIts sequence must be sorted\n");
 155:	53                   	push   %ebx
 156:	53                   	push   %ebx

  printf(1, "3. Test with synchronization of a semaphore with 3 users\n");
  xem_init(&sem);
  sem.value = 3;
  xem_wait(&sem);
  for(int i = 0; i < N; ++i) {
 157:	31 db                	xor    %ebx,%ebx
  printf(1, "\nIts sequence must be sorted\n");
 159:	68 68 0a 00 00       	push   $0xa68
 15e:	6a 01                	push   $0x1
 160:	e8 4b 05 00 00       	call   6b0 <printf>
  printf(1, "3. Test with synchronization of a semaphore with 3 users\n");
 165:	5e                   	pop    %esi
 166:	58                   	pop    %eax
 167:	68 44 0b 00 00       	push   $0xb44
 16c:	6a 01                	push   $0x1
 16e:	e8 3d 05 00 00       	call   6b0 <printf>
  xem_init(&sem);
 173:	c7 04 24 c0 0e 00 00 	movl   $0xec0,(%esp)
 17a:	e8 63 04 00 00       	call   5e2 <xem_init>
  xem_wait(&sem);
 17f:	c7 04 24 c0 0e 00 00 	movl   $0xec0,(%esp)
  sem.value = 3;
 186:	c7 05 c0 0e 00 00 03 	movl   $0x3,0xec0
 18d:	00 00 00 
  xem_wait(&sem);
 190:	e8 55 04 00 00       	call   5ea <xem_wait>
 195:	83 c4 10             	add    $0x10,%esp
    if(thread_create(&t[i], test_with_sem, (void*)(i)) < 0) {
 198:	8d 44 9d c0          	lea    -0x40(%ebp,%ebx,4),%eax
 19c:	51                   	push   %ecx
 19d:	53                   	push   %ebx
 19e:	68 60 02 00 00       	push   $0x260
 1a3:	50                   	push   %eax
 1a4:	e8 21 04 00 00       	call   5ca <thread_create>
 1a9:	83 c4 10             	add    $0x10,%esp
 1ac:	85 c0                	test   %eax,%eax
 1ae:	78 48                	js     1f8 <main+0x1f8>
  for(int i = 0; i < N; ++i) {
 1b0:	83 c3 01             	add    $0x1,%ebx
 1b3:	83 fb 0a             	cmp    $0xa,%ebx
 1b6:	75 e0                	jne    198 <main+0x198>
      printf(1, "panic at thread create\n");
      exit();
    }
  }
  xem_unlock(&sem);
 1b8:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < N; ++i) {
 1bb:	31 db                	xor    %ebx,%ebx
  xem_unlock(&sem);
 1bd:	68 c0 0e 00 00       	push   $0xec0
 1c2:	e8 2b 04 00 00       	call   5f2 <xem_unlock>
 1c7:	83 c4 10             	add    $0x10,%esp
    if(thread_join(t[i], &ret) < 0) {
 1ca:	52                   	push   %edx
 1cb:	52                   	push   %edx
 1cc:	57                   	push   %edi
 1cd:	ff 74 9d c0          	pushl  -0x40(%ebp,%ebx,4)
 1d1:	e8 04 04 00 00       	call   5da <thread_join>
 1d6:	83 c4 10             	add    $0x10,%esp
 1d9:	85 c0                	test   %eax,%eax
 1db:	78 2e                	js     20b <main+0x20b>
  for(int i = 0; i < N; ++i) {
 1dd:	83 c3 01             	add    $0x1,%ebx
 1e0:	83 fb 0a             	cmp    $0xa,%ebx
 1e3:	75 e5                	jne    1ca <main+0x1ca>
      printf(1, "panic at thread join\n");
      exit();
    }
  }
  printf(1, "\nIts sequence could be messy\n");
 1e5:	50                   	push   %eax
 1e6:	50                   	push   %eax
 1e7:	68 86 0a 00 00       	push   $0xa86
 1ec:	6a 01                	push   $0x1
 1ee:	e8 bd 04 00 00       	call   6b0 <printf>
  exit();
 1f3:	e8 1a 03 00 00       	call   512 <exit>
      printf(1, "panic at thread create\n");
 1f8:	53                   	push   %ebx
 1f9:	53                   	push   %ebx
 1fa:	68 0b 0a 00 00       	push   $0xa0b
 1ff:	6a 01                	push   $0x1
 201:	e8 aa 04 00 00       	call   6b0 <printf>
      exit();
 206:	e8 07 03 00 00       	call   512 <exit>
      printf(1, "panic at thread join\n");
 20b:	51                   	push   %ecx
 20c:	51                   	push   %ecx
 20d:	68 23 0a 00 00       	push   $0xa23
 212:	6a 01                	push   $0x1
 214:	e8 97 04 00 00       	call   6b0 <printf>
      exit();
 219:	e8 f4 02 00 00       	call   512 <exit>
 21e:	66 90                	xchg   %ax,%ax

00000220 <test_without_sem>:
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	56                   	push   %esi
 224:	53                   	push   %ebx
 225:	8b 75 08             	mov    0x8(%ebp),%esi
  int id = (int)arg;
 228:	bb 0a 00 00 00       	mov    $0xa,%ebx
 22d:	8d 76 00             	lea    0x0(%esi),%esi
    printf(1, "%d", id);
 230:	83 ec 04             	sub    $0x4,%esp
 233:	56                   	push   %esi
 234:	68 08 0a 00 00       	push   $0xa08
 239:	6a 01                	push   $0x1
 23b:	e8 70 04 00 00       	call   6b0 <printf>
  for(int i = 0; i < 10; ++i)
 240:	83 c4 10             	add    $0x10,%esp
 243:	83 eb 01             	sub    $0x1,%ebx
 246:	75 e8                	jne    230 <test_without_sem+0x10>
  thread_exit(0);
 248:	83 ec 0c             	sub    $0xc,%esp
 24b:	6a 00                	push   $0x0
 24d:	e8 80 03 00 00       	call   5d2 <thread_exit>
}
 252:	8d 65 f8             	lea    -0x8(%ebp),%esp
 255:	31 c0                	xor    %eax,%eax
 257:	5b                   	pop    %ebx
 258:	5e                   	pop    %esi
 259:	5d                   	pop    %ebp
 25a:	c3                   	ret    
 25b:	90                   	nop
 25c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000260 <test_with_sem>:
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	56                   	push   %esi
 264:	53                   	push   %ebx
 265:	8b 75 08             	mov    0x8(%ebp),%esi
  xem_wait(&sem);
 268:	bb 0a 00 00 00       	mov    $0xa,%ebx
 26d:	83 ec 0c             	sub    $0xc,%esp
 270:	68 c0 0e 00 00       	push   $0xec0
 275:	e8 70 03 00 00       	call   5ea <xem_wait>
 27a:	83 c4 10             	add    $0x10,%esp
 27d:	8d 76 00             	lea    0x0(%esi),%esi
    printf(1, "%d", id);
 280:	83 ec 04             	sub    $0x4,%esp
 283:	56                   	push   %esi
 284:	68 08 0a 00 00       	push   $0xa08
 289:	6a 01                	push   $0x1
 28b:	e8 20 04 00 00       	call   6b0 <printf>
  for(int i = 0; i < 10; ++i)
 290:	83 c4 10             	add    $0x10,%esp
 293:	83 eb 01             	sub    $0x1,%ebx
 296:	75 e8                	jne    280 <test_with_sem+0x20>
  xem_unlock(&sem);
 298:	83 ec 0c             	sub    $0xc,%esp
 29b:	68 c0 0e 00 00       	push   $0xec0
 2a0:	e8 4d 03 00 00       	call   5f2 <xem_unlock>
  thread_exit(0);
 2a5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2ac:	e8 21 03 00 00       	call   5d2 <thread_exit>
}
 2b1:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2b4:	31 c0                	xor    %eax,%eax
 2b6:	5b                   	pop    %ebx
 2b7:	5e                   	pop    %esi
 2b8:	5d                   	pop    %ebp
 2b9:	c3                   	ret    
 2ba:	66 90                	xchg   %ax,%ax
 2bc:	66 90                	xchg   %ax,%ax
 2be:	66 90                	xchg   %ax,%ax

000002c0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	53                   	push   %ebx
 2c4:	8b 45 08             	mov    0x8(%ebp),%eax
 2c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2ca:	89 c2                	mov    %eax,%edx
 2cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2d0:	83 c1 01             	add    $0x1,%ecx
 2d3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 2d7:	83 c2 01             	add    $0x1,%edx
 2da:	84 db                	test   %bl,%bl
 2dc:	88 5a ff             	mov    %bl,-0x1(%edx)
 2df:	75 ef                	jne    2d0 <strcpy+0x10>
    ;
  return os;
}
 2e1:	5b                   	pop    %ebx
 2e2:	5d                   	pop    %ebp
 2e3:	c3                   	ret    
 2e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000002f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	53                   	push   %ebx
 2f4:	8b 55 08             	mov    0x8(%ebp),%edx
 2f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 2fa:	0f b6 02             	movzbl (%edx),%eax
 2fd:	0f b6 19             	movzbl (%ecx),%ebx
 300:	84 c0                	test   %al,%al
 302:	75 1c                	jne    320 <strcmp+0x30>
 304:	eb 2a                	jmp    330 <strcmp+0x40>
 306:	8d 76 00             	lea    0x0(%esi),%esi
 309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 310:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 313:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 316:	83 c1 01             	add    $0x1,%ecx
 319:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 31c:	84 c0                	test   %al,%al
 31e:	74 10                	je     330 <strcmp+0x40>
 320:	38 d8                	cmp    %bl,%al
 322:	74 ec                	je     310 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 324:	29 d8                	sub    %ebx,%eax
}
 326:	5b                   	pop    %ebx
 327:	5d                   	pop    %ebp
 328:	c3                   	ret    
 329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 330:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 332:	29 d8                	sub    %ebx,%eax
}
 334:	5b                   	pop    %ebx
 335:	5d                   	pop    %ebp
 336:	c3                   	ret    
 337:	89 f6                	mov    %esi,%esi
 339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000340 <strlen>:

uint
strlen(const char *s)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 346:	80 39 00             	cmpb   $0x0,(%ecx)
 349:	74 15                	je     360 <strlen+0x20>
 34b:	31 d2                	xor    %edx,%edx
 34d:	8d 76 00             	lea    0x0(%esi),%esi
 350:	83 c2 01             	add    $0x1,%edx
 353:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 357:	89 d0                	mov    %edx,%eax
 359:	75 f5                	jne    350 <strlen+0x10>
    ;
  return n;
}
 35b:	5d                   	pop    %ebp
 35c:	c3                   	ret    
 35d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 360:	31 c0                	xor    %eax,%eax
}
 362:	5d                   	pop    %ebp
 363:	c3                   	ret    
 364:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 36a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000370 <memset>:

void*
memset(void *dst, int c, uint n)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	57                   	push   %edi
 374:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 377:	8b 4d 10             	mov    0x10(%ebp),%ecx
 37a:	8b 45 0c             	mov    0xc(%ebp),%eax
 37d:	89 d7                	mov    %edx,%edi
 37f:	fc                   	cld    
 380:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 382:	89 d0                	mov    %edx,%eax
 384:	5f                   	pop    %edi
 385:	5d                   	pop    %ebp
 386:	c3                   	ret    
 387:	89 f6                	mov    %esi,%esi
 389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000390 <strchr>:

char*
strchr(const char *s, char c)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	53                   	push   %ebx
 394:	8b 45 08             	mov    0x8(%ebp),%eax
 397:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 39a:	0f b6 10             	movzbl (%eax),%edx
 39d:	84 d2                	test   %dl,%dl
 39f:	74 1d                	je     3be <strchr+0x2e>
    if(*s == c)
 3a1:	38 d3                	cmp    %dl,%bl
 3a3:	89 d9                	mov    %ebx,%ecx
 3a5:	75 0d                	jne    3b4 <strchr+0x24>
 3a7:	eb 17                	jmp    3c0 <strchr+0x30>
 3a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3b0:	38 ca                	cmp    %cl,%dl
 3b2:	74 0c                	je     3c0 <strchr+0x30>
  for(; *s; s++)
 3b4:	83 c0 01             	add    $0x1,%eax
 3b7:	0f b6 10             	movzbl (%eax),%edx
 3ba:	84 d2                	test   %dl,%dl
 3bc:	75 f2                	jne    3b0 <strchr+0x20>
      return (char*)s;
  return 0;
 3be:	31 c0                	xor    %eax,%eax
}
 3c0:	5b                   	pop    %ebx
 3c1:	5d                   	pop    %ebp
 3c2:	c3                   	ret    
 3c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003d0 <gets>:

char*
gets(char *buf, int max)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	57                   	push   %edi
 3d4:	56                   	push   %esi
 3d5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3d6:	31 f6                	xor    %esi,%esi
 3d8:	89 f3                	mov    %esi,%ebx
{
 3da:	83 ec 1c             	sub    $0x1c,%esp
 3dd:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 3e0:	eb 2f                	jmp    411 <gets+0x41>
 3e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 3e8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3eb:	83 ec 04             	sub    $0x4,%esp
 3ee:	6a 01                	push   $0x1
 3f0:	50                   	push   %eax
 3f1:	6a 00                	push   $0x0
 3f3:	e8 32 01 00 00       	call   52a <read>
    if(cc < 1)
 3f8:	83 c4 10             	add    $0x10,%esp
 3fb:	85 c0                	test   %eax,%eax
 3fd:	7e 1c                	jle    41b <gets+0x4b>
      break;
    buf[i++] = c;
 3ff:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 403:	83 c7 01             	add    $0x1,%edi
 406:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 409:	3c 0a                	cmp    $0xa,%al
 40b:	74 23                	je     430 <gets+0x60>
 40d:	3c 0d                	cmp    $0xd,%al
 40f:	74 1f                	je     430 <gets+0x60>
  for(i=0; i+1 < max; ){
 411:	83 c3 01             	add    $0x1,%ebx
 414:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 417:	89 fe                	mov    %edi,%esi
 419:	7c cd                	jl     3e8 <gets+0x18>
 41b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 41d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 420:	c6 03 00             	movb   $0x0,(%ebx)
}
 423:	8d 65 f4             	lea    -0xc(%ebp),%esp
 426:	5b                   	pop    %ebx
 427:	5e                   	pop    %esi
 428:	5f                   	pop    %edi
 429:	5d                   	pop    %ebp
 42a:	c3                   	ret    
 42b:	90                   	nop
 42c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 430:	8b 75 08             	mov    0x8(%ebp),%esi
 433:	8b 45 08             	mov    0x8(%ebp),%eax
 436:	01 de                	add    %ebx,%esi
 438:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 43a:	c6 03 00             	movb   $0x0,(%ebx)
}
 43d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 440:	5b                   	pop    %ebx
 441:	5e                   	pop    %esi
 442:	5f                   	pop    %edi
 443:	5d                   	pop    %ebp
 444:	c3                   	ret    
 445:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000450 <stat>:

int
stat(const char *n, struct stat *st)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	56                   	push   %esi
 454:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 455:	83 ec 08             	sub    $0x8,%esp
 458:	6a 00                	push   $0x0
 45a:	ff 75 08             	pushl  0x8(%ebp)
 45d:	e8 f0 00 00 00       	call   552 <open>
  if(fd < 0)
 462:	83 c4 10             	add    $0x10,%esp
 465:	85 c0                	test   %eax,%eax
 467:	78 27                	js     490 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 469:	83 ec 08             	sub    $0x8,%esp
 46c:	ff 75 0c             	pushl  0xc(%ebp)
 46f:	89 c3                	mov    %eax,%ebx
 471:	50                   	push   %eax
 472:	e8 f3 00 00 00       	call   56a <fstat>
  close(fd);
 477:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 47a:	89 c6                	mov    %eax,%esi
  close(fd);
 47c:	e8 b9 00 00 00       	call   53a <close>
  return r;
 481:	83 c4 10             	add    $0x10,%esp
}
 484:	8d 65 f8             	lea    -0x8(%ebp),%esp
 487:	89 f0                	mov    %esi,%eax
 489:	5b                   	pop    %ebx
 48a:	5e                   	pop    %esi
 48b:	5d                   	pop    %ebp
 48c:	c3                   	ret    
 48d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 490:	be ff ff ff ff       	mov    $0xffffffff,%esi
 495:	eb ed                	jmp    484 <stat+0x34>
 497:	89 f6                	mov    %esi,%esi
 499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004a0 <atoi>:

int
atoi(const char *s)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	53                   	push   %ebx
 4a4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4a7:	0f be 11             	movsbl (%ecx),%edx
 4aa:	8d 42 d0             	lea    -0x30(%edx),%eax
 4ad:	3c 09                	cmp    $0x9,%al
  n = 0;
 4af:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 4b4:	77 1f                	ja     4d5 <atoi+0x35>
 4b6:	8d 76 00             	lea    0x0(%esi),%esi
 4b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 4c0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 4c3:	83 c1 01             	add    $0x1,%ecx
 4c6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 4ca:	0f be 11             	movsbl (%ecx),%edx
 4cd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 4d0:	80 fb 09             	cmp    $0x9,%bl
 4d3:	76 eb                	jbe    4c0 <atoi+0x20>
  return n;
}
 4d5:	5b                   	pop    %ebx
 4d6:	5d                   	pop    %ebp
 4d7:	c3                   	ret    
 4d8:	90                   	nop
 4d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004e0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	56                   	push   %esi
 4e4:	53                   	push   %ebx
 4e5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4e8:	8b 45 08             	mov    0x8(%ebp),%eax
 4eb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4ee:	85 db                	test   %ebx,%ebx
 4f0:	7e 14                	jle    506 <memmove+0x26>
 4f2:	31 d2                	xor    %edx,%edx
 4f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 4f8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 4fc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 4ff:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 502:	39 d3                	cmp    %edx,%ebx
 504:	75 f2                	jne    4f8 <memmove+0x18>
  return vdst;
}
 506:	5b                   	pop    %ebx
 507:	5e                   	pop    %esi
 508:	5d                   	pop    %ebp
 509:	c3                   	ret    

0000050a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 50a:	b8 01 00 00 00       	mov    $0x1,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <exit>:
SYSCALL(exit)
 512:	b8 02 00 00 00       	mov    $0x2,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <wait>:
SYSCALL(wait)
 51a:	b8 03 00 00 00       	mov    $0x3,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <pipe>:
SYSCALL(pipe)
 522:	b8 04 00 00 00       	mov    $0x4,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    

0000052a <read>:
SYSCALL(read)
 52a:	b8 05 00 00 00       	mov    $0x5,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    

00000532 <write>:
SYSCALL(write)
 532:	b8 10 00 00 00       	mov    $0x10,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret    

0000053a <close>:
SYSCALL(close)
 53a:	b8 15 00 00 00       	mov    $0x15,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret    

00000542 <kill>:
SYSCALL(kill)
 542:	b8 06 00 00 00       	mov    $0x6,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret    

0000054a <exec>:
SYSCALL(exec)
 54a:	b8 07 00 00 00       	mov    $0x7,%eax
 54f:	cd 40                	int    $0x40
 551:	c3                   	ret    

00000552 <open>:
SYSCALL(open)
 552:	b8 0f 00 00 00       	mov    $0xf,%eax
 557:	cd 40                	int    $0x40
 559:	c3                   	ret    

0000055a <mknod>:
SYSCALL(mknod)
 55a:	b8 11 00 00 00       	mov    $0x11,%eax
 55f:	cd 40                	int    $0x40
 561:	c3                   	ret    

00000562 <unlink>:
SYSCALL(unlink)
 562:	b8 12 00 00 00       	mov    $0x12,%eax
 567:	cd 40                	int    $0x40
 569:	c3                   	ret    

0000056a <fstat>:
SYSCALL(fstat)
 56a:	b8 08 00 00 00       	mov    $0x8,%eax
 56f:	cd 40                	int    $0x40
 571:	c3                   	ret    

00000572 <link>:
SYSCALL(link)
 572:	b8 13 00 00 00       	mov    $0x13,%eax
 577:	cd 40                	int    $0x40
 579:	c3                   	ret    

0000057a <mkdir>:
SYSCALL(mkdir)
 57a:	b8 14 00 00 00       	mov    $0x14,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <chdir>:
SYSCALL(chdir)
 582:	b8 09 00 00 00       	mov    $0x9,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    

0000058a <dup>:
SYSCALL(dup)
 58a:	b8 0a 00 00 00       	mov    $0xa,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    

00000592 <getpid>:
SYSCALL(getpid)
 592:	b8 0b 00 00 00       	mov    $0xb,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    

0000059a <sbrk>:
SYSCALL(sbrk)
 59a:	b8 0c 00 00 00       	mov    $0xc,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret    

000005a2 <sleep>:
SYSCALL(sleep)
 5a2:	b8 0d 00 00 00       	mov    $0xd,%eax
 5a7:	cd 40                	int    $0x40
 5a9:	c3                   	ret    

000005aa <uptime>:
SYSCALL(uptime)
 5aa:	b8 0e 00 00 00       	mov    $0xe,%eax
 5af:	cd 40                	int    $0x40
 5b1:	c3                   	ret    

000005b2 <getlev>:
SYSCALL(getlev)
 5b2:	b8 16 00 00 00       	mov    $0x16,%eax
 5b7:	cd 40                	int    $0x40
 5b9:	c3                   	ret    

000005ba <yield>:
SYSCALL(yield)
 5ba:	b8 17 00 00 00       	mov    $0x17,%eax
 5bf:	cd 40                	int    $0x40
 5c1:	c3                   	ret    

000005c2 <set_cpu_share>:
SYSCALL(set_cpu_share)
 5c2:	b8 18 00 00 00       	mov    $0x18,%eax
 5c7:	cd 40                	int    $0x40
 5c9:	c3                   	ret    

000005ca <thread_create>:
SYSCALL(thread_create)
 5ca:	b8 19 00 00 00       	mov    $0x19,%eax
 5cf:	cd 40                	int    $0x40
 5d1:	c3                   	ret    

000005d2 <thread_exit>:
SYSCALL(thread_exit)
 5d2:	b8 1a 00 00 00       	mov    $0x1a,%eax
 5d7:	cd 40                	int    $0x40
 5d9:	c3                   	ret    

000005da <thread_join>:
SYSCALL(thread_join)
 5da:	b8 1b 00 00 00       	mov    $0x1b,%eax
 5df:	cd 40                	int    $0x40
 5e1:	c3                   	ret    

000005e2 <xem_init>:
SYSCALL(xem_init)
 5e2:	b8 1c 00 00 00       	mov    $0x1c,%eax
 5e7:	cd 40                	int    $0x40
 5e9:	c3                   	ret    

000005ea <xem_wait>:
SYSCALL(xem_wait)
 5ea:	b8 1d 00 00 00       	mov    $0x1d,%eax
 5ef:	cd 40                	int    $0x40
 5f1:	c3                   	ret    

000005f2 <xem_unlock>:
SYSCALL(xem_unlock)
 5f2:	b8 1e 00 00 00       	mov    $0x1e,%eax
 5f7:	cd 40                	int    $0x40
 5f9:	c3                   	ret    

000005fa <pread>:
SYSCALL(pread)
 5fa:	b8 1f 00 00 00       	mov    $0x1f,%eax
 5ff:	cd 40                	int    $0x40
 601:	c3                   	ret    

00000602 <pwrite>:
SYSCALL(pwrite)
 602:	b8 20 00 00 00       	mov    $0x20,%eax
 607:	cd 40                	int    $0x40
 609:	c3                   	ret    
 60a:	66 90                	xchg   %ax,%ax
 60c:	66 90                	xchg   %ax,%ax
 60e:	66 90                	xchg   %ax,%ax

00000610 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 610:	55                   	push   %ebp
 611:	89 e5                	mov    %esp,%ebp
 613:	57                   	push   %edi
 614:	56                   	push   %esi
 615:	53                   	push   %ebx
 616:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 619:	85 d2                	test   %edx,%edx
{
 61b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 61e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 620:	79 76                	jns    698 <printint+0x88>
 622:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 626:	74 70                	je     698 <printint+0x88>
    x = -xx;
 628:	f7 d8                	neg    %eax
    neg = 1;
 62a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 631:	31 f6                	xor    %esi,%esi
 633:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 636:	eb 0a                	jmp    642 <printint+0x32>
 638:	90                   	nop
 639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 640:	89 fe                	mov    %edi,%esi
 642:	31 d2                	xor    %edx,%edx
 644:	8d 7e 01             	lea    0x1(%esi),%edi
 647:	f7 f1                	div    %ecx
 649:	0f b6 92 88 0b 00 00 	movzbl 0xb88(%edx),%edx
  }while((x /= base) != 0);
 650:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 652:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 655:	75 e9                	jne    640 <printint+0x30>
  if(neg)
 657:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 65a:	85 c0                	test   %eax,%eax
 65c:	74 08                	je     666 <printint+0x56>
    buf[i++] = '-';
 65e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 663:	8d 7e 02             	lea    0x2(%esi),%edi
 666:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 66a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 66d:	8d 76 00             	lea    0x0(%esi),%esi
 670:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 673:	83 ec 04             	sub    $0x4,%esp
 676:	83 ee 01             	sub    $0x1,%esi
 679:	6a 01                	push   $0x1
 67b:	53                   	push   %ebx
 67c:	57                   	push   %edi
 67d:	88 45 d7             	mov    %al,-0x29(%ebp)
 680:	e8 ad fe ff ff       	call   532 <write>

  while(--i >= 0)
 685:	83 c4 10             	add    $0x10,%esp
 688:	39 de                	cmp    %ebx,%esi
 68a:	75 e4                	jne    670 <printint+0x60>
    putc(fd, buf[i]);
}
 68c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 68f:	5b                   	pop    %ebx
 690:	5e                   	pop    %esi
 691:	5f                   	pop    %edi
 692:	5d                   	pop    %ebp
 693:	c3                   	ret    
 694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 698:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 69f:	eb 90                	jmp    631 <printint+0x21>
 6a1:	eb 0d                	jmp    6b0 <printf>
 6a3:	90                   	nop
 6a4:	90                   	nop
 6a5:	90                   	nop
 6a6:	90                   	nop
 6a7:	90                   	nop
 6a8:	90                   	nop
 6a9:	90                   	nop
 6aa:	90                   	nop
 6ab:	90                   	nop
 6ac:	90                   	nop
 6ad:	90                   	nop
 6ae:	90                   	nop
 6af:	90                   	nop

000006b0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	57                   	push   %edi
 6b4:	56                   	push   %esi
 6b5:	53                   	push   %ebx
 6b6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6b9:	8b 75 0c             	mov    0xc(%ebp),%esi
 6bc:	0f b6 1e             	movzbl (%esi),%ebx
 6bf:	84 db                	test   %bl,%bl
 6c1:	0f 84 b3 00 00 00    	je     77a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 6c7:	8d 45 10             	lea    0x10(%ebp),%eax
 6ca:	83 c6 01             	add    $0x1,%esi
  state = 0;
 6cd:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 6cf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 6d2:	eb 2f                	jmp    703 <printf+0x53>
 6d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6d8:	83 f8 25             	cmp    $0x25,%eax
 6db:	0f 84 a7 00 00 00    	je     788 <printf+0xd8>
  write(fd, &c, 1);
 6e1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 6e4:	83 ec 04             	sub    $0x4,%esp
 6e7:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 6ea:	6a 01                	push   $0x1
 6ec:	50                   	push   %eax
 6ed:	ff 75 08             	pushl  0x8(%ebp)
 6f0:	e8 3d fe ff ff       	call   532 <write>
 6f5:	83 c4 10             	add    $0x10,%esp
 6f8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 6fb:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 6ff:	84 db                	test   %bl,%bl
 701:	74 77                	je     77a <printf+0xca>
    if(state == 0){
 703:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 705:	0f be cb             	movsbl %bl,%ecx
 708:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 70b:	74 cb                	je     6d8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 70d:	83 ff 25             	cmp    $0x25,%edi
 710:	75 e6                	jne    6f8 <printf+0x48>
      if(c == 'd'){
 712:	83 f8 64             	cmp    $0x64,%eax
 715:	0f 84 05 01 00 00    	je     820 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 71b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 721:	83 f9 70             	cmp    $0x70,%ecx
 724:	74 72                	je     798 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 726:	83 f8 73             	cmp    $0x73,%eax
 729:	0f 84 99 00 00 00    	je     7c8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 72f:	83 f8 63             	cmp    $0x63,%eax
 732:	0f 84 08 01 00 00    	je     840 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 738:	83 f8 25             	cmp    $0x25,%eax
 73b:	0f 84 ef 00 00 00    	je     830 <printf+0x180>
  write(fd, &c, 1);
 741:	8d 45 e7             	lea    -0x19(%ebp),%eax
 744:	83 ec 04             	sub    $0x4,%esp
 747:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 74b:	6a 01                	push   $0x1
 74d:	50                   	push   %eax
 74e:	ff 75 08             	pushl  0x8(%ebp)
 751:	e8 dc fd ff ff       	call   532 <write>
 756:	83 c4 0c             	add    $0xc,%esp
 759:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 75c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 75f:	6a 01                	push   $0x1
 761:	50                   	push   %eax
 762:	ff 75 08             	pushl  0x8(%ebp)
 765:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 768:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 76a:	e8 c3 fd ff ff       	call   532 <write>
  for(i = 0; fmt[i]; i++){
 76f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 773:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 776:	84 db                	test   %bl,%bl
 778:	75 89                	jne    703 <printf+0x53>
    }
  }
}
 77a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 77d:	5b                   	pop    %ebx
 77e:	5e                   	pop    %esi
 77f:	5f                   	pop    %edi
 780:	5d                   	pop    %ebp
 781:	c3                   	ret    
 782:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 788:	bf 25 00 00 00       	mov    $0x25,%edi
 78d:	e9 66 ff ff ff       	jmp    6f8 <printf+0x48>
 792:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 798:	83 ec 0c             	sub    $0xc,%esp
 79b:	b9 10 00 00 00       	mov    $0x10,%ecx
 7a0:	6a 00                	push   $0x0
 7a2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 7a5:	8b 45 08             	mov    0x8(%ebp),%eax
 7a8:	8b 17                	mov    (%edi),%edx
 7aa:	e8 61 fe ff ff       	call   610 <printint>
        ap++;
 7af:	89 f8                	mov    %edi,%eax
 7b1:	83 c4 10             	add    $0x10,%esp
      state = 0;
 7b4:	31 ff                	xor    %edi,%edi
        ap++;
 7b6:	83 c0 04             	add    $0x4,%eax
 7b9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 7bc:	e9 37 ff ff ff       	jmp    6f8 <printf+0x48>
 7c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 7c8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 7cb:	8b 08                	mov    (%eax),%ecx
        ap++;
 7cd:	83 c0 04             	add    $0x4,%eax
 7d0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 7d3:	85 c9                	test   %ecx,%ecx
 7d5:	0f 84 8e 00 00 00    	je     869 <printf+0x1b9>
        while(*s != 0){
 7db:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 7de:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 7e0:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 7e2:	84 c0                	test   %al,%al
 7e4:	0f 84 0e ff ff ff    	je     6f8 <printf+0x48>
 7ea:	89 75 d0             	mov    %esi,-0x30(%ebp)
 7ed:	89 de                	mov    %ebx,%esi
 7ef:	8b 5d 08             	mov    0x8(%ebp),%ebx
 7f2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 7f5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 7f8:	83 ec 04             	sub    $0x4,%esp
          s++;
 7fb:	83 c6 01             	add    $0x1,%esi
 7fe:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 801:	6a 01                	push   $0x1
 803:	57                   	push   %edi
 804:	53                   	push   %ebx
 805:	e8 28 fd ff ff       	call   532 <write>
        while(*s != 0){
 80a:	0f b6 06             	movzbl (%esi),%eax
 80d:	83 c4 10             	add    $0x10,%esp
 810:	84 c0                	test   %al,%al
 812:	75 e4                	jne    7f8 <printf+0x148>
 814:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 817:	31 ff                	xor    %edi,%edi
 819:	e9 da fe ff ff       	jmp    6f8 <printf+0x48>
 81e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 820:	83 ec 0c             	sub    $0xc,%esp
 823:	b9 0a 00 00 00       	mov    $0xa,%ecx
 828:	6a 01                	push   $0x1
 82a:	e9 73 ff ff ff       	jmp    7a2 <printf+0xf2>
 82f:	90                   	nop
  write(fd, &c, 1);
 830:	83 ec 04             	sub    $0x4,%esp
 833:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 836:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 839:	6a 01                	push   $0x1
 83b:	e9 21 ff ff ff       	jmp    761 <printf+0xb1>
        putc(fd, *ap);
 840:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 843:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 846:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 848:	6a 01                	push   $0x1
        ap++;
 84a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 84d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 850:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 853:	50                   	push   %eax
 854:	ff 75 08             	pushl  0x8(%ebp)
 857:	e8 d6 fc ff ff       	call   532 <write>
        ap++;
 85c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 85f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 862:	31 ff                	xor    %edi,%edi
 864:	e9 8f fe ff ff       	jmp    6f8 <printf+0x48>
          s = "(null)";
 869:	bb 80 0b 00 00       	mov    $0xb80,%ebx
        while(*s != 0){
 86e:	b8 28 00 00 00       	mov    $0x28,%eax
 873:	e9 72 ff ff ff       	jmp    7ea <printf+0x13a>
 878:	66 90                	xchg   %ax,%ax
 87a:	66 90                	xchg   %ax,%ax
 87c:	66 90                	xchg   %ax,%ax
 87e:	66 90                	xchg   %ax,%ax

00000880 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 880:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 881:	a1 a0 0e 00 00       	mov    0xea0,%eax
{
 886:	89 e5                	mov    %esp,%ebp
 888:	57                   	push   %edi
 889:	56                   	push   %esi
 88a:	53                   	push   %ebx
 88b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 88e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 891:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 898:	39 c8                	cmp    %ecx,%eax
 89a:	8b 10                	mov    (%eax),%edx
 89c:	73 32                	jae    8d0 <free+0x50>
 89e:	39 d1                	cmp    %edx,%ecx
 8a0:	72 04                	jb     8a6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8a2:	39 d0                	cmp    %edx,%eax
 8a4:	72 32                	jb     8d8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8a6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 8a9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 8ac:	39 fa                	cmp    %edi,%edx
 8ae:	74 30                	je     8e0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 8b0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 8b3:	8b 50 04             	mov    0x4(%eax),%edx
 8b6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8b9:	39 f1                	cmp    %esi,%ecx
 8bb:	74 3a                	je     8f7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 8bd:	89 08                	mov    %ecx,(%eax)
  freep = p;
 8bf:	a3 a0 0e 00 00       	mov    %eax,0xea0
}
 8c4:	5b                   	pop    %ebx
 8c5:	5e                   	pop    %esi
 8c6:	5f                   	pop    %edi
 8c7:	5d                   	pop    %ebp
 8c8:	c3                   	ret    
 8c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d0:	39 d0                	cmp    %edx,%eax
 8d2:	72 04                	jb     8d8 <free+0x58>
 8d4:	39 d1                	cmp    %edx,%ecx
 8d6:	72 ce                	jb     8a6 <free+0x26>
{
 8d8:	89 d0                	mov    %edx,%eax
 8da:	eb bc                	jmp    898 <free+0x18>
 8dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 8e0:	03 72 04             	add    0x4(%edx),%esi
 8e3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 8e6:	8b 10                	mov    (%eax),%edx
 8e8:	8b 12                	mov    (%edx),%edx
 8ea:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 8ed:	8b 50 04             	mov    0x4(%eax),%edx
 8f0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8f3:	39 f1                	cmp    %esi,%ecx
 8f5:	75 c6                	jne    8bd <free+0x3d>
    p->s.size += bp->s.size;
 8f7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 8fa:	a3 a0 0e 00 00       	mov    %eax,0xea0
    p->s.size += bp->s.size;
 8ff:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 902:	8b 53 f8             	mov    -0x8(%ebx),%edx
 905:	89 10                	mov    %edx,(%eax)
}
 907:	5b                   	pop    %ebx
 908:	5e                   	pop    %esi
 909:	5f                   	pop    %edi
 90a:	5d                   	pop    %ebp
 90b:	c3                   	ret    
 90c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000910 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 910:	55                   	push   %ebp
 911:	89 e5                	mov    %esp,%ebp
 913:	57                   	push   %edi
 914:	56                   	push   %esi
 915:	53                   	push   %ebx
 916:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 919:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 91c:	8b 15 a0 0e 00 00    	mov    0xea0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 922:	8d 78 07             	lea    0x7(%eax),%edi
 925:	c1 ef 03             	shr    $0x3,%edi
 928:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 92b:	85 d2                	test   %edx,%edx
 92d:	0f 84 9d 00 00 00    	je     9d0 <malloc+0xc0>
 933:	8b 02                	mov    (%edx),%eax
 935:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 938:	39 cf                	cmp    %ecx,%edi
 93a:	76 6c                	jbe    9a8 <malloc+0x98>
 93c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 942:	bb 00 10 00 00       	mov    $0x1000,%ebx
 947:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 94a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 951:	eb 0e                	jmp    961 <malloc+0x51>
 953:	90                   	nop
 954:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 958:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 95a:	8b 48 04             	mov    0x4(%eax),%ecx
 95d:	39 f9                	cmp    %edi,%ecx
 95f:	73 47                	jae    9a8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 961:	39 05 a0 0e 00 00    	cmp    %eax,0xea0
 967:	89 c2                	mov    %eax,%edx
 969:	75 ed                	jne    958 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 96b:	83 ec 0c             	sub    $0xc,%esp
 96e:	56                   	push   %esi
 96f:	e8 26 fc ff ff       	call   59a <sbrk>
  if(p == (char*)-1)
 974:	83 c4 10             	add    $0x10,%esp
 977:	83 f8 ff             	cmp    $0xffffffff,%eax
 97a:	74 1c                	je     998 <malloc+0x88>
  hp->s.size = nu;
 97c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 97f:	83 ec 0c             	sub    $0xc,%esp
 982:	83 c0 08             	add    $0x8,%eax
 985:	50                   	push   %eax
 986:	e8 f5 fe ff ff       	call   880 <free>
  return freep;
 98b:	8b 15 a0 0e 00 00    	mov    0xea0,%edx
      if((p = morecore(nunits)) == 0)
 991:	83 c4 10             	add    $0x10,%esp
 994:	85 d2                	test   %edx,%edx
 996:	75 c0                	jne    958 <malloc+0x48>
        return 0;
  }
}
 998:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 99b:	31 c0                	xor    %eax,%eax
}
 99d:	5b                   	pop    %ebx
 99e:	5e                   	pop    %esi
 99f:	5f                   	pop    %edi
 9a0:	5d                   	pop    %ebp
 9a1:	c3                   	ret    
 9a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 9a8:	39 cf                	cmp    %ecx,%edi
 9aa:	74 54                	je     a00 <malloc+0xf0>
        p->s.size -= nunits;
 9ac:	29 f9                	sub    %edi,%ecx
 9ae:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 9b1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 9b4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 9b7:	89 15 a0 0e 00 00    	mov    %edx,0xea0
}
 9bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 9c0:	83 c0 08             	add    $0x8,%eax
}
 9c3:	5b                   	pop    %ebx
 9c4:	5e                   	pop    %esi
 9c5:	5f                   	pop    %edi
 9c6:	5d                   	pop    %ebp
 9c7:	c3                   	ret    
 9c8:	90                   	nop
 9c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 9d0:	c7 05 a0 0e 00 00 a4 	movl   $0xea4,0xea0
 9d7:	0e 00 00 
 9da:	c7 05 a4 0e 00 00 a4 	movl   $0xea4,0xea4
 9e1:	0e 00 00 
    base.s.size = 0;
 9e4:	b8 a4 0e 00 00       	mov    $0xea4,%eax
 9e9:	c7 05 a8 0e 00 00 00 	movl   $0x0,0xea8
 9f0:	00 00 00 
 9f3:	e9 44 ff ff ff       	jmp    93c <malloc+0x2c>
 9f8:	90                   	nop
 9f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 a00:	8b 08                	mov    (%eax),%ecx
 a02:	89 0a                	mov    %ecx,(%edx)
 a04:	eb b1                	jmp    9b7 <malloc+0xa7>
