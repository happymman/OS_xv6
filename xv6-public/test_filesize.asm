
_test_filesize:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fcntl.h"

#define BUFSIZE (512)
#define STRESSCNT (4)

int main(int argc, char *argv[]) {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	8d 9d e8 fb ff ff    	lea    -0x418(%ebp),%ebx
  char c[BUFSIZE];
  char r[BUFSIZE];
  struct stat st1;
  struct stat stt[STRESSCNT * 2];

  for (i = 0; i < BUFSIZE; i++) {
  17:	31 c9                	xor    %ecx,%ecx
    c[i] = 'a' + (i % 26);
  19:	be 4f ec c4 4e       	mov    $0x4ec4ec4f,%esi
int main(int argc, char *argv[]) {
  1e:	81 ec d8 04 00 00    	sub    $0x4d8,%esp
  24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c[i] = 'a' + (i % 26);
  28:	89 c8                	mov    %ecx,%eax
  2a:	f7 e6                	mul    %esi
  2c:	89 c8                	mov    %ecx,%eax
  2e:	c1 ea 03             	shr    $0x3,%edx
  31:	6b d2 1a             	imul   $0x1a,%edx,%edx
  34:	29 d0                	sub    %edx,%eax
  36:	83 c0 61             	add    $0x61,%eax
  39:	88 04 0b             	mov    %al,(%ebx,%ecx,1)
  for (i = 0; i < BUFSIZE; i++) {
  3c:	83 c1 01             	add    $0x1,%ecx
  3f:	81 f9 00 02 00 00    	cmp    $0x200,%ecx
  45:	75 e1                	jne    28 <main+0x28>
  }

  printf(1, "create test\n");
  47:	83 ec 08             	sub    $0x8,%esp
  4a:	68 18 0b 00 00       	push   $0xb18
  4f:	6a 01                	push   $0x1
  51:	e8 6a 07 00 00       	call   7c0 <printf>
  fd = open("testfile", O_CREATE | O_RDWR);
  56:	59                   	pop    %ecx
  57:	5e                   	pop    %esi
  58:	68 02 02 00 00       	push   $0x202
  5d:	68 25 0b 00 00       	push   $0xb25
  for (i = 0; i < 1024 * 16 * 2; i++) {
  62:	31 f6                	xor    %esi,%esi
  fd = open("testfile", O_CREATE | O_RDWR);
  64:	e8 f9 05 00 00       	call   662 <open>
  69:	83 c4 10             	add    $0x10,%esp
  6c:	89 c7                	mov    %eax,%edi
  6e:	eb 22                	jmp    92 <main+0x92>
    if (!(i % (1024 * 8))) {
      k = i * BUFSIZE;
      printf(1, "%d\n", k);
    }
    if (write(fd, c, BUFSIZE) == -1) {
  70:	83 ec 04             	sub    $0x4,%esp
  73:	68 00 02 00 00       	push   $0x200
  78:	53                   	push   %ebx
  79:	57                   	push   %edi
  7a:	e8 c3 05 00 00       	call   642 <write>
  7f:	83 c4 10             	add    $0x10,%esp
  82:	83 f8 ff             	cmp    $0xffffffff,%eax
  85:	74 2d                	je     b4 <main+0xb4>
  for (i = 0; i < 1024 * 16 * 2; i++) {
  87:	83 c6 01             	add    $0x1,%esi
  8a:	81 fe 00 80 00 00    	cmp    $0x8000,%esi
  90:	74 37                	je     c9 <main+0xc9>
    if (!(i % (1024 * 8))) {
  92:	f7 c6 ff 1f 00 00    	test   $0x1fff,%esi
  98:	75 d6                	jne    70 <main+0x70>
      printf(1, "%d\n", k);
  9a:	89 f0                	mov    %esi,%eax
  9c:	83 ec 04             	sub    $0x4,%esp
  9f:	c1 e0 09             	shl    $0x9,%eax
  a2:	50                   	push   %eax
  a3:	68 b6 0b 00 00       	push   $0xbb6
  a8:	6a 01                	push   $0x1
  aa:	e8 11 07 00 00       	call   7c0 <printf>
  af:	83 c4 10             	add    $0x10,%esp
  b2:	eb bc                	jmp    70 <main+0x70>
      printf(1, "error: write failed at %d\n", i);
  b4:	83 ec 04             	sub    $0x4,%esp
  b7:	56                   	push   %esi
  b8:	68 2e 0b 00 00       	push   $0xb2e
  bd:	6a 01                	push   $0x1
  bf:	e8 fc 06 00 00       	call   7c0 <printf>
      exit();
  c4:	e8 59 05 00 00       	call   622 <exit>
    }
  }
  close(fd);
  c9:	83 ec 0c             	sub    $0xc,%esp
  cc:	57                   	push   %edi
  cd:	e8 78 05 00 00       	call   64a <close>
  k = i * BUFSIZE;
  printf(1, "total write: %d\n", k);
  d2:	83 c4 0c             	add    $0xc,%esp
  d5:	68 00 00 00 01       	push   $0x1000000
  da:	68 49 0b 00 00       	push   $0xb49
  df:	6a 01                	push   $0x1
  e1:	e8 da 06 00 00       	call   7c0 <printf>
  stat("testfile", &st1);
  e6:	58                   	pop    %eax
  e7:	8d 85 34 fb ff ff    	lea    -0x4cc(%ebp),%eax
  ed:	5a                   	pop    %edx
  ee:	50                   	push   %eax
  ef:	68 25 0b 00 00       	push   $0xb25
  f4:	e8 67 04 00 00       	call   560 <stat>
  printf(1, "file size: %d\n", st1.size);
  f9:	83 c4 0c             	add    $0xc,%esp
  fc:	ff b5 44 fb ff ff    	pushl  -0x4bc(%ebp)
 102:	68 19 0c 00 00       	push   $0xc19
 107:	6a 01                	push   $0x1
 109:	e8 b2 06 00 00       	call   7c0 <printf>
  printf(1, "create test passed\n");
 10e:	59                   	pop    %ecx
 10f:	5e                   	pop    %esi
 110:	68 5a 0b 00 00       	push   $0xb5a
 115:	6a 01                	push   $0x1
  

  printf(1, "read test\n");
  fd = open("testfile", O_RDONLY);
  for (i = 0; i < 1024 * 16 * 2; i++) {
 117:	31 f6                	xor    %esi,%esi
  printf(1, "create test passed\n");
 119:	e8 a2 06 00 00       	call   7c0 <printf>
  printf(1, "read test\n");
 11e:	5f                   	pop    %edi
 11f:	58                   	pop    %eax
 120:	68 6e 0b 00 00       	push   $0xb6e
 125:	6a 01                	push   $0x1
 127:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
 12d:	e8 8e 06 00 00       	call   7c0 <printf>
  fd = open("testfile", O_RDONLY);
 132:	58                   	pop    %eax
 133:	5a                   	pop    %edx
 134:	6a 00                	push   $0x0
 136:	68 25 0b 00 00       	push   $0xb25
 13b:	e8 22 05 00 00       	call   662 <open>
 140:	83 c4 10             	add    $0x10,%esp
 143:	89 85 24 fb ff ff    	mov    %eax,-0x4dc(%ebp)
    if (!(i % (1024 * 8))) {
 149:	f7 c6 ff 1f 00 00    	test   $0x1fff,%esi
 14f:	74 54                	je     1a5 <main+0x1a5>
      k = i * BUFSIZE;
      printf(1, "%d\n", k);
    }
    if (read(fd, r, BUFSIZE) == -1) {
 151:	50                   	push   %eax
 152:	68 00 02 00 00       	push   $0x200
 157:	57                   	push   %edi
 158:	ff b5 24 fb ff ff    	pushl  -0x4dc(%ebp)
 15e:	e8 d7 04 00 00       	call   63a <read>
 163:	83 c4 10             	add    $0x10,%esp
 166:	83 c0 01             	add    $0x1,%eax
 169:	0f 84 34 01 00 00    	je     2a3 <main+0x2a3>
      printf(1, "error: read failed\n");
      exit();
    }
    for (j = 0; j < BUFSIZE; j++) {
 16f:	31 c0                	xor    %eax,%eax
 171:	eb 0f                	jmp    182 <main+0x182>
 173:	90                   	nop
 174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 178:	83 c0 01             	add    $0x1,%eax
 17b:	3d 00 02 00 00       	cmp    $0x200,%eax
 180:	74 3b                	je     1bd <main+0x1bd>
      if (r[j] != c[j]) {
 182:	0f b6 0c 03          	movzbl (%ebx,%eax,1),%ecx
 186:	38 0c 07             	cmp    %cl,(%edi,%eax,1)
 189:	74 ed                	je     178 <main+0x178>
        printf(1, "error: wrong write at %d %c\n", i, *r);
 18b:	0f be 85 e8 fd ff ff 	movsbl -0x218(%ebp),%eax
 192:	50                   	push   %eax
 193:	56                   	push   %esi
 194:	68 8d 0b 00 00       	push   $0xb8d
 199:	6a 01                	push   $0x1
 19b:	e8 20 06 00 00       	call   7c0 <printf>
        exit();
 1a0:	e8 7d 04 00 00       	call   622 <exit>
      printf(1, "%d\n", k);
 1a5:	50                   	push   %eax
 1a6:	89 f0                	mov    %esi,%eax
 1a8:	c1 e0 09             	shl    $0x9,%eax
 1ab:	50                   	push   %eax
 1ac:	68 b6 0b 00 00       	push   $0xbb6
 1b1:	6a 01                	push   $0x1
 1b3:	e8 08 06 00 00       	call   7c0 <printf>
 1b8:	83 c4 10             	add    $0x10,%esp
 1bb:	eb 94                	jmp    151 <main+0x151>
  for (i = 0; i < 1024 * 16 * 2; i++) {
 1bd:	83 c6 01             	add    $0x1,%esi
 1c0:	81 fe 00 80 00 00    	cmp    $0x8000,%esi
 1c6:	75 81                	jne    149 <main+0x149>
      }
    }
  }
  close(fd);
 1c8:	83 ec 0c             	sub    $0xc,%esp
 1cb:	ff b5 24 fb ff ff    	pushl  -0x4dc(%ebp)
 1d1:	e8 74 04 00 00       	call   64a <close>
  k = i * BUFSIZE;
  printf(1, "total read: %d\n", k);
 1d6:	83 c4 0c             	add    $0xc,%esp
 1d9:	68 00 00 00 01       	push   $0x1000000
 1de:	68 aa 0b 00 00       	push   $0xbaa
 1e3:	6a 01                	push   $0x1
 1e5:	e8 d6 05 00 00       	call   7c0 <printf>
  printf(1, "read test passed\n");
 1ea:	5e                   	pop    %esi
 1eb:	5f                   	pop    %edi
 1ec:	68 ba 0b 00 00       	push   $0xbba
 1f1:	6a 01                	push   $0x1
 1f3:	e8 c8 05 00 00       	call   7c0 <printf>

  if (unlink("testfile") == -1) {
 1f8:	c7 04 24 25 0b 00 00 	movl   $0xb25,(%esp)
 1ff:	e8 6e 04 00 00       	call   672 <unlink>
 204:	83 c4 10             	add    $0x10,%esp
 207:	83 c0 01             	add    $0x1,%eax
 20a:	0f 84 9f 01 00 00    	je     3af <main+0x3af>
    printf(1, "error: delete file failed\n");
    exit();
  }

  printf(1, "stress test\n");
 210:	51                   	push   %ecx
 211:	51                   	push   %ecx
 212:	68 e7 0b 00 00       	push   $0xbe7
 217:	6a 01                	push   $0x1
 219:	e8 a2 05 00 00       	call   7c0 <printf>
 21e:	8d 85 48 fb ff ff    	lea    -0x4b8(%ebp),%eax
 224:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < 4; i++) {
 227:	c7 85 24 fb ff ff 00 	movl   $0x0,-0x4dc(%ebp)
 22e:	00 00 00 
 231:	89 85 20 fb ff ff    	mov    %eax,-0x4e0(%ebp)
    fd = open("stressfile", O_CREATE | O_RDWR);
 237:	50                   	push   %eax
 238:	50                   	push   %eax
    printf(1, "stressfile created\n");
    for (j = 0; j < 1024 * 16 * 2; j++) {
 239:	31 f6                	xor    %esi,%esi
    fd = open("stressfile", O_CREATE | O_RDWR);
 23b:	68 02 02 00 00       	push   $0x202
 240:	68 f4 0b 00 00       	push   $0xbf4
 245:	e8 18 04 00 00       	call   662 <open>
 24a:	89 c7                	mov    %eax,%edi
    printf(1, "stressfile created\n");
 24c:	58                   	pop    %eax
 24d:	5a                   	pop    %edx
 24e:	68 ff 0b 00 00       	push   $0xbff
 253:	6a 01                	push   $0x1
 255:	e8 66 05 00 00       	call   7c0 <printf>
 25a:	83 c4 10             	add    $0x10,%esp
 25d:	eb 24                	jmp    283 <main+0x283>
      if (!(j % (1024 * 8))) {
	k = j * BUFSIZE;
	printf(1, "%d\n", k);
      }
      if (write(fd, c, BUFSIZE) == -1) {
 25f:	50                   	push   %eax
 260:	68 00 02 00 00       	push   $0x200
 265:	53                   	push   %ebx
 266:	57                   	push   %edi
 267:	e8 d6 03 00 00       	call   642 <write>
 26c:	83 c4 10             	add    $0x10,%esp
 26f:	83 c0 01             	add    $0x1,%eax
 272:	0f 84 1f 01 00 00    	je     397 <main+0x397>
    for (j = 0; j < 1024 * 16 * 2; j++) {
 278:	83 c6 01             	add    $0x1,%esi
 27b:	81 fe 00 80 00 00    	cmp    $0x8000,%esi
 281:	74 33                	je     2b6 <main+0x2b6>
      if (!(j % (1024 * 8))) {
 283:	f7 c6 ff 1f 00 00    	test   $0x1fff,%esi
 289:	75 d4                	jne    25f <main+0x25f>
	printf(1, "%d\n", k);
 28b:	50                   	push   %eax
 28c:	89 f0                	mov    %esi,%eax
 28e:	c1 e0 09             	shl    $0x9,%eax
 291:	50                   	push   %eax
 292:	68 b6 0b 00 00       	push   $0xbb6
 297:	6a 01                	push   $0x1
 299:	e8 22 05 00 00       	call   7c0 <printf>
 29e:	83 c4 10             	add    $0x10,%esp
 2a1:	eb bc                	jmp    25f <main+0x25f>
      printf(1, "error: read failed\n");
 2a3:	50                   	push   %eax
 2a4:	50                   	push   %eax
 2a5:	68 79 0b 00 00       	push   $0xb79
 2aa:	6a 01                	push   $0x1
 2ac:	e8 0f 05 00 00       	call   7c0 <printf>
      exit();
 2b1:	e8 6c 03 00 00       	call   622 <exit>
	printf(1, "error: write failed at %d\n", i);
	exit();
      }
    }
    close(fd);
 2b6:	83 ec 0c             	sub    $0xc,%esp
 2b9:	57                   	push   %edi
 2ba:	e8 8b 03 00 00       	call   64a <close>
    k = j * BUFSIZE;
    printf(1, "total write: %d\n", k);
 2bf:	83 c4 0c             	add    $0xc,%esp
 2c2:	68 00 00 00 01       	push   $0x1000000
 2c7:	68 49 0b 00 00       	push   $0xb49
 2cc:	6a 01                	push   $0x1
 2ce:	e8 ed 04 00 00       	call   7c0 <printf>
    stat("stressfile", &stt[i*2]);
 2d3:	8b bd 20 fb ff ff    	mov    -0x4e0(%ebp),%edi
 2d9:	58                   	pop    %eax
 2da:	5a                   	pop    %edx
 2db:	57                   	push   %edi
 2dc:	68 f4 0b 00 00       	push   $0xbf4
 2e1:	e8 7a 02 00 00       	call   560 <stat>
    printf(1, "stressfile size: %d\n", stt[i*2].size);
 2e6:	83 c4 0c             	add    $0xc,%esp
 2e9:	ff 77 10             	pushl  0x10(%edi)
 2ec:	68 13 0c 00 00       	push   $0xc13
 2f1:	6a 01                	push   $0x1
 2f3:	e8 c8 04 00 00       	call   7c0 <printf>
    if (unlink("stressfile") == -1) {
 2f8:	c7 04 24 f4 0b 00 00 	movl   $0xbf4,(%esp)
 2ff:	e8 6e 03 00 00       	call   672 <unlink>
 304:	83 c4 10             	add    $0x10,%esp
 307:	83 c0 01             	add    $0x1,%eax
 30a:	0f 84 9f 00 00 00    	je     3af <main+0x3af>
      printf(1, "error: delete file failed\n");
      exit();
    }
    printf(1, "stress file deleted\n");
 310:	52                   	push   %edx
 311:	52                   	push   %edx
 312:	68 28 0c 00 00       	push   $0xc28
 317:	6a 01                	push   $0x1
 319:	e8 a2 04 00 00       	call   7c0 <printf>
    stat("stressfile", &stt[i*2+1]);
 31e:	59                   	pop    %ecx
 31f:	8d 47 14             	lea    0x14(%edi),%eax
 322:	89 bd 20 fb ff ff    	mov    %edi,-0x4e0(%ebp)
 328:	5e                   	pop    %esi
 329:	50                   	push   %eax
 32a:	68 f4 0b 00 00       	push   $0xbf4
 32f:	e8 2c 02 00 00       	call   560 <stat>
    printf(1, "stressfile size: %d\n", stt[i*2+1]);
 334:	8b 85 24 fb ff ff    	mov    -0x4dc(%ebp),%eax
 33a:	57                   	push   %edi
 33b:	b9 05 00 00 00       	mov    $0x5,%ecx
 340:	57                   	push   %edi
 341:	89 c7                	mov    %eax,%edi
 343:	01 c7                	add    %eax,%edi
 345:	89 f8                	mov    %edi,%eax
 347:	89 e7                	mov    %esp,%edi
 349:	83 c0 01             	add    $0x1,%eax
 34c:	6b c0 14             	imul   $0x14,%eax,%eax
 34f:	8d b4 05 48 fb ff ff 	lea    -0x4b8(%ebp,%eax,1),%esi
 356:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
 358:	68 13 0c 00 00       	push   $0xc13
 35d:	6a 01                	push   $0x1
 35f:	e8 5c 04 00 00       	call   7c0 <printf>
  for (i = 0; i < 4; i++) {
 364:	83 85 24 fb ff ff 01 	addl   $0x1,-0x4dc(%ebp)
 36b:	83 85 20 fb ff ff 28 	addl   $0x28,-0x4e0(%ebp)
 372:	83 c4 20             	add    $0x20,%esp
 375:	8b 85 24 fb ff ff    	mov    -0x4dc(%ebp),%eax
 37b:	83 f8 04             	cmp    $0x4,%eax
 37e:	0f 85 b3 fe ff ff    	jne    237 <main+0x237>
  }
  printf(1, "stress test passed\n");
 384:	50                   	push   %eax
 385:	50                   	push   %eax
 386:	68 3d 0c 00 00       	push   $0xc3d
 38b:	6a 01                	push   $0x1
 38d:	e8 2e 04 00 00       	call   7c0 <printf>
  exit();
 392:	e8 8b 02 00 00       	call   622 <exit>
	printf(1, "error: write failed at %d\n", i);
 397:	51                   	push   %ecx
 398:	ff b5 24 fb ff ff    	pushl  -0x4dc(%ebp)
 39e:	68 2e 0b 00 00       	push   $0xb2e
 3a3:	6a 01                	push   $0x1
 3a5:	e8 16 04 00 00       	call   7c0 <printf>
	exit();
 3aa:	e8 73 02 00 00       	call   622 <exit>
    printf(1, "error: delete file failed\n");
 3af:	53                   	push   %ebx
 3b0:	53                   	push   %ebx
 3b1:	68 cc 0b 00 00       	push   $0xbcc
 3b6:	6a 01                	push   $0x1
 3b8:	e8 03 04 00 00       	call   7c0 <printf>
    exit();
 3bd:	e8 60 02 00 00       	call   622 <exit>
 3c2:	66 90                	xchg   %ax,%ax
 3c4:	66 90                	xchg   %ax,%ax
 3c6:	66 90                	xchg   %ax,%ax
 3c8:	66 90                	xchg   %ax,%ax
 3ca:	66 90                	xchg   %ax,%ax
 3cc:	66 90                	xchg   %ax,%ax
 3ce:	66 90                	xchg   %ax,%ax

000003d0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	53                   	push   %ebx
 3d4:	8b 45 08             	mov    0x8(%ebp),%eax
 3d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 3da:	89 c2                	mov    %eax,%edx
 3dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3e0:	83 c1 01             	add    $0x1,%ecx
 3e3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 3e7:	83 c2 01             	add    $0x1,%edx
 3ea:	84 db                	test   %bl,%bl
 3ec:	88 5a ff             	mov    %bl,-0x1(%edx)
 3ef:	75 ef                	jne    3e0 <strcpy+0x10>
    ;
  return os;
}
 3f1:	5b                   	pop    %ebx
 3f2:	5d                   	pop    %ebp
 3f3:	c3                   	ret    
 3f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000400 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	53                   	push   %ebx
 404:	8b 55 08             	mov    0x8(%ebp),%edx
 407:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 40a:	0f b6 02             	movzbl (%edx),%eax
 40d:	0f b6 19             	movzbl (%ecx),%ebx
 410:	84 c0                	test   %al,%al
 412:	75 1c                	jne    430 <strcmp+0x30>
 414:	eb 2a                	jmp    440 <strcmp+0x40>
 416:	8d 76 00             	lea    0x0(%esi),%esi
 419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 420:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 423:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 426:	83 c1 01             	add    $0x1,%ecx
 429:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 42c:	84 c0                	test   %al,%al
 42e:	74 10                	je     440 <strcmp+0x40>
 430:	38 d8                	cmp    %bl,%al
 432:	74 ec                	je     420 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 434:	29 d8                	sub    %ebx,%eax
}
 436:	5b                   	pop    %ebx
 437:	5d                   	pop    %ebp
 438:	c3                   	ret    
 439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 440:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 442:	29 d8                	sub    %ebx,%eax
}
 444:	5b                   	pop    %ebx
 445:	5d                   	pop    %ebp
 446:	c3                   	ret    
 447:	89 f6                	mov    %esi,%esi
 449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000450 <strlen>:

uint
strlen(const char *s)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 456:	80 39 00             	cmpb   $0x0,(%ecx)
 459:	74 15                	je     470 <strlen+0x20>
 45b:	31 d2                	xor    %edx,%edx
 45d:	8d 76 00             	lea    0x0(%esi),%esi
 460:	83 c2 01             	add    $0x1,%edx
 463:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 467:	89 d0                	mov    %edx,%eax
 469:	75 f5                	jne    460 <strlen+0x10>
    ;
  return n;
}
 46b:	5d                   	pop    %ebp
 46c:	c3                   	ret    
 46d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 470:	31 c0                	xor    %eax,%eax
}
 472:	5d                   	pop    %ebp
 473:	c3                   	ret    
 474:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 47a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000480 <memset>:

void*
memset(void *dst, int c, uint n)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 487:	8b 4d 10             	mov    0x10(%ebp),%ecx
 48a:	8b 45 0c             	mov    0xc(%ebp),%eax
 48d:	89 d7                	mov    %edx,%edi
 48f:	fc                   	cld    
 490:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 492:	89 d0                	mov    %edx,%eax
 494:	5f                   	pop    %edi
 495:	5d                   	pop    %ebp
 496:	c3                   	ret    
 497:	89 f6                	mov    %esi,%esi
 499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004a0 <strchr>:

char*
strchr(const char *s, char c)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	53                   	push   %ebx
 4a4:	8b 45 08             	mov    0x8(%ebp),%eax
 4a7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 4aa:	0f b6 10             	movzbl (%eax),%edx
 4ad:	84 d2                	test   %dl,%dl
 4af:	74 1d                	je     4ce <strchr+0x2e>
    if(*s == c)
 4b1:	38 d3                	cmp    %dl,%bl
 4b3:	89 d9                	mov    %ebx,%ecx
 4b5:	75 0d                	jne    4c4 <strchr+0x24>
 4b7:	eb 17                	jmp    4d0 <strchr+0x30>
 4b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4c0:	38 ca                	cmp    %cl,%dl
 4c2:	74 0c                	je     4d0 <strchr+0x30>
  for(; *s; s++)
 4c4:	83 c0 01             	add    $0x1,%eax
 4c7:	0f b6 10             	movzbl (%eax),%edx
 4ca:	84 d2                	test   %dl,%dl
 4cc:	75 f2                	jne    4c0 <strchr+0x20>
      return (char*)s;
  return 0;
 4ce:	31 c0                	xor    %eax,%eax
}
 4d0:	5b                   	pop    %ebx
 4d1:	5d                   	pop    %ebp
 4d2:	c3                   	ret    
 4d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004e0 <gets>:

char*
gets(char *buf, int max)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	56                   	push   %esi
 4e5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4e6:	31 f6                	xor    %esi,%esi
 4e8:	89 f3                	mov    %esi,%ebx
{
 4ea:	83 ec 1c             	sub    $0x1c,%esp
 4ed:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 4f0:	eb 2f                	jmp    521 <gets+0x41>
 4f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 4f8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4fb:	83 ec 04             	sub    $0x4,%esp
 4fe:	6a 01                	push   $0x1
 500:	50                   	push   %eax
 501:	6a 00                	push   $0x0
 503:	e8 32 01 00 00       	call   63a <read>
    if(cc < 1)
 508:	83 c4 10             	add    $0x10,%esp
 50b:	85 c0                	test   %eax,%eax
 50d:	7e 1c                	jle    52b <gets+0x4b>
      break;
    buf[i++] = c;
 50f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 513:	83 c7 01             	add    $0x1,%edi
 516:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 519:	3c 0a                	cmp    $0xa,%al
 51b:	74 23                	je     540 <gets+0x60>
 51d:	3c 0d                	cmp    $0xd,%al
 51f:	74 1f                	je     540 <gets+0x60>
  for(i=0; i+1 < max; ){
 521:	83 c3 01             	add    $0x1,%ebx
 524:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 527:	89 fe                	mov    %edi,%esi
 529:	7c cd                	jl     4f8 <gets+0x18>
 52b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 52d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 530:	c6 03 00             	movb   $0x0,(%ebx)
}
 533:	8d 65 f4             	lea    -0xc(%ebp),%esp
 536:	5b                   	pop    %ebx
 537:	5e                   	pop    %esi
 538:	5f                   	pop    %edi
 539:	5d                   	pop    %ebp
 53a:	c3                   	ret    
 53b:	90                   	nop
 53c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 540:	8b 75 08             	mov    0x8(%ebp),%esi
 543:	8b 45 08             	mov    0x8(%ebp),%eax
 546:	01 de                	add    %ebx,%esi
 548:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 54a:	c6 03 00             	movb   $0x0,(%ebx)
}
 54d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 550:	5b                   	pop    %ebx
 551:	5e                   	pop    %esi
 552:	5f                   	pop    %edi
 553:	5d                   	pop    %ebp
 554:	c3                   	ret    
 555:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000560 <stat>:

int
stat(const char *n, struct stat *st)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	56                   	push   %esi
 564:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 565:	83 ec 08             	sub    $0x8,%esp
 568:	6a 00                	push   $0x0
 56a:	ff 75 08             	pushl  0x8(%ebp)
 56d:	e8 f0 00 00 00       	call   662 <open>
  if(fd < 0)
 572:	83 c4 10             	add    $0x10,%esp
 575:	85 c0                	test   %eax,%eax
 577:	78 27                	js     5a0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 579:	83 ec 08             	sub    $0x8,%esp
 57c:	ff 75 0c             	pushl  0xc(%ebp)
 57f:	89 c3                	mov    %eax,%ebx
 581:	50                   	push   %eax
 582:	e8 f3 00 00 00       	call   67a <fstat>
  close(fd);
 587:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 58a:	89 c6                	mov    %eax,%esi
  close(fd);
 58c:	e8 b9 00 00 00       	call   64a <close>
  return r;
 591:	83 c4 10             	add    $0x10,%esp
}
 594:	8d 65 f8             	lea    -0x8(%ebp),%esp
 597:	89 f0                	mov    %esi,%eax
 599:	5b                   	pop    %ebx
 59a:	5e                   	pop    %esi
 59b:	5d                   	pop    %ebp
 59c:	c3                   	ret    
 59d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 5a0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 5a5:	eb ed                	jmp    594 <stat+0x34>
 5a7:	89 f6                	mov    %esi,%esi
 5a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005b0 <atoi>:

int
atoi(const char *s)
{
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	53                   	push   %ebx
 5b4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 5b7:	0f be 11             	movsbl (%ecx),%edx
 5ba:	8d 42 d0             	lea    -0x30(%edx),%eax
 5bd:	3c 09                	cmp    $0x9,%al
  n = 0;
 5bf:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 5c4:	77 1f                	ja     5e5 <atoi+0x35>
 5c6:	8d 76 00             	lea    0x0(%esi),%esi
 5c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 5d0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 5d3:	83 c1 01             	add    $0x1,%ecx
 5d6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 5da:	0f be 11             	movsbl (%ecx),%edx
 5dd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 5e0:	80 fb 09             	cmp    $0x9,%bl
 5e3:	76 eb                	jbe    5d0 <atoi+0x20>
  return n;
}
 5e5:	5b                   	pop    %ebx
 5e6:	5d                   	pop    %ebp
 5e7:	c3                   	ret    
 5e8:	90                   	nop
 5e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000005f0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	56                   	push   %esi
 5f4:	53                   	push   %ebx
 5f5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 5f8:	8b 45 08             	mov    0x8(%ebp),%eax
 5fb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5fe:	85 db                	test   %ebx,%ebx
 600:	7e 14                	jle    616 <memmove+0x26>
 602:	31 d2                	xor    %edx,%edx
 604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 608:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 60c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 60f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 612:	39 d3                	cmp    %edx,%ebx
 614:	75 f2                	jne    608 <memmove+0x18>
  return vdst;
}
 616:	5b                   	pop    %ebx
 617:	5e                   	pop    %esi
 618:	5d                   	pop    %ebp
 619:	c3                   	ret    

