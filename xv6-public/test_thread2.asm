
_test_thread2:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  "stridetest",
};

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
      11:	83 ec 18             	sub    $0x18,%esp
      14:	8b 31                	mov    (%ecx),%esi
      16:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;
  int ret;
  int pid;
  int start = 5;
  int end = NTEST-1;
  if (argc >= 2)
      19:	83 fe 01             	cmp    $0x1,%esi
      1c:	0f 8f f9 00 00 00    	jg     11b <main+0x11b>
  int end = NTEST-1;
      22:	be 0d 00 00 00       	mov    $0xd,%esi
  int start = 5;
      27:	bb 05 00 00 00       	mov    $0x5,%ebx
      write(gpipe[1], (char*)&ret, sizeof(ret));
      close(gpipe[1]);
      exit();
    } else{
      close(gpipe[1]);
      if (wait() == -1 || read(gpipe[0], (char*)&ret, sizeof(ret)) == -1 || ret != 0){
      2c:	8d 7d e4             	lea    -0x1c(%ebp),%edi
      2f:	e9 a9 00 00 00       	jmp    dd <main+0xdd>
      34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ret = 0;
      38:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    if ((pid = fork()) < 0){
      3f:	e8 b6 13 00 00       	call   13fa <fork>
      44:	85 c0                	test   %eax,%eax
      46:	0f 88 1e 01 00 00    	js     16a <main+0x16a>
    if (pid == 0){
      4c:	0f 84 2b 01 00 00    	je     17d <main+0x17d>
      close(gpipe[1]);
      52:	83 ec 0c             	sub    $0xc,%esp
      55:	ff 35 4c 24 00 00    	pushl  0x244c
      5b:	e8 ca 13 00 00       	call   142a <close>
      if (wait() == -1 || read(gpipe[0], (char*)&ret, sizeof(ret)) == -1 || ret != 0){
      60:	e8 a5 13 00 00       	call   140a <wait>
      65:	83 c4 10             	add    $0x10,%esp
      68:	83 f8 ff             	cmp    $0xffffffff,%eax
      6b:	0f 84 e0 00 00 00    	je     151 <main+0x151>
      71:	83 ec 04             	sub    $0x4,%esp
      74:	6a 04                	push   $0x4
      76:	57                   	push   %edi
      77:	ff 35 48 24 00 00    	pushl  0x2448
      7d:	e8 98 13 00 00       	call   141a <read>
      82:	83 c4 10             	add    $0x10,%esp
      85:	83 f8 ff             	cmp    $0xffffffff,%eax
      88:	0f 84 c3 00 00 00    	je     151 <main+0x151>
      8e:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
      91:	85 c9                	test   %ecx,%ecx
      93:	0f 85 b8 00 00 00    	jne    151 <main+0x151>
        printf(1,"%d. %s panic\n", i, testname[i]);
        exit();
      }
      close(gpipe[0]);
      99:	83 ec 0c             	sub    $0xc,%esp
      9c:	ff 35 48 24 00 00    	pushl  0x2448
      a2:	e8 83 13 00 00       	call   142a <close>
    }
    printf(1,"%d. %s finish------------\n", i, testname[i]);
      a7:	ff 34 9d c0 23 00 00 	pushl  0x23c0(,%ebx,4)
      ae:	53                   	push   %ebx
  for (i = start; i <= end; i++){
      af:	83 c3 01             	add    $0x1,%ebx
    printf(1,"%d. %s finish------------\n", i, testname[i]);
      b2:	68 c5 1a 00 00       	push   $0x1ac5
      b7:	6a 01                	push   $0x1
      b9:	e8 e2 14 00 00       	call   15a0 <printf>
    sleep(100);
      be:	83 c4 14             	add    $0x14,%esp
      c1:	6a 64                	push   $0x64
      c3:	e8 ca 13 00 00       	call   1492 <sleep>
	printf(1, "after sleep(100)\n");
      c8:	58                   	pop    %eax
      c9:	5a                   	pop    %edx
      ca:	68 e0 1a 00 00       	push   $0x1ae0
      cf:	6a 01                	push   $0x1
      d1:	e8 ca 14 00 00       	call   15a0 <printf>
  for (i = start; i <= end; i++){
      d6:	83 c4 10             	add    $0x10,%esp
      d9:	39 f3                	cmp    %esi,%ebx
      db:	7f 6f                	jg     14c <main+0x14c>
    printf(1,"%d. %s start\n", i, testname[i]);
      dd:	ff 34 9d c0 23 00 00 	pushl  0x23c0(,%ebx,4)
      e4:	53                   	push   %ebx
      e5:	68 91 1a 00 00       	push   $0x1a91
      ea:	6a 01                	push   $0x1
      ec:	e8 af 14 00 00       	call   15a0 <printf>
    if (pipe(gpipe) < 0){
      f1:	c7 04 24 48 24 00 00 	movl   $0x2448,(%esp)
      f8:	e8 15 13 00 00       	call   1412 <pipe>
      fd:	83 c4 10             	add    $0x10,%esp
     100:	85 c0                	test   %eax,%eax
     102:	0f 89 30 ff ff ff    	jns    38 <main+0x38>
      printf(1,"pipe panic\n");
     108:	57                   	push   %edi
     109:	57                   	push   %edi
     10a:	68 9f 1a 00 00       	push   $0x1a9f
     10f:	6a 01                	push   $0x1
     111:	e8 8a 14 00 00       	call   15a0 <printf>
      exit();
     116:	e8 e7 12 00 00       	call   1402 <exit>
    start = atoi(argv[1]);
     11b:	83 ec 0c             	sub    $0xc,%esp
     11e:	ff 77 04             	pushl  0x4(%edi)
     121:	e8 6a 12 00 00       	call   1390 <atoi>
  if (argc >= 3)
     126:	83 c4 10             	add    $0x10,%esp
     129:	83 fe 02             	cmp    $0x2,%esi
    start = atoi(argv[1]);
     12c:	89 c3                	mov    %eax,%ebx
  if (argc >= 3)
     12e:	0f 84 86 00 00 00    	je     1ba <main+0x1ba>
    end = atoi(argv[2]);
     134:	83 ec 0c             	sub    $0xc,%esp
     137:	ff 77 08             	pushl  0x8(%edi)
     13a:	e8 51 12 00 00       	call   1390 <atoi>
     13f:	83 c4 10             	add    $0x10,%esp
     142:	89 c6                	mov    %eax,%esi
  for (i = start; i <= end; i++){
     144:	39 de                	cmp    %ebx,%esi
     146:	0f 8d e0 fe ff ff    	jge    2c <main+0x2c>
  }
  exit();
     14c:	e8 b1 12 00 00       	call   1402 <exit>
        printf(1,"%d. %s panic\n", i, testname[i]);
     151:	ff 34 9d c0 23 00 00 	pushl  0x23c0(,%ebx,4)
     158:	53                   	push   %ebx
     159:	68 b7 1a 00 00       	push   $0x1ab7
     15e:	6a 01                	push   $0x1
     160:	e8 3b 14 00 00       	call   15a0 <printf>
        exit();
     165:	e8 98 12 00 00       	call   1402 <exit>
      printf(1,"fork panic\n");
     16a:	56                   	push   %esi
     16b:	56                   	push   %esi
     16c:	68 ab 1a 00 00       	push   $0x1aab
     171:	6a 01                	push   $0x1
     173:	e8 28 14 00 00       	call   15a0 <printf>
      exit();
     178:	e8 85 12 00 00       	call   1402 <exit>
      close(gpipe[0]);
     17d:	83 ec 0c             	sub    $0xc,%esp
     180:	ff 35 48 24 00 00    	pushl  0x2448
     186:	e8 9f 12 00 00       	call   142a <close>
      ret = testfunc[i]();
     18b:	ff 14 9d 00 24 00 00 	call   *0x2400(,%ebx,4)
     192:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      write(gpipe[1], (char*)&ret, sizeof(ret));
     195:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     198:	83 c4 0c             	add    $0xc,%esp
     19b:	6a 04                	push   $0x4
     19d:	50                   	push   %eax
     19e:	ff 35 4c 24 00 00    	pushl  0x244c
     1a4:	e8 79 12 00 00       	call   1422 <write>
      close(gpipe[1]);
     1a9:	5b                   	pop    %ebx
     1aa:	ff 35 4c 24 00 00    	pushl  0x244c
     1b0:	e8 75 12 00 00       	call   142a <close>
      exit();
     1b5:	e8 48 12 00 00       	call   1402 <exit>
  int end = NTEST-1;
     1ba:	be 0d 00 00 00       	mov    $0xd,%esi
     1bf:	eb 83                	jmp    144 <main+0x144>
     1c1:	66 90                	xchg   %ax,%ax
     1c3:	66 90                	xchg   %ax,%ax
     1c5:	66 90                	xchg   %ax,%ax
     1c7:	66 90                	xchg   %ax,%ax
     1c9:	66 90                	xchg   %ax,%ax
     1cb:	66 90                	xchg   %ax,%ax
     1cd:	66 90                	xchg   %ax,%ax
     1cf:	90                   	nop

000001d0 <nop>:
}

// ============================================================================
void nop(){ }
     1d0:	55                   	push   %ebp
     1d1:	89 e5                	mov    %esp,%ebp
     1d3:	5d                   	pop    %ebp
     1d4:	c3                   	ret    
     1d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001e0 <racingthreadmain>:

void*
racingthreadmain(void *arg)
{
     1e0:	55                   	push   %ebp
  int tid = (int) arg;
     1e1:	ba 80 96 98 00       	mov    $0x989680,%edx
{
     1e6:	89 e5                	mov    %esp,%ebp
     1e8:	83 ec 08             	sub    $0x8,%esp
     1eb:	90                   	nop
     1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int i;
  int tmp;
  for (i = 0; i < 10000000; i++){
    tmp = gcnt;
     1f0:	a1 44 24 00 00       	mov    0x2444,%eax
    tmp++;
     1f5:	83 c0 01             	add    $0x1,%eax
	asm volatile("call %P0"::"i"(nop));
     1f8:	e8 d3 ff ff ff       	call   1d0 <nop>
  for (i = 0; i < 10000000; i++){
     1fd:	83 ea 01             	sub    $0x1,%edx
    gcnt = tmp;
     200:	a3 44 24 00 00       	mov    %eax,0x2444
  for (i = 0; i < 10000000; i++){
     205:	75 e9                	jne    1f0 <racingthreadmain+0x10>
  }
  thread_exit((void *)(tid+1));
     207:	8b 45 08             	mov    0x8(%ebp),%eax
     20a:	83 ec 0c             	sub    $0xc,%esp
     20d:	83 c0 01             	add    $0x1,%eax
     210:	50                   	push   %eax
     211:	e8 ac 12 00 00       	call   14c2 <thread_exit>

  return 0;
}
     216:	31 c0                	xor    %eax,%eax
     218:	c9                   	leave  
     219:	c3                   	ret    
     21a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000220 <basicthreadmain>:
}

// ============================================================================
void*
basicthreadmain(void *arg)
{
     220:	55                   	push   %ebp
     221:	89 e5                	mov    %esp,%ebp
     223:	57                   	push   %edi
     224:	56                   	push   %esi
     225:	53                   	push   %ebx
  int tid = (int) arg;
  int i;
  for (i = 0; i < 100000000; i++){
    if (i % 20000000 == 0){
     226:	bf 6b ca 5f 6b       	mov    $0x6b5fca6b,%edi
  for (i = 0; i < 100000000; i++){
     22b:	31 db                	xor    %ebx,%ebx
{
     22d:	83 ec 0c             	sub    $0xc,%esp
     230:	8b 75 08             	mov    0x8(%ebp),%esi
     233:	eb 0e                	jmp    243 <basicthreadmain+0x23>
     235:	8d 76 00             	lea    0x0(%esi),%esi
  for (i = 0; i < 100000000; i++){
     238:	83 c3 01             	add    $0x1,%ebx
     23b:	81 fb 00 e1 f5 05    	cmp    $0x5f5e100,%ebx
     241:	74 2f                	je     272 <basicthreadmain+0x52>
    if (i % 20000000 == 0){
     243:	89 d8                	mov    %ebx,%eax
     245:	f7 e7                	mul    %edi
     247:	c1 ea 17             	shr    $0x17,%edx
     24a:	69 d2 00 2d 31 01    	imul   $0x1312d00,%edx,%edx
     250:	39 d3                	cmp    %edx,%ebx
     252:	75 e4                	jne    238 <basicthreadmain+0x18>
      printf(1, "%d", tid);
     254:	83 ec 04             	sub    $0x4,%esp
  for (i = 0; i < 100000000; i++){
     257:	83 c3 01             	add    $0x1,%ebx
      printf(1, "%d", tid);
     25a:	56                   	push   %esi
     25b:	68 f8 18 00 00       	push   $0x18f8
     260:	6a 01                	push   $0x1
     262:	e8 39 13 00 00       	call   15a0 <printf>
     267:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < 100000000; i++){
     26a:	81 fb 00 e1 f5 05    	cmp    $0x5f5e100,%ebx
     270:	75 d1                	jne    243 <basicthreadmain+0x23>
    }
  }
  thread_exit((void *)(tid+1));
     272:	83 ec 0c             	sub    $0xc,%esp
     275:	83 c6 01             	add    $0x1,%esi
     278:	56                   	push   %esi
     279:	e8 44 12 00 00       	call   14c2 <thread_exit>

  return 0;
}
     27e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     281:	31 c0                	xor    %eax,%eax
     283:	5b                   	pop    %ebx
     284:	5e                   	pop    %esi
     285:	5f                   	pop    %edi
     286:	5d                   	pop    %ebp
     287:	c3                   	ret    
     288:	90                   	nop
     289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000290 <jointhreadmain>:

// ============================================================================

void*
jointhreadmain(void *arg)
{
     290:	55                   	push   %ebp
     291:	89 e5                	mov    %esp,%ebp
     293:	83 ec 14             	sub    $0x14,%esp
  int val = (int)arg;
  sleep(200);
     296:	68 c8 00 00 00       	push   $0xc8
     29b:	e8 f2 11 00 00       	call   1492 <sleep>
  printf(1, "thread_exit...\n");
     2a0:	58                   	pop    %eax
     2a1:	5a                   	pop    %edx
     2a2:	68 fb 18 00 00       	push   $0x18fb
     2a7:	6a 01                	push   $0x1
     2a9:	e8 f2 12 00 00       	call   15a0 <printf>
  thread_exit((void *)(val*2));
     2ae:	8b 45 08             	mov    0x8(%ebp),%eax
     2b1:	01 c0                	add    %eax,%eax
     2b3:	89 04 24             	mov    %eax,(%esp)
     2b6:	e8 07 12 00 00       	call   14c2 <thread_exit>

  return 0;
}
     2bb:	31 c0                	xor    %eax,%eax
     2bd:	c9                   	leave  
     2be:	c3                   	ret    
     2bf:	90                   	nop

000002c0 <stressthreadmain>:

// ============================================================================

void*
stressthreadmain(void *arg)
{
     2c0:	55                   	push   %ebp
     2c1:	89 e5                	mov    %esp,%ebp
     2c3:	83 ec 14             	sub    $0x14,%esp
  thread_exit(0);
     2c6:	6a 00                	push   $0x0
     2c8:	e8 f5 11 00 00       	call   14c2 <thread_exit>

  return 0;
}
     2cd:	31 c0                	xor    %eax,%eax
     2cf:	c9                   	leave  
     2d0:	c3                   	ret    
     2d1:	eb 0d                	jmp    2e0 <sleepthreadmain>
     2d3:	90                   	nop
     2d4:	90                   	nop
     2d5:	90                   	nop
     2d6:	90                   	nop
     2d7:	90                   	nop
     2d8:	90                   	nop
     2d9:	90                   	nop
     2da:	90                   	nop
     2db:	90                   	nop
     2dc:	90                   	nop
     2dd:	90                   	nop
     2de:	90                   	nop
     2df:	90                   	nop

000002e0 <sleepthreadmain>:

// ============================================================================

void*
sleepthreadmain(void *arg)
{
     2e0:	55                   	push   %ebp
     2e1:	89 e5                	mov    %esp,%ebp
     2e3:	83 ec 14             	sub    $0x14,%esp
  sleep(1000000);
     2e6:	68 40 42 0f 00       	push   $0xf4240
     2eb:	e8 a2 11 00 00       	call   1492 <sleep>
  thread_exit(0);
     2f0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     2f7:	e8 c6 11 00 00       	call   14c2 <thread_exit>

  return 0;
}
     2fc:	31 c0                	xor    %eax,%eax
     2fe:	c9                   	leave  
     2ff:	c3                   	ret    

00000300 <exittest2>:
{
     300:	55                   	push   %ebp
     301:	89 e5                	mov    %esp,%ebp
     303:	56                   	push   %esi
     304:	53                   	push   %ebx
     305:	8d 75 f8             	lea    -0x8(%ebp),%esi
     308:	8d 5d d0             	lea    -0x30(%ebp),%ebx
     30b:	83 ec 30             	sub    $0x30,%esp
	  printf(1, " asdfasdf\n");
     30e:	83 ec 08             	sub    $0x8,%esp
     311:	68 0b 19 00 00       	push   $0x190b
     316:	6a 01                	push   $0x1
     318:	e8 83 12 00 00       	call   15a0 <printf>
    if (thread_create(&threads[i], exitthreadmain, (void*)2) != 0){
     31d:	83 c4 0c             	add    $0xc,%esp
     320:	6a 02                	push   $0x2
     322:	68 30 09 00 00       	push   $0x930
     327:	53                   	push   %ebx
     328:	e8 8d 11 00 00       	call   14ba <thread_create>
     32d:	83 c4 10             	add    $0x10,%esp
     330:	85 c0                	test   %eax,%eax
     332:	75 0c                	jne    340 <exittest2+0x40>
     334:	83 c3 04             	add    $0x4,%ebx
  for (i = 0; i < NUM_THREAD; i++){
     337:	39 f3                	cmp    %esi,%ebx
     339:	75 d3                	jne    30e <exittest2+0xe>
     33b:	eb fe                	jmp    33b <exittest2+0x3b>
     33d:	8d 76 00             	lea    0x0(%esi),%esi
      printf(1, "panic at thread_create\n");
     340:	83 ec 08             	sub    $0x8,%esp
     343:	68 16 19 00 00       	push   $0x1916
     348:	6a 01                	push   $0x1
     34a:	e8 51 12 00 00       	call   15a0 <printf>
}
     34f:	8d 65 f8             	lea    -0x8(%ebp),%esp
     352:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     357:	5b                   	pop    %ebx
     358:	5e                   	pop    %esi
     359:	5d                   	pop    %ebp
     35a:	c3                   	ret    
     35b:	90                   	nop
     35c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000360 <jointest2>:
{
     360:	55                   	push   %ebp
     361:	89 e5                	mov    %esp,%ebp
     363:	56                   	push   %esi
     364:	53                   	push   %ebx
     365:	8d 75 cc             	lea    -0x34(%ebp),%esi
  for (i = 1; i <= NUM_THREAD; i++){
     368:	bb 01 00 00 00       	mov    $0x1,%ebx
{
     36d:	83 ec 40             	sub    $0x40,%esp
    if (thread_create(&threads[i-1], jointhreadmain, (void*)(i)) != 0){
     370:	8d 04 9e             	lea    (%esi,%ebx,4),%eax
     373:	83 ec 04             	sub    $0x4,%esp
     376:	53                   	push   %ebx
     377:	68 90 02 00 00       	push   $0x290
     37c:	50                   	push   %eax
     37d:	e8 38 11 00 00       	call   14ba <thread_create>
     382:	83 c4 10             	add    $0x10,%esp
     385:	85 c0                	test   %eax,%eax
     387:	75 77                	jne    400 <jointest2+0xa0>
  for (i = 1; i <= NUM_THREAD; i++){
     389:	83 c3 01             	add    $0x1,%ebx
     38c:	83 fb 0b             	cmp    $0xb,%ebx
     38f:	75 df                	jne    370 <jointest2+0x10>
  sleep(500);
     391:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "thread_join!!!\n");
     394:	bb 02 00 00 00       	mov    $0x2,%ebx
  sleep(500);
     399:	68 f4 01 00 00       	push   $0x1f4
     39e:	e8 ef 10 00 00       	call   1492 <sleep>
  printf(1, "thread_join!!!\n");
     3a3:	58                   	pop    %eax
     3a4:	5a                   	pop    %edx
     3a5:	68 2e 19 00 00       	push   $0x192e
     3aa:	6a 01                	push   $0x1
     3ac:	e8 ef 11 00 00       	call   15a0 <printf>
     3b1:	83 c4 10             	add    $0x10,%esp
     3b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (thread_join(threads[i-1], &retval) != 0 || (int)retval != i * 2 ){
     3b8:	83 ec 08             	sub    $0x8,%esp
     3bb:	56                   	push   %esi
     3bc:	ff 74 5d cc          	pushl  -0x34(%ebp,%ebx,2)
     3c0:	e8 05 11 00 00       	call   14ca <thread_join>
     3c5:	83 c4 10             	add    $0x10,%esp
     3c8:	85 c0                	test   %eax,%eax
     3ca:	75 54                	jne    420 <jointest2+0xc0>
     3cc:	39 5d cc             	cmp    %ebx,-0x34(%ebp)
     3cf:	75 4f                	jne    420 <jointest2+0xc0>
     3d1:	83 c3 02             	add    $0x2,%ebx
  for (i = 1; i <= NUM_THREAD; i++){
     3d4:	83 fb 16             	cmp    $0x16,%ebx
     3d7:	75 df                	jne    3b8 <jointest2+0x58>
  printf(1,"\n");
     3d9:	83 ec 08             	sub    $0x8,%esp
     3dc:	89 45 c4             	mov    %eax,-0x3c(%ebp)
     3df:	68 3c 19 00 00       	push   $0x193c
     3e4:	6a 01                	push   $0x1
     3e6:	e8 b5 11 00 00       	call   15a0 <printf>
  return 0;
     3eb:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     3ee:	83 c4 10             	add    $0x10,%esp
}
     3f1:	8d 65 f8             	lea    -0x8(%ebp),%esp
     3f4:	5b                   	pop    %ebx
     3f5:	5e                   	pop    %esi
     3f6:	5d                   	pop    %ebp
     3f7:	c3                   	ret    
     3f8:	90                   	nop
     3f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "panic at thread_create\n");
     400:	83 ec 08             	sub    $0x8,%esp
     403:	68 16 19 00 00       	push   $0x1916
     408:	6a 01                	push   $0x1
     40a:	e8 91 11 00 00       	call   15a0 <printf>
      return -1;
     40f:	83 c4 10             	add    $0x10,%esp
}
     412:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return -1;
     415:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     41a:	5b                   	pop    %ebx
     41b:	5e                   	pop    %esi
     41c:	5d                   	pop    %ebp
     41d:	c3                   	ret    
     41e:	66 90                	xchg   %ax,%ax
      printf(1, "panic at thread_join\n");
     420:	83 ec 08             	sub    $0x8,%esp
     423:	68 3e 19 00 00       	push   $0x193e
     428:	6a 01                	push   $0x1
     42a:	e8 71 11 00 00       	call   15a0 <printf>
      return -1;
     42f:	83 c4 10             	add    $0x10,%esp
}
     432:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return -1;
     435:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     43a:	5b                   	pop    %ebx
     43b:	5e                   	pop    %esi
     43c:	5d                   	pop    %ebp
     43d:	c3                   	ret    
     43e:	66 90                	xchg   %ax,%ax

00000440 <pipetest>:
{
     440:	55                   	push   %ebp
     441:	89 e5                	mov    %esp,%ebp
     443:	57                   	push   %edi
     444:	56                   	push   %esi
     445:	53                   	push   %ebx
  if (pipe(fd) < 0){
     446:	8d 45 ac             	lea    -0x54(%ebp),%eax
{
     449:	83 ec 68             	sub    $0x68,%esp
  if (pipe(fd) < 0){
     44c:	50                   	push   %eax
     44d:	e8 c0 0f 00 00       	call   1412 <pipe>
     452:	83 c4 10             	add    $0x10,%esp
     455:	85 c0                	test   %eax,%eax
     457:	0f 88 94 01 00 00    	js     5f1 <pipetest+0x1b1>
  arg[1] = fd[0];
     45d:	8b 45 ac             	mov    -0x54(%ebp),%eax
     460:	89 45 b8             	mov    %eax,-0x48(%ebp)
  arg[2] = fd[1];
     463:	8b 45 b0             	mov    -0x50(%ebp),%eax
     466:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if ((pid = fork()) < 0){
     469:	e8 8c 0f 00 00       	call   13fa <fork>
     46e:	85 c0                	test   %eax,%eax
     470:	0f 88 94 01 00 00    	js     60a <pipetest+0x1ca>
  } else if (pid == 0){
     476:	75 78                	jne    4f0 <pipetest+0xb0>
    close(fd[0]);
     478:	83 ec 0c             	sub    $0xc,%esp
     47b:	8d 5d c0             	lea    -0x40(%ebp),%ebx
     47e:	ff 75 ac             	pushl  -0x54(%ebp)
     481:	8d 75 b4             	lea    -0x4c(%ebp),%esi
     484:	e8 a1 0f 00 00       	call   142a <close>
    arg[0] = 0;
     489:	89 df                	mov    %ebx,%edi
     48b:	c7 45 b4 00 00 00 00 	movl   $0x0,-0x4c(%ebp)
     492:	83 c4 10             	add    $0x10,%esp
     495:	8d 76 00             	lea    0x0(%esi),%esi
      if (thread_create(&threads[i], pipethreadmain, (void*)arg) != 0){
     498:	83 ec 04             	sub    $0x4,%esp
     49b:	56                   	push   %esi
     49c:	68 b0 06 00 00       	push   $0x6b0
     4a1:	57                   	push   %edi
     4a2:	e8 13 10 00 00       	call   14ba <thread_create>
     4a7:	83 c4 10             	add    $0x10,%esp
     4aa:	85 c0                	test   %eax,%eax
     4ac:	0f 85 f6 00 00 00    	jne    5a8 <pipetest+0x168>
    for (i = 0; i < NUM_THREAD; i++){
     4b2:	8d 45 e8             	lea    -0x18(%ebp),%eax
     4b5:	83 c7 04             	add    $0x4,%edi
     4b8:	39 c7                	cmp    %eax,%edi
     4ba:	75 dc                	jne    498 <pipetest+0x58>
     4bc:	8d 75 a8             	lea    -0x58(%ebp),%esi
     4bf:	90                   	nop
      if (thread_join(threads[i], &retval) != 0){
     4c0:	83 ec 08             	sub    $0x8,%esp
     4c3:	56                   	push   %esi
     4c4:	ff 33                	pushl  (%ebx)
     4c6:	e8 ff 0f 00 00       	call   14ca <thread_join>
     4cb:	83 c4 10             	add    $0x10,%esp
     4ce:	85 c0                	test   %eax,%eax
     4d0:	0f 85 fa 00 00 00    	jne    5d0 <pipetest+0x190>
     4d6:	83 c3 04             	add    $0x4,%ebx
    for (i = 0; i < NUM_THREAD; i++){
     4d9:	39 df                	cmp    %ebx,%edi
     4db:	75 e3                	jne    4c0 <pipetest+0x80>
    close(fd[1]);
     4dd:	83 ec 0c             	sub    $0xc,%esp
     4e0:	ff 75 b0             	pushl  -0x50(%ebp)
     4e3:	e8 42 0f 00 00       	call   142a <close>
    exit();
     4e8:	e8 15 0f 00 00       	call   1402 <exit>
     4ed:	8d 76 00             	lea    0x0(%esi),%esi
    close(fd[1]);
     4f0:	83 ec 0c             	sub    $0xc,%esp
     4f3:	ff 75 b0             	pushl  -0x50(%ebp)
     4f6:	8d 7d e8             	lea    -0x18(%ebp),%edi
     4f9:	8d 75 b4             	lea    -0x4c(%ebp),%esi
     4fc:	e8 29 0f 00 00       	call   142a <close>
     501:	8d 45 c0             	lea    -0x40(%ebp),%eax
    arg[0] = 1;
     504:	c7 45 b4 01 00 00 00 	movl   $0x1,-0x4c(%ebp)
    gcnt = 0;
     50b:	c7 05 44 24 00 00 00 	movl   $0x0,0x2444
     512:	00 00 00 
     515:	83 c4 10             	add    $0x10,%esp
     518:	89 45 a4             	mov    %eax,-0x5c(%ebp)
     51b:	89 c3                	mov    %eax,%ebx
     51d:	8d 76 00             	lea    0x0(%esi),%esi
      if (thread_create(&threads[i], pipethreadmain, (void*)arg) != 0){
     520:	83 ec 04             	sub    $0x4,%esp
     523:	56                   	push   %esi
     524:	68 b0 06 00 00       	push   $0x6b0
     529:	53                   	push   %ebx
     52a:	e8 8b 0f 00 00       	call   14ba <thread_create>
     52f:	83 c4 10             	add    $0x10,%esp
     532:	85 c0                	test   %eax,%eax
     534:	75 72                	jne    5a8 <pipetest+0x168>
     536:	83 c3 04             	add    $0x4,%ebx
    for (i = 0; i < NUM_THREAD; i++){
     539:	39 fb                	cmp    %edi,%ebx
     53b:	75 e3                	jne    520 <pipetest+0xe0>
     53d:	8d 75 a8             	lea    -0x58(%ebp),%esi
      if (thread_join(threads[i], &retval) != 0){
     540:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     543:	83 ec 08             	sub    $0x8,%esp
     546:	56                   	push   %esi
     547:	ff 30                	pushl  (%eax)
     549:	e8 7c 0f 00 00       	call   14ca <thread_join>
     54e:	83 c4 10             	add    $0x10,%esp
     551:	85 c0                	test   %eax,%eax
     553:	89 c7                	mov    %eax,%edi
     555:	75 79                	jne    5d0 <pipetest+0x190>
     557:	83 45 a4 04          	addl   $0x4,-0x5c(%ebp)
     55b:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    for (i = 0; i < NUM_THREAD; i++){
     55e:	39 d8                	cmp    %ebx,%eax
     560:	75 de                	jne    540 <pipetest+0x100>
    close(fd[0]);
     562:	83 ec 0c             	sub    $0xc,%esp
     565:	ff 75 ac             	pushl  -0x54(%ebp)
     568:	e8 bd 0e 00 00       	call   142a <close>
  if (wait() == -1){
     56d:	e8 98 0e 00 00       	call   140a <wait>
     572:	83 c4 10             	add    $0x10,%esp
     575:	83 f8 ff             	cmp    $0xffffffff,%eax
     578:	0f 84 a5 00 00 00    	je     623 <pipetest+0x1e3>
  if (gcnt != 0)
     57e:	a1 44 24 00 00       	mov    0x2444,%eax
     583:	85 c0                	test   %eax,%eax
     585:	74 38                	je     5bf <pipetest+0x17f>
    printf(1,"panic at validation in pipetest : %d\n", gcnt);
     587:	a1 44 24 00 00       	mov    0x2444,%eax
     58c:	83 ec 04             	sub    $0x4,%esp
     58f:	50                   	push   %eax
     590:	68 7c 1b 00 00       	push   $0x1b7c
     595:	6a 01                	push   $0x1
     597:	e8 04 10 00 00       	call   15a0 <printf>
     59c:	83 c4 10             	add    $0x10,%esp
     59f:	eb 1e                	jmp    5bf <pipetest+0x17f>
     5a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "panic at thread_create\n");
     5a8:	83 ec 08             	sub    $0x8,%esp
        return -1;
     5ab:	bf ff ff ff ff       	mov    $0xffffffff,%edi
        printf(1, "panic at thread_create\n");
     5b0:	68 16 19 00 00       	push   $0x1916
     5b5:	6a 01                	push   $0x1
     5b7:	e8 e4 0f 00 00       	call   15a0 <printf>
        return -1;
     5bc:	83 c4 10             	add    $0x10,%esp
}
     5bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
     5c2:	89 f8                	mov    %edi,%eax
     5c4:	5b                   	pop    %ebx
     5c5:	5e                   	pop    %esi
     5c6:	5f                   	pop    %edi
     5c7:	5d                   	pop    %ebp
     5c8:	c3                   	ret    
     5c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "panic at thread_join\n");
     5d0:	83 ec 08             	sub    $0x8,%esp
        return -1;
     5d3:	bf ff ff ff ff       	mov    $0xffffffff,%edi
        printf(1, "panic at thread_join\n");
     5d8:	68 3e 19 00 00       	push   $0x193e
     5dd:	6a 01                	push   $0x1
     5df:	e8 bc 0f 00 00       	call   15a0 <printf>
        return -1;
     5e4:	83 c4 10             	add    $0x10,%esp
}
     5e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
     5ea:	89 f8                	mov    %edi,%eax
     5ec:	5b                   	pop    %ebx
     5ed:	5e                   	pop    %esi
     5ee:	5f                   	pop    %edi
     5ef:	5d                   	pop    %ebp
     5f0:	c3                   	ret    
    printf(1, "panic at pipe in pipetest\n");
     5f1:	83 ec 08             	sub    $0x8,%esp
    return -1;
     5f4:	bf ff ff ff ff       	mov    $0xffffffff,%edi
    printf(1, "panic at pipe in pipetest\n");
     5f9:	68 54 19 00 00       	push   $0x1954
     5fe:	6a 01                	push   $0x1
     600:	e8 9b 0f 00 00       	call   15a0 <printf>
    return -1;
     605:	83 c4 10             	add    $0x10,%esp
     608:	eb b5                	jmp    5bf <pipetest+0x17f>
      printf(1, "panic at fork in pipetest\n");
     60a:	83 ec 08             	sub    $0x8,%esp
      return -1;
     60d:	bf ff ff ff ff       	mov    $0xffffffff,%edi
      printf(1, "panic at fork in pipetest\n");
     612:	68 6f 19 00 00       	push   $0x196f
     617:	6a 01                	push   $0x1
     619:	e8 82 0f 00 00       	call   15a0 <printf>
      return -1;
     61e:	83 c4 10             	add    $0x10,%esp
     621:	eb 9c                	jmp    5bf <pipetest+0x17f>
    printf(1, "panic at wait in pipetest\n");
     623:	50                   	push   %eax
     624:	50                   	push   %eax
    return -1;
     625:	83 cf ff             	or     $0xffffffff,%edi
    printf(1, "panic at wait in pipetest\n");
     628:	68 8a 19 00 00       	push   $0x198a
     62d:	6a 01                	push   $0x1
     62f:	e8 6c 0f 00 00       	call   15a0 <printf>
    return -1;
     634:	83 c4 10             	add    $0x10,%esp
     637:	eb 86                	jmp    5bf <pipetest+0x17f>
     639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000640 <execthreadmain>:
{
     640:	55                   	push   %ebp
     641:	89 e5                	mov    %esp,%ebp
     643:	83 ec 24             	sub    $0x24,%esp
  sleep(1);
     646:	6a 01                	push   $0x1
  char *args[3] = {"echo", "echo is executed!", 0}; 
     648:	c7 45 ec a5 19 00 00 	movl   $0x19a5,-0x14(%ebp)
     64f:	c7 45 f0 aa 19 00 00 	movl   $0x19aa,-0x10(%ebp)
     656:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  sleep(1);
     65d:	e8 30 0e 00 00       	call   1492 <sleep>
  exec("echo", args);
     662:	58                   	pop    %eax
     663:	8d 45 ec             	lea    -0x14(%ebp),%eax
     666:	5a                   	pop    %edx
     667:	50                   	push   %eax
     668:	68 a5 19 00 00       	push   $0x19a5
     66d:	e8 c8 0d 00 00       	call   143a <exec>
  printf(1, "panic at execthreadmain\n");
     672:	59                   	pop    %ecx
     673:	58                   	pop    %eax
     674:	68 bc 19 00 00       	push   $0x19bc
     679:	6a 01                	push   $0x1
     67b:	e8 20 0f 00 00       	call   15a0 <printf>
  exit();
     680:	e8 7d 0d 00 00       	call   1402 <exit>
     685:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000690 <killthreadmain>:
{
     690:	55                   	push   %ebp
     691:	89 e5                	mov    %esp,%ebp
     693:	83 ec 08             	sub    $0x8,%esp
  kill(getpid());
     696:	e8 e7 0d 00 00       	call   1482 <getpid>
     69b:	83 ec 0c             	sub    $0xc,%esp
     69e:	50                   	push   %eax
     69f:	e8 8e 0d 00 00       	call   1432 <kill>
     6a4:	83 c4 10             	add    $0x10,%esp
     6a7:	eb fe                	jmp    6a7 <killthreadmain+0x17>
     6a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006b0 <pipethreadmain>:
{
     6b0:	55                   	push   %ebp
     6b1:	89 e5                	mov    %esp,%ebp
     6b3:	57                   	push   %edi
     6b4:	56                   	push   %esi
     6b5:	53                   	push   %ebx
      write(fd[1], &i, sizeof(int));
     6b6:	8d 7d e0             	lea    -0x20(%ebp),%edi
{
     6b9:	83 ec 1c             	sub    $0x1c,%esp
     6bc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for (i = -5; i <= 5; i++){
     6bf:	c7 45 e0 fb ff ff ff 	movl   $0xfffffffb,-0x20(%ebp)
  int type = ((int*)arg)[0];
     6c6:	8b 33                	mov    (%ebx),%esi
     6c8:	eb 32                	jmp    6fc <pipethreadmain+0x4c>
     6ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      read(fd[0], &input, sizeof(int));
     6d0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     6d3:	83 ec 04             	sub    $0x4,%esp
     6d6:	6a 04                	push   $0x4
     6d8:	50                   	push   %eax
     6d9:	ff 73 04             	pushl  0x4(%ebx)
     6dc:	e8 39 0d 00 00       	call   141a <read>
      __sync_fetch_and_add(&gcnt, input);
     6e1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     6e4:	f0 01 05 44 24 00 00 	lock add %eax,0x2444
  for (i = -5; i <= 5; i++){
     6eb:	8b 45 e0             	mov    -0x20(%ebp),%eax
     6ee:	83 c4 10             	add    $0x10,%esp
     6f1:	83 c0 01             	add    $0x1,%eax
     6f4:	83 f8 05             	cmp    $0x5,%eax
     6f7:	89 45 e0             	mov    %eax,-0x20(%ebp)
     6fa:	7f 23                	jg     71f <pipethreadmain+0x6f>
    if (type){
     6fc:	85 f6                	test   %esi,%esi
     6fe:	75 d0                	jne    6d0 <pipethreadmain+0x20>
      write(fd[1], &i, sizeof(int));
     700:	83 ec 04             	sub    $0x4,%esp
     703:	6a 04                	push   $0x4
     705:	57                   	push   %edi
     706:	ff 73 08             	pushl  0x8(%ebx)
     709:	e8 14 0d 00 00       	call   1422 <write>
  for (i = -5; i <= 5; i++){
     70e:	8b 45 e0             	mov    -0x20(%ebp),%eax
      write(fd[1], &i, sizeof(int));
     711:	83 c4 10             	add    $0x10,%esp
  for (i = -5; i <= 5; i++){
     714:	83 c0 01             	add    $0x1,%eax
     717:	83 f8 05             	cmp    $0x5,%eax
     71a:	89 45 e0             	mov    %eax,-0x20(%ebp)
     71d:	7e dd                	jle    6fc <pipethreadmain+0x4c>
  thread_exit(0);
     71f:	83 ec 0c             	sub    $0xc,%esp
     722:	6a 00                	push   $0x0
     724:	e8 99 0d 00 00       	call   14c2 <thread_exit>
}
     729:	8d 65 f4             	lea    -0xc(%ebp),%esp
     72c:	31 c0                	xor    %eax,%eax
     72e:	5b                   	pop    %ebx
     72f:	5e                   	pop    %esi
     730:	5f                   	pop    %edi
     731:	5d                   	pop    %ebp
     732:	c3                   	ret    
     733:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000740 <stridethreadmain>:

// ============================================================================

void*
stridethreadmain(void *arg)
{
     740:	55                   	push   %ebp
     741:	89 e5                	mov    %esp,%ebp
     743:	83 ec 08             	sub    $0x8,%esp
     746:	8b 55 08             	mov    0x8(%ebp),%edx
     749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  volatile int *flag = (int*)arg;
  int t;
  while(*flag){
     750:	8b 02                	mov    (%edx),%eax
     752:	85 c0                	test   %eax,%eax
     754:	74 22                	je     778 <stridethreadmain+0x38>
     756:	8d 76 00             	lea    0x0(%esi),%esi
     759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    while(*flag == 1){
     760:	8b 02                	mov    (%edx),%eax
     762:	83 f8 01             	cmp    $0x1,%eax
     765:	75 e9                	jne    750 <stridethreadmain+0x10>
      for (t = 0; t < 5; t++);
      __sync_fetch_and_add(&gcnt, 1);
     767:	f0 83 05 44 24 00 00 	lock addl $0x1,0x2444
     76e:	01 
     76f:	eb ef                	jmp    760 <stridethreadmain+0x20>
     771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
  }
  thread_exit(0);
     778:	83 ec 0c             	sub    $0xc,%esp
     77b:	6a 00                	push   $0x0
     77d:	e8 40 0d 00 00       	call   14c2 <thread_exit>

  return 0;
}
     782:	31 c0                	xor    %eax,%eax
     784:	c9                   	leave  
     785:	c3                   	ret    
     786:	8d 76 00             	lea    0x0(%esi),%esi
     789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000790 <stridetest>:

int
stridetest(void)
{
     790:	55                   	push   %ebp
     791:	89 e5                	mov    %esp,%ebp
     793:	57                   	push   %edi
     794:	56                   	push   %esi
     795:	53                   	push   %ebx
     796:	83 ec 4c             	sub    $0x4c,%esp
  int i;
  int pid;
  int flag;
  void *retval;

  gcnt = 0;
     799:	c7 05 44 24 00 00 00 	movl   $0x0,0x2444
     7a0:	00 00 00 
  flag = 2;
     7a3:	c7 45 b8 02 00 00 00 	movl   $0x2,-0x48(%ebp)
  if ((pid = fork()) == -1){
     7aa:	e8 4b 0c 00 00       	call   13fa <fork>
     7af:	83 f8 ff             	cmp    $0xffffffff,%eax
     7b2:	89 45 b4             	mov    %eax,-0x4c(%ebp)
     7b5:	0f 84 2e 01 00 00    	je     8e9 <stridetest+0x159>
    printf(1, "panic at fork in forktest\n");
    exit();
  } else if (pid == 0){
     7bb:	8b 5d b4             	mov    -0x4c(%ebp),%ebx
     7be:	85 db                	test   %ebx,%ebx
     7c0:	0f 85 c2 00 00 00    	jne    888 <stridetest+0xf8>
    set_cpu_share(2);
     7c6:	83 ec 0c             	sub    $0xc,%esp
     7c9:	6a 02                	push   $0x2
     7cb:	e8 e2 0c 00 00       	call   14b2 <set_cpu_share>
     7d0:	83 c4 10             	add    $0x10,%esp
     7d3:	8d 5d c0             	lea    -0x40(%ebp),%ebx
     7d6:	8d 7d b8             	lea    -0x48(%ebp),%edi
{
     7d9:	89 de                	mov    %ebx,%esi
     7db:	90                   	nop
     7dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  } else{
    set_cpu_share(10);
  }

  for (i = 0; i < NUM_THREAD; i++){
    if (thread_create(&threads[i], stridethreadmain, (void*)&flag) != 0){
     7e0:	83 ec 04             	sub    $0x4,%esp
     7e3:	57                   	push   %edi
     7e4:	68 40 07 00 00       	push   $0x740
     7e9:	56                   	push   %esi
     7ea:	e8 cb 0c 00 00       	call   14ba <thread_create>
     7ef:	83 c4 10             	add    $0x10,%esp
     7f2:	85 c0                	test   %eax,%eax
     7f4:	0f 85 a6 00 00 00    	jne    8a0 <stridetest+0x110>
  for (i = 0; i < NUM_THREAD; i++){
     7fa:	8d 45 e8             	lea    -0x18(%ebp),%eax
     7fd:	83 c6 04             	add    $0x4,%esi
     800:	39 c6                	cmp    %eax,%esi
     802:	75 dc                	jne    7e0 <stridetest+0x50>
      printf(1, "panic at thread_create\n");
      return -1;
    }
  }
  flag = 1;
  sleep(500);
     804:	83 ec 0c             	sub    $0xc,%esp
  flag = 1;
     807:	c7 45 b8 01 00 00 00 	movl   $0x1,-0x48(%ebp)
  sleep(500);
     80e:	68 f4 01 00 00       	push   $0x1f4
     813:	e8 7a 0c 00 00       	call   1492 <sleep>
  flag = 0;
     818:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
     81f:	83 c4 10             	add    $0x10,%esp
     822:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for (i = 0; i < NUM_THREAD; i++){
    if (thread_join(threads[i], &retval) != 0){
     828:	8d 45 bc             	lea    -0x44(%ebp),%eax
     82b:	83 ec 08             	sub    $0x8,%esp
     82e:	50                   	push   %eax
     82f:	ff 33                	pushl  (%ebx)
     831:	e8 94 0c 00 00       	call   14ca <thread_join>
     836:	83 c4 10             	add    $0x10,%esp
     839:	85 c0                	test   %eax,%eax
     83b:	89 c7                	mov    %eax,%edi
     83d:	0f 85 85 00 00 00    	jne    8c8 <stridetest+0x138>
     843:	83 c3 04             	add    $0x4,%ebx
  for (i = 0; i < NUM_THREAD; i++){
     846:	39 f3                	cmp    %esi,%ebx
     848:	75 de                	jne    828 <stridetest+0x98>
      printf(1, "panic at thread_join\n");
      return -1;
    }
  }

  if (pid == 0){
     84a:	8b 4d b4             	mov    -0x4c(%ebp),%ecx
    printf(1, " 2% : %d\n", gcnt);
     84d:	a1 44 24 00 00       	mov    0x2444,%eax
  if (pid == 0){
     852:	85 c9                	test   %ecx,%ecx
     854:	0f 84 a2 00 00 00    	je     8fc <stridetest+0x16c>
    exit();
  } else{
    printf(1, "10% : %d\n", gcnt);
     85a:	83 ec 04             	sub    $0x4,%esp
     85d:	50                   	push   %eax
     85e:	68 fa 19 00 00       	push   $0x19fa
     863:	6a 01                	push   $0x1
     865:	e8 36 0d 00 00       	call   15a0 <printf>
    if (wait() == -1){
     86a:	e8 9b 0b 00 00       	call   140a <wait>
     86f:	83 c4 10             	add    $0x10,%esp
     872:	83 f8 ff             	cmp    $0xffffffff,%eax
     875:	0f 84 94 00 00 00    	je     90f <stridetest+0x17f>
      exit();
    }
  }

  return 0;
}
     87b:	8d 65 f4             	lea    -0xc(%ebp),%esp
     87e:	89 f8                	mov    %edi,%eax
     880:	5b                   	pop    %ebx
     881:	5e                   	pop    %esi
     882:	5f                   	pop    %edi
     883:	5d                   	pop    %ebp
     884:	c3                   	ret    
     885:	8d 76 00             	lea    0x0(%esi),%esi
    set_cpu_share(10);
     888:	83 ec 0c             	sub    $0xc,%esp
     88b:	6a 0a                	push   $0xa
     88d:	e8 20 0c 00 00       	call   14b2 <set_cpu_share>
     892:	83 c4 10             	add    $0x10,%esp
     895:	e9 39 ff ff ff       	jmp    7d3 <stridetest+0x43>
     89a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      printf(1, "panic at thread_create\n");
     8a0:	83 ec 08             	sub    $0x8,%esp
      return -1;
     8a3:	bf ff ff ff ff       	mov    $0xffffffff,%edi
      printf(1, "panic at thread_create\n");
     8a8:	68 16 19 00 00       	push   $0x1916
     8ad:	6a 01                	push   $0x1
     8af:	e8 ec 0c 00 00       	call   15a0 <printf>
      return -1;
     8b4:	83 c4 10             	add    $0x10,%esp
}
     8b7:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8ba:	89 f8                	mov    %edi,%eax
     8bc:	5b                   	pop    %ebx
     8bd:	5e                   	pop    %esi
     8be:	5f                   	pop    %edi
     8bf:	5d                   	pop    %ebp
     8c0:	c3                   	ret    
     8c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "panic at thread_join\n");
     8c8:	83 ec 08             	sub    $0x8,%esp
      return -1;
     8cb:	bf ff ff ff ff       	mov    $0xffffffff,%edi
      printf(1, "panic at thread_join\n");
     8d0:	68 3e 19 00 00       	push   $0x193e
     8d5:	6a 01                	push   $0x1
     8d7:	e8 c4 0c 00 00       	call   15a0 <printf>
      return -1;
     8dc:	83 c4 10             	add    $0x10,%esp
}
     8df:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8e2:	89 f8                	mov    %edi,%eax
     8e4:	5b                   	pop    %ebx
     8e5:	5e                   	pop    %esi
     8e6:	5f                   	pop    %edi
     8e7:	5d                   	pop    %ebp
     8e8:	c3                   	ret    
    printf(1, "panic at fork in forktest\n");
     8e9:	56                   	push   %esi
     8ea:	56                   	push   %esi
     8eb:	68 d5 19 00 00       	push   $0x19d5
     8f0:	6a 01                	push   $0x1
     8f2:	e8 a9 0c 00 00       	call   15a0 <printf>
    exit();
     8f7:	e8 06 0b 00 00       	call   1402 <exit>
    printf(1, " 2% : %d\n", gcnt);
     8fc:	52                   	push   %edx
     8fd:	50                   	push   %eax
     8fe:	68 f0 19 00 00       	push   $0x19f0
     903:	6a 01                	push   $0x1
     905:	e8 96 0c 00 00       	call   15a0 <printf>
    exit();
     90a:	e8 f3 0a 00 00       	call   1402 <exit>
      printf(1, "panic at wait in forktest\n");
     90f:	50                   	push   %eax
     910:	50                   	push   %eax
     911:	68 04 1a 00 00       	push   $0x1a04
     916:	6a 01                	push   $0x1
     918:	e8 83 0c 00 00       	call   15a0 <printf>
      exit();
     91d:	e8 e0 0a 00 00       	call   1402 <exit>
     922:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000930 <exitthreadmain>:
{
     930:	55                   	push   %ebp
     931:	89 e5                	mov    %esp,%ebp
     933:	83 ec 08             	sub    $0x8,%esp
     936:	8b 45 08             	mov    0x8(%ebp),%eax
  if ((int)arg == 1){
     939:	83 f8 01             	cmp    $0x1,%eax
     93c:	74 2a                	je     968 <exitthreadmain+0x38>
  } else if ((int)arg == 2){
     93e:	83 f8 02             	cmp    $0x2,%eax
     941:	74 39                	je     97c <exitthreadmain+0x4c>
  printf(1, "before thread_exit(0)\n");
     943:	83 ec 08             	sub    $0x8,%esp
     946:	68 3f 1a 00 00       	push   $0x1a3f
     94b:	6a 01                	push   $0x1
     94d:	e8 4e 0c 00 00       	call   15a0 <printf>
  thread_exit(0);
     952:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     959:	e8 64 0b 00 00       	call   14c2 <thread_exit>
}
     95e:	31 c0                	xor    %eax,%eax
     960:	c9                   	leave  
     961:	c3                   	ret    
     962:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      printf(1, "thread_exit ...\n");
     968:	83 ec 08             	sub    $0x8,%esp
     96b:	68 1f 1a 00 00       	push   $0x1a1f
     970:	6a 01                	push   $0x1
     972:	e8 29 0c 00 00       	call   15a0 <printf>
     977:	83 c4 10             	add    $0x10,%esp
     97a:	eb ec                	jmp    968 <exitthreadmain+0x38>
    printf(1, "before exit()\n");
     97c:	50                   	push   %eax
     97d:	50                   	push   %eax
     97e:	68 30 1a 00 00       	push   $0x1a30
     983:	6a 01                	push   $0x1
     985:	e8 16 0c 00 00       	call   15a0 <printf>
	exit();
     98a:	e8 73 0a 00 00       	call   1402 <exit>
     98f:	90                   	nop

00000990 <forkthreadmain>:
{
     990:	55                   	push   %ebp
     991:	89 e5                	mov    %esp,%ebp
     993:	83 ec 08             	sub    $0x8,%esp
  if ((pid = fork()) == -1){
     996:	e8 5f 0a 00 00       	call   13fa <fork>
     99b:	83 f8 ff             	cmp    $0xffffffff,%eax
     99e:	74 2e                	je     9ce <forkthreadmain+0x3e>
  } else if (pid == 0){
     9a0:	85 c0                	test   %eax,%eax
     9a2:	74 50                	je     9f4 <forkthreadmain+0x64>
    printf(1, "parent\n");
     9a4:	83 ec 08             	sub    $0x8,%esp
     9a7:	68 5d 1a 00 00       	push   $0x1a5d
     9ac:	6a 01                	push   $0x1
     9ae:	e8 ed 0b 00 00       	call   15a0 <printf>
    if (wait() == -1){
     9b3:	e8 52 0a 00 00       	call   140a <wait>
     9b8:	83 c4 10             	add    $0x10,%esp
     9bb:	83 f8 ff             	cmp    $0xffffffff,%eax
     9be:	74 21                	je     9e1 <forkthreadmain+0x51>
  thread_exit(0);
     9c0:	83 ec 0c             	sub    $0xc,%esp
     9c3:	6a 00                	push   $0x0
     9c5:	e8 f8 0a 00 00       	call   14c2 <thread_exit>
}
     9ca:	31 c0                	xor    %eax,%eax
     9cc:	c9                   	leave  
     9cd:	c3                   	ret    
    printf(1, "panic at fork in forktest\n");
     9ce:	51                   	push   %ecx
     9cf:	51                   	push   %ecx
     9d0:	68 d5 19 00 00       	push   $0x19d5
     9d5:	6a 01                	push   $0x1
     9d7:	e8 c4 0b 00 00       	call   15a0 <printf>
    exit();
     9dc:	e8 21 0a 00 00       	call   1402 <exit>
      printf(1, "panic at wait in forktest\n");
     9e1:	50                   	push   %eax
     9e2:	50                   	push   %eax
     9e3:	68 04 1a 00 00       	push   $0x1a04
     9e8:	6a 01                	push   $0x1
     9ea:	e8 b1 0b 00 00       	call   15a0 <printf>
      exit();
     9ef:	e8 0e 0a 00 00       	call   1402 <exit>
    printf(1, "child\n");
     9f4:	52                   	push   %edx
     9f5:	52                   	push   %edx
     9f6:	68 56 1a 00 00       	push   $0x1a56
     9fb:	6a 01                	push   $0x1
     9fd:	e8 9e 0b 00 00       	call   15a0 <printf>
    exit();
     a02:	e8 fb 09 00 00       	call   1402 <exit>
     a07:	89 f6                	mov    %esi,%esi
     a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a10 <exittest1>:
{
     a10:	55                   	push   %ebp
     a11:	89 e5                	mov    %esp,%ebp
     a13:	57                   	push   %edi
     a14:	56                   	push   %esi
     a15:	53                   	push   %ebx
     a16:	8d 7d e8             	lea    -0x18(%ebp),%edi
     a19:	8d 5d c0             	lea    -0x40(%ebp),%ebx
     a1c:	83 ec 3c             	sub    $0x3c,%esp
     a1f:	90                   	nop
    if (thread_create(&threads[i], exitthreadmain, (void*)1) != 0){
     a20:	83 ec 04             	sub    $0x4,%esp
     a23:	6a 01                	push   $0x1
     a25:	68 30 09 00 00       	push   $0x930
     a2a:	53                   	push   %ebx
     a2b:	e8 8a 0a 00 00       	call   14ba <thread_create>
     a30:	83 c4 10             	add    $0x10,%esp
     a33:	85 c0                	test   %eax,%eax
     a35:	89 c6                	mov    %eax,%esi
     a37:	75 27                	jne    a60 <exittest1+0x50>
     a39:	83 c3 04             	add    $0x4,%ebx
  for (i = 0; i < NUM_THREAD; i++){
     a3c:	39 fb                	cmp    %edi,%ebx
     a3e:	75 e0                	jne    a20 <exittest1+0x10>
  sleep(1);
     a40:	83 ec 0c             	sub    $0xc,%esp
     a43:	6a 01                	push   $0x1
     a45:	e8 48 0a 00 00       	call   1492 <sleep>
  return 0;
     a4a:	83 c4 10             	add    $0x10,%esp
}
     a4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a50:	89 f0                	mov    %esi,%eax
     a52:	5b                   	pop    %ebx
     a53:	5e                   	pop    %esi
     a54:	5f                   	pop    %edi
     a55:	5d                   	pop    %ebp
     a56:	c3                   	ret    
     a57:	89 f6                	mov    %esi,%esi
     a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      printf(1, "panic at thread_create\n");
     a60:	83 ec 08             	sub    $0x8,%esp
     a63:	be ff ff ff ff       	mov    $0xffffffff,%esi
     a68:	68 16 19 00 00       	push   $0x1916
     a6d:	6a 01                	push   $0x1
     a6f:	e8 2c 0b 00 00       	call   15a0 <printf>
     a74:	83 c4 10             	add    $0x10,%esp
}
     a77:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a7a:	89 f0                	mov    %esi,%eax
     a7c:	5b                   	pop    %ebx
     a7d:	5e                   	pop    %esi
     a7e:	5f                   	pop    %edi
     a7f:	5d                   	pop    %ebp
     a80:	c3                   	ret    
     a81:	eb 0d                	jmp    a90 <jointest1>
     a83:	90                   	nop
     a84:	90                   	nop
     a85:	90                   	nop
     a86:	90                   	nop
     a87:	90                   	nop
     a88:	90                   	nop
     a89:	90                   	nop
     a8a:	90                   	nop
     a8b:	90                   	nop
     a8c:	90                   	nop
     a8d:	90                   	nop
     a8e:	90                   	nop
     a8f:	90                   	nop

00000a90 <jointest1>:
{
     a90:	55                   	push   %ebp
     a91:	89 e5                	mov    %esp,%ebp
     a93:	56                   	push   %esi
     a94:	53                   	push   %ebx
     a95:	8d 75 cc             	lea    -0x34(%ebp),%esi
  for (i = 1; i <= NUM_THREAD; i++){
     a98:	bb 01 00 00 00       	mov    $0x1,%ebx
{
     a9d:	83 ec 40             	sub    $0x40,%esp
    if (thread_create(&threads[i-1], jointhreadmain, (void*)i) != 0){
     aa0:	8d 04 9e             	lea    (%esi,%ebx,4),%eax
     aa3:	83 ec 04             	sub    $0x4,%esp
     aa6:	53                   	push   %ebx
     aa7:	68 90 02 00 00       	push   $0x290
     aac:	50                   	push   %eax
     aad:	e8 08 0a 00 00       	call   14ba <thread_create>
     ab2:	83 c4 10             	add    $0x10,%esp
     ab5:	85 c0                	test   %eax,%eax
     ab7:	75 67                	jne    b20 <jointest1+0x90>
  for (i = 1; i <= NUM_THREAD; i++){
     ab9:	83 c3 01             	add    $0x1,%ebx
     abc:	83 fb 0b             	cmp    $0xb,%ebx
     abf:	75 df                	jne    aa0 <jointest1+0x10>
  printf(1, "thread_join!!!\n");
     ac1:	83 ec 08             	sub    $0x8,%esp
     ac4:	bb 02 00 00 00       	mov    $0x2,%ebx
     ac9:	68 2e 19 00 00       	push   $0x192e
     ace:	6a 01                	push   $0x1
     ad0:	e8 cb 0a 00 00       	call   15a0 <printf>
     ad5:	83 c4 10             	add    $0x10,%esp
     ad8:	90                   	nop
     ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (thread_join(threads[i-1], &retval) != 0 || (int)retval != i * 2 ){
     ae0:	83 ec 08             	sub    $0x8,%esp
     ae3:	56                   	push   %esi
     ae4:	ff 74 5d cc          	pushl  -0x34(%ebp,%ebx,2)
     ae8:	e8 dd 09 00 00       	call   14ca <thread_join>
     aed:	83 c4 10             	add    $0x10,%esp
     af0:	85 c0                	test   %eax,%eax
     af2:	75 4c                	jne    b40 <jointest1+0xb0>
     af4:	39 5d cc             	cmp    %ebx,-0x34(%ebp)
     af7:	75 47                	jne    b40 <jointest1+0xb0>
     af9:	83 c3 02             	add    $0x2,%ebx
  for (i = 1; i <= NUM_THREAD; i++){
     afc:	83 fb 16             	cmp    $0x16,%ebx
     aff:	75 df                	jne    ae0 <jointest1+0x50>
  printf(1,"\n");
     b01:	83 ec 08             	sub    $0x8,%esp
     b04:	89 45 c4             	mov    %eax,-0x3c(%ebp)
     b07:	68 3c 19 00 00       	push   $0x193c
     b0c:	6a 01                	push   $0x1
     b0e:	e8 8d 0a 00 00       	call   15a0 <printf>
  return 0;
     b13:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     b16:	83 c4 10             	add    $0x10,%esp
}
     b19:	8d 65 f8             	lea    -0x8(%ebp),%esp
     b1c:	5b                   	pop    %ebx
     b1d:	5e                   	pop    %esi
     b1e:	5d                   	pop    %ebp
     b1f:	c3                   	ret    
      printf(1, "panic at thread_create\n");
     b20:	83 ec 08             	sub    $0x8,%esp
     b23:	68 16 19 00 00       	push   $0x1916
     b28:	6a 01                	push   $0x1
     b2a:	e8 71 0a 00 00       	call   15a0 <printf>
      return -1;
     b2f:	83 c4 10             	add    $0x10,%esp
}
     b32:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return -1;
     b35:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     b3a:	5b                   	pop    %ebx
     b3b:	5e                   	pop    %esi
     b3c:	5d                   	pop    %ebp
     b3d:	c3                   	ret    
     b3e:	66 90                	xchg   %ax,%ax
      printf(1, "panic at thread_join\n");
     b40:	83 ec 08             	sub    $0x8,%esp
     b43:	68 3e 19 00 00       	push   $0x193e
     b48:	6a 01                	push   $0x1
     b4a:	e8 51 0a 00 00       	call   15a0 <printf>
     b4f:	83 c4 10             	add    $0x10,%esp
}
     b52:	8d 65 f8             	lea    -0x8(%ebp),%esp
      printf(1, "panic at thread_join\n");
     b55:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     b5a:	5b                   	pop    %ebx
     b5b:	5e                   	pop    %esi
     b5c:	5d                   	pop    %ebp
     b5d:	c3                   	ret    
     b5e:	66 90                	xchg   %ax,%ax

00000b60 <stresstest>:
{
     b60:	55                   	push   %ebp
     b61:	89 e5                	mov    %esp,%ebp
     b63:	57                   	push   %edi
     b64:	56                   	push   %esi
     b65:	53                   	push   %ebx
     b66:	8d 75 bc             	lea    -0x44(%ebp),%esi
     b69:	83 ec 4c             	sub    $0x4c,%esp
  for (n = 1; n <= nstress; n++){
     b6c:	c7 45 b4 01 00 00 00 	movl   $0x1,-0x4c(%ebp)
     b73:	31 ff                	xor    %edi,%edi
     b75:	8d 76 00             	lea    0x0(%esi),%esi
      if (thread_create(&threads[i], stressthreadmain, (void*)i) != 0){
     b78:	8d 44 bd c0          	lea    -0x40(%ebp,%edi,4),%eax
     b7c:	83 ec 04             	sub    $0x4,%esp
     b7f:	8d 5d c0             	lea    -0x40(%ebp),%ebx
     b82:	57                   	push   %edi
     b83:	68 c0 02 00 00       	push   $0x2c0
     b88:	50                   	push   %eax
     b89:	e8 2c 09 00 00       	call   14ba <thread_create>
     b8e:	83 c4 10             	add    $0x10,%esp
     b91:	85 c0                	test   %eax,%eax
     b93:	75 6b                	jne    c00 <stresstest+0xa0>
    for (i = 0; i < NUM_THREAD; i++){
     b95:	83 c7 01             	add    $0x1,%edi
     b98:	83 ff 0a             	cmp    $0xa,%edi
     b9b:	75 db                	jne    b78 <stresstest+0x18>
     b9d:	8d 76 00             	lea    0x0(%esi),%esi
      if (thread_join(threads[i], &retval) != 0){
     ba0:	83 ec 08             	sub    $0x8,%esp
     ba3:	56                   	push   %esi
     ba4:	ff 33                	pushl  (%ebx)
     ba6:	e8 1f 09 00 00       	call   14ca <thread_join>
     bab:	83 c4 10             	add    $0x10,%esp
     bae:	85 c0                	test   %eax,%eax
     bb0:	75 6e                	jne    c20 <stresstest+0xc0>
    for (i = 0; i < NUM_THREAD; i++){
     bb2:	8d 4d e8             	lea    -0x18(%ebp),%ecx
     bb5:	83 c3 04             	add    $0x4,%ebx
     bb8:	39 cb                	cmp    %ecx,%ebx
     bba:	75 e4                	jne    ba0 <stresstest+0x40>
  for (n = 1; n <= nstress; n++){
     bbc:	83 45 b4 01          	addl   $0x1,-0x4c(%ebp)
     bc0:	8b 55 b4             	mov    -0x4c(%ebp),%edx
     bc3:	81 fa b9 88 00 00    	cmp    $0x88b9,%edx
     bc9:	74 74                	je     c3f <stresstest+0xdf>
    if (n % 1000 == 0)
     bcb:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     bce:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
     bd3:	f7 e2                	mul    %edx
     bd5:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     bd8:	c1 ea 06             	shr    $0x6,%edx
     bdb:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
     be1:	39 d0                	cmp    %edx,%eax
     be3:	75 8e                	jne    b73 <stresstest+0x13>
      printf(1, "%d\n", n);
     be5:	83 ec 04             	sub    $0x4,%esp
     be8:	50                   	push   %eax
     be9:	68 00 1a 00 00       	push   $0x1a00
     bee:	6a 01                	push   $0x1
     bf0:	e8 ab 09 00 00       	call   15a0 <printf>
     bf5:	83 c4 10             	add    $0x10,%esp
     bf8:	e9 76 ff ff ff       	jmp    b73 <stresstest+0x13>
     bfd:	8d 76 00             	lea    0x0(%esi),%esi
        printf(1, "panic at thread_create\n");
     c00:	83 ec 08             	sub    $0x8,%esp
     c03:	68 16 19 00 00       	push   $0x1916
     c08:	6a 01                	push   $0x1
     c0a:	e8 91 09 00 00       	call   15a0 <printf>
        return -1;
     c0f:	83 c4 10             	add    $0x10,%esp
     c12:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     c17:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c1a:	5b                   	pop    %ebx
     c1b:	5e                   	pop    %esi
     c1c:	5f                   	pop    %edi
     c1d:	5d                   	pop    %ebp
     c1e:	c3                   	ret    
     c1f:	90                   	nop
        printf(1, "panic at thread_join\n");
     c20:	83 ec 08             	sub    $0x8,%esp
     c23:	68 3e 19 00 00       	push   $0x193e
     c28:	6a 01                	push   $0x1
     c2a:	e8 71 09 00 00       	call   15a0 <printf>
        return -1;
     c2f:	83 c4 10             	add    $0x10,%esp
}
     c32:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
     c35:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     c3a:	5b                   	pop    %ebx
     c3b:	5e                   	pop    %esi
     c3c:	5f                   	pop    %edi
     c3d:	5d                   	pop    %ebp
     c3e:	c3                   	ret    
  printf(1, "\n");
     c3f:	83 ec 08             	sub    $0x8,%esp
     c42:	89 45 b4             	mov    %eax,-0x4c(%ebp)
     c45:	68 3c 19 00 00       	push   $0x193c
     c4a:	6a 01                	push   $0x1
     c4c:	e8 4f 09 00 00       	call   15a0 <printf>
     c51:	83 c4 10             	add    $0x10,%esp
     c54:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     c57:	eb be                	jmp    c17 <stresstest+0xb7>
     c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000c60 <killtest>:
{
     c60:	55                   	push   %ebp
     c61:	89 e5                	mov    %esp,%ebp
     c63:	57                   	push   %edi
     c64:	56                   	push   %esi
     c65:	53                   	push   %ebx
  for (i = 0; i < NUM_THREAD; i++){
     c66:	31 db                	xor    %ebx,%ebx
{
     c68:	83 ec 3c             	sub    $0x3c,%esp
     c6b:	90                   	nop
     c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (thread_create(&threads[i], killthreadmain, (void*)i) != 0){
     c70:	8d 44 9d c0          	lea    -0x40(%ebp,%ebx,4),%eax
     c74:	83 ec 04             	sub    $0x4,%esp
     c77:	8d 75 c0             	lea    -0x40(%ebp),%esi
     c7a:	53                   	push   %ebx
     c7b:	68 90 06 00 00       	push   $0x690
     c80:	50                   	push   %eax
     c81:	e8 34 08 00 00       	call   14ba <thread_create>
     c86:	83 c4 10             	add    $0x10,%esp
     c89:	85 c0                	test   %eax,%eax
     c8b:	75 53                	jne    ce0 <killtest+0x80>
  for (i = 0; i < NUM_THREAD; i++){
     c8d:	83 c3 01             	add    $0x1,%ebx
     c90:	83 fb 0a             	cmp    $0xa,%ebx
     c93:	75 db                	jne    c70 <killtest+0x10>
     c95:	8d 7d e8             	lea    -0x18(%ebp),%edi
     c98:	8d 5d bc             	lea    -0x44(%ebp),%ebx
    if (thread_join(threads[i], &retval) != 0){
     c9b:	83 ec 08             	sub    $0x8,%esp
     c9e:	53                   	push   %ebx
     c9f:	ff 36                	pushl  (%esi)
     ca1:	e8 24 08 00 00       	call   14ca <thread_join>
     ca6:	83 c4 10             	add    $0x10,%esp
     ca9:	85 c0                	test   %eax,%eax
     cab:	75 13                	jne    cc0 <killtest+0x60>
     cad:	83 c6 04             	add    $0x4,%esi
  for (i = 0; i < NUM_THREAD; i++){
     cb0:	39 fe                	cmp    %edi,%esi
     cb2:	75 e7                	jne    c9b <killtest+0x3b>
     cb4:	eb fe                	jmp    cb4 <killtest+0x54>
     cb6:	8d 76 00             	lea    0x0(%esi),%esi
     cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      printf(1, "panic at thread_join\n");
     cc0:	83 ec 08             	sub    $0x8,%esp
     cc3:	68 3e 19 00 00       	push   $0x193e
     cc8:	6a 01                	push   $0x1
     cca:	e8 d1 08 00 00       	call   15a0 <printf>
      return -1;
     ccf:	83 c4 10             	add    $0x10,%esp
}
     cd2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cd5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     cda:	5b                   	pop    %ebx
     cdb:	5e                   	pop    %esi
     cdc:	5f                   	pop    %edi
     cdd:	5d                   	pop    %ebp
     cde:	c3                   	ret    
     cdf:	90                   	nop
      printf(1, "panic at thread_create\n");
     ce0:	83 ec 08             	sub    $0x8,%esp
     ce3:	68 16 19 00 00       	push   $0x1916
     ce8:	6a 01                	push   $0x1
     cea:	e8 b1 08 00 00       	call   15a0 <printf>
     cef:	83 c4 10             	add    $0x10,%esp
}
     cf2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cf5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     cfa:	5b                   	pop    %ebx
     cfb:	5e                   	pop    %esi
     cfc:	5f                   	pop    %edi
     cfd:	5d                   	pop    %ebp
     cfe:	c3                   	ret    
     cff:	90                   	nop

00000d00 <sbrkthreadmain>:
{
     d00:	55                   	push   %ebp
     d01:	89 e5                	mov    %esp,%ebp
     d03:	57                   	push   %edi
     d04:	56                   	push   %esi
     d05:	53                   	push   %ebx
     d06:	83 ec 18             	sub    $0x18,%esp
     d09:	8b 75 08             	mov    0x8(%ebp),%esi
  oldbrk = sbrk(1000);
     d0c:	68 e8 03 00 00       	push   $0x3e8
     d11:	e8 74 07 00 00       	call   148a <sbrk>
     d16:	8d 56 01             	lea    0x1(%esi),%edx
  end = oldbrk + 1000;
     d19:	8d b8 e8 03 00 00    	lea    0x3e8(%eax),%edi
  oldbrk = sbrk(1000);
     d1f:	89 c3                	mov    %eax,%ebx
     d21:	83 c4 10             	add    $0x10,%esp
     d24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *c = tid+1;
     d28:	88 10                	mov    %dl,(%eax)
  for (c = oldbrk; c < end; c++){
     d2a:	83 c0 01             	add    $0x1,%eax
     d2d:	39 c7                	cmp    %eax,%edi
     d2f:	75 f7                	jne    d28 <sbrkthreadmain+0x28>
  sleep(1);
     d31:	83 ec 0c             	sub    $0xc,%esp
    if (*c != tid+1){
     d34:	83 c6 01             	add    $0x1,%esi
  sleep(1);
     d37:	6a 01                	push   $0x1
     d39:	e8 54 07 00 00       	call   1492 <sleep>
    if (*c != tid+1){
     d3e:	0f be 13             	movsbl (%ebx),%edx
     d41:	83 c4 10             	add    $0x10,%esp
     d44:	39 d6                	cmp    %edx,%esi
     d46:	89 d0                	mov    %edx,%eax
     d48:	74 0a                	je     d54 <sbrkthreadmain+0x54>
     d4a:	eb 23                	jmp    d6f <sbrkthreadmain+0x6f>
     d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d50:	38 03                	cmp    %al,(%ebx)
     d52:	75 1b                	jne    d6f <sbrkthreadmain+0x6f>
  for (c = oldbrk; c < end; c++){
     d54:	83 c3 01             	add    $0x1,%ebx
     d57:	39 df                	cmp    %ebx,%edi
     d59:	75 f5                	jne    d50 <sbrkthreadmain+0x50>
  thread_exit(0);
     d5b:	83 ec 0c             	sub    $0xc,%esp
     d5e:	6a 00                	push   $0x0
     d60:	e8 5d 07 00 00       	call   14c2 <thread_exit>
}
     d65:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d68:	31 c0                	xor    %eax,%eax
     d6a:	5b                   	pop    %ebx
     d6b:	5e                   	pop    %esi
     d6c:	5f                   	pop    %edi
     d6d:	5d                   	pop    %ebp
     d6e:	c3                   	ret    
      printf(1, "panic at sbrkthreadmain\n");
     d6f:	83 ec 08             	sub    $0x8,%esp
     d72:	68 65 1a 00 00       	push   $0x1a65
     d77:	6a 01                	push   $0x1
     d79:	e8 22 08 00 00       	call   15a0 <printf>
      exit();
     d7e:	e8 7f 06 00 00       	call   1402 <exit>
     d83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d90 <sleeptest>:
{
     d90:	55                   	push   %ebp
     d91:	89 e5                	mov    %esp,%ebp
     d93:	56                   	push   %esi
     d94:	53                   	push   %ebx
  for (i = 0; i < NUM_THREAD; i++){
     d95:	31 db                	xor    %ebx,%ebx
{
     d97:	83 ec 30             	sub    $0x30,%esp
     d9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (thread_create(&threads[i], sleepthreadmain, (void*)i) != 0){
     da0:	8d 44 9d d0          	lea    -0x30(%ebp,%ebx,4),%eax
     da4:	83 ec 04             	sub    $0x4,%esp
     da7:	53                   	push   %ebx
     da8:	68 e0 02 00 00       	push   $0x2e0
     dad:	50                   	push   %eax
     dae:	e8 07 07 00 00       	call   14ba <thread_create>
     db3:	83 c4 10             	add    $0x10,%esp
     db6:	85 c0                	test   %eax,%eax
     db8:	89 c6                	mov    %eax,%esi
     dba:	75 24                	jne    de0 <sleeptest+0x50>
  for (i = 0; i < NUM_THREAD; i++){
     dbc:	83 c3 01             	add    $0x1,%ebx
     dbf:	83 fb 0a             	cmp    $0xa,%ebx
     dc2:	75 dc                	jne    da0 <sleeptest+0x10>
  sleep(10);
     dc4:	83 ec 0c             	sub    $0xc,%esp
     dc7:	6a 0a                	push   $0xa
     dc9:	e8 c4 06 00 00       	call   1492 <sleep>
  return 0;
     dce:	83 c4 10             	add    $0x10,%esp
}
     dd1:	8d 65 f8             	lea    -0x8(%ebp),%esp
     dd4:	89 f0                	mov    %esi,%eax
     dd6:	5b                   	pop    %ebx
     dd7:	5e                   	pop    %esi
     dd8:	5d                   	pop    %ebp
     dd9:	c3                   	ret    
     dda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      printf(1, "panic at thread_create\n");
     de0:	83 ec 08             	sub    $0x8,%esp
     de3:	be ff ff ff ff       	mov    $0xffffffff,%esi
     de8:	68 16 19 00 00       	push   $0x1916
     ded:	6a 01                	push   $0x1
     def:	e8 ac 07 00 00       	call   15a0 <printf>
     df4:	83 c4 10             	add    $0x10,%esp
}
     df7:	8d 65 f8             	lea    -0x8(%ebp),%esp
     dfa:	89 f0                	mov    %esi,%eax
     dfc:	5b                   	pop    %ebx
     dfd:	5e                   	pop    %esi
     dfe:	5d                   	pop    %ebp
     dff:	c3                   	ret    

00000e00 <forktest>:
{
     e00:	55                   	push   %ebp
     e01:	89 e5                	mov    %esp,%ebp
     e03:	57                   	push   %edi
     e04:	56                   	push   %esi
     e05:	8d 75 c0             	lea    -0x40(%ebp),%esi
     e08:	53                   	push   %ebx
     e09:	8d 7d e8             	lea    -0x18(%ebp),%edi
     e0c:	83 ec 3c             	sub    $0x3c,%esp
     e0f:	89 f3                	mov    %esi,%ebx
     e11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (thread_create(&threads[i], forkthreadmain, (void*)0) != 0){
     e18:	83 ec 04             	sub    $0x4,%esp
     e1b:	6a 00                	push   $0x0
     e1d:	68 90 09 00 00       	push   $0x990
     e22:	53                   	push   %ebx
     e23:	e8 92 06 00 00       	call   14ba <thread_create>
     e28:	83 c4 10             	add    $0x10,%esp
     e2b:	85 c0                	test   %eax,%eax
     e2d:	75 39                	jne    e68 <forktest+0x68>
     e2f:	83 c3 04             	add    $0x4,%ebx
  for (i = 0; i < NUM_THREAD; i++){
     e32:	39 fb                	cmp    %edi,%ebx
     e34:	75 e2                	jne    e18 <forktest+0x18>
     e36:	8d 7d bc             	lea    -0x44(%ebp),%edi
     e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (thread_join(threads[i], &retval) != 0){
     e40:	83 ec 08             	sub    $0x8,%esp
     e43:	57                   	push   %edi
     e44:	ff 36                	pushl  (%esi)
     e46:	e8 7f 06 00 00       	call   14ca <thread_join>
     e4b:	83 c4 10             	add    $0x10,%esp
     e4e:	85 c0                	test   %eax,%eax
     e50:	75 3e                	jne    e90 <forktest+0x90>
     e52:	83 c6 04             	add    $0x4,%esi
  for (i = 0; i < NUM_THREAD; i++){
     e55:	39 de                	cmp    %ebx,%esi
     e57:	75 e7                	jne    e40 <forktest+0x40>
}
     e59:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e5c:	5b                   	pop    %ebx
     e5d:	5e                   	pop    %esi
     e5e:	5f                   	pop    %edi
     e5f:	5d                   	pop    %ebp
     e60:	c3                   	ret    
     e61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "panic at thread_create\n");
     e68:	83 ec 08             	sub    $0x8,%esp
     e6b:	68 16 19 00 00       	push   $0x1916
     e70:	6a 01                	push   $0x1
     e72:	e8 29 07 00 00       	call   15a0 <printf>
      return -1;
     e77:	83 c4 10             	add    $0x10,%esp
}
     e7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
     e7d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     e82:	5b                   	pop    %ebx
     e83:	5e                   	pop    %esi
     e84:	5f                   	pop    %edi
     e85:	5d                   	pop    %ebp
     e86:	c3                   	ret    
     e87:	89 f6                	mov    %esi,%esi
     e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      printf(1, "panic at thread_join\n");
     e90:	83 ec 08             	sub    $0x8,%esp
     e93:	68 3e 19 00 00       	push   $0x193e
     e98:	6a 01                	push   $0x1
     e9a:	e8 01 07 00 00       	call   15a0 <printf>
     e9f:	83 c4 10             	add    $0x10,%esp
}
     ea2:	8d 65 f4             	lea    -0xc(%ebp),%esp
      printf(1, "panic at thread_join\n");
     ea5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     eaa:	5b                   	pop    %ebx
     eab:	5e                   	pop    %esi
     eac:	5f                   	pop    %edi
     ead:	5d                   	pop    %ebp
     eae:	c3                   	ret    
     eaf:	90                   	nop

00000eb0 <sbrktest>:
{
     eb0:	55                   	push   %ebp
     eb1:	89 e5                	mov    %esp,%ebp
     eb3:	57                   	push   %edi
     eb4:	56                   	push   %esi
     eb5:	53                   	push   %ebx
  for (i = 0; i < NUM_THREAD; i++){
     eb6:	31 db                	xor    %ebx,%ebx
{
     eb8:	83 ec 3c             	sub    $0x3c,%esp
     ebb:	90                   	nop
     ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (thread_create(&threads[i], sbrkthreadmain, (void*)i) != 0){
     ec0:	8d 44 9d c0          	lea    -0x40(%ebp,%ebx,4),%eax
     ec4:	83 ec 04             	sub    $0x4,%esp
     ec7:	8d 75 c0             	lea    -0x40(%ebp),%esi
     eca:	53                   	push   %ebx
     ecb:	68 00 0d 00 00       	push   $0xd00
     ed0:	50                   	push   %eax
     ed1:	e8 e4 05 00 00       	call   14ba <thread_create>
     ed6:	83 c4 10             	add    $0x10,%esp
     ed9:	85 c0                	test   %eax,%eax
     edb:	75 3b                	jne    f18 <sbrktest+0x68>
  for (i = 0; i < NUM_THREAD; i++){
     edd:	83 c3 01             	add    $0x1,%ebx
     ee0:	83 fb 0a             	cmp    $0xa,%ebx
     ee3:	75 db                	jne    ec0 <sbrktest+0x10>
     ee5:	8d 7d e8             	lea    -0x18(%ebp),%edi
     ee8:	8d 5d bc             	lea    -0x44(%ebp),%ebx
     eeb:	90                   	nop
     eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (thread_join(threads[i], &retval) != 0){
     ef0:	83 ec 08             	sub    $0x8,%esp
     ef3:	53                   	push   %ebx
     ef4:	ff 36                	pushl  (%esi)
     ef6:	e8 cf 05 00 00       	call   14ca <thread_join>
     efb:	83 c4 10             	add    $0x10,%esp
     efe:	85 c0                	test   %eax,%eax
     f00:	75 3e                	jne    f40 <sbrktest+0x90>
     f02:	83 c6 04             	add    $0x4,%esi
  for (i = 0; i < NUM_THREAD; i++){
     f05:	39 fe                	cmp    %edi,%esi
     f07:	75 e7                	jne    ef0 <sbrktest+0x40>
}
     f09:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f0c:	5b                   	pop    %ebx
     f0d:	5e                   	pop    %esi
     f0e:	5f                   	pop    %edi
     f0f:	5d                   	pop    %ebp
     f10:	c3                   	ret    
     f11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "panic at thread_create\n");
     f18:	83 ec 08             	sub    $0x8,%esp
     f1b:	68 16 19 00 00       	push   $0x1916
     f20:	6a 01                	push   $0x1
     f22:	e8 79 06 00 00       	call   15a0 <printf>
      return -1;
     f27:	83 c4 10             	add    $0x10,%esp
}
     f2a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
     f2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     f32:	5b                   	pop    %ebx
     f33:	5e                   	pop    %esi
     f34:	5f                   	pop    %edi
     f35:	5d                   	pop    %ebp
     f36:	c3                   	ret    
     f37:	89 f6                	mov    %esi,%esi
     f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      printf(1, "panic at thread_join\n");
     f40:	83 ec 08             	sub    $0x8,%esp
     f43:	68 3e 19 00 00       	push   $0x193e
     f48:	6a 01                	push   $0x1
     f4a:	e8 51 06 00 00       	call   15a0 <printf>
     f4f:	83 c4 10             	add    $0x10,%esp
}
     f52:	8d 65 f4             	lea    -0xc(%ebp),%esp
      printf(1, "panic at thread_join\n");
     f55:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     f5a:	5b                   	pop    %ebx
     f5b:	5e                   	pop    %esi
     f5c:	5f                   	pop    %edi
     f5d:	5d                   	pop    %ebp
     f5e:	c3                   	ret    
     f5f:	90                   	nop

00000f60 <basictest>:
{
     f60:	55                   	push   %ebp
     f61:	89 e5                	mov    %esp,%ebp
     f63:	56                   	push   %esi
     f64:	53                   	push   %ebx
  for (i = 0; i < NUM_THREAD; i++){
     f65:	31 db                	xor    %ebx,%ebx
{
     f67:	83 ec 40             	sub    $0x40,%esp
     f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (thread_create(&threads[i], basicthreadmain, (void*)i) != 0){
     f70:	8d 44 9d d0          	lea    -0x30(%ebp,%ebx,4),%eax
     f74:	83 ec 04             	sub    $0x4,%esp
     f77:	53                   	push   %ebx
     f78:	68 20 02 00 00       	push   $0x220
     f7d:	50                   	push   %eax
     f7e:	e8 37 05 00 00       	call   14ba <thread_create>
     f83:	83 c4 10             	add    $0x10,%esp
     f86:	85 c0                	test   %eax,%eax
     f88:	89 c6                	mov    %eax,%esi
     f8a:	75 54                	jne    fe0 <basictest+0x80>
  for (i = 0; i < NUM_THREAD; i++){
     f8c:	83 c3 01             	add    $0x1,%ebx
     f8f:	83 fb 0a             	cmp    $0xa,%ebx
     f92:	75 dc                	jne    f70 <basictest+0x10>
     f94:	8d 5d cc             	lea    -0x34(%ebp),%ebx
     f97:	89 f6                	mov    %esi,%esi
     f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if (thread_join(threads[i], &retval) != 0 || (int)retval != i+1){
     fa0:	83 ec 08             	sub    $0x8,%esp
     fa3:	53                   	push   %ebx
     fa4:	ff 74 b5 d0          	pushl  -0x30(%ebp,%esi,4)
     fa8:	e8 1d 05 00 00       	call   14ca <thread_join>
     fad:	83 c4 10             	add    $0x10,%esp
     fb0:	85 c0                	test   %eax,%eax
     fb2:	75 4c                	jne    1000 <basictest+0xa0>
     fb4:	83 c6 01             	add    $0x1,%esi
     fb7:	39 75 cc             	cmp    %esi,-0x34(%ebp)
     fba:	75 44                	jne    1000 <basictest+0xa0>
  for (i = 0; i < NUM_THREAD; i++){
     fbc:	83 fe 0a             	cmp    $0xa,%esi
     fbf:	75 df                	jne    fa0 <basictest+0x40>
  printf(1,"\n");
     fc1:	83 ec 08             	sub    $0x8,%esp
     fc4:	89 45 c4             	mov    %eax,-0x3c(%ebp)
     fc7:	68 3c 19 00 00       	push   $0x193c
     fcc:	6a 01                	push   $0x1
     fce:	e8 cd 05 00 00       	call   15a0 <printf>
  return 0;
     fd3:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     fd6:	83 c4 10             	add    $0x10,%esp
}
     fd9:	8d 65 f8             	lea    -0x8(%ebp),%esp
     fdc:	5b                   	pop    %ebx
     fdd:	5e                   	pop    %esi
     fde:	5d                   	pop    %ebp
     fdf:	c3                   	ret    
      printf(1, "panic at thread_create\n");
     fe0:	83 ec 08             	sub    $0x8,%esp
     fe3:	68 16 19 00 00       	push   $0x1916
     fe8:	6a 01                	push   $0x1
     fea:	e8 b1 05 00 00       	call   15a0 <printf>
      return -1;
     fef:	83 c4 10             	add    $0x10,%esp
}
     ff2:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return -1;
     ff5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     ffa:	5b                   	pop    %ebx
     ffb:	5e                   	pop    %esi
     ffc:	5d                   	pop    %ebp
     ffd:	c3                   	ret    
     ffe:	66 90                	xchg   %ax,%ax
      printf(1, "panic at thread_join\n");
    1000:	83 ec 08             	sub    $0x8,%esp
    1003:	68 3e 19 00 00       	push   $0x193e
    1008:	6a 01                	push   $0x1
    100a:	e8 91 05 00 00       	call   15a0 <printf>
    100f:	83 c4 10             	add    $0x10,%esp
}
    1012:	8d 65 f8             	lea    -0x8(%ebp),%esp
      printf(1, "panic at thread_join\n");
    1015:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    101a:	5b                   	pop    %ebx
    101b:	5e                   	pop    %esi
    101c:	5d                   	pop    %ebp
    101d:	c3                   	ret    
    101e:	66 90                	xchg   %ax,%ax

00001020 <exectest>:
{
    1020:	55                   	push   %ebp
    1021:	89 e5                	mov    %esp,%ebp
    1023:	57                   	push   %edi
    1024:	56                   	push   %esi
    1025:	8d 75 c0             	lea    -0x40(%ebp),%esi
    1028:	53                   	push   %ebx
    1029:	8d 7d e8             	lea    -0x18(%ebp),%edi
    102c:	83 ec 4c             	sub    $0x4c,%esp
    102f:	89 f3                	mov    %esi,%ebx
    1031:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (thread_create(&threads[i], execthreadmain, (void*)0) != 0){
    1038:	83 ec 04             	sub    $0x4,%esp
    103b:	6a 00                	push   $0x0
    103d:	68 40 06 00 00       	push   $0x640
    1042:	53                   	push   %ebx
    1043:	e8 72 04 00 00       	call   14ba <thread_create>
    1048:	83 c4 10             	add    $0x10,%esp
    104b:	85 c0                	test   %eax,%eax
    104d:	75 51                	jne    10a0 <exectest+0x80>
    104f:	83 c3 04             	add    $0x4,%ebx
  for (i = 0; i < NUM_THREAD; i++){
    1052:	39 fb                	cmp    %edi,%ebx
    1054:	75 e2                	jne    1038 <exectest+0x18>
    1056:	8d 7d bc             	lea    -0x44(%ebp),%edi
    1059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (thread_join(threads[i], &retval) != 0){
    1060:	83 ec 08             	sub    $0x8,%esp
    1063:	57                   	push   %edi
    1064:	ff 36                	pushl  (%esi)
    1066:	e8 5f 04 00 00       	call   14ca <thread_join>
    106b:	83 c4 10             	add    $0x10,%esp
    106e:	85 c0                	test   %eax,%eax
    1070:	75 4e                	jne    10c0 <exectest+0xa0>
    1072:	83 c6 04             	add    $0x4,%esi
  for (i = 0; i < NUM_THREAD; i++){
    1075:	39 de                	cmp    %ebx,%esi
    1077:	75 e7                	jne    1060 <exectest+0x40>
  printf(1, "panic at exectest\n");
    1079:	83 ec 08             	sub    $0x8,%esp
    107c:	89 45 b4             	mov    %eax,-0x4c(%ebp)
    107f:	68 7e 1a 00 00       	push   $0x1a7e
    1084:	6a 01                	push   $0x1
    1086:	e8 15 05 00 00       	call   15a0 <printf>
  return 0;
    108b:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    108e:	83 c4 10             	add    $0x10,%esp
}
    1091:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1094:	5b                   	pop    %ebx
    1095:	5e                   	pop    %esi
    1096:	5f                   	pop    %edi
    1097:	5d                   	pop    %ebp
    1098:	c3                   	ret    
    1099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "panic at thread_create\n");
    10a0:	83 ec 08             	sub    $0x8,%esp
    10a3:	68 16 19 00 00       	push   $0x1916
    10a8:	6a 01                	push   $0x1
    10aa:	e8 f1 04 00 00       	call   15a0 <printf>
      return -1;
    10af:	83 c4 10             	add    $0x10,%esp
}
    10b2:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
    10b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    10ba:	5b                   	pop    %ebx
    10bb:	5e                   	pop    %esi
    10bc:	5f                   	pop    %edi
    10bd:	5d                   	pop    %ebp
    10be:	c3                   	ret    
    10bf:	90                   	nop
      printf(1, "panic at thread_join\n");
    10c0:	83 ec 08             	sub    $0x8,%esp
    10c3:	68 3e 19 00 00       	push   $0x193e
    10c8:	6a 01                	push   $0x1
    10ca:	e8 d1 04 00 00       	call   15a0 <printf>
    10cf:	83 c4 10             	add    $0x10,%esp
}
    10d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
      printf(1, "panic at thread_join\n");
    10d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    10da:	5b                   	pop    %ebx
    10db:	5e                   	pop    %esi
    10dc:	5f                   	pop    %edi
    10dd:	5d                   	pop    %ebp
    10de:	c3                   	ret    
    10df:	90                   	nop

000010e0 <racingtest>:
{
    10e0:	55                   	push   %ebp
    10e1:	89 e5                	mov    %esp,%ebp
    10e3:	56                   	push   %esi
    10e4:	53                   	push   %ebx
  for (i = 0; i < NUM_THREAD; i++){
    10e5:	31 db                	xor    %ebx,%ebx
{
    10e7:	83 ec 40             	sub    $0x40,%esp
  gcnt = 0;
    10ea:	c7 05 44 24 00 00 00 	movl   $0x0,0x2444
    10f1:	00 00 00 
    10f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (thread_create(&threads[i], racingthreadmain, (void*)i) != 0){
    10f8:	8d 44 9d d0          	lea    -0x30(%ebp,%ebx,4),%eax
    10fc:	83 ec 04             	sub    $0x4,%esp
    10ff:	53                   	push   %ebx
    1100:	68 e0 01 00 00       	push   $0x1e0
    1105:	50                   	push   %eax
    1106:	e8 af 03 00 00       	call   14ba <thread_create>
    110b:	83 c4 10             	add    $0x10,%esp
    110e:	85 c0                	test   %eax,%eax
    1110:	89 c6                	mov    %eax,%esi
    1112:	75 5c                	jne    1170 <racingtest+0x90>
  for (i = 0; i < NUM_THREAD; i++){
    1114:	83 c3 01             	add    $0x1,%ebx
    1117:	83 fb 0a             	cmp    $0xa,%ebx
    111a:	75 dc                	jne    10f8 <racingtest+0x18>
    111c:	8d 5d cc             	lea    -0x34(%ebp),%ebx
    111f:	90                   	nop
    if (thread_join(threads[i], &retval) != 0 || (int)retval != i+1){
    1120:	83 ec 08             	sub    $0x8,%esp
    1123:	53                   	push   %ebx
    1124:	ff 74 b5 d0          	pushl  -0x30(%ebp,%esi,4)
    1128:	e8 9d 03 00 00       	call   14ca <thread_join>
    112d:	83 c4 10             	add    $0x10,%esp
    1130:	85 c0                	test   %eax,%eax
    1132:	75 5c                	jne    1190 <racingtest+0xb0>
    1134:	83 c6 01             	add    $0x1,%esi
    1137:	39 75 cc             	cmp    %esi,-0x34(%ebp)
    113a:	75 54                	jne    1190 <racingtest+0xb0>
  for (i = 0; i < NUM_THREAD; i++){
    113c:	83 fe 0a             	cmp    $0xa,%esi
    113f:	75 df                	jne    1120 <racingtest+0x40>
  printf(1,"%d\n", gcnt);
    1141:	8b 15 44 24 00 00    	mov    0x2444,%edx
    1147:	83 ec 04             	sub    $0x4,%esp
    114a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    114d:	52                   	push   %edx
    114e:	68 00 1a 00 00       	push   $0x1a00
    1153:	6a 01                	push   $0x1
    1155:	e8 46 04 00 00       	call   15a0 <printf>
  return 0;
    115a:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    115d:	83 c4 10             	add    $0x10,%esp
}
    1160:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1163:	5b                   	pop    %ebx
    1164:	5e                   	pop    %esi
    1165:	5d                   	pop    %ebp
    1166:	c3                   	ret    
    1167:	89 f6                	mov    %esi,%esi
    1169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      printf(1, "panic at thread_create\n");
    1170:	83 ec 08             	sub    $0x8,%esp
    1173:	68 16 19 00 00       	push   $0x1916
    1178:	6a 01                	push   $0x1
    117a:	e8 21 04 00 00       	call   15a0 <printf>
      return -1;
    117f:	83 c4 10             	add    $0x10,%esp
}
    1182:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return -1;
    1185:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    118a:	5b                   	pop    %ebx
    118b:	5e                   	pop    %esi
    118c:	5d                   	pop    %ebp
    118d:	c3                   	ret    
    118e:	66 90                	xchg   %ax,%ax
      printf(1, "panic at thread_join\n");
    1190:	83 ec 08             	sub    $0x8,%esp
    1193:	68 3e 19 00 00       	push   $0x193e
    1198:	6a 01                	push   $0x1
    119a:	e8 01 04 00 00       	call   15a0 <printf>
    119f:	83 c4 10             	add    $0x10,%esp
}
    11a2:	8d 65 f8             	lea    -0x8(%ebp),%esp
      printf(1, "panic at thread_join\n");
    11a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    11aa:	5b                   	pop    %ebx
    11ab:	5e                   	pop    %esi
    11ac:	5d                   	pop    %ebp
    11ad:	c3                   	ret    
    11ae:	66 90                	xchg   %ax,%ax

000011b0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    11b0:	55                   	push   %ebp
    11b1:	89 e5                	mov    %esp,%ebp
    11b3:	53                   	push   %ebx
    11b4:	8b 45 08             	mov    0x8(%ebp),%eax
    11b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    11ba:	89 c2                	mov    %eax,%edx
    11bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11c0:	83 c1 01             	add    $0x1,%ecx
    11c3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    11c7:	83 c2 01             	add    $0x1,%edx
    11ca:	84 db                	test   %bl,%bl
    11cc:	88 5a ff             	mov    %bl,-0x1(%edx)
    11cf:	75 ef                	jne    11c0 <strcpy+0x10>
    ;
  return os;
}
    11d1:	5b                   	pop    %ebx
    11d2:	5d                   	pop    %ebp
    11d3:	c3                   	ret    
    11d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    11da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000011e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    11e0:	55                   	push   %ebp
    11e1:	89 e5                	mov    %esp,%ebp
    11e3:	53                   	push   %ebx
    11e4:	8b 55 08             	mov    0x8(%ebp),%edx
    11e7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    11ea:	0f b6 02             	movzbl (%edx),%eax
    11ed:	0f b6 19             	movzbl (%ecx),%ebx
    11f0:	84 c0                	test   %al,%al
    11f2:	75 1c                	jne    1210 <strcmp+0x30>
    11f4:	eb 2a                	jmp    1220 <strcmp+0x40>
    11f6:	8d 76 00             	lea    0x0(%esi),%esi
    11f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    1200:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    1203:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    1206:	83 c1 01             	add    $0x1,%ecx
    1209:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
    120c:	84 c0                	test   %al,%al
    120e:	74 10                	je     1220 <strcmp+0x40>
    1210:	38 d8                	cmp    %bl,%al
    1212:	74 ec                	je     1200 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    1214:	29 d8                	sub    %ebx,%eax
}
    1216:	5b                   	pop    %ebx
    1217:	5d                   	pop    %ebp
    1218:	c3                   	ret    
    1219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1220:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    1222:	29 d8                	sub    %ebx,%eax
}
    1224:	5b                   	pop    %ebx
    1225:	5d                   	pop    %ebp
    1226:	c3                   	ret    
    1227:	89 f6                	mov    %esi,%esi
    1229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001230 <strlen>:

uint
strlen(const char *s)
{
    1230:	55                   	push   %ebp
    1231:	89 e5                	mov    %esp,%ebp
    1233:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    1236:	80 39 00             	cmpb   $0x0,(%ecx)
    1239:	74 15                	je     1250 <strlen+0x20>
    123b:	31 d2                	xor    %edx,%edx
    123d:	8d 76 00             	lea    0x0(%esi),%esi
    1240:	83 c2 01             	add    $0x1,%edx
    1243:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1247:	89 d0                	mov    %edx,%eax
    1249:	75 f5                	jne    1240 <strlen+0x10>
    ;
  return n;
}
    124b:	5d                   	pop    %ebp
    124c:	c3                   	ret    
    124d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
    1250:	31 c0                	xor    %eax,%eax
}
    1252:	5d                   	pop    %ebp
    1253:	c3                   	ret    
    1254:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    125a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001260 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1260:	55                   	push   %ebp
    1261:	89 e5                	mov    %esp,%ebp
    1263:	57                   	push   %edi
    1264:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1267:	8b 4d 10             	mov    0x10(%ebp),%ecx
    126a:	8b 45 0c             	mov    0xc(%ebp),%eax
    126d:	89 d7                	mov    %edx,%edi
    126f:	fc                   	cld    
    1270:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1272:	89 d0                	mov    %edx,%eax
    1274:	5f                   	pop    %edi
    1275:	5d                   	pop    %ebp
    1276:	c3                   	ret    
    1277:	89 f6                	mov    %esi,%esi
    1279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001280 <strchr>:

char*
strchr(const char *s, char c)
{
    1280:	55                   	push   %ebp
    1281:	89 e5                	mov    %esp,%ebp
    1283:	53                   	push   %ebx
    1284:	8b 45 08             	mov    0x8(%ebp),%eax
    1287:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    128a:	0f b6 10             	movzbl (%eax),%edx
    128d:	84 d2                	test   %dl,%dl
    128f:	74 1d                	je     12ae <strchr+0x2e>
    if(*s == c)
    1291:	38 d3                	cmp    %dl,%bl
    1293:	89 d9                	mov    %ebx,%ecx
    1295:	75 0d                	jne    12a4 <strchr+0x24>
    1297:	eb 17                	jmp    12b0 <strchr+0x30>
    1299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    12a0:	38 ca                	cmp    %cl,%dl
    12a2:	74 0c                	je     12b0 <strchr+0x30>
  for(; *s; s++)
    12a4:	83 c0 01             	add    $0x1,%eax
    12a7:	0f b6 10             	movzbl (%eax),%edx
    12aa:	84 d2                	test   %dl,%dl
    12ac:	75 f2                	jne    12a0 <strchr+0x20>
      return (char*)s;
  return 0;
    12ae:	31 c0                	xor    %eax,%eax
}
    12b0:	5b                   	pop    %ebx
    12b1:	5d                   	pop    %ebp
    12b2:	c3                   	ret    
    12b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    12b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000012c0 <gets>:

char*
gets(char *buf, int max)
{
    12c0:	55                   	push   %ebp
    12c1:	89 e5                	mov    %esp,%ebp
    12c3:	57                   	push   %edi
    12c4:	56                   	push   %esi
    12c5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    12c6:	31 f6                	xor    %esi,%esi
    12c8:	89 f3                	mov    %esi,%ebx
{
    12ca:	83 ec 1c             	sub    $0x1c,%esp
    12cd:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    12d0:	eb 2f                	jmp    1301 <gets+0x41>
    12d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    12d8:	8d 45 e7             	lea    -0x19(%ebp),%eax
    12db:	83 ec 04             	sub    $0x4,%esp
    12de:	6a 01                	push   $0x1
    12e0:	50                   	push   %eax
    12e1:	6a 00                	push   $0x0
    12e3:	e8 32 01 00 00       	call   141a <read>
    if(cc < 1)
    12e8:	83 c4 10             	add    $0x10,%esp
    12eb:	85 c0                	test   %eax,%eax
    12ed:	7e 1c                	jle    130b <gets+0x4b>
      break;
    buf[i++] = c;
    12ef:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    12f3:	83 c7 01             	add    $0x1,%edi
    12f6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    12f9:	3c 0a                	cmp    $0xa,%al
    12fb:	74 23                	je     1320 <gets+0x60>
    12fd:	3c 0d                	cmp    $0xd,%al
    12ff:	74 1f                	je     1320 <gets+0x60>
  for(i=0; i+1 < max; ){
    1301:	83 c3 01             	add    $0x1,%ebx
    1304:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1307:	89 fe                	mov    %edi,%esi
    1309:	7c cd                	jl     12d8 <gets+0x18>
    130b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    130d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    1310:	c6 03 00             	movb   $0x0,(%ebx)
}
    1313:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1316:	5b                   	pop    %ebx
    1317:	5e                   	pop    %esi
    1318:	5f                   	pop    %edi
    1319:	5d                   	pop    %ebp
    131a:	c3                   	ret    
    131b:	90                   	nop
    131c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1320:	8b 75 08             	mov    0x8(%ebp),%esi
    1323:	8b 45 08             	mov    0x8(%ebp),%eax
    1326:	01 de                	add    %ebx,%esi
    1328:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    132a:	c6 03 00             	movb   $0x0,(%ebx)
}
    132d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1330:	5b                   	pop    %ebx
    1331:	5e                   	pop    %esi
    1332:	5f                   	pop    %edi
    1333:	5d                   	pop    %ebp
    1334:	c3                   	ret    
    1335:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001340 <stat>:

int
stat(const char *n, struct stat *st)
{
    1340:	55                   	push   %ebp
    1341:	89 e5                	mov    %esp,%ebp
    1343:	56                   	push   %esi
    1344:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1345:	83 ec 08             	sub    $0x8,%esp
    1348:	6a 00                	push   $0x0
    134a:	ff 75 08             	pushl  0x8(%ebp)
    134d:	e8 f0 00 00 00       	call   1442 <open>
  if(fd < 0)
    1352:	83 c4 10             	add    $0x10,%esp
    1355:	85 c0                	test   %eax,%eax
    1357:	78 27                	js     1380 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1359:	83 ec 08             	sub    $0x8,%esp
    135c:	ff 75 0c             	pushl  0xc(%ebp)
    135f:	89 c3                	mov    %eax,%ebx
    1361:	50                   	push   %eax
    1362:	e8 f3 00 00 00       	call   145a <fstat>
  close(fd);
    1367:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    136a:	89 c6                	mov    %eax,%esi
  close(fd);
    136c:	e8 b9 00 00 00       	call   142a <close>
  return r;
    1371:	83 c4 10             	add    $0x10,%esp
}
    1374:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1377:	89 f0                	mov    %esi,%eax
    1379:	5b                   	pop    %ebx
    137a:	5e                   	pop    %esi
    137b:	5d                   	pop    %ebp
    137c:	c3                   	ret    
    137d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1380:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1385:	eb ed                	jmp    1374 <stat+0x34>
    1387:	89 f6                	mov    %esi,%esi
    1389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001390 <atoi>:

int
atoi(const char *s)
{
    1390:	55                   	push   %ebp
    1391:	89 e5                	mov    %esp,%ebp
    1393:	53                   	push   %ebx
    1394:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1397:	0f be 11             	movsbl (%ecx),%edx
    139a:	8d 42 d0             	lea    -0x30(%edx),%eax
    139d:	3c 09                	cmp    $0x9,%al
  n = 0;
    139f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    13a4:	77 1f                	ja     13c5 <atoi+0x35>
    13a6:	8d 76 00             	lea    0x0(%esi),%esi
    13a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    13b0:	8d 04 80             	lea    (%eax,%eax,4),%eax
    13b3:	83 c1 01             	add    $0x1,%ecx
    13b6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    13ba:	0f be 11             	movsbl (%ecx),%edx
    13bd:	8d 5a d0             	lea    -0x30(%edx),%ebx
    13c0:	80 fb 09             	cmp    $0x9,%bl
    13c3:	76 eb                	jbe    13b0 <atoi+0x20>
  return n;
}
    13c5:	5b                   	pop    %ebx
    13c6:	5d                   	pop    %ebp
    13c7:	c3                   	ret    
    13c8:	90                   	nop
    13c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000013d0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    13d0:	55                   	push   %ebp
    13d1:	89 e5                	mov    %esp,%ebp
    13d3:	56                   	push   %esi
    13d4:	53                   	push   %ebx
    13d5:	8b 5d 10             	mov    0x10(%ebp),%ebx
    13d8:	8b 45 08             	mov    0x8(%ebp),%eax
    13db:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    13de:	85 db                	test   %ebx,%ebx
    13e0:	7e 14                	jle    13f6 <memmove+0x26>
    13e2:	31 d2                	xor    %edx,%edx
    13e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    13e8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    13ec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    13ef:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
    13f2:	39 d3                	cmp    %edx,%ebx
    13f4:	75 f2                	jne    13e8 <memmove+0x18>
  return vdst;
}
    13f6:	5b                   	pop    %ebx
    13f7:	5e                   	pop    %esi
    13f8:	5d                   	pop    %ebp
    13f9:	c3                   	ret    

000013fa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    13fa:	b8 01 00 00 00       	mov    $0x1,%eax
    13ff:	cd 40                	int    $0x40
    1401:	c3                   	ret    

00001402 <exit>:
SYSCALL(exit)
    1402:	b8 02 00 00 00       	mov    $0x2,%eax
    1407:	cd 40                	int    $0x40
    1409:	c3                   	ret    

0000140a <wait>:
SYSCALL(wait)
    140a:	b8 03 00 00 00       	mov    $0x3,%eax
    140f:	cd 40                	int    $0x40
    1411:	c3                   	ret    

00001412 <pipe>:
SYSCALL(pipe)
    1412:	b8 04 00 00 00       	mov    $0x4,%eax
    1417:	cd 40                	int    $0x40
    1419:	c3                   	ret    

0000141a <read>:
SYSCALL(read)
    141a:	b8 05 00 00 00       	mov    $0x5,%eax
    141f:	cd 40                	int    $0x40
    1421:	c3                   	ret    

00001422 <write>:
SYSCALL(write)
    1422:	b8 10 00 00 00       	mov    $0x10,%eax
    1427:	cd 40                	int    $0x40
    1429:	c3                   	ret    

0000142a <close>:
SYSCALL(close)
    142a:	b8 15 00 00 00       	mov    $0x15,%eax
    142f:	cd 40                	int    $0x40
    1431:	c3                   	ret    

00001432 <kill>:
SYSCALL(kill)
    1432:	b8 06 00 00 00       	mov    $0x6,%eax
    1437:	cd 40                	int    $0x40
    1439:	c3                   	ret    

0000143a <exec>:
SYSCALL(exec)
    143a:	b8 07 00 00 00       	mov    $0x7,%eax
    143f:	cd 40                	int    $0x40
    1441:	c3                   	ret    

00001442 <open>:
SYSCALL(open)
    1442:	b8 0f 00 00 00       	mov    $0xf,%eax
    1447:	cd 40                	int    $0x40
    1449:	c3                   	ret    

0000144a <mknod>:
SYSCALL(mknod)
    144a:	b8 11 00 00 00       	mov    $0x11,%eax
    144f:	cd 40                	int    $0x40
    1451:	c3                   	ret    

00001452 <unlink>:
SYSCALL(unlink)
    1452:	b8 12 00 00 00       	mov    $0x12,%eax
    1457:	cd 40                	int    $0x40
    1459:	c3                   	ret    

0000145a <fstat>:
SYSCALL(fstat)
    145a:	b8 08 00 00 00       	mov    $0x8,%eax
    145f:	cd 40                	int    $0x40
    1461:	c3                   	ret    

00001462 <link>:
SYSCALL(link)
    1462:	b8 13 00 00 00       	mov    $0x13,%eax
    1467:	cd 40                	int    $0x40
    1469:	c3                   	ret    

0000146a <mkdir>:
SYSCALL(mkdir)
    146a:	b8 14 00 00 00       	mov    $0x14,%eax
    146f:	cd 40                	int    $0x40
    1471:	c3                   	ret    

00001472 <chdir>:
SYSCALL(chdir)
    1472:	b8 09 00 00 00       	mov    $0x9,%eax
    1477:	cd 40                	int    $0x40
    1479:	c3                   	ret    

0000147a <dup>:
SYSCALL(dup)
    147a:	b8 0a 00 00 00       	mov    $0xa,%eax
    147f:	cd 40                	int    $0x40
    1481:	c3                   	ret    

00001482 <getpid>:
SYSCALL(getpid)
    1482:	b8 0b 00 00 00       	mov    $0xb,%eax
    1487:	cd 40                	int    $0x40
    1489:	c3                   	ret    

0000148a <sbrk>:
SYSCALL(sbrk)
    148a:	b8 0c 00 00 00       	mov    $0xc,%eax
    148f:	cd 40                	int    $0x40
    1491:	c3                   	ret    

00001492 <sleep>:
SYSCALL(sleep)
    1492:	b8 0d 00 00 00       	mov    $0xd,%eax
    1497:	cd 40                	int    $0x40
    1499:	c3                   	ret    

0000149a <uptime>:
SYSCALL(uptime)
    149a:	b8 0e 00 00 00       	mov    $0xe,%eax
    149f:	cd 40                	int    $0x40
    14a1:	c3                   	ret    

000014a2 <getlev>:
SYSCALL(getlev)
    14a2:	b8 16 00 00 00       	mov    $0x16,%eax
    14a7:	cd 40                	int    $0x40
    14a9:	c3                   	ret    

000014aa <yield>:
SYSCALL(yield)
    14aa:	b8 17 00 00 00       	mov    $0x17,%eax
    14af:	cd 40                	int    $0x40
    14b1:	c3                   	ret    

000014b2 <set_cpu_share>:
SYSCALL(set_cpu_share)
    14b2:	b8 18 00 00 00       	mov    $0x18,%eax
    14b7:	cd 40                	int    $0x40
    14b9:	c3                   	ret    

000014ba <thread_create>:
SYSCALL(thread_create)
    14ba:	b8 19 00 00 00       	mov    $0x19,%eax
    14bf:	cd 40                	int    $0x40
    14c1:	c3                   	ret    

000014c2 <thread_exit>:
SYSCALL(thread_exit)
    14c2:	b8 1a 00 00 00       	mov    $0x1a,%eax
    14c7:	cd 40                	int    $0x40
    14c9:	c3                   	ret    

000014ca <thread_join>:
SYSCALL(thread_join)
    14ca:	b8 1b 00 00 00       	mov    $0x1b,%eax
    14cf:	cd 40                	int    $0x40
    14d1:	c3                   	ret    

000014d2 <xem_init>:
SYSCALL(xem_init)
    14d2:	b8 1c 00 00 00       	mov    $0x1c,%eax
    14d7:	cd 40                	int    $0x40
    14d9:	c3                   	ret    

000014da <xem_wait>:
SYSCALL(xem_wait)
    14da:	b8 1d 00 00 00       	mov    $0x1d,%eax
    14df:	cd 40                	int    $0x40
    14e1:	c3                   	ret    

000014e2 <xem_unlock>:
SYSCALL(xem_unlock)
    14e2:	b8 1e 00 00 00       	mov    $0x1e,%eax
    14e7:	cd 40                	int    $0x40
    14e9:	c3                   	ret    

000014ea <pread>:
SYSCALL(pread)
    14ea:	b8 1f 00 00 00       	mov    $0x1f,%eax
    14ef:	cd 40                	int    $0x40
    14f1:	c3                   	ret    

000014f2 <pwrite>:
SYSCALL(pwrite)
    14f2:	b8 20 00 00 00       	mov    $0x20,%eax
    14f7:	cd 40                	int    $0x40
    14f9:	c3                   	ret    
    14fa:	66 90                	xchg   %ax,%ax
    14fc:	66 90                	xchg   %ax,%ax
    14fe:	66 90                	xchg   %ax,%ax

00001500 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1500:	55                   	push   %ebp
    1501:	89 e5                	mov    %esp,%ebp
    1503:	57                   	push   %edi
    1504:	56                   	push   %esi
    1505:	53                   	push   %ebx
    1506:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1509:	85 d2                	test   %edx,%edx
{
    150b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
    150e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    1510:	79 76                	jns    1588 <printint+0x88>
    1512:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    1516:	74 70                	je     1588 <printint+0x88>
    x = -xx;
    1518:	f7 d8                	neg    %eax
    neg = 1;
    151a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1521:	31 f6                	xor    %esi,%esi
    1523:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    1526:	eb 0a                	jmp    1532 <printint+0x32>
    1528:	90                   	nop
    1529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
    1530:	89 fe                	mov    %edi,%esi
    1532:	31 d2                	xor    %edx,%edx
    1534:	8d 7e 01             	lea    0x1(%esi),%edi
    1537:	f7 f1                	div    %ecx
    1539:	0f b6 92 ac 1b 00 00 	movzbl 0x1bac(%edx),%edx
  }while((x /= base) != 0);
    1540:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    1542:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    1545:	75 e9                	jne    1530 <printint+0x30>
  if(neg)
    1547:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    154a:	85 c0                	test   %eax,%eax
    154c:	74 08                	je     1556 <printint+0x56>
    buf[i++] = '-';
    154e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    1553:	8d 7e 02             	lea    0x2(%esi),%edi
    1556:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    155a:	8b 7d c0             	mov    -0x40(%ebp),%edi
    155d:	8d 76 00             	lea    0x0(%esi),%esi
    1560:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
    1563:	83 ec 04             	sub    $0x4,%esp
    1566:	83 ee 01             	sub    $0x1,%esi
    1569:	6a 01                	push   $0x1
    156b:	53                   	push   %ebx
    156c:	57                   	push   %edi
    156d:	88 45 d7             	mov    %al,-0x29(%ebp)
    1570:	e8 ad fe ff ff       	call   1422 <write>

  while(--i >= 0)
    1575:	83 c4 10             	add    $0x10,%esp
    1578:	39 de                	cmp    %ebx,%esi
    157a:	75 e4                	jne    1560 <printint+0x60>
    putc(fd, buf[i]);
}
    157c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    157f:	5b                   	pop    %ebx
    1580:	5e                   	pop    %esi
    1581:	5f                   	pop    %edi
    1582:	5d                   	pop    %ebp
    1583:	c3                   	ret    
    1584:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1588:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    158f:	eb 90                	jmp    1521 <printint+0x21>
    1591:	eb 0d                	jmp    15a0 <printf>
    1593:	90                   	nop
    1594:	90                   	nop
    1595:	90                   	nop
    1596:	90                   	nop
    1597:	90                   	nop
    1598:	90                   	nop
    1599:	90                   	nop
    159a:	90                   	nop
    159b:	90                   	nop
    159c:	90                   	nop
    159d:	90                   	nop
    159e:	90                   	nop
    159f:	90                   	nop

000015a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    15a0:	55                   	push   %ebp
    15a1:	89 e5                	mov    %esp,%ebp
    15a3:	57                   	push   %edi
    15a4:	56                   	push   %esi
    15a5:	53                   	push   %ebx
    15a6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    15a9:	8b 75 0c             	mov    0xc(%ebp),%esi
    15ac:	0f b6 1e             	movzbl (%esi),%ebx
    15af:	84 db                	test   %bl,%bl
    15b1:	0f 84 b3 00 00 00    	je     166a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
    15b7:	8d 45 10             	lea    0x10(%ebp),%eax
    15ba:	83 c6 01             	add    $0x1,%esi
  state = 0;
    15bd:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
    15bf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    15c2:	eb 2f                	jmp    15f3 <printf+0x53>
    15c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    15c8:	83 f8 25             	cmp    $0x25,%eax
    15cb:	0f 84 a7 00 00 00    	je     1678 <printf+0xd8>
  write(fd, &c, 1);
    15d1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    15d4:	83 ec 04             	sub    $0x4,%esp
    15d7:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    15da:	6a 01                	push   $0x1
    15dc:	50                   	push   %eax
    15dd:	ff 75 08             	pushl  0x8(%ebp)
    15e0:	e8 3d fe ff ff       	call   1422 <write>
    15e5:	83 c4 10             	add    $0x10,%esp
    15e8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
    15eb:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    15ef:	84 db                	test   %bl,%bl
    15f1:	74 77                	je     166a <printf+0xca>
    if(state == 0){
    15f3:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
    15f5:	0f be cb             	movsbl %bl,%ecx
    15f8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    15fb:	74 cb                	je     15c8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    15fd:	83 ff 25             	cmp    $0x25,%edi
    1600:	75 e6                	jne    15e8 <printf+0x48>
      if(c == 'd'){
    1602:	83 f8 64             	cmp    $0x64,%eax
    1605:	0f 84 05 01 00 00    	je     1710 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    160b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    1611:	83 f9 70             	cmp    $0x70,%ecx
    1614:	74 72                	je     1688 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1616:	83 f8 73             	cmp    $0x73,%eax
    1619:	0f 84 99 00 00 00    	je     16b8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    161f:	83 f8 63             	cmp    $0x63,%eax
    1622:	0f 84 08 01 00 00    	je     1730 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1628:	83 f8 25             	cmp    $0x25,%eax
    162b:	0f 84 ef 00 00 00    	je     1720 <printf+0x180>
  write(fd, &c, 1);
    1631:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1634:	83 ec 04             	sub    $0x4,%esp
    1637:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    163b:	6a 01                	push   $0x1
    163d:	50                   	push   %eax
    163e:	ff 75 08             	pushl  0x8(%ebp)
    1641:	e8 dc fd ff ff       	call   1422 <write>
    1646:	83 c4 0c             	add    $0xc,%esp
    1649:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    164c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    164f:	6a 01                	push   $0x1
    1651:	50                   	push   %eax
    1652:	ff 75 08             	pushl  0x8(%ebp)
    1655:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1658:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    165a:	e8 c3 fd ff ff       	call   1422 <write>
  for(i = 0; fmt[i]; i++){
    165f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
    1663:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    1666:	84 db                	test   %bl,%bl
    1668:	75 89                	jne    15f3 <printf+0x53>
    }
  }
}
    166a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    166d:	5b                   	pop    %ebx
    166e:	5e                   	pop    %esi
    166f:	5f                   	pop    %edi
    1670:	5d                   	pop    %ebp
    1671:	c3                   	ret    
    1672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
    1678:	bf 25 00 00 00       	mov    $0x25,%edi
    167d:	e9 66 ff ff ff       	jmp    15e8 <printf+0x48>
    1682:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    1688:	83 ec 0c             	sub    $0xc,%esp
    168b:	b9 10 00 00 00       	mov    $0x10,%ecx
    1690:	6a 00                	push   $0x0
    1692:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    1695:	8b 45 08             	mov    0x8(%ebp),%eax
    1698:	8b 17                	mov    (%edi),%edx
    169a:	e8 61 fe ff ff       	call   1500 <printint>
        ap++;
    169f:	89 f8                	mov    %edi,%eax
    16a1:	83 c4 10             	add    $0x10,%esp
      state = 0;
    16a4:	31 ff                	xor    %edi,%edi
        ap++;
    16a6:	83 c0 04             	add    $0x4,%eax
    16a9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    16ac:	e9 37 ff ff ff       	jmp    15e8 <printf+0x48>
    16b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    16b8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    16bb:	8b 08                	mov    (%eax),%ecx
        ap++;
    16bd:	83 c0 04             	add    $0x4,%eax
    16c0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    16c3:	85 c9                	test   %ecx,%ecx
    16c5:	0f 84 8e 00 00 00    	je     1759 <printf+0x1b9>
        while(*s != 0){
    16cb:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
    16ce:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
    16d0:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
    16d2:	84 c0                	test   %al,%al
    16d4:	0f 84 0e ff ff ff    	je     15e8 <printf+0x48>
    16da:	89 75 d0             	mov    %esi,-0x30(%ebp)
    16dd:	89 de                	mov    %ebx,%esi
    16df:	8b 5d 08             	mov    0x8(%ebp),%ebx
    16e2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
    16e5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    16e8:	83 ec 04             	sub    $0x4,%esp
          s++;
    16eb:	83 c6 01             	add    $0x1,%esi
    16ee:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    16f1:	6a 01                	push   $0x1
    16f3:	57                   	push   %edi
    16f4:	53                   	push   %ebx
    16f5:	e8 28 fd ff ff       	call   1422 <write>
        while(*s != 0){
    16fa:	0f b6 06             	movzbl (%esi),%eax
    16fd:	83 c4 10             	add    $0x10,%esp
    1700:	84 c0                	test   %al,%al
    1702:	75 e4                	jne    16e8 <printf+0x148>
    1704:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
    1707:	31 ff                	xor    %edi,%edi
    1709:	e9 da fe ff ff       	jmp    15e8 <printf+0x48>
    170e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
    1710:	83 ec 0c             	sub    $0xc,%esp
    1713:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1718:	6a 01                	push   $0x1
    171a:	e9 73 ff ff ff       	jmp    1692 <printf+0xf2>
    171f:	90                   	nop
  write(fd, &c, 1);
    1720:	83 ec 04             	sub    $0x4,%esp
    1723:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    1726:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1729:	6a 01                	push   $0x1
    172b:	e9 21 ff ff ff       	jmp    1651 <printf+0xb1>
        putc(fd, *ap);
    1730:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
    1733:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    1736:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
    1738:	6a 01                	push   $0x1
        ap++;
    173a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
    173d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    1740:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1743:	50                   	push   %eax
    1744:	ff 75 08             	pushl  0x8(%ebp)
    1747:	e8 d6 fc ff ff       	call   1422 <write>
        ap++;
    174c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    174f:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1752:	31 ff                	xor    %edi,%edi
    1754:	e9 8f fe ff ff       	jmp    15e8 <printf+0x48>
          s = "(null)";
    1759:	bb a4 1b 00 00       	mov    $0x1ba4,%ebx
        while(*s != 0){
    175e:	b8 28 00 00 00       	mov    $0x28,%eax
    1763:	e9 72 ff ff ff       	jmp    16da <printf+0x13a>
    1768:	66 90                	xchg   %ax,%ax
    176a:	66 90                	xchg   %ax,%ax
    176c:	66 90                	xchg   %ax,%ax
    176e:	66 90                	xchg   %ax,%ax

00001770 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1770:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1771:	a1 38 24 00 00       	mov    0x2438,%eax
{
    1776:	89 e5                	mov    %esp,%ebp
    1778:	57                   	push   %edi
    1779:	56                   	push   %esi
    177a:	53                   	push   %ebx
    177b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    177e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1781:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1788:	39 c8                	cmp    %ecx,%eax
    178a:	8b 10                	mov    (%eax),%edx
    178c:	73 32                	jae    17c0 <free+0x50>
    178e:	39 d1                	cmp    %edx,%ecx
    1790:	72 04                	jb     1796 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1792:	39 d0                	cmp    %edx,%eax
    1794:	72 32                	jb     17c8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1796:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1799:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    179c:	39 fa                	cmp    %edi,%edx
    179e:	74 30                	je     17d0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    17a0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    17a3:	8b 50 04             	mov    0x4(%eax),%edx
    17a6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    17a9:	39 f1                	cmp    %esi,%ecx
    17ab:	74 3a                	je     17e7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    17ad:	89 08                	mov    %ecx,(%eax)
  freep = p;
    17af:	a3 38 24 00 00       	mov    %eax,0x2438
}
    17b4:	5b                   	pop    %ebx
    17b5:	5e                   	pop    %esi
    17b6:	5f                   	pop    %edi
    17b7:	5d                   	pop    %ebp
    17b8:	c3                   	ret    
    17b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    17c0:	39 d0                	cmp    %edx,%eax
    17c2:	72 04                	jb     17c8 <free+0x58>
    17c4:	39 d1                	cmp    %edx,%ecx
    17c6:	72 ce                	jb     1796 <free+0x26>
{
    17c8:	89 d0                	mov    %edx,%eax
    17ca:	eb bc                	jmp    1788 <free+0x18>
    17cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    17d0:	03 72 04             	add    0x4(%edx),%esi
    17d3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    17d6:	8b 10                	mov    (%eax),%edx
    17d8:	8b 12                	mov    (%edx),%edx
    17da:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    17dd:	8b 50 04             	mov    0x4(%eax),%edx
    17e0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    17e3:	39 f1                	cmp    %esi,%ecx
    17e5:	75 c6                	jne    17ad <free+0x3d>
    p->s.size += bp->s.size;
    17e7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    17ea:	a3 38 24 00 00       	mov    %eax,0x2438
    p->s.size += bp->s.size;
    17ef:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    17f2:	8b 53 f8             	mov    -0x8(%ebx),%edx
    17f5:	89 10                	mov    %edx,(%eax)
}
    17f7:	5b                   	pop    %ebx
    17f8:	5e                   	pop    %esi
    17f9:	5f                   	pop    %edi
    17fa:	5d                   	pop    %ebp
    17fb:	c3                   	ret    
    17fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001800 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1800:	55                   	push   %ebp
    1801:	89 e5                	mov    %esp,%ebp
    1803:	57                   	push   %edi
    1804:	56                   	push   %esi
    1805:	53                   	push   %ebx
    1806:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1809:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    180c:	8b 15 38 24 00 00    	mov    0x2438,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1812:	8d 78 07             	lea    0x7(%eax),%edi
    1815:	c1 ef 03             	shr    $0x3,%edi
    1818:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    181b:	85 d2                	test   %edx,%edx
    181d:	0f 84 9d 00 00 00    	je     18c0 <malloc+0xc0>
    1823:	8b 02                	mov    (%edx),%eax
    1825:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1828:	39 cf                	cmp    %ecx,%edi
    182a:	76 6c                	jbe    1898 <malloc+0x98>
    182c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1832:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1837:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    183a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1841:	eb 0e                	jmp    1851 <malloc+0x51>
    1843:	90                   	nop
    1844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1848:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    184a:	8b 48 04             	mov    0x4(%eax),%ecx
    184d:	39 f9                	cmp    %edi,%ecx
    184f:	73 47                	jae    1898 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1851:	39 05 38 24 00 00    	cmp    %eax,0x2438
    1857:	89 c2                	mov    %eax,%edx
    1859:	75 ed                	jne    1848 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    185b:	83 ec 0c             	sub    $0xc,%esp
    185e:	56                   	push   %esi
    185f:	e8 26 fc ff ff       	call   148a <sbrk>
  if(p == (char*)-1)
    1864:	83 c4 10             	add    $0x10,%esp
    1867:	83 f8 ff             	cmp    $0xffffffff,%eax
    186a:	74 1c                	je     1888 <malloc+0x88>
  hp->s.size = nu;
    186c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    186f:	83 ec 0c             	sub    $0xc,%esp
    1872:	83 c0 08             	add    $0x8,%eax
    1875:	50                   	push   %eax
    1876:	e8 f5 fe ff ff       	call   1770 <free>
  return freep;
    187b:	8b 15 38 24 00 00    	mov    0x2438,%edx
      if((p = morecore(nunits)) == 0)
    1881:	83 c4 10             	add    $0x10,%esp
    1884:	85 d2                	test   %edx,%edx
    1886:	75 c0                	jne    1848 <malloc+0x48>
        return 0;
  }
}
    1888:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    188b:	31 c0                	xor    %eax,%eax
}
    188d:	5b                   	pop    %ebx
    188e:	5e                   	pop    %esi
    188f:	5f                   	pop    %edi
    1890:	5d                   	pop    %ebp
    1891:	c3                   	ret    
    1892:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1898:	39 cf                	cmp    %ecx,%edi
    189a:	74 54                	je     18f0 <malloc+0xf0>
        p->s.size -= nunits;
    189c:	29 f9                	sub    %edi,%ecx
    189e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    18a1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    18a4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    18a7:	89 15 38 24 00 00    	mov    %edx,0x2438
}
    18ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    18b0:	83 c0 08             	add    $0x8,%eax
}
    18b3:	5b                   	pop    %ebx
    18b4:	5e                   	pop    %esi
    18b5:	5f                   	pop    %edi
    18b6:	5d                   	pop    %ebp
    18b7:	c3                   	ret    
    18b8:	90                   	nop
    18b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    18c0:	c7 05 38 24 00 00 3c 	movl   $0x243c,0x2438
    18c7:	24 00 00 
    18ca:	c7 05 3c 24 00 00 3c 	movl   $0x243c,0x243c
    18d1:	24 00 00 
    base.s.size = 0;
    18d4:	b8 3c 24 00 00       	mov    $0x243c,%eax
    18d9:	c7 05 40 24 00 00 00 	movl   $0x0,0x2440
    18e0:	00 00 00 
    18e3:	e9 44 ff ff ff       	jmp    182c <malloc+0x2c>
    18e8:	90                   	nop
    18e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    18f0:	8b 08                	mov    (%eax),%ecx
    18f2:	89 0a                	mov    %ecx,(%edx)
    18f4:	eb b1                	jmp    18a7 <malloc+0xa7>