0000061a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 61a:	b8 01 00 00 00       	mov    $0x1,%eax
 61f:	cd 40                	int    $0x40
 621:	c3                   	ret    

00000622 <exit>:
SYSCALL(exit)
 622:	b8 02 00 00 00       	mov    $0x2,%eax
 627:	cd 40                	int    $0x40
 629:	c3                   	ret    

0000062a <wait>:
SYSCALL(wait)
 62a:	b8 03 00 00 00       	mov    $0x3,%eax
 62f:	cd 40                	int    $0x40
 631:	c3                   	ret    

00000632 <pipe>:
SYSCALL(pipe)
 632:	b8 04 00 00 00       	mov    $0x4,%eax
 637:	cd 40                	int    $0x40
 639:	c3                   	ret    

0000063a <read>:
SYSCALL(read)
 63a:	b8 05 00 00 00       	mov    $0x5,%eax
 63f:	cd 40                	int    $0x40
 641:	c3                   	ret    

00000642 <write>:
SYSCALL(write)
 642:	b8 10 00 00 00       	mov    $0x10,%eax
 647:	cd 40                	int    $0x40
 649:	c3                   	ret    

0000064a <close>:
SYSCALL(close)
 64a:	b8 15 00 00 00       	mov    $0x15,%eax
 64f:	cd 40                	int    $0x40
 651:	c3                   	ret    

00000652 <kill>:
SYSCALL(kill)
 652:	b8 06 00 00 00       	mov    $0x6,%eax
 657:	cd 40                	int    $0x40
 659:	c3                   	ret    

0000065a <exec>:
SYSCALL(exec)
 65a:	b8 07 00 00 00       	mov    $0x7,%eax
 65f:	cd 40                	int    $0x40
 661:	c3                   	ret    

00000662 <open>:
SYSCALL(open)
 662:	b8 0f 00 00 00       	mov    $0xf,%eax
 667:	cd 40                	int    $0x40
 669:	c3                   	ret    

0000066a <mknod>:
SYSCALL(mknod)
 66a:	b8 11 00 00 00       	mov    $0x11,%eax
 66f:	cd 40                	int    $0x40
 671:	c3                   	ret    

00000672 <unlink>:
SYSCALL(unlink)
 672:	b8 12 00 00 00       	mov    $0x12,%eax
 677:	cd 40                	int    $0x40
 679:	c3                   	ret    

0000067a <fstat>:
SYSCALL(fstat)
 67a:	b8 08 00 00 00       	mov    $0x8,%eax
 67f:	cd 40                	int    $0x40
 681:	c3                   	ret    

00000682 <link>:
SYSCALL(link)
 682:	b8 13 00 00 00       	mov    $0x13,%eax
 687:	cd 40                	int    $0x40
 689:	c3                   	ret    

0000068a <mkdir>:
SYSCALL(mkdir)
 68a:	b8 14 00 00 00       	mov    $0x14,%eax
 68f:	cd 40                	int    $0x40
 691:	c3                   	ret    

00000692 <chdir>:
SYSCALL(chdir)
 692:	b8 09 00 00 00       	mov    $0x9,%eax
 697:	cd 40                	int    $0x40
 699:	c3                   	ret    

0000069a <dup>:
SYSCALL(dup)
 69a:	b8 0a 00 00 00       	mov    $0xa,%eax
 69f:	cd 40                	int    $0x40
 6a1:	c3                   	ret    

000006a2 <getpid>:
SYSCALL(getpid)
 6a2:	b8 0b 00 00 00       	mov    $0xb,%eax
 6a7:	cd 40                	int    $0x40
 6a9:	c3                   	ret    

000006aa <sbrk>:
SYSCALL(sbrk)
 6aa:	b8 0c 00 00 00       	mov    $0xc,%eax
 6af:	cd 40                	int    $0x40
 6b1:	c3                   	ret    

000006b2 <sleep>:
SYSCALL(sleep)
 6b2:	b8 0d 00 00 00       	mov    $0xd,%eax
 6b7:	cd 40                	int    $0x40
 6b9:	c3                   	ret    

000006ba <uptime>:
SYSCALL(uptime)
 6ba:	b8 0e 00 00 00       	mov    $0xe,%eax
 6bf:	cd 40                	int    $0x40
 6c1:	c3                   	ret    

000006c2 <getlev>:
SYSCALL(getlev)
 6c2:	b8 16 00 00 00       	mov    $0x16,%eax
 6c7:	cd 40                	int    $0x40
 6c9:	c3                   	ret    

000006ca <yield>:
SYSCALL(yield)
 6ca:	b8 17 00 00 00       	mov    $0x17,%eax
 6cf:	cd 40                	int    $0x40
 6d1:	c3                   	ret    

000006d2 <set_cpu_share>:
SYSCALL(set_cpu_share)
 6d2:	b8 18 00 00 00       	mov    $0x18,%eax
 6d7:	cd 40                	int    $0x40
 6d9:	c3                   	ret    

000006da <thread_create>:
SYSCALL(thread_create)
 6da:	b8 19 00 00 00       	mov    $0x19,%eax
 6df:	cd 40                	int    $0x40
 6e1:	c3                   	ret    

000006e2 <thread_exit>:
SYSCALL(thread_exit)
 6e2:	b8 1a 00 00 00       	mov    $0x1a,%eax
 6e7:	cd 40                	int    $0x40
 6e9:	c3                   	ret    

000006ea <thread_join>:
SYSCALL(thread_join)
 6ea:	b8 1b 00 00 00       	mov    $0x1b,%eax
 6ef:	cd 40                	int    $0x40
 6f1:	c3                   	ret    

000006f2 <xem_init>:
SYSCALL(xem_init)
 6f2:	b8 1c 00 00 00       	mov    $0x1c,%eax
 6f7:	cd 40                	int    $0x40
 6f9:	c3                   	ret    

000006fa <xem_wait>:
SYSCALL(xem_wait)
 6fa:	b8 1d 00 00 00       	mov    $0x1d,%eax
 6ff:	cd 40                	int    $0x40
 701:	c3                   	ret    

00000702 <xem_unlock>:
SYSCALL(xem_unlock)
 702:	b8 1e 00 00 00       	mov    $0x1e,%eax
 707:	cd 40                	int    $0x40
 709:	c3                   	ret    

0000070a <pread>:
SYSCALL(pread)
 70a:	b8 1f 00 00 00       	mov    $0x1f,%eax
 70f:	cd 40                	int    $0x40
 711:	c3                   	ret    

00000712 <pwrite>:
SYSCALL(pwrite)
 712:	b8 20 00 00 00       	mov    $0x20,%eax
 717:	cd 40                	int    $0x40
 719:	c3                   	ret    
 71a:	66 90                	xchg   %ax,%ax
 71c:	66 90                	xchg   %ax,%ax
 71e:	66 90                	xchg   %ax,%ax

00000720 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	57                   	push   %edi
 724:	56                   	push   %esi
 725:	53                   	push   %ebx
 726:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 729:	85 d2                	test   %edx,%edx
{
 72b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 72e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 730:	79 76                	jns    7a8 <printint+0x88>
 732:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 736:	74 70                	je     7a8 <printint+0x88>
    x = -xx;
 738:	f7 d8                	neg    %eax
    neg = 1;
 73a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 741:	31 f6                	xor    %esi,%esi
 743:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 746:	eb 0a                	jmp    752 <printint+0x32>
 748:	90                   	nop
 749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 750:	89 fe                	mov    %edi,%esi
 752:	31 d2                	xor    %edx,%edx
 754:	8d 7e 01             	lea    0x1(%esi),%edi
 757:	f7 f1                	div    %ecx
 759:	0f b6 92 58 0c 00 00 	movzbl 0xc58(%edx),%edx
  }while((x /= base) != 0);
 760:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 762:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 765:	75 e9                	jne    750 <printint+0x30>
  if(neg)
 767:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 76a:	85 c0                	test   %eax,%eax
 76c:	74 08                	je     776 <printint+0x56>
    buf[i++] = '-';
 76e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 773:	8d 7e 02             	lea    0x2(%esi),%edi
 776:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 77a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 77d:	8d 76 00             	lea    0x0(%esi),%esi
 780:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 783:	83 ec 04             	sub    $0x4,%esp
 786:	83 ee 01             	sub    $0x1,%esi
 789:	6a 01                	push   $0x1
 78b:	53                   	push   %ebx
 78c:	57                   	push   %edi
 78d:	88 45 d7             	mov    %al,-0x29(%ebp)
 790:	e8 ad fe ff ff       	call   642 <write>

  while(--i >= 0)
 795:	83 c4 10             	add    $0x10,%esp
 798:	39 de                	cmp    %ebx,%esi
 79a:	75 e4                	jne    780 <printint+0x60>
    putc(fd, buf[i]);
}
 79c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 79f:	5b                   	pop    %ebx
 7a0:	5e                   	pop    %esi
 7a1:	5f                   	pop    %edi
 7a2:	5d                   	pop    %ebp
 7a3:	c3                   	ret    
 7a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 7a8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 7af:	eb 90                	jmp    741 <printint+0x21>
 7b1:	eb 0d                	jmp    7c0 <printf>
 7b3:	90                   	nop
 7b4:	90                   	nop
 7b5:	90                   	nop
 7b6:	90                   	nop
 7b7:	90                   	nop
 7b8:	90                   	nop
 7b9:	90                   	nop
 7ba:	90                   	nop
 7bb:	90                   	nop
 7bc:	90                   	nop
 7bd:	90                   	nop
 7be:	90                   	nop
 7bf:	90                   	nop

000007c0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 7c0:	55                   	push   %ebp
 7c1:	89 e5                	mov    %esp,%ebp
 7c3:	57                   	push   %edi
 7c4:	56                   	push   %esi
 7c5:	53                   	push   %ebx
 7c6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7c9:	8b 75 0c             	mov    0xc(%ebp),%esi
 7cc:	0f b6 1e             	movzbl (%esi),%ebx
 7cf:	84 db                	test   %bl,%bl
 7d1:	0f 84 b3 00 00 00    	je     88a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 7d7:	8d 45 10             	lea    0x10(%ebp),%eax
 7da:	83 c6 01             	add    $0x1,%esi
  state = 0;
 7dd:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 7df:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 7e2:	eb 2f                	jmp    813 <printf+0x53>
 7e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 7e8:	83 f8 25             	cmp    $0x25,%eax
 7eb:	0f 84 a7 00 00 00    	je     898 <printf+0xd8>
  write(fd, &c, 1);
 7f1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 7f4:	83 ec 04             	sub    $0x4,%esp
 7f7:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 7fa:	6a 01                	push   $0x1
 7fc:	50                   	push   %eax
 7fd:	ff 75 08             	pushl  0x8(%ebp)
 800:	e8 3d fe ff ff       	call   642 <write>
 805:	83 c4 10             	add    $0x10,%esp
 808:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 80b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 80f:	84 db                	test   %bl,%bl
 811:	74 77                	je     88a <printf+0xca>
    if(state == 0){
 813:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 815:	0f be cb             	movsbl %bl,%ecx
 818:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 81b:	74 cb                	je     7e8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 81d:	83 ff 25             	cmp    $0x25,%edi
 820:	75 e6                	jne    808 <printf+0x48>
      if(c == 'd'){
 822:	83 f8 64             	cmp    $0x64,%eax
 825:	0f 84 05 01 00 00    	je     930 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 82b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 831:	83 f9 70             	cmp    $0x70,%ecx
 834:	74 72                	je     8a8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 836:	83 f8 73             	cmp    $0x73,%eax
 839:	0f 84 99 00 00 00    	je     8d8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 83f:	83 f8 63             	cmp    $0x63,%eax
 842:	0f 84 08 01 00 00    	je     950 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 848:	83 f8 25             	cmp    $0x25,%eax
 84b:	0f 84 ef 00 00 00    	je     940 <printf+0x180>
  write(fd, &c, 1);
 851:	8d 45 e7             	lea    -0x19(%ebp),%eax
 854:	83 ec 04             	sub    $0x4,%esp
 857:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 85b:	6a 01                	push   $0x1
 85d:	50                   	push   %eax
 85e:	ff 75 08             	pushl  0x8(%ebp)
 861:	e8 dc fd ff ff       	call   642 <write>
 866:	83 c4 0c             	add    $0xc,%esp
 869:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 86c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 86f:	6a 01                	push   $0x1
 871:	50                   	push   %eax
 872:	ff 75 08             	pushl  0x8(%ebp)
 875:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 878:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 87a:	e8 c3 fd ff ff       	call   642 <write>
  for(i = 0; fmt[i]; i++){
 87f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 883:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 886:	84 db                	test   %bl,%bl
 888:	75 89                	jne    813 <printf+0x53>
    }
  }
}
 88a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 88d:	5b                   	pop    %ebx
 88e:	5e                   	pop    %esi
 88f:	5f                   	pop    %edi
 890:	5d                   	pop    %ebp
 891:	c3                   	ret    
 892:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 898:	bf 25 00 00 00       	mov    $0x25,%edi
 89d:	e9 66 ff ff ff       	jmp    808 <printf+0x48>
 8a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 8a8:	83 ec 0c             	sub    $0xc,%esp
 8ab:	b9 10 00 00 00       	mov    $0x10,%ecx
 8b0:	6a 00                	push   $0x0
 8b2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 8b5:	8b 45 08             	mov    0x8(%ebp),%eax
 8b8:	8b 17                	mov    (%edi),%edx
 8ba:	e8 61 fe ff ff       	call   720 <printint>
        ap++;
 8bf:	89 f8                	mov    %edi,%eax
 8c1:	83 c4 10             	add    $0x10,%esp
      state = 0;
 8c4:	31 ff                	xor    %edi,%edi
        ap++;
 8c6:	83 c0 04             	add    $0x4,%eax
 8c9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 8cc:	e9 37 ff ff ff       	jmp    808 <printf+0x48>
 8d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 8d8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 8db:	8b 08                	mov    (%eax),%ecx
        ap++;
 8dd:	83 c0 04             	add    $0x4,%eax
 8e0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 8e3:	85 c9                	test   %ecx,%ecx
 8e5:	0f 84 8e 00 00 00    	je     979 <printf+0x1b9>
        while(*s != 0){
 8eb:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 8ee:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 8f0:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 8f2:	84 c0                	test   %al,%al
 8f4:	0f 84 0e ff ff ff    	je     808 <printf+0x48>
 8fa:	89 75 d0             	mov    %esi,-0x30(%ebp)
 8fd:	89 de                	mov    %ebx,%esi
 8ff:	8b 5d 08             	mov    0x8(%ebp),%ebx
 902:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 905:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 908:	83 ec 04             	sub    $0x4,%esp
          s++;
 90b:	83 c6 01             	add    $0x1,%esi
 90e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 911:	6a 01                	push   $0x1
 913:	57                   	push   %edi
 914:	53                   	push   %ebx
 915:	e8 28 fd ff ff       	call   642 <write>
        while(*s != 0){
 91a:	0f b6 06             	movzbl (%esi),%eax
 91d:	83 c4 10             	add    $0x10,%esp
 920:	84 c0                	test   %al,%al
 922:	75 e4                	jne    908 <printf+0x148>
 924:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 927:	31 ff                	xor    %edi,%edi
 929:	e9 da fe ff ff       	jmp    808 <printf+0x48>
 92e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 930:	83 ec 0c             	sub    $0xc,%esp
 933:	b9 0a 00 00 00       	mov    $0xa,%ecx
 938:	6a 01                	push   $0x1
 93a:	e9 73 ff ff ff       	jmp    8b2 <printf+0xf2>
 93f:	90                   	nop
  write(fd, &c, 1);
 940:	83 ec 04             	sub    $0x4,%esp
 943:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 946:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 949:	6a 01                	push   $0x1
 94b:	e9 21 ff ff ff       	jmp    871 <printf+0xb1>
        putc(fd, *ap);
 950:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 953:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 956:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 958:	6a 01                	push   $0x1
        ap++;
 95a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 95d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 960:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 963:	50                   	push   %eax
 964:	ff 75 08             	pushl  0x8(%ebp)
 967:	e8 d6 fc ff ff       	call   642 <write>
        ap++;
 96c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 96f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 972:	31 ff                	xor    %edi,%edi
 974:	e9 8f fe ff ff       	jmp    808 <printf+0x48>
          s = "(null)";
 979:	bb 51 0c 00 00       	mov    $0xc51,%ebx
        while(*s != 0){
 97e:	b8 28 00 00 00       	mov    $0x28,%eax
 983:	e9 72 ff ff ff       	jmp    8fa <printf+0x13a>
 988:	66 90                	xchg   %ax,%ax
 98a:	66 90                	xchg   %ax,%ax
 98c:	66 90                	xchg   %ax,%ax
 98e:	66 90                	xchg   %ax,%ax

00000990 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 990:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 991:	a1 08 0f 00 00       	mov    0xf08,%eax
{
 996:	89 e5                	mov    %esp,%ebp
 998:	57                   	push   %edi
 999:	56                   	push   %esi
 99a:	53                   	push   %ebx
 99b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 99e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 9a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9a8:	39 c8                	cmp    %ecx,%eax
 9aa:	8b 10                	mov    (%eax),%edx
 9ac:	73 32                	jae    9e0 <free+0x50>
 9ae:	39 d1                	cmp    %edx,%ecx
 9b0:	72 04                	jb     9b6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9b2:	39 d0                	cmp    %edx,%eax
 9b4:	72 32                	jb     9e8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 9b6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 9b9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 9bc:	39 fa                	cmp    %edi,%edx
 9be:	74 30                	je     9f0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 9c0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 9c3:	8b 50 04             	mov    0x4(%eax),%edx
 9c6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 9c9:	39 f1                	cmp    %esi,%ecx
 9cb:	74 3a                	je     a07 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 9cd:	89 08                	mov    %ecx,(%eax)
  freep = p;
 9cf:	a3 08 0f 00 00       	mov    %eax,0xf08
}
 9d4:	5b                   	pop    %ebx
 9d5:	5e                   	pop    %esi
 9d6:	5f                   	pop    %edi
 9d7:	5d                   	pop    %ebp
 9d8:	c3                   	ret    
 9d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9e0:	39 d0                	cmp    %edx,%eax
 9e2:	72 04                	jb     9e8 <free+0x58>
 9e4:	39 d1                	cmp    %edx,%ecx
 9e6:	72 ce                	jb     9b6 <free+0x26>
{
 9e8:	89 d0                	mov    %edx,%eax
 9ea:	eb bc                	jmp    9a8 <free+0x18>
 9ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 9f0:	03 72 04             	add    0x4(%edx),%esi
 9f3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 9f6:	8b 10                	mov    (%eax),%edx
 9f8:	8b 12                	mov    (%edx),%edx
 9fa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 9fd:	8b 50 04             	mov    0x4(%eax),%edx
 a00:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a03:	39 f1                	cmp    %esi,%ecx
 a05:	75 c6                	jne    9cd <free+0x3d>
    p->s.size += bp->s.size;
 a07:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 a0a:	a3 08 0f 00 00       	mov    %eax,0xf08
    p->s.size += bp->s.size;
 a0f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 a12:	8b 53 f8             	mov    -0x8(%ebx),%edx
 a15:	89 10                	mov    %edx,(%eax)
}
 a17:	5b                   	pop    %ebx
 a18:	5e                   	pop    %esi
 a19:	5f                   	pop    %edi
 a1a:	5d                   	pop    %ebp
 a1b:	c3                   	ret    
 a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a20 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a20:	55                   	push   %ebp
 a21:	89 e5                	mov    %esp,%ebp
 a23:	57                   	push   %edi
 a24:	56                   	push   %esi
 a25:	53                   	push   %ebx
 a26:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a29:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 a2c:	8b 15 08 0f 00 00    	mov    0xf08,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a32:	8d 78 07             	lea    0x7(%eax),%edi
 a35:	c1 ef 03             	shr    $0x3,%edi
 a38:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 a3b:	85 d2                	test   %edx,%edx
 a3d:	0f 84 9d 00 00 00    	je     ae0 <malloc+0xc0>
 a43:	8b 02                	mov    (%edx),%eax
 a45:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 a48:	39 cf                	cmp    %ecx,%edi
 a4a:	76 6c                	jbe    ab8 <malloc+0x98>
 a4c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 a52:	bb 00 10 00 00       	mov    $0x1000,%ebx
 a57:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 a5a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 a61:	eb 0e                	jmp    a71 <malloc+0x51>
 a63:	90                   	nop
 a64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a68:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a6a:	8b 48 04             	mov    0x4(%eax),%ecx
 a6d:	39 f9                	cmp    %edi,%ecx
 a6f:	73 47                	jae    ab8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a71:	39 05 08 0f 00 00    	cmp    %eax,0xf08
 a77:	89 c2                	mov    %eax,%edx
 a79:	75 ed                	jne    a68 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 a7b:	83 ec 0c             	sub    $0xc,%esp
 a7e:	56                   	push   %esi
 a7f:	e8 26 fc ff ff       	call   6aa <sbrk>
  if(p == (char*)-1)
 a84:	83 c4 10             	add    $0x10,%esp
 a87:	83 f8 ff             	cmp    $0xffffffff,%eax
 a8a:	74 1c                	je     aa8 <malloc+0x88>
  hp->s.size = nu;
 a8c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 a8f:	83 ec 0c             	sub    $0xc,%esp
 a92:	83 c0 08             	add    $0x8,%eax
 a95:	50                   	push   %eax
 a96:	e8 f5 fe ff ff       	call   990 <free>
  return freep;
 a9b:	8b 15 08 0f 00 00    	mov    0xf08,%edx
      if((p = morecore(nunits)) == 0)
 aa1:	83 c4 10             	add    $0x10,%esp
 aa4:	85 d2                	test   %edx,%edx
 aa6:	75 c0                	jne    a68 <malloc+0x48>
        return 0;
  }
}
 aa8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 aab:	31 c0                	xor    %eax,%eax
}
 aad:	5b                   	pop    %ebx
 aae:	5e                   	pop    %esi
 aaf:	5f                   	pop    %edi
 ab0:	5d                   	pop    %ebp
 ab1:	c3                   	ret    
 ab2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 ab8:	39 cf                	cmp    %ecx,%edi
 aba:	74 54                	je     b10 <malloc+0xf0>
        p->s.size -= nunits;
 abc:	29 f9                	sub    %edi,%ecx
 abe:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 ac1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 ac4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 ac7:	89 15 08 0f 00 00    	mov    %edx,0xf08
}
 acd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 ad0:	83 c0 08             	add    $0x8,%eax
}
 ad3:	5b                   	pop    %ebx
 ad4:	5e                   	pop    %esi
 ad5:	5f                   	pop    %edi
 ad6:	5d                   	pop    %ebp
 ad7:	c3                   	ret    
 ad8:	90                   	nop
 ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 ae0:	c7 05 08 0f 00 00 0c 	movl   $0xf0c,0xf08
 ae7:	0f 00 00 
 aea:	c7 05 0c 0f 00 00 0c 	movl   $0xf0c,0xf0c
 af1:	0f 00 00 
    base.s.size = 0;
 af4:	b8 0c 0f 00 00       	mov    $0xf0c,%eax
 af9:	c7 05 10 0f 00 00 00 	movl   $0x0,0xf10
 b00:	00 00 00 
 b03:	e9 44 ff ff ff       	jmp    a4c <malloc+0x2c>
 b08:	90                   	nop
 b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 b10:	8b 08                	mov    (%eax),%ecx
 b12:	89 0a                	mov    %ecx,(%edx)
 b14:	eb b1                	jmp    ac7 <malloc+0xa7>
