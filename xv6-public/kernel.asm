
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 b0 10 00       	mov    $0x10b000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc d0 d5 10 80       	mov    $0x8010d5d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 30 34 10 80       	mov    $0x80103430,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 14 d6 10 80       	mov    $0x8010d614,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 c0 8b 10 80       	push   $0x80108bc0
80100051:	68 e0 d5 10 80       	push   $0x8010d5e0
80100056:	e8 55 5b 00 00       	call   80105bb0 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 2c 1d 11 80 dc 	movl   $0x80111cdc,0x80111d2c
80100062:	1c 11 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 30 1d 11 80 dc 	movl   $0x80111cdc,0x80111d30
8010006c:	1c 11 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba dc 1c 11 80       	mov    $0x80111cdc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 dc 1c 11 80 	movl   $0x80111cdc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 c7 8b 10 80       	push   $0x80108bc7
80100097:	50                   	push   %eax
80100098:	e8 e3 59 00 00       	call   80105a80 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 30 1d 11 80       	mov    0x80111d30,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 30 1d 11 80    	mov    %ebx,0x80111d30
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d dc 1c 11 80       	cmp    $0x80111cdc,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 e0 d5 10 80       	push   $0x8010d5e0
801000e4:	e8 07 5c 00 00       	call   80105cf0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 30 1d 11 80    	mov    0x80111d30,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb dc 1c 11 80    	cmp    $0x80111cdc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb dc 1c 11 80    	cmp    $0x80111cdc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 2c 1d 11 80    	mov    0x80111d2c,%ebx
80100126:	81 fb dc 1c 11 80    	cmp    $0x80111cdc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb dc 1c 11 80    	cmp    $0x80111cdc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 e0 d5 10 80       	push   $0x8010d5e0
80100162:	e8 49 5c 00 00       	call   80105db0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 4e 59 00 00       	call   80105ac0 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 2d 25 00 00       	call   801026b0 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 ce 8b 10 80       	push   $0x80108bce
80100198:	e8 f3 01 00 00       	call   80100390 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 ad 59 00 00       	call   80105b60 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
  iderw(b);
801001c4:	e9 e7 24 00 00       	jmp    801026b0 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 df 8b 10 80       	push   $0x80108bdf
801001d1:	e8 ba 01 00 00       	call   80100390 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 6c 59 00 00       	call   80105b60 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 1c 59 00 00       	call   80105b20 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 e0 d5 10 80 	movl   $0x8010d5e0,(%esp)
8010020b:	e8 e0 5a 00 00       	call   80105cf0 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 30 1d 11 80       	mov    0x80111d30,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 dc 1c 11 80 	movl   $0x80111cdc,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 30 1d 11 80       	mov    0x80111d30,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 30 1d 11 80    	mov    %ebx,0x80111d30
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 e0 d5 10 80 	movl   $0x8010d5e0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 4f 5b 00 00       	jmp    80105db0 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 e6 8b 10 80       	push   $0x80108be6
80100269:	e8 22 01 00 00       	call   80100390 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 2b 18 00 00       	call   80101ab0 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010028c:	e8 5f 5a 00 00       	call   80105cf0 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 c0 1f 11 80    	mov    0x80111fc0,%edx
801002a7:	39 15 c4 1f 11 80    	cmp    %edx,0x80111fc4
801002ad:	74 2c                	je     801002db <consoleread+0x6b>
801002af:	eb 5f                	jmp    80100310 <consoleread+0xa0>
801002b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b8:	83 ec 08             	sub    $0x8,%esp
801002bb:	68 20 c5 10 80       	push   $0x8010c520
801002c0:	68 c0 1f 11 80       	push   $0x80111fc0
801002c5:	e8 96 4b 00 00       	call   80104e60 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 c0 1f 11 80    	mov    0x80111fc0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 c4 1f 11 80    	cmp    0x80111fc4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 90 40 00 00       	call   80104370 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 c5 10 80       	push   $0x8010c520
801002ef:	e8 bc 5a 00 00       	call   80105db0 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 d4 16 00 00       	call   801019d0 <ilock>
        return -1;
801002fc:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100302:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100307:	5b                   	pop    %ebx
80100308:	5e                   	pop    %esi
80100309:	5f                   	pop    %edi
8010030a:	5d                   	pop    %ebp
8010030b:	c3                   	ret    
8010030c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100310:	8d 42 01             	lea    0x1(%edx),%eax
80100313:	a3 c0 1f 11 80       	mov    %eax,0x80111fc0
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 40 1f 11 80 	movsbl -0x7feee0c0(%eax),%eax
    if(c == C('D')){  // EOF
80100324:	83 f8 04             	cmp    $0x4,%eax
80100327:	74 3f                	je     80100368 <consoleread+0xf8>
    *dst++ = c;
80100329:	83 c6 01             	add    $0x1,%esi
    --n;
8010032c:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
8010032f:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
80100332:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100335:	74 43                	je     8010037a <consoleread+0x10a>
  while(n > 0){
80100337:	85 db                	test   %ebx,%ebx
80100339:	0f 85 62 ff ff ff    	jne    801002a1 <consoleread+0x31>
8010033f:	8b 45 10             	mov    0x10(%ebp),%eax
  release(&cons.lock);
80100342:	83 ec 0c             	sub    $0xc,%esp
80100345:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100348:	68 20 c5 10 80       	push   $0x8010c520
8010034d:	e8 5e 5a 00 00       	call   80105db0 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 76 16 00 00       	call   801019d0 <ilock>
  return target - n;
8010035a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010035d:	83 c4 10             	add    $0x10,%esp
}
80100360:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100363:	5b                   	pop    %ebx
80100364:	5e                   	pop    %esi
80100365:	5f                   	pop    %edi
80100366:	5d                   	pop    %ebp
80100367:	c3                   	ret    
80100368:	8b 45 10             	mov    0x10(%ebp),%eax
8010036b:	29 d8                	sub    %ebx,%eax
      if(n < target){
8010036d:	3b 5d 10             	cmp    0x10(%ebp),%ebx
80100370:	73 d0                	jae    80100342 <consoleread+0xd2>
        input.r--;
80100372:	89 15 c0 1f 11 80    	mov    %edx,0x80111fc0
80100378:	eb c8                	jmp    80100342 <consoleread+0xd2>
8010037a:	8b 45 10             	mov    0x10(%ebp),%eax
8010037d:	29 d8                	sub    %ebx,%eax
8010037f:	eb c1                	jmp    80100342 <consoleread+0xd2>
80100381:	eb 0d                	jmp    80100390 <panic>
80100383:	90                   	nop
80100384:	90                   	nop
80100385:	90                   	nop
80100386:	90                   	nop
80100387:	90                   	nop
80100388:	90                   	nop
80100389:	90                   	nop
8010038a:	90                   	nop
8010038b:	90                   	nop
8010038c:	90                   	nop
8010038d:	90                   	nop
8010038e:	90                   	nop
8010038f:	90                   	nop

80100390 <panic>:
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100398:	fa                   	cli    
  cons.locking = 0;
80100399:	c7 05 54 c5 10 80 00 	movl   $0x0,0x8010c554
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 12 29 00 00       	call   80102cc0 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 ed 8b 10 80       	push   $0x80108bed
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 3b 96 10 80 	movl   $0x8010963b,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 f3 57 00 00       	call   80105bd0 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 01 8c 10 80       	push   $0x80108c01
801003ed:	e8 6e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 58 c5 10 80 01 	movl   $0x1,0x8010c558
80100400:	00 00 00 
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc>:
  if(panicked){
80100410:	8b 0d 58 c5 10 80    	mov    0x8010c558,%ecx
80100416:	85 c9                	test   %ecx,%ecx
80100418:	74 06                	je     80100420 <consputc+0x10>
8010041a:	fa                   	cli    
8010041b:	eb fe                	jmp    8010041b <consputc+0xb>
8010041d:	8d 76 00             	lea    0x0(%esi),%esi
{
80100420:	55                   	push   %ebp
80100421:	89 e5                	mov    %esp,%ebp
80100423:	57                   	push   %edi
80100424:	56                   	push   %esi
80100425:	53                   	push   %ebx
80100426:	89 c6                	mov    %eax,%esi
80100428:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
8010042b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100430:	0f 84 b1 00 00 00    	je     801004e7 <consputc+0xd7>
    uartputc(c);
80100436:	83 ec 0c             	sub    $0xc,%esp
80100439:	50                   	push   %eax
8010043a:	e8 91 73 00 00       	call   801077d0 <uartputc>
8010043f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100442:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100447:	b8 0e 00 00 00       	mov    $0xe,%eax
8010044c:	89 da                	mov    %ebx,%edx
8010044e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100454:	89 ca                	mov    %ecx,%edx
80100456:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100457:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010045a:	89 da                	mov    %ebx,%edx
8010045c:	c1 e0 08             	shl    $0x8,%eax
8010045f:	89 c7                	mov    %eax,%edi
80100461:	b8 0f 00 00 00       	mov    $0xf,%eax
80100466:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100467:	89 ca                	mov    %ecx,%edx
80100469:	ec                   	in     (%dx),%al
8010046a:	0f b6 d8             	movzbl %al,%ebx
  pos |= inb(CRTPORT+1);
8010046d:	09 fb                	or     %edi,%ebx
  if(c == '\n')
8010046f:	83 fe 0a             	cmp    $0xa,%esi
80100472:	0f 84 f3 00 00 00    	je     8010056b <consputc+0x15b>
  else if(c == BACKSPACE){
80100478:	81 fe 00 01 00 00    	cmp    $0x100,%esi
8010047e:	0f 84 d7 00 00 00    	je     8010055b <consputc+0x14b>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100484:	89 f0                	mov    %esi,%eax
80100486:	0f b6 c0             	movzbl %al,%eax
80100489:	80 cc 07             	or     $0x7,%ah
8010048c:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
80100493:	80 
80100494:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
80100497:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010049d:	0f 8f ab 00 00 00    	jg     8010054e <consputc+0x13e>
  if((pos/80) >= 24){  // Scroll up.
801004a3:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004a9:	7f 66                	jg     80100511 <consputc+0x101>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004ab:	be d4 03 00 00       	mov    $0x3d4,%esi
801004b0:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b5:	89 f2                	mov    %esi,%edx
801004b7:	ee                   	out    %al,(%dx)
801004b8:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
801004bd:	89 d8                	mov    %ebx,%eax
801004bf:	c1 f8 08             	sar    $0x8,%eax
801004c2:	89 ca                	mov    %ecx,%edx
801004c4:	ee                   	out    %al,(%dx)
801004c5:	b8 0f 00 00 00       	mov    $0xf,%eax
801004ca:	89 f2                	mov    %esi,%edx
801004cc:	ee                   	out    %al,(%dx)
801004cd:	89 d8                	mov    %ebx,%eax
801004cf:	89 ca                	mov    %ecx,%edx
801004d1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004d2:	b8 20 07 00 00       	mov    $0x720,%eax
801004d7:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004de:	80 
}
801004df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004e2:	5b                   	pop    %ebx
801004e3:	5e                   	pop    %esi
801004e4:	5f                   	pop    %edi
801004e5:	5d                   	pop    %ebp
801004e6:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e7:	83 ec 0c             	sub    $0xc,%esp
801004ea:	6a 08                	push   $0x8
801004ec:	e8 df 72 00 00       	call   801077d0 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 d3 72 00 00       	call   801077d0 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 c7 72 00 00       	call   801077d0 <uartputc>
80100509:	83 c4 10             	add    $0x10,%esp
8010050c:	e9 31 ff ff ff       	jmp    80100442 <consputc+0x32>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100511:	52                   	push   %edx
80100512:	68 60 0e 00 00       	push   $0xe60
    pos -= 80;
80100517:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010051a:	68 a0 80 0b 80       	push   $0x800b80a0
8010051f:	68 00 80 0b 80       	push   $0x800b8000
80100524:	e8 87 59 00 00       	call   80105eb0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100529:	b8 80 07 00 00       	mov    $0x780,%eax
8010052e:	83 c4 0c             	add    $0xc,%esp
80100531:	29 d8                	sub    %ebx,%eax
80100533:	01 c0                	add    %eax,%eax
80100535:	50                   	push   %eax
80100536:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
80100539:	6a 00                	push   $0x0
8010053b:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100540:	50                   	push   %eax
80100541:	e8 ba 58 00 00       	call   80105e00 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 05 8c 10 80       	push   $0x80108c05
80100556:	e8 35 fe ff ff       	call   80100390 <panic>
    if(pos > 0) --pos;
8010055b:	85 db                	test   %ebx,%ebx
8010055d:	0f 84 48 ff ff ff    	je     801004ab <consputc+0x9b>
80100563:	83 eb 01             	sub    $0x1,%ebx
80100566:	e9 2c ff ff ff       	jmp    80100497 <consputc+0x87>
    pos += 80 - pos%80;
8010056b:	89 d8                	mov    %ebx,%eax
8010056d:	b9 50 00 00 00       	mov    $0x50,%ecx
80100572:	99                   	cltd   
80100573:	f7 f9                	idiv   %ecx
80100575:	29 d1                	sub    %edx,%ecx
80100577:	01 cb                	add    %ecx,%ebx
80100579:	e9 19 ff ff ff       	jmp    80100497 <consputc+0x87>
8010057e:	66 90                	xchg   %ax,%ax

80100580 <printint>:
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d3                	mov    %edx,%ebx
80100588:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100590:	74 04                	je     80100596 <printint+0x16>
80100592:	85 c0                	test   %eax,%eax
80100594:	78 5a                	js     801005f0 <printint+0x70>
    x = xx;
80100596:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010059d:	31 c9                	xor    %ecx,%ecx
8010059f:	8d 75 d7             	lea    -0x29(%ebp),%esi
801005a2:	eb 06                	jmp    801005aa <printint+0x2a>
801005a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
801005a8:	89 f9                	mov    %edi,%ecx
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 79 01             	lea    0x1(%ecx),%edi
801005af:	f7 f3                	div    %ebx
801005b1:	0f b6 92 30 8c 10 80 	movzbl -0x7fef73d0(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005ba:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>
  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
801005cb:	8d 79 02             	lea    0x2(%ecx),%edi
801005ce:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
801005d8:	0f be 03             	movsbl (%ebx),%eax
801005db:	83 eb 01             	sub    $0x1,%ebx
801005de:	e8 2d fe ff ff       	call   80100410 <consputc>
  while(--i >= 0)
801005e3:	39 f3                	cmp    %esi,%ebx
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
801005ef:	90                   	nop
    x = -xx;
801005f0:	f7 d8                	neg    %eax
801005f2:	eb a9                	jmp    8010059d <printint+0x1d>
801005f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100600 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
80100609:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060c:	ff 75 08             	pushl  0x8(%ebp)
8010060f:	e8 9c 14 00 00       	call   80101ab0 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010061b:	e8 d0 56 00 00       	call   80105cf0 <acquire>
  for(i = 0; i < n; i++)
80100620:	83 c4 10             	add    $0x10,%esp
80100623:	85 f6                	test   %esi,%esi
80100625:	7e 18                	jle    8010063f <consolewrite+0x3f>
80100627:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010062a:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 d5 fd ff ff       	call   80100410 <consputc>
  for(i = 0; i < n; i++)
8010063b:	39 fb                	cmp    %edi,%ebx
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 c5 10 80       	push   $0x8010c520
80100647:	e8 64 57 00 00       	call   80105db0 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 7b 13 00 00       	call   801019d0 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100669:	a1 54 c5 10 80       	mov    0x8010c554,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100670:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100673:	0f 85 6f 01 00 00    	jne    801007e8 <cprintf+0x188>
  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c7                	mov    %eax,%edi
80100680:	0f 84 77 01 00 00    	je     801007fd <cprintf+0x19d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100689:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010068c:	31 db                	xor    %ebx,%ebx
  argp = (uint*)(void*)(&fmt + 1);
8010068e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100691:	85 c0                	test   %eax,%eax
80100693:	75 56                	jne    801006eb <cprintf+0x8b>
80100695:	eb 79                	jmp    80100710 <cprintf+0xb0>
80100697:	89 f6                	mov    %esi,%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
801006a0:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
801006a3:	85 d2                	test   %edx,%edx
801006a5:	74 69                	je     80100710 <cprintf+0xb0>
801006a7:	83 c3 02             	add    $0x2,%ebx
    switch(c){
801006aa:	83 fa 70             	cmp    $0x70,%edx
801006ad:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
801006b0:	0f 84 84 00 00 00    	je     8010073a <cprintf+0xda>
801006b6:	7f 78                	jg     80100730 <cprintf+0xd0>
801006b8:	83 fa 25             	cmp    $0x25,%edx
801006bb:	0f 84 ff 00 00 00    	je     801007c0 <cprintf+0x160>
801006c1:	83 fa 64             	cmp    $0x64,%edx
801006c4:	0f 85 8e 00 00 00    	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 10, 1);
801006ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006cd:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d2:	8d 48 04             	lea    0x4(%eax),%ecx
801006d5:	8b 00                	mov    (%eax),%eax
801006d7:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801006da:	b9 01 00 00 00       	mov    $0x1,%ecx
801006df:	e8 9c fe ff ff       	call   80100580 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e4:	0f b6 06             	movzbl (%esi),%eax
801006e7:	85 c0                	test   %eax,%eax
801006e9:	74 25                	je     80100710 <cprintf+0xb0>
801006eb:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801006ee:	83 f8 25             	cmp    $0x25,%eax
801006f1:	8d 34 17             	lea    (%edi,%edx,1),%esi
801006f4:	74 aa                	je     801006a0 <cprintf+0x40>
801006f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801006f9:	e8 12 fd ff ff       	call   80100410 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fe:	0f b6 06             	movzbl (%esi),%eax
      continue;
80100701:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100704:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100706:	85 c0                	test   %eax,%eax
80100708:	75 e1                	jne    801006eb <cprintf+0x8b>
8010070a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(locking)
80100710:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100713:	85 c0                	test   %eax,%eax
80100715:	74 10                	je     80100727 <cprintf+0xc7>
    release(&cons.lock);
80100717:	83 ec 0c             	sub    $0xc,%esp
8010071a:	68 20 c5 10 80       	push   $0x8010c520
8010071f:	e8 8c 56 00 00       	call   80105db0 <release>
80100724:	83 c4 10             	add    $0x10,%esp
}
80100727:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010072a:	5b                   	pop    %ebx
8010072b:	5e                   	pop    %esi
8010072c:	5f                   	pop    %edi
8010072d:	5d                   	pop    %ebp
8010072e:	c3                   	ret    
8010072f:	90                   	nop
    switch(c){
80100730:	83 fa 73             	cmp    $0x73,%edx
80100733:	74 43                	je     80100778 <cprintf+0x118>
80100735:	83 fa 78             	cmp    $0x78,%edx
80100738:	75 1e                	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 16, 0);
8010073a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010073d:	ba 10 00 00 00       	mov    $0x10,%edx
80100742:	8d 48 04             	lea    0x4(%eax),%ecx
80100745:	8b 00                	mov    (%eax),%eax
80100747:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010074a:	31 c9                	xor    %ecx,%ecx
8010074c:	e8 2f fe ff ff       	call   80100580 <printint>
      break;
80100751:	eb 91                	jmp    801006e4 <cprintf+0x84>
80100753:	90                   	nop
80100754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100758:	b8 25 00 00 00       	mov    $0x25,%eax
8010075d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100760:	e8 ab fc ff ff       	call   80100410 <consputc>
      consputc(c);
80100765:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100768:	89 d0                	mov    %edx,%eax
8010076a:	e8 a1 fc ff ff       	call   80100410 <consputc>
      break;
8010076f:	e9 70 ff ff ff       	jmp    801006e4 <cprintf+0x84>
80100774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100778:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010077b:	8b 10                	mov    (%eax),%edx
8010077d:	8d 48 04             	lea    0x4(%eax),%ecx
80100780:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100783:	85 d2                	test   %edx,%edx
80100785:	74 49                	je     801007d0 <cprintf+0x170>
      for(; *s; s++)
80100787:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
8010078a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      for(; *s; s++)
8010078d:	84 c0                	test   %al,%al
8010078f:	0f 84 4f ff ff ff    	je     801006e4 <cprintf+0x84>
80100795:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100798:	89 d3                	mov    %edx,%ebx
8010079a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801007a0:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
801007a3:	e8 68 fc ff ff       	call   80100410 <consputc>
      for(; *s; s++)
801007a8:	0f be 03             	movsbl (%ebx),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
      if((s = (char*)*argp++) == 0)
801007af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007b2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801007b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801007b8:	e9 27 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007bd:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
801007c0:	b8 25 00 00 00       	mov    $0x25,%eax
801007c5:	e8 46 fc ff ff       	call   80100410 <consputc>
      break;
801007ca:	e9 15 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007cf:	90                   	nop
        s = "(null)";
801007d0:	ba 18 8c 10 80       	mov    $0x80108c18,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 c5 10 80       	push   $0x8010c520
801007f0:	e8 fb 54 00 00       	call   80105cf0 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 1f 8c 10 80       	push   $0x80108c1f
80100805:	e8 86 fb ff ff       	call   80100390 <panic>
8010080a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100810 <consoleintr>:
{
80100810:	55                   	push   %ebp
80100811:	89 e5                	mov    %esp,%ebp
80100813:	57                   	push   %edi
80100814:	56                   	push   %esi
80100815:	53                   	push   %ebx
  int c, doprocdump = 0;
80100816:	31 f6                	xor    %esi,%esi
{
80100818:	83 ec 18             	sub    $0x18,%esp
8010081b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
8010081e:	68 20 c5 10 80       	push   $0x8010c520
80100823:	e8 c8 54 00 00       	call   80105cf0 <acquire>
  while((c = getc()) >= 0){
80100828:	83 c4 10             	add    $0x10,%esp
8010082b:	90                   	nop
8010082c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100830:	ff d3                	call   *%ebx
80100832:	85 c0                	test   %eax,%eax
80100834:	89 c7                	mov    %eax,%edi
80100836:	78 48                	js     80100880 <consoleintr+0x70>
    switch(c){
80100838:	83 ff 10             	cmp    $0x10,%edi
8010083b:	0f 84 e7 00 00 00    	je     80100928 <consoleintr+0x118>
80100841:	7e 5d                	jle    801008a0 <consoleintr+0x90>
80100843:	83 ff 15             	cmp    $0x15,%edi
80100846:	0f 84 ec 00 00 00    	je     80100938 <consoleintr+0x128>
8010084c:	83 ff 7f             	cmp    $0x7f,%edi
8010084f:	75 54                	jne    801008a5 <consoleintr+0x95>
      if(input.e != input.w){
80100851:	a1 c8 1f 11 80       	mov    0x80111fc8,%eax
80100856:	3b 05 c4 1f 11 80    	cmp    0x80111fc4,%eax
8010085c:	74 d2                	je     80100830 <consoleintr+0x20>
        input.e--;
8010085e:	83 e8 01             	sub    $0x1,%eax
80100861:	a3 c8 1f 11 80       	mov    %eax,0x80111fc8
        consputc(BACKSPACE);
80100866:	b8 00 01 00 00       	mov    $0x100,%eax
8010086b:	e8 a0 fb ff ff       	call   80100410 <consputc>
  while((c = getc()) >= 0){
80100870:	ff d3                	call   *%ebx
80100872:	85 c0                	test   %eax,%eax
80100874:	89 c7                	mov    %eax,%edi
80100876:	79 c0                	jns    80100838 <consoleintr+0x28>
80100878:	90                   	nop
80100879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100880:	83 ec 0c             	sub    $0xc,%esp
80100883:	68 20 c5 10 80       	push   $0x8010c520
80100888:	e8 23 55 00 00       	call   80105db0 <release>
  if(doprocdump) {
8010088d:	83 c4 10             	add    $0x10,%esp
80100890:	85 f6                	test   %esi,%esi
80100892:	0f 85 f8 00 00 00    	jne    80100990 <consoleintr+0x180>
}
80100898:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010089b:	5b                   	pop    %ebx
8010089c:	5e                   	pop    %esi
8010089d:	5f                   	pop    %edi
8010089e:	5d                   	pop    %ebp
8010089f:	c3                   	ret    
    switch(c){
801008a0:	83 ff 08             	cmp    $0x8,%edi
801008a3:	74 ac                	je     80100851 <consoleintr+0x41>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008a5:	85 ff                	test   %edi,%edi
801008a7:	74 87                	je     80100830 <consoleintr+0x20>
801008a9:	a1 c8 1f 11 80       	mov    0x80111fc8,%eax
801008ae:	89 c2                	mov    %eax,%edx
801008b0:	2b 15 c0 1f 11 80    	sub    0x80111fc0,%edx
801008b6:	83 fa 7f             	cmp    $0x7f,%edx
801008b9:	0f 87 71 ff ff ff    	ja     80100830 <consoleintr+0x20>
801008bf:	8d 50 01             	lea    0x1(%eax),%edx
801008c2:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801008c5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008c8:	89 15 c8 1f 11 80    	mov    %edx,0x80111fc8
        c = (c == '\r') ? '\n' : c;
801008ce:	0f 84 cc 00 00 00    	je     801009a0 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d4:	89 f9                	mov    %edi,%ecx
801008d6:	88 88 40 1f 11 80    	mov    %cl,-0x7feee0c0(%eax)
        consputc(c);
801008dc:	89 f8                	mov    %edi,%eax
801008de:	e8 2d fb ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e3:	83 ff 0a             	cmp    $0xa,%edi
801008e6:	0f 84 c5 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008ec:	83 ff 04             	cmp    $0x4,%edi
801008ef:	0f 84 bc 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008f5:	a1 c0 1f 11 80       	mov    0x80111fc0,%eax
801008fa:	83 e8 80             	sub    $0xffffff80,%eax
801008fd:	39 05 c8 1f 11 80    	cmp    %eax,0x80111fc8
80100903:	0f 85 27 ff ff ff    	jne    80100830 <consoleintr+0x20>
          wakeup(&input.r);
80100909:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
8010090c:	a3 c4 1f 11 80       	mov    %eax,0x80111fc4
          wakeup(&input.r);
80100911:	68 c0 1f 11 80       	push   $0x80111fc0
80100916:	e8 55 48 00 00       	call   80105170 <wakeup>
8010091b:	83 c4 10             	add    $0x10,%esp
8010091e:	e9 0d ff ff ff       	jmp    80100830 <consoleintr+0x20>
80100923:	90                   	nop
80100924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
80100928:	be 01 00 00 00       	mov    $0x1,%esi
8010092d:	e9 fe fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100938:	a1 c8 1f 11 80       	mov    0x80111fc8,%eax
8010093d:	39 05 c4 1f 11 80    	cmp    %eax,0x80111fc4
80100943:	75 2b                	jne    80100970 <consoleintr+0x160>
80100945:	e9 e6 fe ff ff       	jmp    80100830 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100950:	a3 c8 1f 11 80       	mov    %eax,0x80111fc8
        consputc(BACKSPACE);
80100955:	b8 00 01 00 00       	mov    $0x100,%eax
8010095a:	e8 b1 fa ff ff       	call   80100410 <consputc>
      while(input.e != input.w &&
8010095f:	a1 c8 1f 11 80       	mov    0x80111fc8,%eax
80100964:	3b 05 c4 1f 11 80    	cmp    0x80111fc4,%eax
8010096a:	0f 84 c0 fe ff ff    	je     80100830 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100970:	83 e8 01             	sub    $0x1,%eax
80100973:	89 c2                	mov    %eax,%edx
80100975:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100978:	80 ba 40 1f 11 80 0a 	cmpb   $0xa,-0x7feee0c0(%edx)
8010097f:	75 cf                	jne    80100950 <consoleintr+0x140>
80100981:	e9 aa fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100986:	8d 76 00             	lea    0x0(%esi),%esi
80100989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80100990:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100993:	5b                   	pop    %ebx
80100994:	5e                   	pop    %esi
80100995:	5f                   	pop    %edi
80100996:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100997:	e9 e4 48 00 00       	jmp    80105280 <procdump>
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
801009a0:	c6 80 40 1f 11 80 0a 	movb   $0xa,-0x7feee0c0(%eax)
        consputc(c);
801009a7:	b8 0a 00 00 00       	mov    $0xa,%eax
801009ac:	e8 5f fa ff ff       	call   80100410 <consputc>
801009b1:	a1 c8 1f 11 80       	mov    0x80111fc8,%eax
801009b6:	e9 4e ff ff ff       	jmp    80100909 <consoleintr+0xf9>
801009bb:	90                   	nop
801009bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009c0 <consoleinit>:

void
consoleinit(void)
{
801009c0:	55                   	push   %ebp
801009c1:	89 e5                	mov    %esp,%ebp
801009c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009c6:	68 28 8c 10 80       	push   $0x80108c28
801009cb:	68 20 c5 10 80       	push   $0x8010c520
801009d0:	e8 db 51 00 00       	call   80105bb0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009d5:	58                   	pop    %eax
801009d6:	5a                   	pop    %edx
801009d7:	6a 00                	push   $0x0
801009d9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801009db:	c7 05 8c 29 11 80 00 	movl   $0x80100600,0x8011298c
801009e2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009e5:	c7 05 88 29 11 80 70 	movl   $0x80100270,0x80112988
801009ec:	02 10 80 
  cons.locking = 1;
801009ef:	c7 05 54 c5 10 80 01 	movl   $0x1,0x8010c554
801009f6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801009f9:	e8 62 1e 00 00       	call   80102860 <ioapicenable>
}
801009fe:	83 c4 10             	add    $0x10,%esp
80100a01:	c9                   	leave  
80100a02:	c3                   	ret    
80100a03:	66 90                	xchg   %ax,%ax
80100a05:	66 90                	xchg   %ax,%ax
80100a07:	66 90                	xchg   %ax,%ax
80100a09:	66 90                	xchg   %ax,%ax
80100a0b:	66 90                	xchg   %ax,%ax
80100a0d:	66 90                	xchg   %ax,%ax
80100a0f:	90                   	nop

80100a10 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a10:	55                   	push   %ebp
80100a11:	89 e5                	mov    %esp,%ebp
80100a13:	57                   	push   %edi
80100a14:	56                   	push   %esi
80100a15:	53                   	push   %ebx
80100a16:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a1c:	e8 4f 39 00 00       	call   80104370 <myproc>
80100a21:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100a27:	e8 04 27 00 00       	call   80103130 <begin_op>

  if((ip = namei(path)) == 0){
80100a2c:	83 ec 0c             	sub    $0xc,%esp
80100a2f:	ff 75 08             	pushl  0x8(%ebp)
80100a32:	e8 39 1a 00 00       	call   80102470 <namei>
80100a37:	83 c4 10             	add    $0x10,%esp
80100a3a:	85 c0                	test   %eax,%eax
80100a3c:	0f 84 91 01 00 00    	je     80100bd3 <exec+0x1c3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a42:	83 ec 0c             	sub    $0xc,%esp
80100a45:	89 c3                	mov    %eax,%ebx
80100a47:	50                   	push   %eax
80100a48:	e8 83 0f 00 00       	call   801019d0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a4d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a53:	6a 34                	push   $0x34
80100a55:	6a 00                	push   $0x0
80100a57:	50                   	push   %eax
80100a58:	53                   	push   %ebx
80100a59:	e8 92 14 00 00       	call   80101ef0 <readi>
80100a5e:	83 c4 20             	add    $0x20,%esp
80100a61:	83 f8 34             	cmp    $0x34,%eax
80100a64:	74 22                	je     80100a88 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a66:	83 ec 0c             	sub    $0xc,%esp
80100a69:	53                   	push   %ebx
80100a6a:	e8 31 14 00 00       	call   80101ea0 <iunlockput>
    end_op();
80100a6f:	e8 2c 27 00 00       	call   801031a0 <end_op>
80100a74:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a7f:	5b                   	pop    %ebx
80100a80:	5e                   	pop    %esi
80100a81:	5f                   	pop    %edi
80100a82:	5d                   	pop    %ebp
80100a83:	c3                   	ret    
80100a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100a88:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a8f:	45 4c 46 
80100a92:	75 d2                	jne    80100a66 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100a94:	e8 87 7e 00 00       	call   80108920 <setupkvm>
80100a99:	85 c0                	test   %eax,%eax
80100a9b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100aa1:	74 c3                	je     80100a66 <exec+0x56>
  sz = 0;
80100aa3:	31 ff                	xor    %edi,%edi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100aa5:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100aac:	00 
80100aad:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100ab3:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100ab9:	0f 84 8c 02 00 00    	je     80100d4b <exec+0x33b>
80100abf:	31 f6                	xor    %esi,%esi
80100ac1:	eb 7f                	jmp    80100b42 <exec+0x132>
80100ac3:	90                   	nop
80100ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100ac8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100acf:	75 63                	jne    80100b34 <exec+0x124>
    if(ph.memsz < ph.filesz)
80100ad1:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ad7:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100add:	0f 82 86 00 00 00    	jb     80100b69 <exec+0x159>
80100ae3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ae9:	72 7e                	jb     80100b69 <exec+0x159>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100aeb:	83 ec 04             	sub    $0x4,%esp
80100aee:	50                   	push   %eax
80100aef:	57                   	push   %edi
80100af0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100af6:	e8 45 7c 00 00       	call   80108740 <allocuvm>
80100afb:	83 c4 10             	add    $0x10,%esp
80100afe:	85 c0                	test   %eax,%eax
80100b00:	89 c7                	mov    %eax,%edi
80100b02:	74 65                	je     80100b69 <exec+0x159>
    if(ph.vaddr % PGSIZE != 0)
80100b04:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b0a:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b0f:	75 58                	jne    80100b69 <exec+0x159>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b11:	83 ec 0c             	sub    $0xc,%esp
80100b14:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b1a:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b20:	53                   	push   %ebx
80100b21:	50                   	push   %eax
80100b22:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b28:	e8 53 7b 00 00       	call   80108680 <loaduvm>
80100b2d:	83 c4 20             	add    $0x20,%esp
80100b30:	85 c0                	test   %eax,%eax
80100b32:	78 35                	js     80100b69 <exec+0x159>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b34:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b3b:	83 c6 01             	add    $0x1,%esi
80100b3e:	39 f0                	cmp    %esi,%eax
80100b40:	7e 3d                	jle    80100b7f <exec+0x16f>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b42:	89 f0                	mov    %esi,%eax
80100b44:	6a 20                	push   $0x20
80100b46:	c1 e0 05             	shl    $0x5,%eax
80100b49:	03 85 ec fe ff ff    	add    -0x114(%ebp),%eax
80100b4f:	50                   	push   %eax
80100b50:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b56:	50                   	push   %eax
80100b57:	53                   	push   %ebx
80100b58:	e8 93 13 00 00       	call   80101ef0 <readi>
80100b5d:	83 c4 10             	add    $0x10,%esp
80100b60:	83 f8 20             	cmp    $0x20,%eax
80100b63:	0f 84 5f ff ff ff    	je     80100ac8 <exec+0xb8>
    freevm(pgdir);
80100b69:	83 ec 0c             	sub    $0xc,%esp
80100b6c:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b72:	e8 29 7d 00 00       	call   801088a0 <freevm>
80100b77:	83 c4 10             	add    $0x10,%esp
80100b7a:	e9 e7 fe ff ff       	jmp    80100a66 <exec+0x56>
80100b7f:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100b85:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100b8b:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100b91:	83 ec 0c             	sub    $0xc,%esp
80100b94:	53                   	push   %ebx
80100b95:	e8 06 13 00 00       	call   80101ea0 <iunlockput>
  end_op();
80100b9a:	e8 01 26 00 00       	call   801031a0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b9f:	83 c4 0c             	add    $0xc,%esp
80100ba2:	56                   	push   %esi
80100ba3:	57                   	push   %edi
80100ba4:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100baa:	e8 91 7b 00 00       	call   80108740 <allocuvm>
80100baf:	83 c4 10             	add    $0x10,%esp
80100bb2:	85 c0                	test   %eax,%eax
80100bb4:	89 c6                	mov    %eax,%esi
80100bb6:	75 3a                	jne    80100bf2 <exec+0x1e2>
    freevm(pgdir);
80100bb8:	83 ec 0c             	sub    $0xc,%esp
80100bbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bc1:	e8 da 7c 00 00       	call   801088a0 <freevm>
80100bc6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100bc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bce:	e9 a9 fe ff ff       	jmp    80100a7c <exec+0x6c>
    end_op();
80100bd3:	e8 c8 25 00 00       	call   801031a0 <end_op>
    cprintf("exec: fail\n");
80100bd8:	83 ec 0c             	sub    $0xc,%esp
80100bdb:	68 41 8c 10 80       	push   $0x80108c41
80100be0:	e8 7b fa ff ff       	call   80100660 <cprintf>
    return -1;
80100be5:	83 c4 10             	add    $0x10,%esp
80100be8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bed:	e9 8a fe ff ff       	jmp    80100a7c <exec+0x6c>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bf2:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100bf8:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100bfb:	31 ff                	xor    %edi,%edi
80100bfd:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bff:	50                   	push   %eax
80100c00:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c06:	e8 b5 7d 00 00       	call   801089c0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c0b:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c0e:	83 c4 10             	add    $0x10,%esp
80100c11:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c17:	8b 00                	mov    (%eax),%eax
80100c19:	85 c0                	test   %eax,%eax
80100c1b:	74 70                	je     80100c8d <exec+0x27d>
80100c1d:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100c23:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c29:	eb 0a                	jmp    80100c35 <exec+0x225>
80100c2b:	90                   	nop
80100c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100c30:	83 ff 20             	cmp    $0x20,%edi
80100c33:	74 83                	je     80100bb8 <exec+0x1a8>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c35:	83 ec 0c             	sub    $0xc,%esp
80100c38:	50                   	push   %eax
80100c39:	e8 e2 53 00 00       	call   80106020 <strlen>
80100c3e:	f7 d0                	not    %eax
80100c40:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c42:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c45:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c46:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c49:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4c:	e8 cf 53 00 00       	call   80106020 <strlen>
80100c51:	83 c0 01             	add    $0x1,%eax
80100c54:	50                   	push   %eax
80100c55:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c58:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c5b:	53                   	push   %ebx
80100c5c:	56                   	push   %esi
80100c5d:	e8 be 7e 00 00       	call   80108b20 <copyout>
80100c62:	83 c4 20             	add    $0x20,%esp
80100c65:	85 c0                	test   %eax,%eax
80100c67:	0f 88 4b ff ff ff    	js     80100bb8 <exec+0x1a8>
  for(argc = 0; argv[argc]; argc++) {
80100c6d:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c70:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c77:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100c7a:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100c80:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c83:	85 c0                	test   %eax,%eax
80100c85:	75 a9                	jne    80100c30 <exec+0x220>
80100c87:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c8d:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c94:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100c96:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c9d:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100ca1:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100ca8:	ff ff ff 
  ustack[1] = argc;
80100cab:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb1:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100cb3:	83 c0 0c             	add    $0xc,%eax
80100cb6:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cb8:	50                   	push   %eax
80100cb9:	52                   	push   %edx
80100cba:	53                   	push   %ebx
80100cbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cc1:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cc7:	e8 54 7e 00 00       	call   80108b20 <copyout>
80100ccc:	83 c4 10             	add    $0x10,%esp
80100ccf:	85 c0                	test   %eax,%eax
80100cd1:	0f 88 e1 fe ff ff    	js     80100bb8 <exec+0x1a8>
  for(last=s=path; *s; s++)
80100cd7:	8b 45 08             	mov    0x8(%ebp),%eax
80100cda:	0f b6 00             	movzbl (%eax),%eax
80100cdd:	84 c0                	test   %al,%al
80100cdf:	74 17                	je     80100cf8 <exec+0x2e8>
80100ce1:	8b 55 08             	mov    0x8(%ebp),%edx
80100ce4:	89 d1                	mov    %edx,%ecx
80100ce6:	83 c1 01             	add    $0x1,%ecx
80100ce9:	3c 2f                	cmp    $0x2f,%al
80100ceb:	0f b6 01             	movzbl (%ecx),%eax
80100cee:	0f 44 d1             	cmove  %ecx,%edx
80100cf1:	84 c0                	test   %al,%al
80100cf3:	75 f1                	jne    80100ce6 <exec+0x2d6>
80100cf5:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cf8:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cfe:	50                   	push   %eax
80100cff:	6a 10                	push   $0x10
80100d01:	ff 75 08             	pushl  0x8(%ebp)
80100d04:	89 f8                	mov    %edi,%eax
80100d06:	83 c0 6c             	add    $0x6c,%eax
80100d09:	50                   	push   %eax
80100d0a:	e8 d1 52 00 00       	call   80105fe0 <safestrcpy>
  curproc->pgdir = pgdir;
80100d0f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  oldpgdir = curproc->pgdir;
80100d15:	89 f9                	mov    %edi,%ecx
80100d17:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->tf->eip = elf.entry;  // main
80100d1a:	8b 41 18             	mov    0x18(%ecx),%eax
  curproc->sz = sz;
80100d1d:	89 31                	mov    %esi,(%ecx)
  curproc->pgdir = pgdir;
80100d1f:	89 51 04             	mov    %edx,0x4(%ecx)
  curproc->tf->eip = elf.entry;  // main
80100d22:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d28:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d2b:	8b 41 18             	mov    0x18(%ecx),%eax
80100d2e:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d31:	89 0c 24             	mov    %ecx,(%esp)
80100d34:	e8 b7 77 00 00       	call   801084f0 <switchuvm>
  freevm(oldpgdir);
80100d39:	89 3c 24             	mov    %edi,(%esp)
80100d3c:	e8 5f 7b 00 00       	call   801088a0 <freevm>
  return 0;
80100d41:	83 c4 10             	add    $0x10,%esp
80100d44:	31 c0                	xor    %eax,%eax
80100d46:	e9 31 fd ff ff       	jmp    80100a7c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d4b:	be 00 20 00 00       	mov    $0x2000,%esi
80100d50:	e9 3c fe ff ff       	jmp    80100b91 <exec+0x181>
80100d55:	66 90                	xchg   %ax,%ax
80100d57:	66 90                	xchg   %ax,%ax
80100d59:	66 90                	xchg   %ax,%ax
80100d5b:	66 90                	xchg   %ax,%ax
80100d5d:	66 90                	xchg   %ax,%ax
80100d5f:	90                   	nop

80100d60 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d60:	55                   	push   %ebp
80100d61:	89 e5                	mov    %esp,%ebp
80100d63:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d66:	68 4d 8c 10 80       	push   $0x80108c4d
80100d6b:	68 e0 1f 11 80       	push   $0x80111fe0
80100d70:	e8 3b 4e 00 00       	call   80105bb0 <initlock>
}
80100d75:	83 c4 10             	add    $0x10,%esp
80100d78:	c9                   	leave  
80100d79:	c3                   	ret    
80100d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d80 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d80:	55                   	push   %ebp
80100d81:	89 e5                	mov    %esp,%ebp
80100d83:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d84:	bb 14 20 11 80       	mov    $0x80112014,%ebx
{
80100d89:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100d8c:	68 e0 1f 11 80       	push   $0x80111fe0
80100d91:	e8 5a 4f 00 00       	call   80105cf0 <acquire>
80100d96:	83 c4 10             	add    $0x10,%esp
80100d99:	eb 10                	jmp    80100dab <filealloc+0x2b>
80100d9b:	90                   	nop
80100d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100da0:	83 c3 18             	add    $0x18,%ebx
80100da3:	81 fb 74 29 11 80    	cmp    $0x80112974,%ebx
80100da9:	73 25                	jae    80100dd0 <filealloc+0x50>
    if(f->ref == 0){
80100dab:	8b 43 04             	mov    0x4(%ebx),%eax
80100dae:	85 c0                	test   %eax,%eax
80100db0:	75 ee                	jne    80100da0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100db2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100db5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100dbc:	68 e0 1f 11 80       	push   $0x80111fe0
80100dc1:	e8 ea 4f 00 00       	call   80105db0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100dc6:	89 d8                	mov    %ebx,%eax
      return f;
80100dc8:	83 c4 10             	add    $0x10,%esp
}
80100dcb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dce:	c9                   	leave  
80100dcf:	c3                   	ret    
  release(&ftable.lock);
80100dd0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100dd3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100dd5:	68 e0 1f 11 80       	push   $0x80111fe0
80100dda:	e8 d1 4f 00 00       	call   80105db0 <release>
}
80100ddf:	89 d8                	mov    %ebx,%eax
  return 0;
80100de1:	83 c4 10             	add    $0x10,%esp
}
80100de4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100de7:	c9                   	leave  
80100de8:	c3                   	ret    
80100de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100df0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100df0:	55                   	push   %ebp
80100df1:	89 e5                	mov    %esp,%ebp
80100df3:	53                   	push   %ebx
80100df4:	83 ec 10             	sub    $0x10,%esp
80100df7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dfa:	68 e0 1f 11 80       	push   $0x80111fe0
80100dff:	e8 ec 4e 00 00       	call   80105cf0 <acquire>
  if(f->ref < 1)
80100e04:	8b 43 04             	mov    0x4(%ebx),%eax
80100e07:	83 c4 10             	add    $0x10,%esp
80100e0a:	85 c0                	test   %eax,%eax
80100e0c:	7e 1a                	jle    80100e28 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e0e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e11:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100e14:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e17:	68 e0 1f 11 80       	push   $0x80111fe0
80100e1c:	e8 8f 4f 00 00       	call   80105db0 <release>
  return f;
}
80100e21:	89 d8                	mov    %ebx,%eax
80100e23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e26:	c9                   	leave  
80100e27:	c3                   	ret    
    panic("filedup");
80100e28:	83 ec 0c             	sub    $0xc,%esp
80100e2b:	68 54 8c 10 80       	push   $0x80108c54
80100e30:	e8 5b f5 ff ff       	call   80100390 <panic>
80100e35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e40 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e40:	55                   	push   %ebp
80100e41:	89 e5                	mov    %esp,%ebp
80100e43:	57                   	push   %edi
80100e44:	56                   	push   %esi
80100e45:	53                   	push   %ebx
80100e46:	83 ec 28             	sub    $0x28,%esp
80100e49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100e4c:	68 e0 1f 11 80       	push   $0x80111fe0
80100e51:	e8 9a 4e 00 00       	call   80105cf0 <acquire>
  if(f->ref < 1)
80100e56:	8b 43 04             	mov    0x4(%ebx),%eax
80100e59:	83 c4 10             	add    $0x10,%esp
80100e5c:	85 c0                	test   %eax,%eax
80100e5e:	0f 8e 9b 00 00 00    	jle    80100eff <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e64:	83 e8 01             	sub    $0x1,%eax
80100e67:	85 c0                	test   %eax,%eax
80100e69:	89 43 04             	mov    %eax,0x4(%ebx)
80100e6c:	74 1a                	je     80100e88 <fileclose+0x48>
    release(&ftable.lock);
80100e6e:	c7 45 08 e0 1f 11 80 	movl   $0x80111fe0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e75:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e78:	5b                   	pop    %ebx
80100e79:	5e                   	pop    %esi
80100e7a:	5f                   	pop    %edi
80100e7b:	5d                   	pop    %ebp
    release(&ftable.lock);
80100e7c:	e9 2f 4f 00 00       	jmp    80105db0 <release>
80100e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100e88:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100e8c:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100e8e:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100e91:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100e94:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100e9a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e9d:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100ea0:	68 e0 1f 11 80       	push   $0x80111fe0
  ff = *f;
80100ea5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100ea8:	e8 03 4f 00 00       	call   80105db0 <release>
  if(ff.type == FD_PIPE)
80100ead:	83 c4 10             	add    $0x10,%esp
80100eb0:	83 ff 01             	cmp    $0x1,%edi
80100eb3:	74 13                	je     80100ec8 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100eb5:	83 ff 02             	cmp    $0x2,%edi
80100eb8:	74 26                	je     80100ee0 <fileclose+0xa0>
}
80100eba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ebd:	5b                   	pop    %ebx
80100ebe:	5e                   	pop    %esi
80100ebf:	5f                   	pop    %edi
80100ec0:	5d                   	pop    %ebp
80100ec1:	c3                   	ret    
80100ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100ec8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100ecc:	83 ec 08             	sub    $0x8,%esp
80100ecf:	53                   	push   %ebx
80100ed0:	56                   	push   %esi
80100ed1:	e8 0a 2a 00 00       	call   801038e0 <pipeclose>
80100ed6:	83 c4 10             	add    $0x10,%esp
80100ed9:	eb df                	jmp    80100eba <fileclose+0x7a>
80100edb:	90                   	nop
80100edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100ee0:	e8 4b 22 00 00       	call   80103130 <begin_op>
    iput(ff.ip);
80100ee5:	83 ec 0c             	sub    $0xc,%esp
80100ee8:	ff 75 e0             	pushl  -0x20(%ebp)
80100eeb:	e8 10 0c 00 00       	call   80101b00 <iput>
    end_op();
80100ef0:	83 c4 10             	add    $0x10,%esp
}
80100ef3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ef6:	5b                   	pop    %ebx
80100ef7:	5e                   	pop    %esi
80100ef8:	5f                   	pop    %edi
80100ef9:	5d                   	pop    %ebp
    end_op();
80100efa:	e9 a1 22 00 00       	jmp    801031a0 <end_op>
    panic("fileclose");
80100eff:	83 ec 0c             	sub    $0xc,%esp
80100f02:	68 5c 8c 10 80       	push   $0x80108c5c
80100f07:	e8 84 f4 ff ff       	call   80100390 <panic>
80100f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f10 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f10:	55                   	push   %ebp
80100f11:	89 e5                	mov    %esp,%ebp
80100f13:	53                   	push   %ebx
80100f14:	83 ec 04             	sub    $0x4,%esp
80100f17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f1a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f1d:	75 31                	jne    80100f50 <filestat+0x40>
    ilock(f->ip);
80100f1f:	83 ec 0c             	sub    $0xc,%esp
80100f22:	ff 73 10             	pushl  0x10(%ebx)
80100f25:	e8 a6 0a 00 00       	call   801019d0 <ilock>
    stati(f->ip, st);
80100f2a:	58                   	pop    %eax
80100f2b:	5a                   	pop    %edx
80100f2c:	ff 75 0c             	pushl  0xc(%ebp)
80100f2f:	ff 73 10             	pushl  0x10(%ebx)
80100f32:	e8 89 0f 00 00       	call   80101ec0 <stati>
    iunlock(f->ip);
80100f37:	59                   	pop    %ecx
80100f38:	ff 73 10             	pushl  0x10(%ebx)
80100f3b:	e8 70 0b 00 00       	call   80101ab0 <iunlock>
    return 0;
80100f40:	83 c4 10             	add    $0x10,%esp
80100f43:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f48:	c9                   	leave  
80100f49:	c3                   	ret    
80100f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80100f50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f55:	eb ee                	jmp    80100f45 <filestat+0x35>
80100f57:	89 f6                	mov    %esi,%esi
80100f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f60 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f60:	55                   	push   %ebp
80100f61:	89 e5                	mov    %esp,%ebp
80100f63:	57                   	push   %edi
80100f64:	56                   	push   %esi
80100f65:	53                   	push   %ebx
80100f66:	83 ec 0c             	sub    $0xc,%esp
80100f69:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f6c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f6f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f72:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f76:	74 60                	je     80100fd8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f78:	8b 03                	mov    (%ebx),%eax
80100f7a:	83 f8 01             	cmp    $0x1,%eax
80100f7d:	74 41                	je     80100fc0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f7f:	83 f8 02             	cmp    $0x2,%eax
80100f82:	75 5b                	jne    80100fdf <fileread+0x7f>
    ilock(f->ip);
80100f84:	83 ec 0c             	sub    $0xc,%esp
80100f87:	ff 73 10             	pushl  0x10(%ebx)
80100f8a:	e8 41 0a 00 00       	call   801019d0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f8f:	57                   	push   %edi
80100f90:	ff 73 14             	pushl  0x14(%ebx)
80100f93:	56                   	push   %esi
80100f94:	ff 73 10             	pushl  0x10(%ebx)
80100f97:	e8 54 0f 00 00       	call   80101ef0 <readi>
80100f9c:	83 c4 20             	add    $0x20,%esp
80100f9f:	85 c0                	test   %eax,%eax
80100fa1:	89 c6                	mov    %eax,%esi
80100fa3:	7e 03                	jle    80100fa8 <fileread+0x48>
      f->off += r;
80100fa5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100fa8:	83 ec 0c             	sub    $0xc,%esp
80100fab:	ff 73 10             	pushl  0x10(%ebx)
80100fae:	e8 fd 0a 00 00       	call   80101ab0 <iunlock>
    return r;
80100fb3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80100fb6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb9:	89 f0                	mov    %esi,%eax
80100fbb:	5b                   	pop    %ebx
80100fbc:	5e                   	pop    %esi
80100fbd:	5f                   	pop    %edi
80100fbe:	5d                   	pop    %ebp
80100fbf:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80100fc0:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fc3:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100fc6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fc9:	5b                   	pop    %ebx
80100fca:	5e                   	pop    %esi
80100fcb:	5f                   	pop    %edi
80100fcc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100fcd:	e9 be 2a 00 00       	jmp    80103a90 <piperead>
80100fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80100fd8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80100fdd:	eb d7                	jmp    80100fb6 <fileread+0x56>
  panic("fileread");
80100fdf:	83 ec 0c             	sub    $0xc,%esp
80100fe2:	68 66 8c 10 80       	push   $0x80108c66
80100fe7:	e8 a4 f3 ff ff       	call   80100390 <panic>
80100fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ff0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100ff0:	55                   	push   %ebp
80100ff1:	89 e5                	mov    %esp,%ebp
80100ff3:	57                   	push   %edi
80100ff4:	56                   	push   %esi
80100ff5:	53                   	push   %ebx
80100ff6:	83 ec 1c             	sub    $0x1c,%esp
80100ff9:	8b 75 08             	mov    0x8(%ebp),%esi
80100ffc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80100fff:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101003:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101006:	8b 45 10             	mov    0x10(%ebp),%eax
80101009:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010100c:	0f 84 aa 00 00 00    	je     801010bc <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101012:	8b 06                	mov    (%esi),%eax
80101014:	83 f8 01             	cmp    $0x1,%eax
80101017:	0f 84 c3 00 00 00    	je     801010e0 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010101d:	83 f8 02             	cmp    $0x2,%eax
80101020:	0f 85 d9 00 00 00    	jne    801010ff <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101026:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101029:	31 ff                	xor    %edi,%edi
    while(i < n){
8010102b:	85 c0                	test   %eax,%eax
8010102d:	7f 34                	jg     80101063 <filewrite+0x73>
8010102f:	e9 9c 00 00 00       	jmp    801010d0 <filewrite+0xe0>
80101034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101038:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010103b:	83 ec 0c             	sub    $0xc,%esp
8010103e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101041:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101044:	e8 67 0a 00 00       	call   80101ab0 <iunlock>
      end_op();
80101049:	e8 52 21 00 00       	call   801031a0 <end_op>
8010104e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101051:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101054:	39 c3                	cmp    %eax,%ebx
80101056:	0f 85 96 00 00 00    	jne    801010f2 <filewrite+0x102>
        panic("short filewrite");
      i += r;
8010105c:	01 df                	add    %ebx,%edi
    while(i < n){
8010105e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101061:	7e 6d                	jle    801010d0 <filewrite+0xe0>
      int n1 = n - i;
80101063:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101066:	b8 00 06 00 00       	mov    $0x600,%eax
8010106b:	29 fb                	sub    %edi,%ebx
8010106d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101073:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101076:	e8 b5 20 00 00       	call   80103130 <begin_op>
      ilock(f->ip);
8010107b:	83 ec 0c             	sub    $0xc,%esp
8010107e:	ff 76 10             	pushl  0x10(%esi)
80101081:	e8 4a 09 00 00       	call   801019d0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101086:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101089:	53                   	push   %ebx
8010108a:	ff 76 14             	pushl  0x14(%esi)
8010108d:	01 f8                	add    %edi,%eax
8010108f:	50                   	push   %eax
80101090:	ff 76 10             	pushl  0x10(%esi)
80101093:	e8 58 0f 00 00       	call   80101ff0 <writei>
80101098:	83 c4 20             	add    $0x20,%esp
8010109b:	85 c0                	test   %eax,%eax
8010109d:	7f 99                	jg     80101038 <filewrite+0x48>
      iunlock(f->ip);
8010109f:	83 ec 0c             	sub    $0xc,%esp
801010a2:	ff 76 10             	pushl  0x10(%esi)
801010a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010a8:	e8 03 0a 00 00       	call   80101ab0 <iunlock>
      end_op();
801010ad:	e8 ee 20 00 00       	call   801031a0 <end_op>
      if(r < 0)
801010b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010b5:	83 c4 10             	add    $0x10,%esp
801010b8:	85 c0                	test   %eax,%eax
801010ba:	74 98                	je     80101054 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801010bf:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
801010c4:	89 f8                	mov    %edi,%eax
801010c6:	5b                   	pop    %ebx
801010c7:	5e                   	pop    %esi
801010c8:	5f                   	pop    %edi
801010c9:	5d                   	pop    %ebp
801010ca:	c3                   	ret    
801010cb:	90                   	nop
801010cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
801010d0:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010d3:	75 e7                	jne    801010bc <filewrite+0xcc>
}
801010d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010d8:	89 f8                	mov    %edi,%eax
801010da:	5b                   	pop    %ebx
801010db:	5e                   	pop    %esi
801010dc:	5f                   	pop    %edi
801010dd:	5d                   	pop    %ebp
801010de:	c3                   	ret    
801010df:	90                   	nop
    return pipewrite(f->pipe, addr, n);
801010e0:	8b 46 0c             	mov    0xc(%esi),%eax
801010e3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010e9:	5b                   	pop    %ebx
801010ea:	5e                   	pop    %esi
801010eb:	5f                   	pop    %edi
801010ec:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801010ed:	e9 8e 28 00 00       	jmp    80103980 <pipewrite>
        panic("short filewrite");
801010f2:	83 ec 0c             	sub    $0xc,%esp
801010f5:	68 6f 8c 10 80       	push   $0x80108c6f
801010fa:	e8 91 f2 ff ff       	call   80100390 <panic>
  panic("filewrite");
801010ff:	83 ec 0c             	sub    $0xc,%esp
80101102:	68 75 8c 10 80       	push   $0x80108c75
80101107:	e8 84 f2 ff ff       	call   80100390 <panic>
8010110c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101110 <pfileread>:

int
pfileread(struct file* f, char *addr, int n, int off)
{
80101110:	55                   	push   %ebp
80101111:	89 e5                	mov    %esp,%ebp
80101113:	57                   	push   %edi
80101114:	56                   	push   %esi
80101115:	53                   	push   %ebx
80101116:	83 ec 0c             	sub    $0xc,%esp
80101119:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010111c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010111f:	8b 7d 10             	mov    0x10(%ebp),%edi
	int r;

	if(f->readable == 0)
80101122:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101126:	74 60                	je     80101188 <pfileread+0x78>
		return -1;
	if(f->type == FD_PIPE)
80101128:	8b 03                	mov    (%ebx),%eax
8010112a:	83 f8 01             	cmp    $0x1,%eax
8010112d:	74 41                	je     80101170 <pfileread+0x60>
		return piperead(f->pipe, addr, n);
	if(f->type == FD_INODE){
8010112f:	83 f8 02             	cmp    $0x2,%eax
80101132:	75 5b                	jne    8010118f <pfileread+0x7f>
		ilock(f->ip);
80101134:	83 ec 0c             	sub    $0xc,%esp
80101137:	ff 73 10             	pushl  0x10(%ebx)
8010113a:	e8 91 08 00 00       	call   801019d0 <ilock>
		if((r = readi(f->ip, addr, f->off, n)) > 0)
8010113f:	57                   	push   %edi
80101140:	ff 73 14             	pushl  0x14(%ebx)
80101143:	56                   	push   %esi
80101144:	ff 73 10             	pushl  0x10(%ebx)
80101147:	e8 a4 0d 00 00       	call   80101ef0 <readi>
8010114c:	83 c4 20             	add    $0x20,%esp
8010114f:	85 c0                	test   %eax,%eax
80101151:	89 c6                	mov    %eax,%esi
80101153:	7e 03                	jle    80101158 <pfileread+0x48>
			f->off+= r;
80101155:	01 43 14             	add    %eax,0x14(%ebx)
		iunlock(f->ip);
80101158:	83 ec 0c             	sub    $0xc,%esp
8010115b:	ff 73 10             	pushl  0x10(%ebx)
8010115e:	e8 4d 09 00 00       	call   80101ab0 <iunlock>
		return r;
80101163:	83 c4 10             	add    $0x10,%esp
	}
	panic("fileread");
}
80101166:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101169:	89 f0                	mov    %esi,%eax
8010116b:	5b                   	pop    %ebx
8010116c:	5e                   	pop    %esi
8010116d:	5f                   	pop    %edi
8010116e:	5d                   	pop    %ebp
8010116f:	c3                   	ret    
		return piperead(f->pipe, addr, n);
80101170:	8b 43 0c             	mov    0xc(%ebx),%eax
80101173:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101176:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101179:	5b                   	pop    %ebx
8010117a:	5e                   	pop    %esi
8010117b:	5f                   	pop    %edi
8010117c:	5d                   	pop    %ebp
		return piperead(f->pipe, addr, n);
8010117d:	e9 0e 29 00 00       	jmp    80103a90 <piperead>
80101182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		return -1;
80101188:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010118d:	eb d7                	jmp    80101166 <pfileread+0x56>
	panic("fileread");
8010118f:	83 ec 0c             	sub    $0xc,%esp
80101192:	68 66 8c 10 80       	push   $0x80108c66
80101197:	e8 f4 f1 ff ff       	call   80100390 <panic>
8010119c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801011a0 <pfilewrite>:

int
pfilewrite(struct file *f, char* addr, int n, int offset)
{
801011a0:	55                   	push   %ebp
801011a1:	89 e5                	mov    %esp,%ebp
801011a3:	57                   	push   %edi
801011a4:	56                   	push   %esi
801011a5:	53                   	push   %ebx
801011a6:	83 ec 0c             	sub    $0xc,%esp
	int r;

	if(f->writable == 0 || f->type != FD_INODE)
801011a9:	8b 45 08             	mov    0x8(%ebp),%eax
801011ac:	80 78 09 00          	cmpb   $0x0,0x9(%eax)
801011b0:	0f 84 91 00 00 00    	je     80101247 <pfilewrite+0xa7>
801011b6:	8b 45 08             	mov    0x8(%ebp),%eax
801011b9:	83 38 02             	cmpl   $0x2,(%eax)
801011bc:	0f 85 85 00 00 00    	jne    80101247 <pfilewrite+0xa7>
		return -1;

	int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
	int i = 0;
	int off = f->off + offset;
801011c2:	8b 5d 14             	mov    0x14(%ebp),%ebx
801011c5:	03 58 14             	add    0x14(%eax),%ebx
	int i = 0;
801011c8:	31 ff                	xor    %edi,%edi

	begin_op();
801011ca:	e8 61 1f 00 00       	call   80103130 <begin_op>
	ilock(f->ip);
801011cf:	8b 45 08             	mov    0x8(%ebp),%eax
801011d2:	83 ec 0c             	sub    $0xc,%esp
801011d5:	ff 70 10             	pushl  0x10(%eax)
801011d8:	e8 f3 07 00 00       	call   801019d0 <ilock>
		
	while(i < n){
801011dd:	8b 45 10             	mov    0x10(%ebp),%eax
801011e0:	83 c4 10             	add    $0x10,%esp
801011e3:	85 c0                	test   %eax,%eax
801011e5:	7e 7b                	jle    80101262 <pfilewrite+0xc2>
801011e7:	89 f8                	mov    %edi,%eax
801011e9:	89 df                	mov    %ebx,%edi
801011eb:	89 c3                	mov    %eax,%ebx
801011ed:	eb 12                	jmp    80101201 <pfilewrite+0x61>
801011ef:	90                   	nop
		int n1 = n - i;
		if(n1 > max)
			n1 = max;
		
		if((r = writei(f->ip, addr + i, off, n1)) > 0)
			off += r;
801011f0:	01 c7                	add    %eax,%edi

		if(r < 0)
			break;
		if(r != n1)
801011f2:	39 c6                	cmp    %eax,%esi
801011f4:	0f 85 8d 00 00 00    	jne    80101287 <pfilewrite+0xe7>
			panic("short filewrite");

		i+=r;
801011fa:	01 f3                	add    %esi,%ebx
	while(i < n){
801011fc:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801011ff:	7e 5f                	jle    80101260 <pfilewrite+0xc0>
		int n1 = n - i;
80101201:	8b 75 10             	mov    0x10(%ebp),%esi
80101204:	b8 00 06 00 00       	mov    $0x600,%eax
80101209:	29 de                	sub    %ebx,%esi
8010120b:	81 fe 00 06 00 00    	cmp    $0x600,%esi
80101211:	0f 4f f0             	cmovg  %eax,%esi
		if((r = writei(f->ip, addr + i, off, n1)) > 0)
80101214:	8b 45 0c             	mov    0xc(%ebp),%eax
80101217:	56                   	push   %esi
80101218:	57                   	push   %edi
80101219:	01 d8                	add    %ebx,%eax
8010121b:	50                   	push   %eax
8010121c:	8b 45 08             	mov    0x8(%ebp),%eax
8010121f:	ff 70 10             	pushl  0x10(%eax)
80101222:	e8 c9 0d 00 00       	call   80101ff0 <writei>
80101227:	83 c4 10             	add    $0x10,%esp
8010122a:	83 f8 00             	cmp    $0x0,%eax
8010122d:	7f c1                	jg     801011f0 <pfilewrite+0x50>
		if(r < 0)
8010122f:	74 c1                	je     801011f2 <pfilewrite+0x52>
	}

	iunlock(f->ip);
80101231:	8b 45 08             	mov    0x8(%ebp),%eax
80101234:	83 ec 0c             	sub    $0xc,%esp
80101237:	ff 70 10             	pushl  0x10(%eax)
8010123a:	e8 71 08 00 00       	call   80101ab0 <iunlock>
	end_op();
8010123f:	e8 5c 1f 00 00       	call   801031a0 <end_op>
80101244:	83 c4 10             	add    $0x10,%esp
	
	return i == n ? n : -1;
}
80101247:	8d 65 f4             	lea    -0xc(%ebp),%esp
	return i == n ? n : -1;
8010124a:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
8010124f:	89 f8                	mov    %edi,%eax
80101251:	5b                   	pop    %ebx
80101252:	5e                   	pop    %esi
80101253:	5f                   	pop    %edi
80101254:	5d                   	pop    %ebp
80101255:	c3                   	ret    
80101256:	8d 76 00             	lea    0x0(%esi),%esi
80101259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101260:	89 df                	mov    %ebx,%edi
	iunlock(f->ip);
80101262:	8b 45 08             	mov    0x8(%ebp),%eax
80101265:	83 ec 0c             	sub    $0xc,%esp
80101268:	ff 70 10             	pushl  0x10(%eax)
8010126b:	e8 40 08 00 00       	call   80101ab0 <iunlock>
	end_op();
80101270:	e8 2b 1f 00 00       	call   801031a0 <end_op>
	return i == n ? n : -1;
80101275:	83 c4 10             	add    $0x10,%esp
80101278:	39 7d 10             	cmp    %edi,0x10(%ebp)
8010127b:	75 ca                	jne    80101247 <pfilewrite+0xa7>
}
8010127d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101280:	89 f8                	mov    %edi,%eax
80101282:	5b                   	pop    %ebx
80101283:	5e                   	pop    %esi
80101284:	5f                   	pop    %edi
80101285:	5d                   	pop    %ebp
80101286:	c3                   	ret    
			panic("short filewrite");
80101287:	83 ec 0c             	sub    $0xc,%esp
8010128a:	68 6f 8c 10 80       	push   $0x80108c6f
8010128f:	e8 fc f0 ff ff       	call   80100390 <panic>
80101294:	66 90                	xchg   %ax,%ax
80101296:	66 90                	xchg   %ax,%ax
80101298:	66 90                	xchg   %ax,%ax
8010129a:	66 90                	xchg   %ax,%ax
8010129c:	66 90                	xchg   %ax,%ax
8010129e:	66 90                	xchg   %ax,%ax

801012a0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801012a0:	55                   	push   %ebp
801012a1:	89 e5                	mov    %esp,%ebp
801012a3:	56                   	push   %esi
801012a4:	53                   	push   %ebx
801012a5:	89 d3                	mov    %edx,%ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
801012a7:	c1 ea 0c             	shr    $0xc,%edx
801012aa:	03 15 f8 29 11 80    	add    0x801129f8,%edx
801012b0:	83 ec 08             	sub    $0x8,%esp
801012b3:	52                   	push   %edx
801012b4:	50                   	push   %eax
801012b5:	e8 16 ee ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
801012ba:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801012bc:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
801012bf:	ba 01 00 00 00       	mov    $0x1,%edx
801012c4:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
801012c7:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
801012cd:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
801012d0:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
801012d2:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
801012d7:	85 d1                	test   %edx,%ecx
801012d9:	74 25                	je     80101300 <bfree+0x60>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
801012db:	f7 d2                	not    %edx
801012dd:	89 c6                	mov    %eax,%esi
  log_write(bp);
801012df:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
801012e2:	21 ca                	and    %ecx,%edx
801012e4:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
801012e8:	56                   	push   %esi
801012e9:	e8 12 20 00 00       	call   80103300 <log_write>
  brelse(bp);
801012ee:	89 34 24             	mov    %esi,(%esp)
801012f1:	e8 ea ee ff ff       	call   801001e0 <brelse>
}
801012f6:	83 c4 10             	add    $0x10,%esp
801012f9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801012fc:	5b                   	pop    %ebx
801012fd:	5e                   	pop    %esi
801012fe:	5d                   	pop    %ebp
801012ff:	c3                   	ret    
    panic("freeing free block");
80101300:	83 ec 0c             	sub    $0xc,%esp
80101303:	68 7f 8c 10 80       	push   $0x80108c7f
80101308:	e8 83 f0 ff ff       	call   80100390 <panic>
8010130d:	8d 76 00             	lea    0x0(%esi),%esi

80101310 <balloc>:
{
80101310:	55                   	push   %ebp
80101311:	89 e5                	mov    %esp,%ebp
80101313:	57                   	push   %edi
80101314:	56                   	push   %esi
80101315:	53                   	push   %ebx
80101316:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80101319:	8b 0d e0 29 11 80    	mov    0x801129e0,%ecx
{
8010131f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101322:	85 c9                	test   %ecx,%ecx
80101324:	0f 84 87 00 00 00    	je     801013b1 <balloc+0xa1>
8010132a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101331:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101334:	83 ec 08             	sub    $0x8,%esp
80101337:	89 f0                	mov    %esi,%eax
80101339:	c1 f8 0c             	sar    $0xc,%eax
8010133c:	03 05 f8 29 11 80    	add    0x801129f8,%eax
80101342:	50                   	push   %eax
80101343:	ff 75 d8             	pushl  -0x28(%ebp)
80101346:	e8 85 ed ff ff       	call   801000d0 <bread>
8010134b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010134e:	a1 e0 29 11 80       	mov    0x801129e0,%eax
80101353:	83 c4 10             	add    $0x10,%esp
80101356:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101359:	31 c0                	xor    %eax,%eax
8010135b:	eb 2f                	jmp    8010138c <balloc+0x7c>
8010135d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101360:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101362:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101365:	bb 01 00 00 00       	mov    $0x1,%ebx
8010136a:	83 e1 07             	and    $0x7,%ecx
8010136d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010136f:	89 c1                	mov    %eax,%ecx
80101371:	c1 f9 03             	sar    $0x3,%ecx
80101374:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101379:	85 df                	test   %ebx,%edi
8010137b:	89 fa                	mov    %edi,%edx
8010137d:	74 41                	je     801013c0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010137f:	83 c0 01             	add    $0x1,%eax
80101382:	83 c6 01             	add    $0x1,%esi
80101385:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010138a:	74 05                	je     80101391 <balloc+0x81>
8010138c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010138f:	77 cf                	ja     80101360 <balloc+0x50>
    brelse(bp);
80101391:	83 ec 0c             	sub    $0xc,%esp
80101394:	ff 75 e4             	pushl  -0x1c(%ebp)
80101397:	e8 44 ee ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010139c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801013a3:	83 c4 10             	add    $0x10,%esp
801013a6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801013a9:	39 05 e0 29 11 80    	cmp    %eax,0x801129e0
801013af:	77 80                	ja     80101331 <balloc+0x21>
  panic("balloc: out of blocks");
801013b1:	83 ec 0c             	sub    $0xc,%esp
801013b4:	68 92 8c 10 80       	push   $0x80108c92
801013b9:	e8 d2 ef ff ff       	call   80100390 <panic>
801013be:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
801013c0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801013c3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801013c6:	09 da                	or     %ebx,%edx
801013c8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801013cc:	57                   	push   %edi
801013cd:	e8 2e 1f 00 00       	call   80103300 <log_write>
        brelse(bp);
801013d2:	89 3c 24             	mov    %edi,(%esp)
801013d5:	e8 06 ee ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
801013da:	58                   	pop    %eax
801013db:	5a                   	pop    %edx
801013dc:	56                   	push   %esi
801013dd:	ff 75 d8             	pushl  -0x28(%ebp)
801013e0:	e8 eb ec ff ff       	call   801000d0 <bread>
801013e5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801013e7:	8d 40 5c             	lea    0x5c(%eax),%eax
801013ea:	83 c4 0c             	add    $0xc,%esp
801013ed:	68 00 02 00 00       	push   $0x200
801013f2:	6a 00                	push   $0x0
801013f4:	50                   	push   %eax
801013f5:	e8 06 4a 00 00       	call   80105e00 <memset>
  log_write(bp);
801013fa:	89 1c 24             	mov    %ebx,(%esp)
801013fd:	e8 fe 1e 00 00       	call   80103300 <log_write>
  brelse(bp);
80101402:	89 1c 24             	mov    %ebx,(%esp)
80101405:	e8 d6 ed ff ff       	call   801001e0 <brelse>
}
8010140a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010140d:	89 f0                	mov    %esi,%eax
8010140f:	5b                   	pop    %ebx
80101410:	5e                   	pop    %esi
80101411:	5f                   	pop    %edi
80101412:	5d                   	pop    %ebp
80101413:	c3                   	ret    
80101414:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010141a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101420 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101420:	55                   	push   %ebp
80101421:	89 e5                	mov    %esp,%ebp
80101423:	57                   	push   %edi
80101424:	56                   	push   %esi
80101425:	53                   	push   %ebx
80101426:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101428:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010142a:	bb 34 2a 11 80       	mov    $0x80112a34,%ebx
{
8010142f:	83 ec 28             	sub    $0x28,%esp
80101432:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101435:	68 00 2a 11 80       	push   $0x80112a00
8010143a:	e8 b1 48 00 00       	call   80105cf0 <acquire>
8010143f:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101442:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101445:	eb 17                	jmp    8010145e <iget+0x3e>
80101447:	89 f6                	mov    %esi,%esi
80101449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101450:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101456:	81 fb 54 46 11 80    	cmp    $0x80114654,%ebx
8010145c:	73 22                	jae    80101480 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010145e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101461:	85 c9                	test   %ecx,%ecx
80101463:	7e 04                	jle    80101469 <iget+0x49>
80101465:	39 3b                	cmp    %edi,(%ebx)
80101467:	74 4f                	je     801014b8 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101469:	85 f6                	test   %esi,%esi
8010146b:	75 e3                	jne    80101450 <iget+0x30>
8010146d:	85 c9                	test   %ecx,%ecx
8010146f:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101472:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101478:	81 fb 54 46 11 80    	cmp    $0x80114654,%ebx
8010147e:	72 de                	jb     8010145e <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101480:	85 f6                	test   %esi,%esi
80101482:	74 5b                	je     801014df <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101484:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101487:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101489:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010148c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101493:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010149a:	68 00 2a 11 80       	push   $0x80112a00
8010149f:	e8 0c 49 00 00       	call   80105db0 <release>

  return ip;
801014a4:	83 c4 10             	add    $0x10,%esp
}
801014a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014aa:	89 f0                	mov    %esi,%eax
801014ac:	5b                   	pop    %ebx
801014ad:	5e                   	pop    %esi
801014ae:	5f                   	pop    %edi
801014af:	5d                   	pop    %ebp
801014b0:	c3                   	ret    
801014b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801014b8:	39 53 04             	cmp    %edx,0x4(%ebx)
801014bb:	75 ac                	jne    80101469 <iget+0x49>
      release(&icache.lock);
801014bd:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
801014c0:	83 c1 01             	add    $0x1,%ecx
      return ip;
801014c3:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801014c5:	68 00 2a 11 80       	push   $0x80112a00
      ip->ref++;
801014ca:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801014cd:	e8 de 48 00 00       	call   80105db0 <release>
      return ip;
801014d2:	83 c4 10             	add    $0x10,%esp
}
801014d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014d8:	89 f0                	mov    %esi,%eax
801014da:	5b                   	pop    %ebx
801014db:	5e                   	pop    %esi
801014dc:	5f                   	pop    %edi
801014dd:	5d                   	pop    %ebp
801014de:	c3                   	ret    
    panic("iget: no inodes");
801014df:	83 ec 0c             	sub    $0xc,%esp
801014e2:	68 a8 8c 10 80       	push   $0x80108ca8
801014e7:	e8 a4 ee ff ff       	call   80100390 <panic>
801014ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801014f0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801014f0:	55                   	push   %ebp
801014f1:	89 e5                	mov    %esp,%ebp
801014f3:	57                   	push   %edi
801014f4:	56                   	push   %esi
801014f5:	53                   	push   %ebx
801014f6:	89 c6                	mov    %eax,%esi
801014f8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801014fb:	83 fa 09             	cmp    $0x9,%edx
801014fe:	77 20                	ja     80101520 <bmap+0x30>
80101500:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
80101503:	8b 5f 5c             	mov    0x5c(%edi),%ebx
80101506:	85 db                	test   %ebx,%ebx
80101508:	0f 84 42 01 00 00    	je     80101650 <bmap+0x160>
		}
	  brelse(bp);
	  return addr;
	}
  panic("bmap: out of range");
}
8010150e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101511:	89 d8                	mov    %ebx,%eax
80101513:	5b                   	pop    %ebx
80101514:	5e                   	pop    %esi
80101515:	5f                   	pop    %edi
80101516:	5d                   	pop    %ebp
80101517:	c3                   	ret    
80101518:	90                   	nop
80101519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
80101520:	8d 5a f6             	lea    -0xa(%edx),%ebx
  if(bn < NINDIRECT){
80101523:	83 fb 7f             	cmp    $0x7f,%ebx
80101526:	77 48                	ja     80101570 <bmap+0x80>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101528:	8b 90 84 00 00 00    	mov    0x84(%eax),%edx
8010152e:	8b 00                	mov    (%eax),%eax
80101530:	85 d2                	test   %edx,%edx
80101532:	0f 84 78 01 00 00    	je     801016b0 <bmap+0x1c0>
    bp = bread(ip->dev, addr);
80101538:	83 ec 08             	sub    $0x8,%esp
8010153b:	52                   	push   %edx
8010153c:	50                   	push   %eax
8010153d:	e8 8e eb ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
80101542:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
80101546:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
80101549:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
8010154b:	8b 1a                	mov    (%edx),%ebx
8010154d:	85 db                	test   %ebx,%ebx
8010154f:	0f 84 c4 00 00 00    	je     80101619 <bmap+0x129>
	  brelse(bp);
80101555:	83 ec 0c             	sub    $0xc,%esp
80101558:	57                   	push   %edi
80101559:	e8 82 ec ff ff       	call   801001e0 <brelse>
8010155e:	83 c4 10             	add    $0x10,%esp
}
80101561:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101564:	89 d8                	mov    %ebx,%eax
80101566:	5b                   	pop    %ebx
80101567:	5e                   	pop    %esi
80101568:	5f                   	pop    %edi
80101569:	5d                   	pop    %ebp
8010156a:	c3                   	ret    
8010156b:	90                   	nop
8010156c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(bn < NDINDIRECT){
80101570:	81 fb ff 3f 00 00    	cmp    $0x3fff,%ebx
80101576:	0f 86 f4 00 00 00    	jbe    80101670 <bmap+0x180>
  if(bn < NTINDIRECT){
8010157c:	81 fb ff ff 1f 00    	cmp    $0x1fffff,%ebx
80101582:	0f 87 f3 01 00 00    	ja     8010177b <bmap+0x28b>
	  if((addr = ip->addrs[NDIRECT+2]) == 0)
80101588:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
8010158e:	8b 00                	mov    (%eax),%eax
80101590:	85 d2                	test   %edx,%edx
80101592:	0f 84 30 01 00 00    	je     801016c8 <bmap+0x1d8>
	  bp = bread(ip->dev, addr);
80101598:	83 ec 08             	sub    $0x8,%esp
8010159b:	52                   	push   %edx
8010159c:	50                   	push   %eax
8010159d:	e8 2e eb ff ff       	call   801000d0 <bread>
801015a2:	89 c2                	mov    %eax,%edx
	  if((addr = a[bn / NDINDIRECT]) == 0){
801015a4:	89 d8                	mov    %ebx,%eax
801015a6:	83 c4 10             	add    $0x10,%esp
801015a9:	c1 e8 0e             	shr    $0xe,%eax
801015ac:	8d 4c 82 5c          	lea    0x5c(%edx,%eax,4),%ecx
801015b0:	8b 39                	mov    (%ecx),%edi
801015b2:	85 ff                	test   %edi,%edi
801015b4:	0f 84 96 01 00 00    	je     80101750 <bmap+0x260>
	  brelse(bp);
801015ba:	83 ec 0c             	sub    $0xc,%esp
801015bd:	52                   	push   %edx
801015be:	e8 1d ec ff ff       	call   801001e0 <brelse>
	  bp = bread(ip->dev, addr);
801015c3:	59                   	pop    %ecx
801015c4:	58                   	pop    %eax
801015c5:	57                   	push   %edi
801015c6:	ff 36                	pushl  (%esi)
801015c8:	e8 03 eb ff ff       	call   801000d0 <bread>
801015cd:	89 c7                	mov    %eax,%edi
	  if((addr = a[(bn % NDINDIRECT) / NINDIRECT]) == 0){
801015cf:	89 d8                	mov    %ebx,%eax
801015d1:	83 c4 10             	add    $0x10,%esp
801015d4:	c1 e8 05             	shr    $0x5,%eax
801015d7:	25 fc 01 00 00       	and    $0x1fc,%eax
801015dc:	8d 54 07 5c          	lea    0x5c(%edi,%eax,1),%edx
801015e0:	8b 02                	mov    (%edx),%eax
801015e2:	85 c0                	test   %eax,%eax
801015e4:	0f 84 3e 01 00 00    	je     80101728 <bmap+0x238>
	  brelse(bp);
801015ea:	83 ec 0c             	sub    $0xc,%esp
801015ed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801015f0:	57                   	push   %edi
801015f1:	e8 ea eb ff ff       	call   801001e0 <brelse>
	  bp = bread(ip->dev, addr);
801015f6:	58                   	pop    %eax
801015f7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801015fa:	5a                   	pop    %edx
801015fb:	50                   	push   %eax
801015fc:	ff 36                	pushl  (%esi)
	  if((addr = a[bn % NINDIRECT]) == 0){
801015fe:	83 e3 7f             	and    $0x7f,%ebx
	  bp = bread(ip->dev, addr);
80101601:	e8 ca ea ff ff       	call   801000d0 <bread>
	  if((addr = a[bn % NINDIRECT]) == 0){
80101606:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010160a:	83 c4 10             	add    $0x10,%esp
	  bp = bread(ip->dev, addr);
8010160d:	89 c7                	mov    %eax,%edi
	  if((addr = a[bn % NINDIRECT]) == 0){
8010160f:	8b 1a                	mov    (%edx),%ebx
80101611:	85 db                	test   %ebx,%ebx
80101613:	0f 85 3c ff ff ff    	jne    80101555 <bmap+0x65>
		  a[bn % NINDIRECT] = addr = balloc(ip->dev);
80101619:	8b 06                	mov    (%esi),%eax
8010161b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010161e:	e8 ed fc ff ff       	call   80101310 <balloc>
80101623:	8b 55 e4             	mov    -0x1c(%ebp),%edx
		  log_write(bp);
80101626:	83 ec 0c             	sub    $0xc,%esp
		  a[bn % NINDIRECT] = addr = balloc(ip->dev);
80101629:	89 c3                	mov    %eax,%ebx
8010162b:	89 02                	mov    %eax,(%edx)
		  log_write(bp);
8010162d:	57                   	push   %edi
8010162e:	e8 cd 1c 00 00       	call   80103300 <log_write>
80101633:	83 c4 10             	add    $0x10,%esp
	  brelse(bp);
80101636:	83 ec 0c             	sub    $0xc,%esp
80101639:	57                   	push   %edi
8010163a:	e8 a1 eb ff ff       	call   801001e0 <brelse>
8010163f:	83 c4 10             	add    $0x10,%esp
80101642:	e9 1a ff ff ff       	jmp    80101561 <bmap+0x71>
80101647:	89 f6                	mov    %esi,%esi
80101649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[bn] = addr = balloc(ip->dev);
80101650:	8b 00                	mov    (%eax),%eax
80101652:	e8 b9 fc ff ff       	call   80101310 <balloc>
80101657:	89 47 5c             	mov    %eax,0x5c(%edi)
}
8010165a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
8010165d:	89 c3                	mov    %eax,%ebx
}
8010165f:	89 d8                	mov    %ebx,%eax
80101661:	5b                   	pop    %ebx
80101662:	5e                   	pop    %esi
80101663:	5f                   	pop    %edi
80101664:	5d                   	pop    %ebp
80101665:	c3                   	ret    
80101666:	8d 76 00             	lea    0x0(%esi),%esi
80101669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	  if((addr = ip->addrs[NDIRECT+1]) ==0)
80101670:	8b 90 88 00 00 00    	mov    0x88(%eax),%edx
80101676:	8b 00                	mov    (%eax),%eax
80101678:	85 d2                	test   %edx,%edx
8010167a:	0f 84 90 00 00 00    	je     80101710 <bmap+0x220>
	  bp = bread(ip->dev, addr);
80101680:	83 ec 08             	sub    $0x8,%esp
80101683:	52                   	push   %edx
80101684:	50                   	push   %eax
80101685:	e8 46 ea ff ff       	call   801000d0 <bread>
8010168a:	89 c2                	mov    %eax,%edx
	  if((addr = a[bn / NINDIRECT]) == 0){
8010168c:	89 d8                	mov    %ebx,%eax
8010168e:	83 c4 10             	add    $0x10,%esp
80101691:	c1 e8 07             	shr    $0x7,%eax
80101694:	8d 4c 82 5c          	lea    0x5c(%edx,%eax,4),%ecx
80101698:	8b 39                	mov    (%ecx),%edi
8010169a:	85 ff                	test   %edi,%edi
8010169c:	74 42                	je     801016e0 <bmap+0x1f0>
	  brelse(bp);
8010169e:	83 ec 0c             	sub    $0xc,%esp
801016a1:	52                   	push   %edx
801016a2:	e8 39 eb ff ff       	call   801001e0 <brelse>
	  bp = bread(ip->dev, addr);
801016a7:	58                   	pop    %eax
801016a8:	5a                   	pop    %edx
801016a9:	57                   	push   %edi
801016aa:	e9 4d ff ff ff       	jmp    801015fc <bmap+0x10c>
801016af:	90                   	nop
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801016b0:	e8 5b fc ff ff       	call   80101310 <balloc>
801016b5:	89 c2                	mov    %eax,%edx
801016b7:	89 86 84 00 00 00    	mov    %eax,0x84(%esi)
801016bd:	8b 06                	mov    (%esi),%eax
801016bf:	e9 74 fe ff ff       	jmp    80101538 <bmap+0x48>
801016c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		  ip->addrs[NDIRECT+2] = addr = balloc(ip->dev);
801016c8:	e8 43 fc ff ff       	call   80101310 <balloc>
801016cd:	89 c2                	mov    %eax,%edx
801016cf:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801016d5:	8b 06                	mov    (%esi),%eax
801016d7:	e9 bc fe ff ff       	jmp    80101598 <bmap+0xa8>
801016dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		  a[bn / NINDIRECT] = addr = balloc(ip->dev);
801016e0:	8b 06                	mov    (%esi),%eax
801016e2:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801016e5:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801016e8:	e8 23 fc ff ff       	call   80101310 <balloc>
		  log_write(bp);
801016ed:	8b 55 e4             	mov    -0x1c(%ebp),%edx
		  a[bn / NINDIRECT] = addr = balloc(ip->dev);
801016f0:	8b 4d e0             	mov    -0x20(%ebp),%ecx
		  log_write(bp);
801016f3:	83 ec 0c             	sub    $0xc,%esp
		  a[bn / NINDIRECT] = addr = balloc(ip->dev);
801016f6:	89 c7                	mov    %eax,%edi
801016f8:	89 01                	mov    %eax,(%ecx)
		  log_write(bp);
801016fa:	52                   	push   %edx
801016fb:	e8 00 1c 00 00       	call   80103300 <log_write>
80101700:	83 c4 10             	add    $0x10,%esp
80101703:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101706:	eb 96                	jmp    8010169e <bmap+0x1ae>
80101708:	90                   	nop
80101709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		  ip->addrs[NDIRECT+1] = addr = balloc(ip->dev);
80101710:	e8 fb fb ff ff       	call   80101310 <balloc>
80101715:	89 c2                	mov    %eax,%edx
80101717:	89 86 88 00 00 00    	mov    %eax,0x88(%esi)
8010171d:	8b 06                	mov    (%esi),%eax
8010171f:	e9 5c ff ff ff       	jmp    80101680 <bmap+0x190>
80101724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		  a[(bn % NDINDIRECT) / NINDIRECT] = addr = balloc(ip->dev);
80101728:	8b 06                	mov    (%esi),%eax
8010172a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010172d:	e8 de fb ff ff       	call   80101310 <balloc>
80101732:	8b 55 e4             	mov    -0x1c(%ebp),%edx
		  log_write(bp);
80101735:	83 ec 0c             	sub    $0xc,%esp
		  a[(bn % NDINDIRECT) / NINDIRECT] = addr = balloc(ip->dev);
80101738:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010173b:	89 02                	mov    %eax,(%edx)
		  log_write(bp);
8010173d:	57                   	push   %edi
8010173e:	e8 bd 1b 00 00       	call   80103300 <log_write>
80101743:	83 c4 10             	add    $0x10,%esp
80101746:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101749:	e9 9c fe ff ff       	jmp    801015ea <bmap+0xfa>
8010174e:	66 90                	xchg   %ax,%ax
		  a[bn / NDINDIRECT] = addr = balloc(ip->dev);
80101750:	8b 06                	mov    (%esi),%eax
80101752:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101755:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101758:	e8 b3 fb ff ff       	call   80101310 <balloc>
		  log_write(bp);
8010175d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
		  a[bn / NDINDIRECT] = addr = balloc(ip->dev);
80101760:	8b 4d e0             	mov    -0x20(%ebp),%ecx
		  log_write(bp);
80101763:	83 ec 0c             	sub    $0xc,%esp
		  a[bn / NDINDIRECT] = addr = balloc(ip->dev);
80101766:	89 c7                	mov    %eax,%edi
80101768:	89 01                	mov    %eax,(%ecx)
		  log_write(bp);
8010176a:	52                   	push   %edx
8010176b:	e8 90 1b 00 00       	call   80103300 <log_write>
80101770:	83 c4 10             	add    $0x10,%esp
80101773:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101776:	e9 3f fe ff ff       	jmp    801015ba <bmap+0xca>
  panic("bmap: out of range");
8010177b:	83 ec 0c             	sub    $0xc,%esp
8010177e:	68 b8 8c 10 80       	push   $0x80108cb8
80101783:	e8 08 ec ff ff       	call   80100390 <panic>
80101788:	90                   	nop
80101789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101790 <readsb>:
{
80101790:	55                   	push   %ebp
80101791:	89 e5                	mov    %esp,%ebp
80101793:	56                   	push   %esi
80101794:	53                   	push   %ebx
80101795:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101798:	83 ec 08             	sub    $0x8,%esp
8010179b:	6a 01                	push   $0x1
8010179d:	ff 75 08             	pushl  0x8(%ebp)
801017a0:	e8 2b e9 ff ff       	call   801000d0 <bread>
801017a5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801017a7:	8d 40 5c             	lea    0x5c(%eax),%eax
801017aa:	83 c4 0c             	add    $0xc,%esp
801017ad:	6a 1c                	push   $0x1c
801017af:	50                   	push   %eax
801017b0:	56                   	push   %esi
801017b1:	e8 fa 46 00 00       	call   80105eb0 <memmove>
  brelse(bp);
801017b6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801017b9:	83 c4 10             	add    $0x10,%esp
}
801017bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017bf:	5b                   	pop    %ebx
801017c0:	5e                   	pop    %esi
801017c1:	5d                   	pop    %ebp
  brelse(bp);
801017c2:	e9 19 ea ff ff       	jmp    801001e0 <brelse>
801017c7:	89 f6                	mov    %esi,%esi
801017c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801017d0 <iinit>:
{
801017d0:	55                   	push   %ebp
801017d1:	89 e5                	mov    %esp,%ebp
801017d3:	53                   	push   %ebx
801017d4:	bb 40 2a 11 80       	mov    $0x80112a40,%ebx
801017d9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801017dc:	68 cb 8c 10 80       	push   $0x80108ccb
801017e1:	68 00 2a 11 80       	push   $0x80112a00
801017e6:	e8 c5 43 00 00       	call   80105bb0 <initlock>
801017eb:	83 c4 10             	add    $0x10,%esp
801017ee:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801017f0:	83 ec 08             	sub    $0x8,%esp
801017f3:	68 d2 8c 10 80       	push   $0x80108cd2
801017f8:	53                   	push   %ebx
801017f9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801017ff:	e8 7c 42 00 00       	call   80105a80 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101804:	83 c4 10             	add    $0x10,%esp
80101807:	81 fb 60 46 11 80    	cmp    $0x80114660,%ebx
8010180d:	75 e1                	jne    801017f0 <iinit+0x20>
  readsb(dev, &sb);
8010180f:	83 ec 08             	sub    $0x8,%esp
80101812:	68 e0 29 11 80       	push   $0x801129e0
80101817:	ff 75 08             	pushl  0x8(%ebp)
8010181a:	e8 71 ff ff ff       	call   80101790 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010181f:	ff 35 f8 29 11 80    	pushl  0x801129f8
80101825:	ff 35 f4 29 11 80    	pushl  0x801129f4
8010182b:	ff 35 f0 29 11 80    	pushl  0x801129f0
80101831:	ff 35 ec 29 11 80    	pushl  0x801129ec
80101837:	ff 35 e8 29 11 80    	pushl  0x801129e8
8010183d:	ff 35 e4 29 11 80    	pushl  0x801129e4
80101843:	ff 35 e0 29 11 80    	pushl  0x801129e0
80101849:	68 38 8d 10 80       	push   $0x80108d38
8010184e:	e8 0d ee ff ff       	call   80100660 <cprintf>
}
80101853:	83 c4 30             	add    $0x30,%esp
80101856:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101859:	c9                   	leave  
8010185a:	c3                   	ret    
8010185b:	90                   	nop
8010185c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101860 <ialloc>:
{
80101860:	55                   	push   %ebp
80101861:	89 e5                	mov    %esp,%ebp
80101863:	57                   	push   %edi
80101864:	56                   	push   %esi
80101865:	53                   	push   %ebx
80101866:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101869:	83 3d e8 29 11 80 01 	cmpl   $0x1,0x801129e8
{
80101870:	8b 45 0c             	mov    0xc(%ebp),%eax
80101873:	8b 75 08             	mov    0x8(%ebp),%esi
80101876:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101879:	0f 86 91 00 00 00    	jbe    80101910 <ialloc+0xb0>
8010187f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101884:	eb 21                	jmp    801018a7 <ialloc+0x47>
80101886:	8d 76 00             	lea    0x0(%esi),%esi
80101889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101890:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101893:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101896:	57                   	push   %edi
80101897:	e8 44 e9 ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010189c:	83 c4 10             	add    $0x10,%esp
8010189f:	39 1d e8 29 11 80    	cmp    %ebx,0x801129e8
801018a5:	76 69                	jbe    80101910 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
801018a7:	89 d8                	mov    %ebx,%eax
801018a9:	83 ec 08             	sub    $0x8,%esp
801018ac:	c1 e8 03             	shr    $0x3,%eax
801018af:	03 05 f4 29 11 80    	add    0x801129f4,%eax
801018b5:	50                   	push   %eax
801018b6:	56                   	push   %esi
801018b7:	e8 14 e8 ff ff       	call   801000d0 <bread>
801018bc:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
801018be:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
801018c0:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
801018c3:	83 e0 07             	and    $0x7,%eax
801018c6:	c1 e0 06             	shl    $0x6,%eax
801018c9:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801018cd:	66 83 39 00          	cmpw   $0x0,(%ecx)
801018d1:	75 bd                	jne    80101890 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801018d3:	83 ec 04             	sub    $0x4,%esp
801018d6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801018d9:	6a 40                	push   $0x40
801018db:	6a 00                	push   $0x0
801018dd:	51                   	push   %ecx
801018de:	e8 1d 45 00 00       	call   80105e00 <memset>
      dip->type = type;
801018e3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801018e7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801018ea:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801018ed:	89 3c 24             	mov    %edi,(%esp)
801018f0:	e8 0b 1a 00 00       	call   80103300 <log_write>
      brelse(bp);
801018f5:	89 3c 24             	mov    %edi,(%esp)
801018f8:	e8 e3 e8 ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801018fd:	83 c4 10             	add    $0x10,%esp
}
80101900:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101903:	89 da                	mov    %ebx,%edx
80101905:	89 f0                	mov    %esi,%eax
}
80101907:	5b                   	pop    %ebx
80101908:	5e                   	pop    %esi
80101909:	5f                   	pop    %edi
8010190a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010190b:	e9 10 fb ff ff       	jmp    80101420 <iget>
  panic("ialloc: no inodes");
80101910:	83 ec 0c             	sub    $0xc,%esp
80101913:	68 d8 8c 10 80       	push   $0x80108cd8
80101918:	e8 73 ea ff ff       	call   80100390 <panic>
8010191d:	8d 76 00             	lea    0x0(%esi),%esi

80101920 <iupdate>:
{
80101920:	55                   	push   %ebp
80101921:	89 e5                	mov    %esp,%ebp
80101923:	56                   	push   %esi
80101924:	53                   	push   %ebx
80101925:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101928:	83 ec 08             	sub    $0x8,%esp
8010192b:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010192e:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101931:	c1 e8 03             	shr    $0x3,%eax
80101934:	03 05 f4 29 11 80    	add    0x801129f4,%eax
8010193a:	50                   	push   %eax
8010193b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010193e:	e8 8d e7 ff ff       	call   801000d0 <bread>
80101943:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101945:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
80101948:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010194c:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010194f:	83 e0 07             	and    $0x7,%eax
80101952:	c1 e0 06             	shl    $0x6,%eax
80101955:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101959:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010195c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101960:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101963:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101967:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010196b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010196f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101973:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101977:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010197a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010197d:	6a 34                	push   $0x34
8010197f:	53                   	push   %ebx
80101980:	50                   	push   %eax
80101981:	e8 2a 45 00 00       	call   80105eb0 <memmove>
  log_write(bp);
80101986:	89 34 24             	mov    %esi,(%esp)
80101989:	e8 72 19 00 00       	call   80103300 <log_write>
  brelse(bp);
8010198e:	89 75 08             	mov    %esi,0x8(%ebp)
80101991:	83 c4 10             	add    $0x10,%esp
}
80101994:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101997:	5b                   	pop    %ebx
80101998:	5e                   	pop    %esi
80101999:	5d                   	pop    %ebp
  brelse(bp);
8010199a:	e9 41 e8 ff ff       	jmp    801001e0 <brelse>
8010199f:	90                   	nop

801019a0 <idup>:
{
801019a0:	55                   	push   %ebp
801019a1:	89 e5                	mov    %esp,%ebp
801019a3:	53                   	push   %ebx
801019a4:	83 ec 10             	sub    $0x10,%esp
801019a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801019aa:	68 00 2a 11 80       	push   $0x80112a00
801019af:	e8 3c 43 00 00       	call   80105cf0 <acquire>
  ip->ref++;
801019b4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801019b8:	c7 04 24 00 2a 11 80 	movl   $0x80112a00,(%esp)
801019bf:	e8 ec 43 00 00       	call   80105db0 <release>
}
801019c4:	89 d8                	mov    %ebx,%eax
801019c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801019c9:	c9                   	leave  
801019ca:	c3                   	ret    
801019cb:	90                   	nop
801019cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801019d0 <ilock>:
{
801019d0:	55                   	push   %ebp
801019d1:	89 e5                	mov    %esp,%ebp
801019d3:	56                   	push   %esi
801019d4:	53                   	push   %ebx
801019d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801019d8:	85 db                	test   %ebx,%ebx
801019da:	0f 84 b7 00 00 00    	je     80101a97 <ilock+0xc7>
801019e0:	8b 53 08             	mov    0x8(%ebx),%edx
801019e3:	85 d2                	test   %edx,%edx
801019e5:	0f 8e ac 00 00 00    	jle    80101a97 <ilock+0xc7>
  acquiresleep(&ip->lock);
801019eb:	8d 43 0c             	lea    0xc(%ebx),%eax
801019ee:	83 ec 0c             	sub    $0xc,%esp
801019f1:	50                   	push   %eax
801019f2:	e8 c9 40 00 00       	call   80105ac0 <acquiresleep>
  if(ip->valid == 0){
801019f7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801019fa:	83 c4 10             	add    $0x10,%esp
801019fd:	85 c0                	test   %eax,%eax
801019ff:	74 0f                	je     80101a10 <ilock+0x40>
}
80101a01:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101a04:	5b                   	pop    %ebx
80101a05:	5e                   	pop    %esi
80101a06:	5d                   	pop    %ebp
80101a07:	c3                   	ret    
80101a08:	90                   	nop
80101a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101a10:	8b 43 04             	mov    0x4(%ebx),%eax
80101a13:	83 ec 08             	sub    $0x8,%esp
80101a16:	c1 e8 03             	shr    $0x3,%eax
80101a19:	03 05 f4 29 11 80    	add    0x801129f4,%eax
80101a1f:	50                   	push   %eax
80101a20:	ff 33                	pushl  (%ebx)
80101a22:	e8 a9 e6 ff ff       	call   801000d0 <bread>
80101a27:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101a29:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101a2c:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101a2f:	83 e0 07             	and    $0x7,%eax
80101a32:	c1 e0 06             	shl    $0x6,%eax
80101a35:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101a39:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101a3c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
80101a3f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101a43:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101a47:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101a4b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
80101a4f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101a53:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101a57:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101a5b:	8b 50 fc             	mov    -0x4(%eax),%edx
80101a5e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101a61:	6a 34                	push   $0x34
80101a63:	50                   	push   %eax
80101a64:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101a67:	50                   	push   %eax
80101a68:	e8 43 44 00 00       	call   80105eb0 <memmove>
    brelse(bp);
80101a6d:	89 34 24             	mov    %esi,(%esp)
80101a70:	e8 6b e7 ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101a75:	83 c4 10             	add    $0x10,%esp
80101a78:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
80101a7d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101a84:	0f 85 77 ff ff ff    	jne    80101a01 <ilock+0x31>
      panic("ilock: no type");
80101a8a:	83 ec 0c             	sub    $0xc,%esp
80101a8d:	68 f0 8c 10 80       	push   $0x80108cf0
80101a92:	e8 f9 e8 ff ff       	call   80100390 <panic>
    panic("ilock");
80101a97:	83 ec 0c             	sub    $0xc,%esp
80101a9a:	68 ea 8c 10 80       	push   $0x80108cea
80101a9f:	e8 ec e8 ff ff       	call   80100390 <panic>
80101aa4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101aaa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101ab0 <iunlock>:
{
80101ab0:	55                   	push   %ebp
80101ab1:	89 e5                	mov    %esp,%ebp
80101ab3:	56                   	push   %esi
80101ab4:	53                   	push   %ebx
80101ab5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101ab8:	85 db                	test   %ebx,%ebx
80101aba:	74 28                	je     80101ae4 <iunlock+0x34>
80101abc:	8d 73 0c             	lea    0xc(%ebx),%esi
80101abf:	83 ec 0c             	sub    $0xc,%esp
80101ac2:	56                   	push   %esi
80101ac3:	e8 98 40 00 00       	call   80105b60 <holdingsleep>
80101ac8:	83 c4 10             	add    $0x10,%esp
80101acb:	85 c0                	test   %eax,%eax
80101acd:	74 15                	je     80101ae4 <iunlock+0x34>
80101acf:	8b 43 08             	mov    0x8(%ebx),%eax
80101ad2:	85 c0                	test   %eax,%eax
80101ad4:	7e 0e                	jle    80101ae4 <iunlock+0x34>
  releasesleep(&ip->lock);
80101ad6:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101ad9:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101adc:	5b                   	pop    %ebx
80101add:	5e                   	pop    %esi
80101ade:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
80101adf:	e9 3c 40 00 00       	jmp    80105b20 <releasesleep>
    panic("iunlock");
80101ae4:	83 ec 0c             	sub    $0xc,%esp
80101ae7:	68 ff 8c 10 80       	push   $0x80108cff
80101aec:	e8 9f e8 ff ff       	call   80100390 <panic>
80101af1:	eb 0d                	jmp    80101b00 <iput>
80101af3:	90                   	nop
80101af4:	90                   	nop
80101af5:	90                   	nop
80101af6:	90                   	nop
80101af7:	90                   	nop
80101af8:	90                   	nop
80101af9:	90                   	nop
80101afa:	90                   	nop
80101afb:	90                   	nop
80101afc:	90                   	nop
80101afd:	90                   	nop
80101afe:	90                   	nop
80101aff:	90                   	nop

80101b00 <iput>:
{
80101b00:	55                   	push   %ebp
80101b01:	89 e5                	mov    %esp,%ebp
80101b03:	57                   	push   %edi
80101b04:	56                   	push   %esi
80101b05:	53                   	push   %ebx
80101b06:	83 ec 48             	sub    $0x48,%esp
80101b09:	8b 7d 08             	mov    0x8(%ebp),%edi
  acquiresleep(&ip->lock);
80101b0c:	8d 47 0c             	lea    0xc(%edi),%eax
{
80101b0f:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  acquiresleep(&ip->lock);
80101b12:	50                   	push   %eax
80101b13:	89 45 c8             	mov    %eax,-0x38(%ebp)
80101b16:	e8 a5 3f 00 00       	call   80105ac0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101b1b:	8b 4f 4c             	mov    0x4c(%edi),%ecx
80101b1e:	83 c4 10             	add    $0x10,%esp
80101b21:	85 c9                	test   %ecx,%ecx
80101b23:	74 07                	je     80101b2c <iput+0x2c>
80101b25:	66 83 7f 56 00       	cmpw   $0x0,0x56(%edi)
80101b2a:	74 34                	je     80101b60 <iput+0x60>
  releasesleep(&ip->lock);
80101b2c:	83 ec 0c             	sub    $0xc,%esp
80101b2f:	ff 75 c8             	pushl  -0x38(%ebp)
80101b32:	e8 e9 3f 00 00       	call   80105b20 <releasesleep>
  acquire(&icache.lock);
80101b37:	c7 04 24 00 2a 11 80 	movl   $0x80112a00,(%esp)
80101b3e:	e8 ad 41 00 00       	call   80105cf0 <acquire>
  ip->ref--;
80101b43:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  release(&icache.lock);
80101b46:	83 c4 10             	add    $0x10,%esp
  ip->ref--;
80101b49:	83 68 08 01          	subl   $0x1,0x8(%eax)
  release(&icache.lock);
80101b4d:	c7 45 08 00 2a 11 80 	movl   $0x80112a00,0x8(%ebp)
}
80101b54:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b57:	5b                   	pop    %ebx
80101b58:	5e                   	pop    %esi
80101b59:	5f                   	pop    %edi
80101b5a:	5d                   	pop    %ebp
  release(&icache.lock);
80101b5b:	e9 50 42 00 00       	jmp    80105db0 <release>
    acquire(&icache.lock);
80101b60:	83 ec 0c             	sub    $0xc,%esp
80101b63:	68 00 2a 11 80       	push   $0x80112a00
80101b68:	e8 83 41 00 00       	call   80105cf0 <acquire>
    int r = ip->ref;
80101b6d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b70:	8b 58 08             	mov    0x8(%eax),%ebx
    release(&icache.lock);
80101b73:	c7 04 24 00 2a 11 80 	movl   $0x80112a00,(%esp)
80101b7a:	e8 31 42 00 00       	call   80105db0 <release>
    if(r == 1){
80101b7f:	83 c4 10             	add    $0x10,%esp
80101b82:	83 fb 01             	cmp    $0x1,%ebx
80101b85:	75 a5                	jne    80101b2c <iput+0x2c>
80101b87:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b8a:	8d 70 5c             	lea    0x5c(%eax),%esi
80101b8d:	8d 98 84 00 00 00    	lea    0x84(%eax),%ebx
80101b93:	eb 07                	jmp    80101b9c <iput+0x9c>
80101b95:	83 c6 04             	add    $0x4,%esi
  struct buf *bp3;
  uint *a;
  uint *a2;
  uint *a3;

  for(i = 0; i < NDIRECT; i++){
80101b98:	39 de                	cmp    %ebx,%esi
80101b9a:	74 1e                	je     80101bba <iput+0xba>
    if(ip->addrs[i]){
80101b9c:	8b 16                	mov    (%esi),%edx
80101b9e:	85 d2                	test   %edx,%edx
80101ba0:	74 f3                	je     80101b95 <iput+0x95>
      bfree(ip->dev, ip->addrs[i]);
80101ba2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101ba5:	83 c6 04             	add    $0x4,%esi
80101ba8:	8b 00                	mov    (%eax),%eax
80101baa:	e8 f1 f6 ff ff       	call   801012a0 <bfree>
      ip->addrs[i] = 0;
80101baf:	c7 46 fc 00 00 00 00 	movl   $0x0,-0x4(%esi)
  for(i = 0; i < NDIRECT; i++){
80101bb6:	39 de                	cmp    %ebx,%esi
80101bb8:	75 e2                	jne    80101b9c <iput+0x9c>
    }
  }

	if(ip->addrs[NDIRECT]){
80101bba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101bbd:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
80101bc3:	85 c0                	test   %eax,%eax
80101bc5:	75 52                	jne    80101c19 <iput+0x119>
		bfree(ip->dev, ip->addrs[NDIRECT]);
		ip->addrs[NDIRECT] = 0;
	}


	if(ip->addrs[NDIRECT+1]){
80101bc7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101bca:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
80101bd0:	85 c0                	test   %eax,%eax
80101bd2:	0f 85 fc 01 00 00    	jne    80101dd4 <iput+0x2d4>
		brelse(bp);
		bfree(ip->dev, ip->addrs[NDIRECT+1]);
		ip->addrs[NDIRECT+1] = 0;
	}

	if(ip->addrs[NDIRECT+2]){
80101bd8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101bdb:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101be1:	85 c0                	test   %eax,%eax
80101be3:	0f 85 9b 00 00 00    	jne    80101c84 <iput+0x184>
				ip->addrs[NDIRECT+2] = 0;
			}
		}
	}

	ip->size = 0;
80101be9:	8b 7d e4             	mov    -0x1c(%ebp),%edi
	iupdate(ip);
80101bec:	83 ec 0c             	sub    $0xc,%esp
	ip->size = 0;
80101bef:	c7 47 58 00 00 00 00 	movl   $0x0,0x58(%edi)
	iupdate(ip);
80101bf6:	57                   	push   %edi
80101bf7:	e8 24 fd ff ff       	call   80101920 <iupdate>
      ip->type = 0;
80101bfc:	31 d2                	xor    %edx,%edx
80101bfe:	66 89 57 50          	mov    %dx,0x50(%edi)
      iupdate(ip);
80101c02:	89 3c 24             	mov    %edi,(%esp)
80101c05:	e8 16 fd ff ff       	call   80101920 <iupdate>
      ip->valid = 0;
80101c0a:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
80101c11:	83 c4 10             	add    $0x10,%esp
80101c14:	e9 13 ff ff ff       	jmp    80101b2c <iput+0x2c>
		bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101c19:	52                   	push   %edx
80101c1a:	52                   	push   %edx
80101c1b:	50                   	push   %eax
80101c1c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101c1f:	ff 30                	pushl  (%eax)
80101c21:	e8 aa e4 ff ff       	call   801000d0 <bread>
80101c26:	83 c4 10             	add    $0x10,%esp
80101c29:	89 c6                	mov    %eax,%esi
		a = (uint*)bp->data;
80101c2b:	8d 58 5c             	lea    0x5c(%eax),%ebx
80101c2e:	8d b8 5c 02 00 00    	lea    0x25c(%eax),%edi
80101c34:	eb 11                	jmp    80101c47 <iput+0x147>
80101c36:	8d 76 00             	lea    0x0(%esi),%esi
80101c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101c40:	83 c3 04             	add    $0x4,%ebx
		for(j=0; j<NINDIRECT; j++){
80101c43:	39 fb                	cmp    %edi,%ebx
80101c45:	74 12                	je     80101c59 <iput+0x159>
			if(a[j])
80101c47:	8b 13                	mov    (%ebx),%edx
80101c49:	85 d2                	test   %edx,%edx
80101c4b:	74 f3                	je     80101c40 <iput+0x140>
				bfree(ip->dev, a[j]);
80101c4d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101c50:	8b 00                	mov    (%eax),%eax
80101c52:	e8 49 f6 ff ff       	call   801012a0 <bfree>
80101c57:	eb e7                	jmp    80101c40 <iput+0x140>
		brelse(bp);
80101c59:	83 ec 0c             	sub    $0xc,%esp
80101c5c:	56                   	push   %esi
80101c5d:	e8 7e e5 ff ff       	call   801001e0 <brelse>
		bfree(ip->dev, ip->addrs[NDIRECT]);
80101c62:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101c65:	8b 97 84 00 00 00    	mov    0x84(%edi),%edx
80101c6b:	8b 07                	mov    (%edi),%eax
80101c6d:	e8 2e f6 ff ff       	call   801012a0 <bfree>
		ip->addrs[NDIRECT] = 0;
80101c72:	c7 87 84 00 00 00 00 	movl   $0x0,0x84(%edi)
80101c79:	00 00 00 
80101c7c:	83 c4 10             	add    $0x10,%esp
80101c7f:	e9 43 ff ff ff       	jmp    80101bc7 <iput+0xc7>
		bp = bread(ip->dev, ip->addrs[NDIRECT+2]);
80101c84:	56                   	push   %esi
80101c85:	56                   	push   %esi
80101c86:	50                   	push   %eax
80101c87:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101c8a:	ff 30                	pushl  (%eax)
80101c8c:	e8 3f e4 ff ff       	call   801000d0 <bread>
		a = (uint*)bp->data;
80101c91:	8d 48 5c             	lea    0x5c(%eax),%ecx
		bp = bread(ip->dev, ip->addrs[NDIRECT+2]);
80101c94:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80101c97:	05 5c 02 00 00       	add    $0x25c,%eax
80101c9c:	89 45 cc             	mov    %eax,-0x34(%ebp)
80101c9f:	83 c4 10             	add    $0x10,%esp
		a = (uint*)bp->data;
80101ca2:	89 4d dc             	mov    %ecx,-0x24(%ebp)
80101ca5:	eb 19                	jmp    80101cc0 <iput+0x1c0>
80101ca7:	89 f6                	mov    %esi,%esi
80101ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101cb0:	83 45 dc 04          	addl   $0x4,-0x24(%ebp)
80101cb4:	8b 45 dc             	mov    -0x24(%ebp),%eax
		for(i=0; i<NINDIRECT; i++){
80101cb7:	39 45 cc             	cmp    %eax,-0x34(%ebp)
80101cba:	0f 84 29 ff ff ff    	je     80101be9 <iput+0xe9>
			if(a[i]){
80101cc0:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101cc3:	8b 00                	mov    (%eax),%eax
80101cc5:	85 c0                	test   %eax,%eax
80101cc7:	74 e7                	je     80101cb0 <iput+0x1b0>
				bp2=bread(ip->dev, a[i]);
80101cc9:	83 ec 08             	sub    $0x8,%esp
80101ccc:	50                   	push   %eax
80101ccd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101cd0:	ff 30                	pushl  (%eax)
80101cd2:	e8 f9 e3 ff ff       	call   801000d0 <bread>
80101cd7:	89 45 d4             	mov    %eax,-0x2c(%ebp)
				a2=(uint*)bp2->data;
80101cda:	83 c0 5c             	add    $0x5c,%eax
80101cdd:	83 c4 10             	add    $0x10,%esp
80101ce0:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101ce3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80101cea:	eb 33                	jmp    80101d1f <iput+0x21f>
80101cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
					brelse(bp2);
80101cf0:	83 ec 0c             	sub    $0xc,%esp
80101cf3:	ff 75 d4             	pushl  -0x2c(%ebp)
80101cf6:	e8 e5 e4 ff ff       	call   801001e0 <brelse>
					bfree(ip->dev, a[i]);
80101cfb:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101cfe:	8b 10                	mov    (%eax),%edx
80101d00:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d03:	8b 00                	mov    (%eax),%eax
80101d05:	e8 96 f5 ff ff       	call   801012a0 <bfree>
80101d0a:	83 45 e0 04          	addl   $0x4,-0x20(%ebp)
				for(j=0 ; j<NINDIRECT; j++){
80101d0e:	83 c4 10             	add    $0x10,%esp
80101d11:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101d14:	3d 00 02 00 00       	cmp    $0x200,%eax
80101d19:	0f 84 88 00 00 00    	je     80101da7 <iput+0x2a7>
					if(a2[j]){
80101d1f:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101d22:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101d25:	8b 1c 08             	mov    (%eax,%ecx,1),%ebx
80101d28:	85 db                	test   %ebx,%ebx
80101d2a:	74 c4                	je     80101cf0 <iput+0x1f0>
						bp3=bread(ip->dev, a[i]);
80101d2c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101d2f:	83 ec 08             	sub    $0x8,%esp
						for(k=0 ; k<NINDIRECT; k++){
80101d32:	31 db                	xor    %ebx,%ebx
						bp3=bread(ip->dev, a[i]);
80101d34:	ff 30                	pushl  (%eax)
80101d36:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d39:	ff 30                	pushl  (%eax)
80101d3b:	e8 90 e3 ff ff       	call   801000d0 <bread>
						a3=(uint*)bp3->data;
80101d40:	8d 78 5c             	lea    0x5c(%eax),%edi
						bp3=bread(ip->dev, a[i]);
80101d43:	89 45 d0             	mov    %eax,-0x30(%ebp)
80101d46:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101d49:	83 c4 10             	add    $0x10,%esp
80101d4c:	8d 34 07             	lea    (%edi,%eax,1),%esi
80101d4f:	eb 12                	jmp    80101d63 <iput+0x263>
80101d51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
						for(k=0 ; k<NINDIRECT; k++){
80101d58:	83 c3 01             	add    $0x1,%ebx
80101d5b:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
80101d61:	74 1e                	je     80101d81 <iput+0x281>
							if(a3[j])
80101d63:	8b 0e                	mov    (%esi),%ecx
80101d65:	85 c9                	test   %ecx,%ecx
80101d67:	74 ef                	je     80101d58 <iput+0x258>
								bfree(ip->dev, a3[k]);
80101d69:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d6c:	8b 14 9f             	mov    (%edi,%ebx,4),%edx
						for(k=0 ; k<NINDIRECT; k++){
80101d6f:	83 c3 01             	add    $0x1,%ebx
								bfree(ip->dev, a3[k]);
80101d72:	8b 00                	mov    (%eax),%eax
80101d74:	e8 27 f5 ff ff       	call   801012a0 <bfree>
						for(k=0 ; k<NINDIRECT; k++){
80101d79:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
80101d7f:	75 e2                	jne    80101d63 <iput+0x263>
						brelse(bp3);
80101d81:	83 ec 0c             	sub    $0xc,%esp
80101d84:	ff 75 d0             	pushl  -0x30(%ebp)
80101d87:	e8 54 e4 ff ff       	call   801001e0 <brelse>
						bfree(ip->dev, a2[j]);
80101d8c:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101d8f:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101d92:	8b 14 08             	mov    (%eax,%ecx,1),%edx
80101d95:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d98:	8b 00                	mov    (%eax),%eax
80101d9a:	e8 01 f5 ff ff       	call   801012a0 <bfree>
80101d9f:	83 c4 10             	add    $0x10,%esp
80101da2:	e9 49 ff ff ff       	jmp    80101cf0 <iput+0x1f0>
				brelse(bp);
80101da7:	83 ec 0c             	sub    $0xc,%esp
80101daa:	ff 75 c4             	pushl  -0x3c(%ebp)
80101dad:	e8 2e e4 ff ff       	call   801001e0 <brelse>
				bfree(ip->dev, ip->addrs[NDIRECT+2]);
80101db2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101db5:	8b 97 8c 00 00 00    	mov    0x8c(%edi),%edx
80101dbb:	8b 07                	mov    (%edi),%eax
80101dbd:	e8 de f4 ff ff       	call   801012a0 <bfree>
				ip->addrs[NDIRECT+2] = 0;
80101dc2:	c7 87 8c 00 00 00 00 	movl   $0x0,0x8c(%edi)
80101dc9:	00 00 00 
80101dcc:	83 c4 10             	add    $0x10,%esp
80101dcf:	e9 dc fe ff ff       	jmp    80101cb0 <iput+0x1b0>
		bp = bread(ip->dev, ip->addrs[NDIRECT+1]);
80101dd4:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101dd7:	57                   	push   %edi
80101dd8:	57                   	push   %edi
80101dd9:	50                   	push   %eax
80101dda:	ff 36                	pushl  (%esi)
80101ddc:	e8 ef e2 ff ff       	call   801000d0 <bread>
		a = (uint*)bp->data;
80101de1:	8d 48 5c             	lea    0x5c(%eax),%ecx
		bp = bread(ip->dev, ip->addrs[NDIRECT+1]);
80101de4:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101de7:	05 5c 02 00 00       	add    $0x25c,%eax
80101dec:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101def:	83 c4 10             	add    $0x10,%esp
		a = (uint*)bp->data;
80101df2:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101df5:	eb 15                	jmp    80101e0c <iput+0x30c>
80101df7:	89 f6                	mov    %esi,%esi
80101df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101e00:	83 45 e0 04          	addl   $0x4,-0x20(%ebp)
80101e04:	8b 45 e0             	mov    -0x20(%ebp),%eax
		for(i=0; i<NINDIRECT; i++){
80101e07:	3b 45 dc             	cmp    -0x24(%ebp),%eax
80101e0a:	74 63                	je     80101e6f <iput+0x36f>
			if(a[i]){
80101e0c:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e0f:	8b 00                	mov    (%eax),%eax
80101e11:	85 c0                	test   %eax,%eax
80101e13:	74 eb                	je     80101e00 <iput+0x300>
				bp2=bread(ip->dev, a[i]);
80101e15:	83 ec 08             	sub    $0x8,%esp
80101e18:	50                   	push   %eax
80101e19:	ff 36                	pushl  (%esi)
80101e1b:	e8 b0 e2 ff ff       	call   801000d0 <bread>
80101e20:	83 c4 10             	add    $0x10,%esp
80101e23:	89 45 d4             	mov    %eax,-0x2c(%ebp)
				a2=(uint*)bp2->data;
80101e26:	8d 58 5c             	lea    0x5c(%eax),%ebx
80101e29:	8d b8 5c 02 00 00    	lea    0x25c(%eax),%edi
80101e2f:	eb 0e                	jmp    80101e3f <iput+0x33f>
80101e31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e38:	83 c3 04             	add    $0x4,%ebx
				for(j=0 ; j<NINDIRECT; j++){
80101e3b:	39 fb                	cmp    %edi,%ebx
80101e3d:	74 14                	je     80101e53 <iput+0x353>
					if(a2[j])
80101e3f:	8b 13                	mov    (%ebx),%edx
80101e41:	85 d2                	test   %edx,%edx
80101e43:	74 f3                	je     80101e38 <iput+0x338>
						bfree(ip->dev, a2[j]);
80101e45:	8b 06                	mov    (%esi),%eax
80101e47:	83 c3 04             	add    $0x4,%ebx
80101e4a:	e8 51 f4 ff ff       	call   801012a0 <bfree>
				for(j=0 ; j<NINDIRECT; j++){
80101e4f:	39 fb                	cmp    %edi,%ebx
80101e51:	75 ec                	jne    80101e3f <iput+0x33f>
				brelse(bp2);
80101e53:	83 ec 0c             	sub    $0xc,%esp
80101e56:	ff 75 d4             	pushl  -0x2c(%ebp)
80101e59:	e8 82 e3 ff ff       	call   801001e0 <brelse>
				bfree(ip->dev, a[i]);
80101e5e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e61:	8b 10                	mov    (%eax),%edx
80101e63:	8b 06                	mov    (%esi),%eax
80101e65:	e8 36 f4 ff ff       	call   801012a0 <bfree>
80101e6a:	83 c4 10             	add    $0x10,%esp
80101e6d:	eb 91                	jmp    80101e00 <iput+0x300>
		brelse(bp);
80101e6f:	83 ec 0c             	sub    $0xc,%esp
80101e72:	ff 75 d8             	pushl  -0x28(%ebp)
80101e75:	e8 66 e3 ff ff       	call   801001e0 <brelse>
		bfree(ip->dev, ip->addrs[NDIRECT+1]);
80101e7a:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101e7d:	8b 97 88 00 00 00    	mov    0x88(%edi),%edx
80101e83:	8b 07                	mov    (%edi),%eax
80101e85:	e8 16 f4 ff ff       	call   801012a0 <bfree>
		ip->addrs[NDIRECT+1] = 0;
80101e8a:	c7 87 88 00 00 00 00 	movl   $0x0,0x88(%edi)
80101e91:	00 00 00 
80101e94:	83 c4 10             	add    $0x10,%esp
80101e97:	e9 3c fd ff ff       	jmp    80101bd8 <iput+0xd8>
80101e9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ea0 <iunlockput>:
{
80101ea0:	55                   	push   %ebp
80101ea1:	89 e5                	mov    %esp,%ebp
80101ea3:	53                   	push   %ebx
80101ea4:	83 ec 10             	sub    $0x10,%esp
80101ea7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101eaa:	53                   	push   %ebx
80101eab:	e8 00 fc ff ff       	call   80101ab0 <iunlock>
  iput(ip);
80101eb0:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101eb3:	83 c4 10             	add    $0x10,%esp
}
80101eb6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101eb9:	c9                   	leave  
  iput(ip);
80101eba:	e9 41 fc ff ff       	jmp    80101b00 <iput>
80101ebf:	90                   	nop

80101ec0 <stati>:
}
// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101ec0:	55                   	push   %ebp
80101ec1:	89 e5                	mov    %esp,%ebp
80101ec3:	8b 55 08             	mov    0x8(%ebp),%edx
80101ec6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101ec9:	8b 0a                	mov    (%edx),%ecx
80101ecb:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101ece:	8b 4a 04             	mov    0x4(%edx),%ecx
80101ed1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101ed4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101ed8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101edb:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101edf:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101ee3:	8b 52 58             	mov    0x58(%edx),%edx
80101ee6:	89 50 10             	mov    %edx,0x10(%eax)
}
80101ee9:	5d                   	pop    %ebp
80101eea:	c3                   	ret    
80101eeb:	90                   	nop
80101eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ef0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101ef0:	55                   	push   %ebp
80101ef1:	89 e5                	mov    %esp,%ebp
80101ef3:	57                   	push   %edi
80101ef4:	56                   	push   %esi
80101ef5:	53                   	push   %ebx
80101ef6:	83 ec 1c             	sub    $0x1c,%esp
80101ef9:	8b 45 08             	mov    0x8(%ebp),%eax
80101efc:	8b 75 0c             	mov    0xc(%ebp),%esi
80101eff:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101f02:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101f07:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101f0a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101f0d:	8b 75 10             	mov    0x10(%ebp),%esi
80101f10:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101f13:	0f 84 a7 00 00 00    	je     80101fc0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101f19:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101f1c:	8b 40 58             	mov    0x58(%eax),%eax
80101f1f:	39 c6                	cmp    %eax,%esi
80101f21:	0f 87 ba 00 00 00    	ja     80101fe1 <readi+0xf1>
80101f27:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101f2a:	89 f9                	mov    %edi,%ecx
80101f2c:	01 f1                	add    %esi,%ecx
80101f2e:	0f 82 ad 00 00 00    	jb     80101fe1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101f34:	89 c2                	mov    %eax,%edx
80101f36:	29 f2                	sub    %esi,%edx
80101f38:	39 c8                	cmp    %ecx,%eax
80101f3a:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101f3d:	31 ff                	xor    %edi,%edi
80101f3f:	85 d2                	test   %edx,%edx
    n = ip->size - off;
80101f41:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101f44:	74 6c                	je     80101fb2 <readi+0xc2>
80101f46:	8d 76 00             	lea    0x0(%esi),%esi
80101f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101f50:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101f53:	89 f2                	mov    %esi,%edx
80101f55:	c1 ea 09             	shr    $0x9,%edx
80101f58:	89 d8                	mov    %ebx,%eax
80101f5a:	e8 91 f5 ff ff       	call   801014f0 <bmap>
80101f5f:	83 ec 08             	sub    $0x8,%esp
80101f62:	50                   	push   %eax
80101f63:	ff 33                	pushl  (%ebx)
80101f65:	e8 66 e1 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101f6a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101f6d:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101f6f:	89 f0                	mov    %esi,%eax
80101f71:	25 ff 01 00 00       	and    $0x1ff,%eax
80101f76:	b9 00 02 00 00       	mov    $0x200,%ecx
80101f7b:	83 c4 0c             	add    $0xc,%esp
80101f7e:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101f80:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101f84:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101f87:	29 fb                	sub    %edi,%ebx
80101f89:	39 d9                	cmp    %ebx,%ecx
80101f8b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101f8e:	53                   	push   %ebx
80101f8f:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101f90:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101f92:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101f95:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101f97:	e8 14 3f 00 00       	call   80105eb0 <memmove>
    brelse(bp);
80101f9c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101f9f:	89 14 24             	mov    %edx,(%esp)
80101fa2:	e8 39 e2 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101fa7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101faa:	83 c4 10             	add    $0x10,%esp
80101fad:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101fb0:	77 9e                	ja     80101f50 <readi+0x60>
  }
  return n;
80101fb2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101fb5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fb8:	5b                   	pop    %ebx
80101fb9:	5e                   	pop    %esi
80101fba:	5f                   	pop    %edi
80101fbb:	5d                   	pop    %ebp
80101fbc:	c3                   	ret    
80101fbd:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101fc0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101fc4:	66 83 f8 09          	cmp    $0x9,%ax
80101fc8:	77 17                	ja     80101fe1 <readi+0xf1>
80101fca:	8b 04 c5 80 29 11 80 	mov    -0x7feed680(,%eax,8),%eax
80101fd1:	85 c0                	test   %eax,%eax
80101fd3:	74 0c                	je     80101fe1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101fd5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101fd8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fdb:	5b                   	pop    %ebx
80101fdc:	5e                   	pop    %esi
80101fdd:	5f                   	pop    %edi
80101fde:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101fdf:	ff e0                	jmp    *%eax
      return -1;
80101fe1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101fe6:	eb cd                	jmp    80101fb5 <readi+0xc5>
80101fe8:	90                   	nop
80101fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101ff0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101ff0:	55                   	push   %ebp
80101ff1:	89 e5                	mov    %esp,%ebp
80101ff3:	57                   	push   %edi
80101ff4:	56                   	push   %esi
80101ff5:	53                   	push   %ebx
80101ff6:	83 ec 1c             	sub    $0x1c,%esp
80101ff9:	8b 45 08             	mov    0x8(%ebp),%eax
80101ffc:	8b 75 0c             	mov    0xc(%ebp),%esi
80101fff:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102002:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80102007:	89 75 dc             	mov    %esi,-0x24(%ebp)
8010200a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010200d:	8b 75 10             	mov    0x10(%ebp),%esi
80102010:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80102013:	0f 84 b7 00 00 00    	je     801020d0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80102019:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010201c:	39 70 58             	cmp    %esi,0x58(%eax)
8010201f:	0f 82 eb 00 00 00    	jb     80102110 <writei+0x120>
80102025:	8b 7d e0             	mov    -0x20(%ebp),%edi
80102028:	31 d2                	xor    %edx,%edx
8010202a:	89 f8                	mov    %edi,%eax
8010202c:	01 f0                	add    %esi,%eax
8010202e:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80102031:	3d 00 14 81 40       	cmp    $0x40811400,%eax
80102036:	0f 87 d4 00 00 00    	ja     80102110 <writei+0x120>
8010203c:	85 d2                	test   %edx,%edx
8010203e:	0f 85 cc 00 00 00    	jne    80102110 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102044:	85 ff                	test   %edi,%edi
80102046:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010204d:	74 72                	je     801020c1 <writei+0xd1>
8010204f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102050:	8b 7d d8             	mov    -0x28(%ebp),%edi
80102053:	89 f2                	mov    %esi,%edx
80102055:	c1 ea 09             	shr    $0x9,%edx
80102058:	89 f8                	mov    %edi,%eax
8010205a:	e8 91 f4 ff ff       	call   801014f0 <bmap>
8010205f:	83 ec 08             	sub    $0x8,%esp
80102062:	50                   	push   %eax
80102063:	ff 37                	pushl  (%edi)
80102065:	e8 66 e0 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
8010206a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
8010206d:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102070:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80102072:	89 f0                	mov    %esi,%eax
80102074:	b9 00 02 00 00       	mov    $0x200,%ecx
80102079:	83 c4 0c             	add    $0xc,%esp
8010207c:	25 ff 01 00 00       	and    $0x1ff,%eax
80102081:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80102083:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102087:	39 d9                	cmp    %ebx,%ecx
80102089:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
8010208c:	53                   	push   %ebx
8010208d:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102090:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80102092:	50                   	push   %eax
80102093:	e8 18 3e 00 00       	call   80105eb0 <memmove>
    log_write(bp);
80102098:	89 3c 24             	mov    %edi,(%esp)
8010209b:	e8 60 12 00 00       	call   80103300 <log_write>
    brelse(bp);
801020a0:	89 3c 24             	mov    %edi,(%esp)
801020a3:	e8 38 e1 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801020a8:	01 5d e4             	add    %ebx,-0x1c(%ebp)
801020ab:	01 5d dc             	add    %ebx,-0x24(%ebp)
801020ae:	83 c4 10             	add    $0x10,%esp
801020b1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801020b4:	39 45 e0             	cmp    %eax,-0x20(%ebp)
801020b7:	77 97                	ja     80102050 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
801020b9:	8b 45 d8             	mov    -0x28(%ebp),%eax
801020bc:	3b 70 58             	cmp    0x58(%eax),%esi
801020bf:	77 37                	ja     801020f8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
801020c1:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
801020c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020c7:	5b                   	pop    %ebx
801020c8:	5e                   	pop    %esi
801020c9:	5f                   	pop    %edi
801020ca:	5d                   	pop    %ebp
801020cb:	c3                   	ret    
801020cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
801020d0:	0f bf 40 52          	movswl 0x52(%eax),%eax
801020d4:	66 83 f8 09          	cmp    $0x9,%ax
801020d8:	77 36                	ja     80102110 <writei+0x120>
801020da:	8b 04 c5 84 29 11 80 	mov    -0x7feed67c(,%eax,8),%eax
801020e1:	85 c0                	test   %eax,%eax
801020e3:	74 2b                	je     80102110 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
801020e5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
801020e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020eb:	5b                   	pop    %ebx
801020ec:	5e                   	pop    %esi
801020ed:	5f                   	pop    %edi
801020ee:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
801020ef:	ff e0                	jmp    *%eax
801020f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
801020f8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
801020fb:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
801020fe:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80102101:	50                   	push   %eax
80102102:	e8 19 f8 ff ff       	call   80101920 <iupdate>
80102107:	83 c4 10             	add    $0x10,%esp
8010210a:	eb b5                	jmp    801020c1 <writei+0xd1>
8010210c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80102110:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102115:	eb ad                	jmp    801020c4 <writei+0xd4>
80102117:	89 f6                	mov    %esi,%esi
80102119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102120 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102120:	55                   	push   %ebp
80102121:	89 e5                	mov    %esp,%ebp
80102123:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80102126:	6a 0e                	push   $0xe
80102128:	ff 75 0c             	pushl  0xc(%ebp)
8010212b:	ff 75 08             	pushl  0x8(%ebp)
8010212e:	e8 ed 3d 00 00       	call   80105f20 <strncmp>
}
80102133:	c9                   	leave  
80102134:	c3                   	ret    
80102135:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102140 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102140:	55                   	push   %ebp
80102141:	89 e5                	mov    %esp,%ebp
80102143:	57                   	push   %edi
80102144:	56                   	push   %esi
80102145:	53                   	push   %ebx
80102146:	83 ec 1c             	sub    $0x1c,%esp
80102149:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
8010214c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80102151:	0f 85 85 00 00 00    	jne    801021dc <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102157:	8b 53 58             	mov    0x58(%ebx),%edx
8010215a:	31 ff                	xor    %edi,%edi
8010215c:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010215f:	85 d2                	test   %edx,%edx
80102161:	74 3e                	je     801021a1 <dirlookup+0x61>
80102163:	90                   	nop
80102164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102168:	6a 10                	push   $0x10
8010216a:	57                   	push   %edi
8010216b:	56                   	push   %esi
8010216c:	53                   	push   %ebx
8010216d:	e8 7e fd ff ff       	call   80101ef0 <readi>
80102172:	83 c4 10             	add    $0x10,%esp
80102175:	83 f8 10             	cmp    $0x10,%eax
80102178:	75 55                	jne    801021cf <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
8010217a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010217f:	74 18                	je     80102199 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80102181:	8d 45 da             	lea    -0x26(%ebp),%eax
80102184:	83 ec 04             	sub    $0x4,%esp
80102187:	6a 0e                	push   $0xe
80102189:	50                   	push   %eax
8010218a:	ff 75 0c             	pushl  0xc(%ebp)
8010218d:	e8 8e 3d 00 00       	call   80105f20 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80102192:	83 c4 10             	add    $0x10,%esp
80102195:	85 c0                	test   %eax,%eax
80102197:	74 17                	je     801021b0 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102199:	83 c7 10             	add    $0x10,%edi
8010219c:	3b 7b 58             	cmp    0x58(%ebx),%edi
8010219f:	72 c7                	jb     80102168 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
801021a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801021a4:	31 c0                	xor    %eax,%eax
}
801021a6:	5b                   	pop    %ebx
801021a7:	5e                   	pop    %esi
801021a8:	5f                   	pop    %edi
801021a9:	5d                   	pop    %ebp
801021aa:	c3                   	ret    
801021ab:	90                   	nop
801021ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
801021b0:	8b 45 10             	mov    0x10(%ebp),%eax
801021b3:	85 c0                	test   %eax,%eax
801021b5:	74 05                	je     801021bc <dirlookup+0x7c>
        *poff = off;
801021b7:	8b 45 10             	mov    0x10(%ebp),%eax
801021ba:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
801021bc:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
801021c0:	8b 03                	mov    (%ebx),%eax
801021c2:	e8 59 f2 ff ff       	call   80101420 <iget>
}
801021c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021ca:	5b                   	pop    %ebx
801021cb:	5e                   	pop    %esi
801021cc:	5f                   	pop    %edi
801021cd:	5d                   	pop    %ebp
801021ce:	c3                   	ret    
      panic("dirlookup read");
801021cf:	83 ec 0c             	sub    $0xc,%esp
801021d2:	68 19 8d 10 80       	push   $0x80108d19
801021d7:	e8 b4 e1 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
801021dc:	83 ec 0c             	sub    $0xc,%esp
801021df:	68 07 8d 10 80       	push   $0x80108d07
801021e4:	e8 a7 e1 ff ff       	call   80100390 <panic>
801021e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801021f0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
801021f0:	55                   	push   %ebp
801021f1:	89 e5                	mov    %esp,%ebp
801021f3:	57                   	push   %edi
801021f4:	56                   	push   %esi
801021f5:	53                   	push   %ebx
801021f6:	89 cf                	mov    %ecx,%edi
801021f8:	89 c3                	mov    %eax,%ebx
801021fa:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
801021fd:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80102200:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80102203:	0f 84 67 01 00 00    	je     80102370 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80102209:	e8 62 21 00 00       	call   80104370 <myproc>
  acquire(&icache.lock);
8010220e:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80102211:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80102214:	68 00 2a 11 80       	push   $0x80112a00
80102219:	e8 d2 3a 00 00       	call   80105cf0 <acquire>
  ip->ref++;
8010221e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102222:	c7 04 24 00 2a 11 80 	movl   $0x80112a00,(%esp)
80102229:	e8 82 3b 00 00       	call   80105db0 <release>
8010222e:	83 c4 10             	add    $0x10,%esp
80102231:	eb 08                	jmp    8010223b <namex+0x4b>
80102233:	90                   	nop
80102234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102238:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
8010223b:	0f b6 03             	movzbl (%ebx),%eax
8010223e:	3c 2f                	cmp    $0x2f,%al
80102240:	74 f6                	je     80102238 <namex+0x48>
  if(*path == 0)
80102242:	84 c0                	test   %al,%al
80102244:	0f 84 ee 00 00 00    	je     80102338 <namex+0x148>
  while(*path != '/' && *path != 0)
8010224a:	0f b6 03             	movzbl (%ebx),%eax
8010224d:	3c 2f                	cmp    $0x2f,%al
8010224f:	0f 84 b3 00 00 00    	je     80102308 <namex+0x118>
80102255:	84 c0                	test   %al,%al
80102257:	89 da                	mov    %ebx,%edx
80102259:	75 09                	jne    80102264 <namex+0x74>
8010225b:	e9 a8 00 00 00       	jmp    80102308 <namex+0x118>
80102260:	84 c0                	test   %al,%al
80102262:	74 0a                	je     8010226e <namex+0x7e>
    path++;
80102264:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80102267:	0f b6 02             	movzbl (%edx),%eax
8010226a:	3c 2f                	cmp    $0x2f,%al
8010226c:	75 f2                	jne    80102260 <namex+0x70>
8010226e:	89 d1                	mov    %edx,%ecx
80102270:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80102272:	83 f9 0d             	cmp    $0xd,%ecx
80102275:	0f 8e 91 00 00 00    	jle    8010230c <namex+0x11c>
    memmove(name, s, DIRSIZ);
8010227b:	83 ec 04             	sub    $0x4,%esp
8010227e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80102281:	6a 0e                	push   $0xe
80102283:	53                   	push   %ebx
80102284:	57                   	push   %edi
80102285:	e8 26 3c 00 00       	call   80105eb0 <memmove>
    path++;
8010228a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
8010228d:	83 c4 10             	add    $0x10,%esp
    path++;
80102290:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80102292:	80 3a 2f             	cmpb   $0x2f,(%edx)
80102295:	75 11                	jne    801022a8 <namex+0xb8>
80102297:	89 f6                	mov    %esi,%esi
80102299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
801022a0:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
801022a3:	80 3b 2f             	cmpb   $0x2f,(%ebx)
801022a6:	74 f8                	je     801022a0 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
801022a8:	83 ec 0c             	sub    $0xc,%esp
801022ab:	56                   	push   %esi
801022ac:	e8 1f f7 ff ff       	call   801019d0 <ilock>
    if(ip->type != T_DIR){
801022b1:	83 c4 10             	add    $0x10,%esp
801022b4:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801022b9:	0f 85 91 00 00 00    	jne    80102350 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
801022bf:	8b 55 e0             	mov    -0x20(%ebp),%edx
801022c2:	85 d2                	test   %edx,%edx
801022c4:	74 09                	je     801022cf <namex+0xdf>
801022c6:	80 3b 00             	cmpb   $0x0,(%ebx)
801022c9:	0f 84 b7 00 00 00    	je     80102386 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
801022cf:	83 ec 04             	sub    $0x4,%esp
801022d2:	6a 00                	push   $0x0
801022d4:	57                   	push   %edi
801022d5:	56                   	push   %esi
801022d6:	e8 65 fe ff ff       	call   80102140 <dirlookup>
801022db:	83 c4 10             	add    $0x10,%esp
801022de:	85 c0                	test   %eax,%eax
801022e0:	74 6e                	je     80102350 <namex+0x160>
  iunlock(ip);
801022e2:	83 ec 0c             	sub    $0xc,%esp
801022e5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801022e8:	56                   	push   %esi
801022e9:	e8 c2 f7 ff ff       	call   80101ab0 <iunlock>
  iput(ip);
801022ee:	89 34 24             	mov    %esi,(%esp)
801022f1:	e8 0a f8 ff ff       	call   80101b00 <iput>
801022f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801022f9:	83 c4 10             	add    $0x10,%esp
801022fc:	89 c6                	mov    %eax,%esi
801022fe:	e9 38 ff ff ff       	jmp    8010223b <namex+0x4b>
80102303:	90                   	nop
80102304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80102308:	89 da                	mov    %ebx,%edx
8010230a:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
8010230c:	83 ec 04             	sub    $0x4,%esp
8010230f:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102312:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80102315:	51                   	push   %ecx
80102316:	53                   	push   %ebx
80102317:	57                   	push   %edi
80102318:	e8 93 3b 00 00       	call   80105eb0 <memmove>
    name[len] = 0;
8010231d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80102320:	8b 55 dc             	mov    -0x24(%ebp),%edx
80102323:	83 c4 10             	add    $0x10,%esp
80102326:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
8010232a:	89 d3                	mov    %edx,%ebx
8010232c:	e9 61 ff ff ff       	jmp    80102292 <namex+0xa2>
80102331:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80102338:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010233b:	85 c0                	test   %eax,%eax
8010233d:	75 5d                	jne    8010239c <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
8010233f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102342:	89 f0                	mov    %esi,%eax
80102344:	5b                   	pop    %ebx
80102345:	5e                   	pop    %esi
80102346:	5f                   	pop    %edi
80102347:	5d                   	pop    %ebp
80102348:	c3                   	ret    
80102349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80102350:	83 ec 0c             	sub    $0xc,%esp
80102353:	56                   	push   %esi
80102354:	e8 57 f7 ff ff       	call   80101ab0 <iunlock>
  iput(ip);
80102359:	89 34 24             	mov    %esi,(%esp)
      return 0;
8010235c:	31 f6                	xor    %esi,%esi
  iput(ip);
8010235e:	e8 9d f7 ff ff       	call   80101b00 <iput>
      return 0;
80102363:	83 c4 10             	add    $0x10,%esp
}
80102366:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102369:	89 f0                	mov    %esi,%eax
8010236b:	5b                   	pop    %ebx
8010236c:	5e                   	pop    %esi
8010236d:	5f                   	pop    %edi
8010236e:	5d                   	pop    %ebp
8010236f:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80102370:	ba 01 00 00 00       	mov    $0x1,%edx
80102375:	b8 01 00 00 00       	mov    $0x1,%eax
8010237a:	e8 a1 f0 ff ff       	call   80101420 <iget>
8010237f:	89 c6                	mov    %eax,%esi
80102381:	e9 b5 fe ff ff       	jmp    8010223b <namex+0x4b>
      iunlock(ip);
80102386:	83 ec 0c             	sub    $0xc,%esp
80102389:	56                   	push   %esi
8010238a:	e8 21 f7 ff ff       	call   80101ab0 <iunlock>
      return ip;
8010238f:	83 c4 10             	add    $0x10,%esp
}
80102392:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102395:	89 f0                	mov    %esi,%eax
80102397:	5b                   	pop    %ebx
80102398:	5e                   	pop    %esi
80102399:	5f                   	pop    %edi
8010239a:	5d                   	pop    %ebp
8010239b:	c3                   	ret    
    iput(ip);
8010239c:	83 ec 0c             	sub    $0xc,%esp
8010239f:	56                   	push   %esi
    return 0;
801023a0:	31 f6                	xor    %esi,%esi
    iput(ip);
801023a2:	e8 59 f7 ff ff       	call   80101b00 <iput>
    return 0;
801023a7:	83 c4 10             	add    $0x10,%esp
801023aa:	eb 93                	jmp    8010233f <namex+0x14f>
801023ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801023b0 <dirlink>:
{
801023b0:	55                   	push   %ebp
801023b1:	89 e5                	mov    %esp,%ebp
801023b3:	57                   	push   %edi
801023b4:	56                   	push   %esi
801023b5:	53                   	push   %ebx
801023b6:	83 ec 20             	sub    $0x20,%esp
801023b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
801023bc:	6a 00                	push   $0x0
801023be:	ff 75 0c             	pushl  0xc(%ebp)
801023c1:	53                   	push   %ebx
801023c2:	e8 79 fd ff ff       	call   80102140 <dirlookup>
801023c7:	83 c4 10             	add    $0x10,%esp
801023ca:	85 c0                	test   %eax,%eax
801023cc:	75 67                	jne    80102435 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
801023ce:	8b 7b 58             	mov    0x58(%ebx),%edi
801023d1:	8d 75 d8             	lea    -0x28(%ebp),%esi
801023d4:	85 ff                	test   %edi,%edi
801023d6:	74 29                	je     80102401 <dirlink+0x51>
801023d8:	31 ff                	xor    %edi,%edi
801023da:	8d 75 d8             	lea    -0x28(%ebp),%esi
801023dd:	eb 09                	jmp    801023e8 <dirlink+0x38>
801023df:	90                   	nop
801023e0:	83 c7 10             	add    $0x10,%edi
801023e3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801023e6:	73 19                	jae    80102401 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801023e8:	6a 10                	push   $0x10
801023ea:	57                   	push   %edi
801023eb:	56                   	push   %esi
801023ec:	53                   	push   %ebx
801023ed:	e8 fe fa ff ff       	call   80101ef0 <readi>
801023f2:	83 c4 10             	add    $0x10,%esp
801023f5:	83 f8 10             	cmp    $0x10,%eax
801023f8:	75 4e                	jne    80102448 <dirlink+0x98>
    if(de.inum == 0)
801023fa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801023ff:	75 df                	jne    801023e0 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102401:	8d 45 da             	lea    -0x26(%ebp),%eax
80102404:	83 ec 04             	sub    $0x4,%esp
80102407:	6a 0e                	push   $0xe
80102409:	ff 75 0c             	pushl  0xc(%ebp)
8010240c:	50                   	push   %eax
8010240d:	e8 6e 3b 00 00       	call   80105f80 <strncpy>
  de.inum = inum;
80102412:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102415:	6a 10                	push   $0x10
80102417:	57                   	push   %edi
80102418:	56                   	push   %esi
80102419:	53                   	push   %ebx
  de.inum = inum;
8010241a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010241e:	e8 cd fb ff ff       	call   80101ff0 <writei>
80102423:	83 c4 20             	add    $0x20,%esp
80102426:	83 f8 10             	cmp    $0x10,%eax
80102429:	75 2a                	jne    80102455 <dirlink+0xa5>
  return 0;
8010242b:	31 c0                	xor    %eax,%eax
}
8010242d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102430:	5b                   	pop    %ebx
80102431:	5e                   	pop    %esi
80102432:	5f                   	pop    %edi
80102433:	5d                   	pop    %ebp
80102434:	c3                   	ret    
    iput(ip);
80102435:	83 ec 0c             	sub    $0xc,%esp
80102438:	50                   	push   %eax
80102439:	e8 c2 f6 ff ff       	call   80101b00 <iput>
    return -1;
8010243e:	83 c4 10             	add    $0x10,%esp
80102441:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102446:	eb e5                	jmp    8010242d <dirlink+0x7d>
      panic("dirlink read");
80102448:	83 ec 0c             	sub    $0xc,%esp
8010244b:	68 28 8d 10 80       	push   $0x80108d28
80102450:	e8 3b df ff ff       	call   80100390 <panic>
    panic("dirlink");
80102455:	83 ec 0c             	sub    $0xc,%esp
80102458:	68 22 94 10 80       	push   $0x80109422
8010245d:	e8 2e df ff ff       	call   80100390 <panic>
80102462:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102470 <namei>:

struct inode*
namei(char *path)
{
80102470:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102471:	31 d2                	xor    %edx,%edx
{
80102473:	89 e5                	mov    %esp,%ebp
80102475:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102478:	8b 45 08             	mov    0x8(%ebp),%eax
8010247b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010247e:	e8 6d fd ff ff       	call   801021f0 <namex>
}
80102483:	c9                   	leave  
80102484:	c3                   	ret    
80102485:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102490 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102490:	55                   	push   %ebp
  return namex(path, 1, name);
80102491:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102496:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102498:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010249b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010249e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010249f:	e9 4c fd ff ff       	jmp    801021f0 <namex>
801024a4:	66 90                	xchg   %ax,%ax
801024a6:	66 90                	xchg   %ax,%ax
801024a8:	66 90                	xchg   %ax,%ax
801024aa:	66 90                	xchg   %ax,%ax
801024ac:	66 90                	xchg   %ax,%ax
801024ae:	66 90                	xchg   %ax,%ax

801024b0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801024b0:	55                   	push   %ebp
801024b1:	89 e5                	mov    %esp,%ebp
801024b3:	57                   	push   %edi
801024b4:	56                   	push   %esi
801024b5:	53                   	push   %ebx
801024b6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
801024b9:	85 c0                	test   %eax,%eax
801024bb:	0f 84 b4 00 00 00    	je     80102575 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801024c1:	8b 58 08             	mov    0x8(%eax),%ebx
801024c4:	89 c6                	mov    %eax,%esi
801024c6:	81 fb 9f 0f 00 00    	cmp    $0xf9f,%ebx
801024cc:	0f 87 96 00 00 00    	ja     80102568 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801024d2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
801024d7:	89 f6                	mov    %esi,%esi
801024d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801024e0:	89 ca                	mov    %ecx,%edx
801024e2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801024e3:	83 e0 c0             	and    $0xffffffc0,%eax
801024e6:	3c 40                	cmp    $0x40,%al
801024e8:	75 f6                	jne    801024e0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801024ea:	31 ff                	xor    %edi,%edi
801024ec:	ba f6 03 00 00       	mov    $0x3f6,%edx
801024f1:	89 f8                	mov    %edi,%eax
801024f3:	ee                   	out    %al,(%dx)
801024f4:	b8 01 00 00 00       	mov    $0x1,%eax
801024f9:	ba f2 01 00 00       	mov    $0x1f2,%edx
801024fe:	ee                   	out    %al,(%dx)
801024ff:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102504:	89 d8                	mov    %ebx,%eax
80102506:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102507:	89 d8                	mov    %ebx,%eax
80102509:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010250e:	c1 f8 08             	sar    $0x8,%eax
80102511:	ee                   	out    %al,(%dx)
80102512:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102517:	89 f8                	mov    %edi,%eax
80102519:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010251a:	0f b6 46 04          	movzbl 0x4(%esi),%eax
8010251e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102523:	c1 e0 04             	shl    $0x4,%eax
80102526:	83 e0 10             	and    $0x10,%eax
80102529:	83 c8 e0             	or     $0xffffffe0,%eax
8010252c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010252d:	f6 06 04             	testb  $0x4,(%esi)
80102530:	75 16                	jne    80102548 <idestart+0x98>
80102532:	b8 20 00 00 00       	mov    $0x20,%eax
80102537:	89 ca                	mov    %ecx,%edx
80102539:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010253a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010253d:	5b                   	pop    %ebx
8010253e:	5e                   	pop    %esi
8010253f:	5f                   	pop    %edi
80102540:	5d                   	pop    %ebp
80102541:	c3                   	ret    
80102542:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102548:	b8 30 00 00 00       	mov    $0x30,%eax
8010254d:	89 ca                	mov    %ecx,%edx
8010254f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102550:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102555:	83 c6 5c             	add    $0x5c,%esi
80102558:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010255d:	fc                   	cld    
8010255e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102560:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102563:	5b                   	pop    %ebx
80102564:	5e                   	pop    %esi
80102565:	5f                   	pop    %edi
80102566:	5d                   	pop    %ebp
80102567:	c3                   	ret    
    panic("incorrect blockno");
80102568:	83 ec 0c             	sub    $0xc,%esp
8010256b:	68 94 8d 10 80       	push   $0x80108d94
80102570:	e8 1b de ff ff       	call   80100390 <panic>
    panic("idestart");
80102575:	83 ec 0c             	sub    $0xc,%esp
80102578:	68 8b 8d 10 80       	push   $0x80108d8b
8010257d:	e8 0e de ff ff       	call   80100390 <panic>
80102582:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102590 <ideinit>:
{
80102590:	55                   	push   %ebp
80102591:	89 e5                	mov    %esp,%ebp
80102593:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102596:	68 a6 8d 10 80       	push   $0x80108da6
8010259b:	68 80 c5 10 80       	push   $0x8010c580
801025a0:	e8 0b 36 00 00       	call   80105bb0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801025a5:	58                   	pop    %eax
801025a6:	a1 20 4d 11 80       	mov    0x80114d20,%eax
801025ab:	5a                   	pop    %edx
801025ac:	83 e8 01             	sub    $0x1,%eax
801025af:	50                   	push   %eax
801025b0:	6a 0e                	push   $0xe
801025b2:	e8 a9 02 00 00       	call   80102860 <ioapicenable>
801025b7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801025ba:	ba f7 01 00 00       	mov    $0x1f7,%edx
801025bf:	90                   	nop
801025c0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801025c1:	83 e0 c0             	and    $0xffffffc0,%eax
801025c4:	3c 40                	cmp    $0x40,%al
801025c6:	75 f8                	jne    801025c0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801025c8:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801025cd:	ba f6 01 00 00       	mov    $0x1f6,%edx
801025d2:	ee                   	out    %al,(%dx)
801025d3:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801025d8:	ba f7 01 00 00       	mov    $0x1f7,%edx
801025dd:	eb 06                	jmp    801025e5 <ideinit+0x55>
801025df:	90                   	nop
  for(i=0; i<1000; i++){
801025e0:	83 e9 01             	sub    $0x1,%ecx
801025e3:	74 0f                	je     801025f4 <ideinit+0x64>
801025e5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801025e6:	84 c0                	test   %al,%al
801025e8:	74 f6                	je     801025e0 <ideinit+0x50>
      havedisk1 = 1;
801025ea:	c7 05 60 c5 10 80 01 	movl   $0x1,0x8010c560
801025f1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801025f4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801025f9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801025fe:	ee                   	out    %al,(%dx)
}
801025ff:	c9                   	leave  
80102600:	c3                   	ret    
80102601:	eb 0d                	jmp    80102610 <ideintr>
80102603:	90                   	nop
80102604:	90                   	nop
80102605:	90                   	nop
80102606:	90                   	nop
80102607:	90                   	nop
80102608:	90                   	nop
80102609:	90                   	nop
8010260a:	90                   	nop
8010260b:	90                   	nop
8010260c:	90                   	nop
8010260d:	90                   	nop
8010260e:	90                   	nop
8010260f:	90                   	nop

80102610 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102610:	55                   	push   %ebp
80102611:	89 e5                	mov    %esp,%ebp
80102613:	57                   	push   %edi
80102614:	56                   	push   %esi
80102615:	53                   	push   %ebx
80102616:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102619:	68 80 c5 10 80       	push   $0x8010c580
8010261e:	e8 cd 36 00 00       	call   80105cf0 <acquire>

  if((b = idequeue) == 0){
80102623:	8b 1d 64 c5 10 80    	mov    0x8010c564,%ebx
80102629:	83 c4 10             	add    $0x10,%esp
8010262c:	85 db                	test   %ebx,%ebx
8010262e:	74 67                	je     80102697 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102630:	8b 43 58             	mov    0x58(%ebx),%eax
80102633:	a3 64 c5 10 80       	mov    %eax,0x8010c564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102638:	8b 3b                	mov    (%ebx),%edi
8010263a:	f7 c7 04 00 00 00    	test   $0x4,%edi
80102640:	75 31                	jne    80102673 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102642:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102647:	89 f6                	mov    %esi,%esi
80102649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102650:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102651:	89 c6                	mov    %eax,%esi
80102653:	83 e6 c0             	and    $0xffffffc0,%esi
80102656:	89 f1                	mov    %esi,%ecx
80102658:	80 f9 40             	cmp    $0x40,%cl
8010265b:	75 f3                	jne    80102650 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010265d:	a8 21                	test   $0x21,%al
8010265f:	75 12                	jne    80102673 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
80102661:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102664:	b9 80 00 00 00       	mov    $0x80,%ecx
80102669:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010266e:	fc                   	cld    
8010266f:	f3 6d                	rep insl (%dx),%es:(%edi)
80102671:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102673:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
80102676:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102679:	89 f9                	mov    %edi,%ecx
8010267b:	83 c9 02             	or     $0x2,%ecx
8010267e:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
80102680:	53                   	push   %ebx
80102681:	e8 ea 2a 00 00       	call   80105170 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102686:	a1 64 c5 10 80       	mov    0x8010c564,%eax
8010268b:	83 c4 10             	add    $0x10,%esp
8010268e:	85 c0                	test   %eax,%eax
80102690:	74 05                	je     80102697 <ideintr+0x87>
    idestart(idequeue);
80102692:	e8 19 fe ff ff       	call   801024b0 <idestart>
    release(&idelock);
80102697:	83 ec 0c             	sub    $0xc,%esp
8010269a:	68 80 c5 10 80       	push   $0x8010c580
8010269f:	e8 0c 37 00 00       	call   80105db0 <release>

  release(&idelock);
}
801026a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801026a7:	5b                   	pop    %ebx
801026a8:	5e                   	pop    %esi
801026a9:	5f                   	pop    %edi
801026aa:	5d                   	pop    %ebp
801026ab:	c3                   	ret    
801026ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801026b0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801026b0:	55                   	push   %ebp
801026b1:	89 e5                	mov    %esp,%ebp
801026b3:	53                   	push   %ebx
801026b4:	83 ec 10             	sub    $0x10,%esp
801026b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801026ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801026bd:	50                   	push   %eax
801026be:	e8 9d 34 00 00       	call   80105b60 <holdingsleep>
801026c3:	83 c4 10             	add    $0x10,%esp
801026c6:	85 c0                	test   %eax,%eax
801026c8:	0f 84 c6 00 00 00    	je     80102794 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801026ce:	8b 03                	mov    (%ebx),%eax
801026d0:	83 e0 06             	and    $0x6,%eax
801026d3:	83 f8 02             	cmp    $0x2,%eax
801026d6:	0f 84 ab 00 00 00    	je     80102787 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801026dc:	8b 53 04             	mov    0x4(%ebx),%edx
801026df:	85 d2                	test   %edx,%edx
801026e1:	74 0d                	je     801026f0 <iderw+0x40>
801026e3:	a1 60 c5 10 80       	mov    0x8010c560,%eax
801026e8:	85 c0                	test   %eax,%eax
801026ea:	0f 84 b1 00 00 00    	je     801027a1 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801026f0:	83 ec 0c             	sub    $0xc,%esp
801026f3:	68 80 c5 10 80       	push   $0x8010c580
801026f8:	e8 f3 35 00 00       	call   80105cf0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801026fd:	8b 15 64 c5 10 80    	mov    0x8010c564,%edx
80102703:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
80102706:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010270d:	85 d2                	test   %edx,%edx
8010270f:	75 09                	jne    8010271a <iderw+0x6a>
80102711:	eb 6d                	jmp    80102780 <iderw+0xd0>
80102713:	90                   	nop
80102714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102718:	89 c2                	mov    %eax,%edx
8010271a:	8b 42 58             	mov    0x58(%edx),%eax
8010271d:	85 c0                	test   %eax,%eax
8010271f:	75 f7                	jne    80102718 <iderw+0x68>
80102721:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102724:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102726:	39 1d 64 c5 10 80    	cmp    %ebx,0x8010c564
8010272c:	74 42                	je     80102770 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010272e:	8b 03                	mov    (%ebx),%eax
80102730:	83 e0 06             	and    $0x6,%eax
80102733:	83 f8 02             	cmp    $0x2,%eax
80102736:	74 23                	je     8010275b <iderw+0xab>
80102738:	90                   	nop
80102739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102740:	83 ec 08             	sub    $0x8,%esp
80102743:	68 80 c5 10 80       	push   $0x8010c580
80102748:	53                   	push   %ebx
80102749:	e8 12 27 00 00       	call   80104e60 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010274e:	8b 03                	mov    (%ebx),%eax
80102750:	83 c4 10             	add    $0x10,%esp
80102753:	83 e0 06             	and    $0x6,%eax
80102756:	83 f8 02             	cmp    $0x2,%eax
80102759:	75 e5                	jne    80102740 <iderw+0x90>
  }


  release(&idelock);
8010275b:	c7 45 08 80 c5 10 80 	movl   $0x8010c580,0x8(%ebp)
}
80102762:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102765:	c9                   	leave  
  release(&idelock);
80102766:	e9 45 36 00 00       	jmp    80105db0 <release>
8010276b:	90                   	nop
8010276c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
80102770:	89 d8                	mov    %ebx,%eax
80102772:	e8 39 fd ff ff       	call   801024b0 <idestart>
80102777:	eb b5                	jmp    8010272e <iderw+0x7e>
80102779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102780:	ba 64 c5 10 80       	mov    $0x8010c564,%edx
80102785:	eb 9d                	jmp    80102724 <iderw+0x74>
    panic("iderw: nothing to do");
80102787:	83 ec 0c             	sub    $0xc,%esp
8010278a:	68 c0 8d 10 80       	push   $0x80108dc0
8010278f:	e8 fc db ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102794:	83 ec 0c             	sub    $0xc,%esp
80102797:	68 aa 8d 10 80       	push   $0x80108daa
8010279c:	e8 ef db ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
801027a1:	83 ec 0c             	sub    $0xc,%esp
801027a4:	68 d5 8d 10 80       	push   $0x80108dd5
801027a9:	e8 e2 db ff ff       	call   80100390 <panic>
801027ae:	66 90                	xchg   %ax,%ax

801027b0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801027b0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801027b1:	c7 05 54 46 11 80 00 	movl   $0xfec00000,0x80114654
801027b8:	00 c0 fe 
{
801027bb:	89 e5                	mov    %esp,%ebp
801027bd:	56                   	push   %esi
801027be:	53                   	push   %ebx
  ioapic->reg = reg;
801027bf:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801027c6:	00 00 00 
  return ioapic->data;
801027c9:	a1 54 46 11 80       	mov    0x80114654,%eax
801027ce:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
801027d1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
801027d7:	8b 0d 54 46 11 80    	mov    0x80114654,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801027dd:	0f b6 15 80 47 11 80 	movzbl 0x80114780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801027e4:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
801027e7:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801027ea:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
801027ed:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801027f0:	39 c2                	cmp    %eax,%edx
801027f2:	74 16                	je     8010280a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801027f4:	83 ec 0c             	sub    $0xc,%esp
801027f7:	68 f4 8d 10 80       	push   $0x80108df4
801027fc:	e8 5f de ff ff       	call   80100660 <cprintf>
80102801:	8b 0d 54 46 11 80    	mov    0x80114654,%ecx
80102807:	83 c4 10             	add    $0x10,%esp
8010280a:	83 c3 21             	add    $0x21,%ebx
{
8010280d:	ba 10 00 00 00       	mov    $0x10,%edx
80102812:	b8 20 00 00 00       	mov    $0x20,%eax
80102817:	89 f6                	mov    %esi,%esi
80102819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
80102820:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102822:	8b 0d 54 46 11 80    	mov    0x80114654,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102828:	89 c6                	mov    %eax,%esi
8010282a:	81 ce 00 00 01 00    	or     $0x10000,%esi
80102830:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102833:	89 71 10             	mov    %esi,0x10(%ecx)
80102836:	8d 72 01             	lea    0x1(%edx),%esi
80102839:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
8010283c:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
8010283e:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
80102840:	8b 0d 54 46 11 80    	mov    0x80114654,%ecx
80102846:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010284d:	75 d1                	jne    80102820 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010284f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102852:	5b                   	pop    %ebx
80102853:	5e                   	pop    %esi
80102854:	5d                   	pop    %ebp
80102855:	c3                   	ret    
80102856:	8d 76 00             	lea    0x0(%esi),%esi
80102859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102860 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102860:	55                   	push   %ebp
  ioapic->reg = reg;
80102861:	8b 0d 54 46 11 80    	mov    0x80114654,%ecx
{
80102867:	89 e5                	mov    %esp,%ebp
80102869:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010286c:	8d 50 20             	lea    0x20(%eax),%edx
8010286f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102873:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102875:	8b 0d 54 46 11 80    	mov    0x80114654,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010287b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010287e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102881:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102884:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102886:	a1 54 46 11 80       	mov    0x80114654,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010288b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010288e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102891:	5d                   	pop    %ebp
80102892:	c3                   	ret    
80102893:	66 90                	xchg   %ax,%ax
80102895:	66 90                	xchg   %ax,%ax
80102897:	66 90                	xchg   %ax,%ax
80102899:	66 90                	xchg   %ax,%ax
8010289b:	66 90                	xchg   %ax,%ax
8010289d:	66 90                	xchg   %ax,%ax
8010289f:	90                   	nop

801028a0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801028a0:	55                   	push   %ebp
801028a1:	89 e5                	mov    %esp,%ebp
801028a3:	53                   	push   %ebx
801028a4:	83 ec 04             	sub    $0x4,%esp
801028a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801028aa:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801028b0:	75 70                	jne    80102922 <kfree+0x82>
801028b2:	81 fb 08 c3 11 80    	cmp    $0x8011c308,%ebx
801028b8:	72 68                	jb     80102922 <kfree+0x82>
801028ba:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801028c0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801028c5:	77 5b                	ja     80102922 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801028c7:	83 ec 04             	sub    $0x4,%esp
801028ca:	68 00 10 00 00       	push   $0x1000
801028cf:	6a 01                	push   $0x1
801028d1:	53                   	push   %ebx
801028d2:	e8 29 35 00 00       	call   80105e00 <memset>

  if(kmem.use_lock)
801028d7:	8b 15 94 46 11 80    	mov    0x80114694,%edx
801028dd:	83 c4 10             	add    $0x10,%esp
801028e0:	85 d2                	test   %edx,%edx
801028e2:	75 2c                	jne    80102910 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801028e4:	a1 98 46 11 80       	mov    0x80114698,%eax
801028e9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801028eb:	a1 94 46 11 80       	mov    0x80114694,%eax
  kmem.freelist = r;
801028f0:	89 1d 98 46 11 80    	mov    %ebx,0x80114698
  if(kmem.use_lock)
801028f6:	85 c0                	test   %eax,%eax
801028f8:	75 06                	jne    80102900 <kfree+0x60>
    release(&kmem.lock);
}
801028fa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801028fd:	c9                   	leave  
801028fe:	c3                   	ret    
801028ff:	90                   	nop
    release(&kmem.lock);
80102900:	c7 45 08 60 46 11 80 	movl   $0x80114660,0x8(%ebp)
}
80102907:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010290a:	c9                   	leave  
    release(&kmem.lock);
8010290b:	e9 a0 34 00 00       	jmp    80105db0 <release>
    acquire(&kmem.lock);
80102910:	83 ec 0c             	sub    $0xc,%esp
80102913:	68 60 46 11 80       	push   $0x80114660
80102918:	e8 d3 33 00 00       	call   80105cf0 <acquire>
8010291d:	83 c4 10             	add    $0x10,%esp
80102920:	eb c2                	jmp    801028e4 <kfree+0x44>
    panic("kfree");
80102922:	83 ec 0c             	sub    $0xc,%esp
80102925:	68 26 8e 10 80       	push   $0x80108e26
8010292a:	e8 61 da ff ff       	call   80100390 <panic>
8010292f:	90                   	nop

80102930 <freerange>:
{
80102930:	55                   	push   %ebp
80102931:	89 e5                	mov    %esp,%ebp
80102933:	56                   	push   %esi
80102934:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102935:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102938:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010293b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102941:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102947:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010294d:	39 de                	cmp    %ebx,%esi
8010294f:	72 23                	jb     80102974 <freerange+0x44>
80102951:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102958:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010295e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102961:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102967:	50                   	push   %eax
80102968:	e8 33 ff ff ff       	call   801028a0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010296d:	83 c4 10             	add    $0x10,%esp
80102970:	39 f3                	cmp    %esi,%ebx
80102972:	76 e4                	jbe    80102958 <freerange+0x28>
}
80102974:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102977:	5b                   	pop    %ebx
80102978:	5e                   	pop    %esi
80102979:	5d                   	pop    %ebp
8010297a:	c3                   	ret    
8010297b:	90                   	nop
8010297c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102980 <kinit1>:
{
80102980:	55                   	push   %ebp
80102981:	89 e5                	mov    %esp,%ebp
80102983:	56                   	push   %esi
80102984:	53                   	push   %ebx
80102985:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102988:	83 ec 08             	sub    $0x8,%esp
8010298b:	68 2c 8e 10 80       	push   $0x80108e2c
80102990:	68 60 46 11 80       	push   $0x80114660
80102995:	e8 16 32 00 00       	call   80105bb0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010299a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010299d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
801029a0:	c7 05 94 46 11 80 00 	movl   $0x0,0x80114694
801029a7:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
801029aa:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801029b0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801029b6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801029bc:	39 de                	cmp    %ebx,%esi
801029be:	72 1c                	jb     801029dc <kinit1+0x5c>
    kfree(p);
801029c0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801029c6:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801029c9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801029cf:	50                   	push   %eax
801029d0:	e8 cb fe ff ff       	call   801028a0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801029d5:	83 c4 10             	add    $0x10,%esp
801029d8:	39 de                	cmp    %ebx,%esi
801029da:	73 e4                	jae    801029c0 <kinit1+0x40>
}
801029dc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801029df:	5b                   	pop    %ebx
801029e0:	5e                   	pop    %esi
801029e1:	5d                   	pop    %ebp
801029e2:	c3                   	ret    
801029e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801029e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801029f0 <kinit2>:
{
801029f0:	55                   	push   %ebp
801029f1:	89 e5                	mov    %esp,%ebp
801029f3:	56                   	push   %esi
801029f4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801029f5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801029f8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801029fb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102a01:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a07:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102a0d:	39 de                	cmp    %ebx,%esi
80102a0f:	72 23                	jb     80102a34 <kinit2+0x44>
80102a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102a18:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102a1e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a21:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102a27:	50                   	push   %eax
80102a28:	e8 73 fe ff ff       	call   801028a0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a2d:	83 c4 10             	add    $0x10,%esp
80102a30:	39 de                	cmp    %ebx,%esi
80102a32:	73 e4                	jae    80102a18 <kinit2+0x28>
  kmem.use_lock = 1;
80102a34:	c7 05 94 46 11 80 01 	movl   $0x1,0x80114694
80102a3b:	00 00 00 
}
80102a3e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102a41:	5b                   	pop    %ebx
80102a42:	5e                   	pop    %esi
80102a43:	5d                   	pop    %ebp
80102a44:	c3                   	ret    
80102a45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102a50 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102a50:	a1 94 46 11 80       	mov    0x80114694,%eax
80102a55:	85 c0                	test   %eax,%eax
80102a57:	75 1f                	jne    80102a78 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102a59:	a1 98 46 11 80       	mov    0x80114698,%eax
  if(r)
80102a5e:	85 c0                	test   %eax,%eax
80102a60:	74 0e                	je     80102a70 <kalloc+0x20>
    kmem.freelist = r->next;
80102a62:	8b 10                	mov    (%eax),%edx
80102a64:	89 15 98 46 11 80    	mov    %edx,0x80114698
80102a6a:	c3                   	ret    
80102a6b:	90                   	nop
80102a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102a70:	f3 c3                	repz ret 
80102a72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
80102a78:	55                   	push   %ebp
80102a79:	89 e5                	mov    %esp,%ebp
80102a7b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
80102a7e:	68 60 46 11 80       	push   $0x80114660
80102a83:	e8 68 32 00 00       	call   80105cf0 <acquire>
  r = kmem.freelist;
80102a88:	a1 98 46 11 80       	mov    0x80114698,%eax
  if(r)
80102a8d:	83 c4 10             	add    $0x10,%esp
80102a90:	8b 15 94 46 11 80    	mov    0x80114694,%edx
80102a96:	85 c0                	test   %eax,%eax
80102a98:	74 08                	je     80102aa2 <kalloc+0x52>
    kmem.freelist = r->next;
80102a9a:	8b 08                	mov    (%eax),%ecx
80102a9c:	89 0d 98 46 11 80    	mov    %ecx,0x80114698
  if(kmem.use_lock)
80102aa2:	85 d2                	test   %edx,%edx
80102aa4:	74 16                	je     80102abc <kalloc+0x6c>
    release(&kmem.lock);
80102aa6:	83 ec 0c             	sub    $0xc,%esp
80102aa9:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102aac:	68 60 46 11 80       	push   $0x80114660
80102ab1:	e8 fa 32 00 00       	call   80105db0 <release>
  return (char*)r;
80102ab6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102ab9:	83 c4 10             	add    $0x10,%esp
}
80102abc:	c9                   	leave  
80102abd:	c3                   	ret    
80102abe:	66 90                	xchg   %ax,%ax

80102ac0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ac0:	ba 64 00 00 00       	mov    $0x64,%edx
80102ac5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102ac6:	a8 01                	test   $0x1,%al
80102ac8:	0f 84 c2 00 00 00    	je     80102b90 <kbdgetc+0xd0>
80102ace:	ba 60 00 00 00       	mov    $0x60,%edx
80102ad3:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102ad4:	0f b6 d0             	movzbl %al,%edx
80102ad7:	8b 0d b4 c5 10 80    	mov    0x8010c5b4,%ecx

  if(data == 0xE0){
80102add:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102ae3:	0f 84 7f 00 00 00    	je     80102b68 <kbdgetc+0xa8>
{
80102ae9:	55                   	push   %ebp
80102aea:	89 e5                	mov    %esp,%ebp
80102aec:	53                   	push   %ebx
80102aed:	89 cb                	mov    %ecx,%ebx
80102aef:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102af2:	84 c0                	test   %al,%al
80102af4:	78 4a                	js     80102b40 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102af6:	85 db                	test   %ebx,%ebx
80102af8:	74 09                	je     80102b03 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102afa:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102afd:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102b00:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102b03:	0f b6 82 60 8f 10 80 	movzbl -0x7fef70a0(%edx),%eax
80102b0a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
80102b0c:	0f b6 82 60 8e 10 80 	movzbl -0x7fef71a0(%edx),%eax
80102b13:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102b15:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102b17:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102b1d:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102b20:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102b23:	8b 04 85 40 8e 10 80 	mov    -0x7fef71c0(,%eax,4),%eax
80102b2a:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102b2e:	74 31                	je     80102b61 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
80102b30:	8d 50 9f             	lea    -0x61(%eax),%edx
80102b33:	83 fa 19             	cmp    $0x19,%edx
80102b36:	77 40                	ja     80102b78 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102b38:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102b3b:	5b                   	pop    %ebx
80102b3c:	5d                   	pop    %ebp
80102b3d:	c3                   	ret    
80102b3e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102b40:	83 e0 7f             	and    $0x7f,%eax
80102b43:	85 db                	test   %ebx,%ebx
80102b45:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102b48:	0f b6 82 60 8f 10 80 	movzbl -0x7fef70a0(%edx),%eax
80102b4f:	83 c8 40             	or     $0x40,%eax
80102b52:	0f b6 c0             	movzbl %al,%eax
80102b55:	f7 d0                	not    %eax
80102b57:	21 c1                	and    %eax,%ecx
    return 0;
80102b59:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
80102b5b:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
}
80102b61:	5b                   	pop    %ebx
80102b62:	5d                   	pop    %ebp
80102b63:	c3                   	ret    
80102b64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
80102b68:	83 c9 40             	or     $0x40,%ecx
    return 0;
80102b6b:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102b6d:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
    return 0;
80102b73:	c3                   	ret    
80102b74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102b78:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102b7b:	8d 50 20             	lea    0x20(%eax),%edx
}
80102b7e:	5b                   	pop    %ebx
      c += 'a' - 'A';
80102b7f:	83 f9 1a             	cmp    $0x1a,%ecx
80102b82:	0f 42 c2             	cmovb  %edx,%eax
}
80102b85:	5d                   	pop    %ebp
80102b86:	c3                   	ret    
80102b87:	89 f6                	mov    %esi,%esi
80102b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102b90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102b95:	c3                   	ret    
80102b96:	8d 76 00             	lea    0x0(%esi),%esi
80102b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ba0 <kbdintr>:

void
kbdintr(void)
{
80102ba0:	55                   	push   %ebp
80102ba1:	89 e5                	mov    %esp,%ebp
80102ba3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102ba6:	68 c0 2a 10 80       	push   $0x80102ac0
80102bab:	e8 60 dc ff ff       	call   80100810 <consoleintr>
}
80102bb0:	83 c4 10             	add    $0x10,%esp
80102bb3:	c9                   	leave  
80102bb4:	c3                   	ret    
80102bb5:	66 90                	xchg   %ax,%ax
80102bb7:	66 90                	xchg   %ax,%ax
80102bb9:	66 90                	xchg   %ax,%ax
80102bbb:	66 90                	xchg   %ax,%ax
80102bbd:	66 90                	xchg   %ax,%ax
80102bbf:	90                   	nop

80102bc0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102bc0:	a1 9c 46 11 80       	mov    0x8011469c,%eax
{
80102bc5:	55                   	push   %ebp
80102bc6:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102bc8:	85 c0                	test   %eax,%eax
80102bca:	0f 84 c8 00 00 00    	je     80102c98 <lapicinit+0xd8>
  lapic[index] = value;
80102bd0:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102bd7:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102bda:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102bdd:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102be4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102be7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102bea:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102bf1:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102bf4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102bf7:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102bfe:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102c01:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c04:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102c0b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102c0e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c11:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102c18:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102c1b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102c1e:	8b 50 30             	mov    0x30(%eax),%edx
80102c21:	c1 ea 10             	shr    $0x10,%edx
80102c24:	80 fa 03             	cmp    $0x3,%dl
80102c27:	77 77                	ja     80102ca0 <lapicinit+0xe0>
  lapic[index] = value;
80102c29:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102c30:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102c33:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c36:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102c3d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102c40:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c43:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102c4a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102c4d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c50:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102c57:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102c5a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c5d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102c64:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102c67:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c6a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102c71:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102c74:	8b 50 20             	mov    0x20(%eax),%edx
80102c77:	89 f6                	mov    %esi,%esi
80102c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102c80:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102c86:	80 e6 10             	and    $0x10,%dh
80102c89:	75 f5                	jne    80102c80 <lapicinit+0xc0>
  lapic[index] = value;
80102c8b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102c92:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102c95:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102c98:	5d                   	pop    %ebp
80102c99:	c3                   	ret    
80102c9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102ca0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102ca7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102caa:	8b 50 20             	mov    0x20(%eax),%edx
80102cad:	e9 77 ff ff ff       	jmp    80102c29 <lapicinit+0x69>
80102cb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102cc0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102cc0:	8b 15 9c 46 11 80    	mov    0x8011469c,%edx
{
80102cc6:	55                   	push   %ebp
80102cc7:	31 c0                	xor    %eax,%eax
80102cc9:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102ccb:	85 d2                	test   %edx,%edx
80102ccd:	74 06                	je     80102cd5 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
80102ccf:	8b 42 20             	mov    0x20(%edx),%eax
80102cd2:	c1 e8 18             	shr    $0x18,%eax
}
80102cd5:	5d                   	pop    %ebp
80102cd6:	c3                   	ret    
80102cd7:	89 f6                	mov    %esi,%esi
80102cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ce0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102ce0:	a1 9c 46 11 80       	mov    0x8011469c,%eax
{
80102ce5:	55                   	push   %ebp
80102ce6:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102ce8:	85 c0                	test   %eax,%eax
80102cea:	74 0d                	je     80102cf9 <lapiceoi+0x19>
  lapic[index] = value;
80102cec:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102cf3:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102cf6:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102cf9:	5d                   	pop    %ebp
80102cfa:	c3                   	ret    
80102cfb:	90                   	nop
80102cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102d00 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102d00:	55                   	push   %ebp
80102d01:	89 e5                	mov    %esp,%ebp
}
80102d03:	5d                   	pop    %ebp
80102d04:	c3                   	ret    
80102d05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102d10 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102d10:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d11:	b8 0f 00 00 00       	mov    $0xf,%eax
80102d16:	ba 70 00 00 00       	mov    $0x70,%edx
80102d1b:	89 e5                	mov    %esp,%ebp
80102d1d:	53                   	push   %ebx
80102d1e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102d21:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102d24:	ee                   	out    %al,(%dx)
80102d25:	b8 0a 00 00 00       	mov    $0xa,%eax
80102d2a:	ba 71 00 00 00       	mov    $0x71,%edx
80102d2f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102d30:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102d32:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102d35:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102d3b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102d3d:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
80102d40:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
80102d43:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102d45:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102d48:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102d4e:	a1 9c 46 11 80       	mov    0x8011469c,%eax
80102d53:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102d59:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102d5c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102d63:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d66:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102d69:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102d70:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d73:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102d76:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102d7c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102d7f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102d85:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102d88:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102d8e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d91:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102d97:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102d9a:	5b                   	pop    %ebx
80102d9b:	5d                   	pop    %ebp
80102d9c:	c3                   	ret    
80102d9d:	8d 76 00             	lea    0x0(%esi),%esi

80102da0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102da0:	55                   	push   %ebp
80102da1:	b8 0b 00 00 00       	mov    $0xb,%eax
80102da6:	ba 70 00 00 00       	mov    $0x70,%edx
80102dab:	89 e5                	mov    %esp,%ebp
80102dad:	57                   	push   %edi
80102dae:	56                   	push   %esi
80102daf:	53                   	push   %ebx
80102db0:	83 ec 4c             	sub    $0x4c,%esp
80102db3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102db4:	ba 71 00 00 00       	mov    $0x71,%edx
80102db9:	ec                   	in     (%dx),%al
80102dba:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102dbd:	bb 70 00 00 00       	mov    $0x70,%ebx
80102dc2:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102dc5:	8d 76 00             	lea    0x0(%esi),%esi
80102dc8:	31 c0                	xor    %eax,%eax
80102dca:	89 da                	mov    %ebx,%edx
80102dcc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102dcd:	b9 71 00 00 00       	mov    $0x71,%ecx
80102dd2:	89 ca                	mov    %ecx,%edx
80102dd4:	ec                   	in     (%dx),%al
80102dd5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102dd8:	89 da                	mov    %ebx,%edx
80102dda:	b8 02 00 00 00       	mov    $0x2,%eax
80102ddf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102de0:	89 ca                	mov    %ecx,%edx
80102de2:	ec                   	in     (%dx),%al
80102de3:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102de6:	89 da                	mov    %ebx,%edx
80102de8:	b8 04 00 00 00       	mov    $0x4,%eax
80102ded:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102dee:	89 ca                	mov    %ecx,%edx
80102df0:	ec                   	in     (%dx),%al
80102df1:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102df4:	89 da                	mov    %ebx,%edx
80102df6:	b8 07 00 00 00       	mov    $0x7,%eax
80102dfb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102dfc:	89 ca                	mov    %ecx,%edx
80102dfe:	ec                   	in     (%dx),%al
80102dff:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e02:	89 da                	mov    %ebx,%edx
80102e04:	b8 08 00 00 00       	mov    $0x8,%eax
80102e09:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e0a:	89 ca                	mov    %ecx,%edx
80102e0c:	ec                   	in     (%dx),%al
80102e0d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e0f:	89 da                	mov    %ebx,%edx
80102e11:	b8 09 00 00 00       	mov    $0x9,%eax
80102e16:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e17:	89 ca                	mov    %ecx,%edx
80102e19:	ec                   	in     (%dx),%al
80102e1a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e1c:	89 da                	mov    %ebx,%edx
80102e1e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102e23:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e24:	89 ca                	mov    %ecx,%edx
80102e26:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102e27:	84 c0                	test   %al,%al
80102e29:	78 9d                	js     80102dc8 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102e2b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102e2f:	89 fa                	mov    %edi,%edx
80102e31:	0f b6 fa             	movzbl %dl,%edi
80102e34:	89 f2                	mov    %esi,%edx
80102e36:	0f b6 f2             	movzbl %dl,%esi
80102e39:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e3c:	89 da                	mov    %ebx,%edx
80102e3e:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102e41:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102e44:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102e48:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102e4b:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102e4f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102e52:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102e56:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102e59:	31 c0                	xor    %eax,%eax
80102e5b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e5c:	89 ca                	mov    %ecx,%edx
80102e5e:	ec                   	in     (%dx),%al
80102e5f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e62:	89 da                	mov    %ebx,%edx
80102e64:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102e67:	b8 02 00 00 00       	mov    $0x2,%eax
80102e6c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e6d:	89 ca                	mov    %ecx,%edx
80102e6f:	ec                   	in     (%dx),%al
80102e70:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e73:	89 da                	mov    %ebx,%edx
80102e75:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102e78:	b8 04 00 00 00       	mov    $0x4,%eax
80102e7d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e7e:	89 ca                	mov    %ecx,%edx
80102e80:	ec                   	in     (%dx),%al
80102e81:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e84:	89 da                	mov    %ebx,%edx
80102e86:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102e89:	b8 07 00 00 00       	mov    $0x7,%eax
80102e8e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e8f:	89 ca                	mov    %ecx,%edx
80102e91:	ec                   	in     (%dx),%al
80102e92:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e95:	89 da                	mov    %ebx,%edx
80102e97:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102e9a:	b8 08 00 00 00       	mov    $0x8,%eax
80102e9f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ea0:	89 ca                	mov    %ecx,%edx
80102ea2:	ec                   	in     (%dx),%al
80102ea3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ea6:	89 da                	mov    %ebx,%edx
80102ea8:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102eab:	b8 09 00 00 00       	mov    $0x9,%eax
80102eb0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102eb1:	89 ca                	mov    %ecx,%edx
80102eb3:	ec                   	in     (%dx),%al
80102eb4:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102eb7:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102eba:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102ebd:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102ec0:	6a 18                	push   $0x18
80102ec2:	50                   	push   %eax
80102ec3:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102ec6:	50                   	push   %eax
80102ec7:	e8 84 2f 00 00       	call   80105e50 <memcmp>
80102ecc:	83 c4 10             	add    $0x10,%esp
80102ecf:	85 c0                	test   %eax,%eax
80102ed1:	0f 85 f1 fe ff ff    	jne    80102dc8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102ed7:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102edb:	75 78                	jne    80102f55 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102edd:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102ee0:	89 c2                	mov    %eax,%edx
80102ee2:	83 e0 0f             	and    $0xf,%eax
80102ee5:	c1 ea 04             	shr    $0x4,%edx
80102ee8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102eeb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102eee:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102ef1:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102ef4:	89 c2                	mov    %eax,%edx
80102ef6:	83 e0 0f             	and    $0xf,%eax
80102ef9:	c1 ea 04             	shr    $0x4,%edx
80102efc:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102eff:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102f02:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102f05:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102f08:	89 c2                	mov    %eax,%edx
80102f0a:	83 e0 0f             	and    $0xf,%eax
80102f0d:	c1 ea 04             	shr    $0x4,%edx
80102f10:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102f13:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102f16:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102f19:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102f1c:	89 c2                	mov    %eax,%edx
80102f1e:	83 e0 0f             	and    $0xf,%eax
80102f21:	c1 ea 04             	shr    $0x4,%edx
80102f24:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102f27:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102f2a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102f2d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102f30:	89 c2                	mov    %eax,%edx
80102f32:	83 e0 0f             	and    $0xf,%eax
80102f35:	c1 ea 04             	shr    $0x4,%edx
80102f38:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102f3b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102f3e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102f41:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102f44:	89 c2                	mov    %eax,%edx
80102f46:	83 e0 0f             	and    $0xf,%eax
80102f49:	c1 ea 04             	shr    $0x4,%edx
80102f4c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102f4f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102f52:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102f55:	8b 75 08             	mov    0x8(%ebp),%esi
80102f58:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102f5b:	89 06                	mov    %eax,(%esi)
80102f5d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102f60:	89 46 04             	mov    %eax,0x4(%esi)
80102f63:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102f66:	89 46 08             	mov    %eax,0x8(%esi)
80102f69:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102f6c:	89 46 0c             	mov    %eax,0xc(%esi)
80102f6f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102f72:	89 46 10             	mov    %eax,0x10(%esi)
80102f75:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102f78:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102f7b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102f82:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f85:	5b                   	pop    %ebx
80102f86:	5e                   	pop    %esi
80102f87:	5f                   	pop    %edi
80102f88:	5d                   	pop    %ebp
80102f89:	c3                   	ret    
80102f8a:	66 90                	xchg   %ax,%ax
80102f8c:	66 90                	xchg   %ax,%ax
80102f8e:	66 90                	xchg   %ax,%ax

80102f90 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102f90:	8b 0d e8 46 11 80    	mov    0x801146e8,%ecx
80102f96:	85 c9                	test   %ecx,%ecx
80102f98:	0f 8e 8a 00 00 00    	jle    80103028 <install_trans+0x98>
{
80102f9e:	55                   	push   %ebp
80102f9f:	89 e5                	mov    %esp,%ebp
80102fa1:	57                   	push   %edi
80102fa2:	56                   	push   %esi
80102fa3:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102fa4:	31 db                	xor    %ebx,%ebx
{
80102fa6:	83 ec 0c             	sub    $0xc,%esp
80102fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102fb0:	a1 d4 46 11 80       	mov    0x801146d4,%eax
80102fb5:	83 ec 08             	sub    $0x8,%esp
80102fb8:	01 d8                	add    %ebx,%eax
80102fba:	83 c0 01             	add    $0x1,%eax
80102fbd:	50                   	push   %eax
80102fbe:	ff 35 e4 46 11 80    	pushl  0x801146e4
80102fc4:	e8 07 d1 ff ff       	call   801000d0 <bread>
80102fc9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102fcb:	58                   	pop    %eax
80102fcc:	5a                   	pop    %edx
80102fcd:	ff 34 9d ec 46 11 80 	pushl  -0x7feeb914(,%ebx,4)
80102fd4:	ff 35 e4 46 11 80    	pushl  0x801146e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102fda:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102fdd:	e8 ee d0 ff ff       	call   801000d0 <bread>
80102fe2:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102fe4:	8d 47 5c             	lea    0x5c(%edi),%eax
80102fe7:	83 c4 0c             	add    $0xc,%esp
80102fea:	68 00 02 00 00       	push   $0x200
80102fef:	50                   	push   %eax
80102ff0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102ff3:	50                   	push   %eax
80102ff4:	e8 b7 2e 00 00       	call   80105eb0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102ff9:	89 34 24             	mov    %esi,(%esp)
80102ffc:	e8 9f d1 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80103001:	89 3c 24             	mov    %edi,(%esp)
80103004:	e8 d7 d1 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80103009:	89 34 24             	mov    %esi,(%esp)
8010300c:	e8 cf d1 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103011:	83 c4 10             	add    $0x10,%esp
80103014:	39 1d e8 46 11 80    	cmp    %ebx,0x801146e8
8010301a:	7f 94                	jg     80102fb0 <install_trans+0x20>
  }
}
8010301c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010301f:	5b                   	pop    %ebx
80103020:	5e                   	pop    %esi
80103021:	5f                   	pop    %edi
80103022:	5d                   	pop    %ebp
80103023:	c3                   	ret    
80103024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103028:	f3 c3                	repz ret 
8010302a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103030 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103030:	55                   	push   %ebp
80103031:	89 e5                	mov    %esp,%ebp
80103033:	56                   	push   %esi
80103034:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80103035:	83 ec 08             	sub    $0x8,%esp
80103038:	ff 35 d4 46 11 80    	pushl  0x801146d4
8010303e:	ff 35 e4 46 11 80    	pushl  0x801146e4
80103044:	e8 87 d0 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80103049:	8b 1d e8 46 11 80    	mov    0x801146e8,%ebx
  for (i = 0; i < log.lh.n; i++) {
8010304f:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80103052:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80103054:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80103056:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80103059:	7e 16                	jle    80103071 <write_head+0x41>
8010305b:	c1 e3 02             	shl    $0x2,%ebx
8010305e:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80103060:	8b 8a ec 46 11 80    	mov    -0x7feeb914(%edx),%ecx
80103066:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
8010306a:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
8010306d:	39 da                	cmp    %ebx,%edx
8010306f:	75 ef                	jne    80103060 <write_head+0x30>
  }
  bwrite(buf);
80103071:	83 ec 0c             	sub    $0xc,%esp
80103074:	56                   	push   %esi
80103075:	e8 26 d1 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
8010307a:	89 34 24             	mov    %esi,(%esp)
8010307d:	e8 5e d1 ff ff       	call   801001e0 <brelse>
}
80103082:	83 c4 10             	add    $0x10,%esp
80103085:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103088:	5b                   	pop    %ebx
80103089:	5e                   	pop    %esi
8010308a:	5d                   	pop    %ebp
8010308b:	c3                   	ret    
8010308c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103090 <initlog>:
{
80103090:	55                   	push   %ebp
80103091:	89 e5                	mov    %esp,%ebp
80103093:	53                   	push   %ebx
80103094:	83 ec 2c             	sub    $0x2c,%esp
80103097:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
8010309a:	68 60 90 10 80       	push   $0x80109060
8010309f:	68 a0 46 11 80       	push   $0x801146a0
801030a4:	e8 07 2b 00 00       	call   80105bb0 <initlock>
  readsb(dev, &sb);
801030a9:	58                   	pop    %eax
801030aa:	8d 45 dc             	lea    -0x24(%ebp),%eax
801030ad:	5a                   	pop    %edx
801030ae:	50                   	push   %eax
801030af:	53                   	push   %ebx
801030b0:	e8 db e6 ff ff       	call   80101790 <readsb>
  log.size = sb.nlog;
801030b5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
801030b8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
801030bb:	59                   	pop    %ecx
  log.dev = dev;
801030bc:	89 1d e4 46 11 80    	mov    %ebx,0x801146e4
  log.size = sb.nlog;
801030c2:	89 15 d8 46 11 80    	mov    %edx,0x801146d8
  log.start = sb.logstart;
801030c8:	a3 d4 46 11 80       	mov    %eax,0x801146d4
  struct buf *buf = bread(log.dev, log.start);
801030cd:	5a                   	pop    %edx
801030ce:	50                   	push   %eax
801030cf:	53                   	push   %ebx
801030d0:	e8 fb cf ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
801030d5:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
801030d8:	83 c4 10             	add    $0x10,%esp
801030db:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
801030dd:	89 1d e8 46 11 80    	mov    %ebx,0x801146e8
  for (i = 0; i < log.lh.n; i++) {
801030e3:	7e 1c                	jle    80103101 <initlog+0x71>
801030e5:	c1 e3 02             	shl    $0x2,%ebx
801030e8:	31 d2                	xor    %edx,%edx
801030ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
801030f0:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
801030f4:	83 c2 04             	add    $0x4,%edx
801030f7:	89 8a e8 46 11 80    	mov    %ecx,-0x7feeb918(%edx)
  for (i = 0; i < log.lh.n; i++) {
801030fd:	39 d3                	cmp    %edx,%ebx
801030ff:	75 ef                	jne    801030f0 <initlog+0x60>
  brelse(buf);
80103101:	83 ec 0c             	sub    $0xc,%esp
80103104:	50                   	push   %eax
80103105:	e8 d6 d0 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
8010310a:	e8 81 fe ff ff       	call   80102f90 <install_trans>
  log.lh.n = 0;
8010310f:	c7 05 e8 46 11 80 00 	movl   $0x0,0x801146e8
80103116:	00 00 00 
  write_head(); // clear the log
80103119:	e8 12 ff ff ff       	call   80103030 <write_head>
}
8010311e:	83 c4 10             	add    $0x10,%esp
80103121:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103124:	c9                   	leave  
80103125:	c3                   	ret    
80103126:	8d 76 00             	lea    0x0(%esi),%esi
80103129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103130 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103130:	55                   	push   %ebp
80103131:	89 e5                	mov    %esp,%ebp
80103133:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80103136:	68 a0 46 11 80       	push   $0x801146a0
8010313b:	e8 b0 2b 00 00       	call   80105cf0 <acquire>
80103140:	83 c4 10             	add    $0x10,%esp
80103143:	eb 18                	jmp    8010315d <begin_op+0x2d>
80103145:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103148:	83 ec 08             	sub    $0x8,%esp
8010314b:	68 a0 46 11 80       	push   $0x801146a0
80103150:	68 a0 46 11 80       	push   $0x801146a0
80103155:	e8 06 1d 00 00       	call   80104e60 <sleep>
8010315a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
8010315d:	a1 e0 46 11 80       	mov    0x801146e0,%eax
80103162:	85 c0                	test   %eax,%eax
80103164:	75 e2                	jne    80103148 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103166:	a1 dc 46 11 80       	mov    0x801146dc,%eax
8010316b:	8b 15 e8 46 11 80    	mov    0x801146e8,%edx
80103171:	83 c0 01             	add    $0x1,%eax
80103174:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80103177:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
8010317a:	83 fa 1e             	cmp    $0x1e,%edx
8010317d:	7f c9                	jg     80103148 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
8010317f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80103182:	a3 dc 46 11 80       	mov    %eax,0x801146dc
      release(&log.lock);
80103187:	68 a0 46 11 80       	push   $0x801146a0
8010318c:	e8 1f 2c 00 00       	call   80105db0 <release>
      break;
    }
  }
}
80103191:	83 c4 10             	add    $0x10,%esp
80103194:	c9                   	leave  
80103195:	c3                   	ret    
80103196:	8d 76 00             	lea    0x0(%esi),%esi
80103199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801031a0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
801031a0:	55                   	push   %ebp
801031a1:	89 e5                	mov    %esp,%ebp
801031a3:	57                   	push   %edi
801031a4:	56                   	push   %esi
801031a5:	53                   	push   %ebx
801031a6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
801031a9:	68 a0 46 11 80       	push   $0x801146a0
801031ae:	e8 3d 2b 00 00       	call   80105cf0 <acquire>
  log.outstanding -= 1;
801031b3:	a1 dc 46 11 80       	mov    0x801146dc,%eax
  if(log.committing)
801031b8:	8b 35 e0 46 11 80    	mov    0x801146e0,%esi
801031be:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
801031c1:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
801031c4:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
801031c6:	89 1d dc 46 11 80    	mov    %ebx,0x801146dc
  if(log.committing)
801031cc:	0f 85 1a 01 00 00    	jne    801032ec <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
801031d2:	85 db                	test   %ebx,%ebx
801031d4:	0f 85 ee 00 00 00    	jne    801032c8 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
801031da:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
801031dd:	c7 05 e0 46 11 80 01 	movl   $0x1,0x801146e0
801031e4:	00 00 00 
  release(&log.lock);
801031e7:	68 a0 46 11 80       	push   $0x801146a0
801031ec:	e8 bf 2b 00 00       	call   80105db0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
801031f1:	8b 0d e8 46 11 80    	mov    0x801146e8,%ecx
801031f7:	83 c4 10             	add    $0x10,%esp
801031fa:	85 c9                	test   %ecx,%ecx
801031fc:	0f 8e 85 00 00 00    	jle    80103287 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103202:	a1 d4 46 11 80       	mov    0x801146d4,%eax
80103207:	83 ec 08             	sub    $0x8,%esp
8010320a:	01 d8                	add    %ebx,%eax
8010320c:	83 c0 01             	add    $0x1,%eax
8010320f:	50                   	push   %eax
80103210:	ff 35 e4 46 11 80    	pushl  0x801146e4
80103216:	e8 b5 ce ff ff       	call   801000d0 <bread>
8010321b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010321d:	58                   	pop    %eax
8010321e:	5a                   	pop    %edx
8010321f:	ff 34 9d ec 46 11 80 	pushl  -0x7feeb914(,%ebx,4)
80103226:	ff 35 e4 46 11 80    	pushl  0x801146e4
  for (tail = 0; tail < log.lh.n; tail++) {
8010322c:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010322f:	e8 9c ce ff ff       	call   801000d0 <bread>
80103234:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103236:	8d 40 5c             	lea    0x5c(%eax),%eax
80103239:	83 c4 0c             	add    $0xc,%esp
8010323c:	68 00 02 00 00       	push   $0x200
80103241:	50                   	push   %eax
80103242:	8d 46 5c             	lea    0x5c(%esi),%eax
80103245:	50                   	push   %eax
80103246:	e8 65 2c 00 00       	call   80105eb0 <memmove>
    bwrite(to);  // write the log
8010324b:	89 34 24             	mov    %esi,(%esp)
8010324e:	e8 4d cf ff ff       	call   801001a0 <bwrite>
    brelse(from);
80103253:	89 3c 24             	mov    %edi,(%esp)
80103256:	e8 85 cf ff ff       	call   801001e0 <brelse>
    brelse(to);
8010325b:	89 34 24             	mov    %esi,(%esp)
8010325e:	e8 7d cf ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103263:	83 c4 10             	add    $0x10,%esp
80103266:	3b 1d e8 46 11 80    	cmp    0x801146e8,%ebx
8010326c:	7c 94                	jl     80103202 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
8010326e:	e8 bd fd ff ff       	call   80103030 <write_head>
    install_trans(); // Now install writes to home locations
80103273:	e8 18 fd ff ff       	call   80102f90 <install_trans>
    log.lh.n = 0;
80103278:	c7 05 e8 46 11 80 00 	movl   $0x0,0x801146e8
8010327f:	00 00 00 
    write_head();    // Erase the transaction from the log
80103282:	e8 a9 fd ff ff       	call   80103030 <write_head>
    acquire(&log.lock);
80103287:	83 ec 0c             	sub    $0xc,%esp
8010328a:	68 a0 46 11 80       	push   $0x801146a0
8010328f:	e8 5c 2a 00 00       	call   80105cf0 <acquire>
    wakeup(&log);
80103294:	c7 04 24 a0 46 11 80 	movl   $0x801146a0,(%esp)
    log.committing = 0;
8010329b:	c7 05 e0 46 11 80 00 	movl   $0x0,0x801146e0
801032a2:	00 00 00 
    wakeup(&log);
801032a5:	e8 c6 1e 00 00       	call   80105170 <wakeup>
    release(&log.lock);
801032aa:	c7 04 24 a0 46 11 80 	movl   $0x801146a0,(%esp)
801032b1:	e8 fa 2a 00 00       	call   80105db0 <release>
801032b6:	83 c4 10             	add    $0x10,%esp
}
801032b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801032bc:	5b                   	pop    %ebx
801032bd:	5e                   	pop    %esi
801032be:	5f                   	pop    %edi
801032bf:	5d                   	pop    %ebp
801032c0:	c3                   	ret    
801032c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
801032c8:	83 ec 0c             	sub    $0xc,%esp
801032cb:	68 a0 46 11 80       	push   $0x801146a0
801032d0:	e8 9b 1e 00 00       	call   80105170 <wakeup>
  release(&log.lock);
801032d5:	c7 04 24 a0 46 11 80 	movl   $0x801146a0,(%esp)
801032dc:	e8 cf 2a 00 00       	call   80105db0 <release>
801032e1:	83 c4 10             	add    $0x10,%esp
}
801032e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801032e7:	5b                   	pop    %ebx
801032e8:	5e                   	pop    %esi
801032e9:	5f                   	pop    %edi
801032ea:	5d                   	pop    %ebp
801032eb:	c3                   	ret    
    panic("log.committing");
801032ec:	83 ec 0c             	sub    $0xc,%esp
801032ef:	68 64 90 10 80       	push   $0x80109064
801032f4:	e8 97 d0 ff ff       	call   80100390 <panic>
801032f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103300 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103300:	55                   	push   %ebp
80103301:	89 e5                	mov    %esp,%ebp
80103303:	53                   	push   %ebx
80103304:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103307:	8b 15 e8 46 11 80    	mov    0x801146e8,%edx
{
8010330d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103310:	83 fa 1d             	cmp    $0x1d,%edx
80103313:	0f 8f 9d 00 00 00    	jg     801033b6 <log_write+0xb6>
80103319:	a1 d8 46 11 80       	mov    0x801146d8,%eax
8010331e:	83 e8 01             	sub    $0x1,%eax
80103321:	39 c2                	cmp    %eax,%edx
80103323:	0f 8d 8d 00 00 00    	jge    801033b6 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103329:	a1 dc 46 11 80       	mov    0x801146dc,%eax
8010332e:	85 c0                	test   %eax,%eax
80103330:	0f 8e 8d 00 00 00    	jle    801033c3 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80103336:	83 ec 0c             	sub    $0xc,%esp
80103339:	68 a0 46 11 80       	push   $0x801146a0
8010333e:	e8 ad 29 00 00       	call   80105cf0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80103343:	8b 0d e8 46 11 80    	mov    0x801146e8,%ecx
80103349:	83 c4 10             	add    $0x10,%esp
8010334c:	83 f9 00             	cmp    $0x0,%ecx
8010334f:	7e 57                	jle    801033a8 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103351:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80103354:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103356:	3b 15 ec 46 11 80    	cmp    0x801146ec,%edx
8010335c:	75 0b                	jne    80103369 <log_write+0x69>
8010335e:	eb 38                	jmp    80103398 <log_write+0x98>
80103360:	39 14 85 ec 46 11 80 	cmp    %edx,-0x7feeb914(,%eax,4)
80103367:	74 2f                	je     80103398 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80103369:	83 c0 01             	add    $0x1,%eax
8010336c:	39 c1                	cmp    %eax,%ecx
8010336e:	75 f0                	jne    80103360 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80103370:	89 14 85 ec 46 11 80 	mov    %edx,-0x7feeb914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80103377:	83 c0 01             	add    $0x1,%eax
8010337a:	a3 e8 46 11 80       	mov    %eax,0x801146e8
  b->flags |= B_DIRTY; // prevent eviction
8010337f:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80103382:	c7 45 08 a0 46 11 80 	movl   $0x801146a0,0x8(%ebp)
}
80103389:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010338c:	c9                   	leave  
  release(&log.lock);
8010338d:	e9 1e 2a 00 00       	jmp    80105db0 <release>
80103392:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80103398:	89 14 85 ec 46 11 80 	mov    %edx,-0x7feeb914(,%eax,4)
8010339f:	eb de                	jmp    8010337f <log_write+0x7f>
801033a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033a8:	8b 43 08             	mov    0x8(%ebx),%eax
801033ab:	a3 ec 46 11 80       	mov    %eax,0x801146ec
  if (i == log.lh.n)
801033b0:	75 cd                	jne    8010337f <log_write+0x7f>
801033b2:	31 c0                	xor    %eax,%eax
801033b4:	eb c1                	jmp    80103377 <log_write+0x77>
    panic("too big a transaction");
801033b6:	83 ec 0c             	sub    $0xc,%esp
801033b9:	68 73 90 10 80       	push   $0x80109073
801033be:	e8 cd cf ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
801033c3:	83 ec 0c             	sub    $0xc,%esp
801033c6:	68 89 90 10 80       	push   $0x80109089
801033cb:	e8 c0 cf ff ff       	call   80100390 <panic>

801033d0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801033d0:	55                   	push   %ebp
801033d1:	89 e5                	mov    %esp,%ebp
801033d3:	53                   	push   %ebx
801033d4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
801033d7:	e8 24 0e 00 00       	call   80104200 <cpuid>
801033dc:	89 c3                	mov    %eax,%ebx
801033de:	e8 1d 0e 00 00       	call   80104200 <cpuid>
801033e3:	83 ec 04             	sub    $0x4,%esp
801033e6:	53                   	push   %ebx
801033e7:	50                   	push   %eax
801033e8:	68 a4 90 10 80       	push   $0x801090a4
801033ed:	e8 6e d2 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
801033f2:	e8 29 3f 00 00       	call   80107320 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
801033f7:	e8 84 0d 00 00       	call   80104180 <mycpu>
801033fc:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801033fe:	b8 01 00 00 00       	mov    $0x1,%eax
80103403:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010340a:	e8 31 13 00 00       	call   80104740 <scheduler>
8010340f:	90                   	nop

80103410 <mpenter>:
{
80103410:	55                   	push   %ebp
80103411:	89 e5                	mov    %esp,%ebp
80103413:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103416:	e8 b5 50 00 00       	call   801084d0 <switchkvm>
  seginit();
8010341b:	e8 20 50 00 00       	call   80108440 <seginit>
  lapicinit();
80103420:	e8 9b f7 ff ff       	call   80102bc0 <lapicinit>
  mpmain();
80103425:	e8 a6 ff ff ff       	call   801033d0 <mpmain>
8010342a:	66 90                	xchg   %ax,%ax
8010342c:	66 90                	xchg   %ax,%ax
8010342e:	66 90                	xchg   %ax,%ax

80103430 <main>:
{
80103430:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103434:	83 e4 f0             	and    $0xfffffff0,%esp
80103437:	ff 71 fc             	pushl  -0x4(%ecx)
8010343a:	55                   	push   %ebp
8010343b:	89 e5                	mov    %esp,%ebp
8010343d:	53                   	push   %ebx
8010343e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010343f:	83 ec 08             	sub    $0x8,%esp
80103442:	68 00 00 40 80       	push   $0x80400000
80103447:	68 08 c3 11 80       	push   $0x8011c308
8010344c:	e8 2f f5 ff ff       	call   80102980 <kinit1>
  kvmalloc();      // kernel page table
80103451:	e8 4a 55 00 00       	call   801089a0 <kvmalloc>
  mpinit();        // detect other processors
80103456:	e8 75 01 00 00       	call   801035d0 <mpinit>
  lapicinit();     // interrupt controller
8010345b:	e8 60 f7 ff ff       	call   80102bc0 <lapicinit>
  seginit();       // segment descriptors
80103460:	e8 db 4f 00 00       	call   80108440 <seginit>
  picinit();       // disable pic
80103465:	e8 46 03 00 00       	call   801037b0 <picinit>
  ioapicinit();    // another interrupt controller
8010346a:	e8 41 f3 ff ff       	call   801027b0 <ioapicinit>
  consoleinit();   // console hardware
8010346f:	e8 4c d5 ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80103474:	e8 97 42 00 00       	call   80107710 <uartinit>
  pinit();         // process table
80103479:	e8 e2 0c 00 00       	call   80104160 <pinit>
	minit();				 // mlfq process
8010347e:	e8 5d 09 00 00       	call   80103de0 <minit>
  tvinit();        // trap vectors
80103483:	e8 18 3e 00 00       	call   801072a0 <tvinit>
  binit();         // buffer cache
80103488:	e8 b3 cb ff ff       	call   80100040 <binit>
  fileinit();      // file table
8010348d:	e8 ce d8 ff ff       	call   80100d60 <fileinit>
  ideinit();       // disk 
80103492:	e8 f9 f0 ff ff       	call   80102590 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103497:	83 c4 0c             	add    $0xc,%esp
8010349a:	68 8a 00 00 00       	push   $0x8a
8010349f:	68 8c c4 10 80       	push   $0x8010c48c
801034a4:	68 00 70 00 80       	push   $0x80007000
801034a9:	e8 02 2a 00 00       	call   80105eb0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801034ae:	69 05 20 4d 11 80 b0 	imul   $0xb0,0x80114d20,%eax
801034b5:	00 00 00 
801034b8:	83 c4 10             	add    $0x10,%esp
801034bb:	05 a0 47 11 80       	add    $0x801147a0,%eax
801034c0:	3d a0 47 11 80       	cmp    $0x801147a0,%eax
801034c5:	76 6c                	jbe    80103533 <main+0x103>
801034c7:	bb a0 47 11 80       	mov    $0x801147a0,%ebx
801034cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
801034d0:	e8 ab 0c 00 00       	call   80104180 <mycpu>
801034d5:	39 d8                	cmp    %ebx,%eax
801034d7:	74 41                	je     8010351a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801034d9:	e8 72 f5 ff ff       	call   80102a50 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
801034de:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
801034e3:	c7 05 f8 6f 00 80 10 	movl   $0x80103410,0x80006ff8
801034ea:	34 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801034ed:	c7 05 f4 6f 00 80 00 	movl   $0x10b000,0x80006ff4
801034f4:	b0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
801034f7:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
801034fc:	0f b6 03             	movzbl (%ebx),%eax
801034ff:	83 ec 08             	sub    $0x8,%esp
80103502:	68 00 70 00 00       	push   $0x7000
80103507:	50                   	push   %eax
80103508:	e8 03 f8 ff ff       	call   80102d10 <lapicstartap>
8010350d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103510:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103516:	85 c0                	test   %eax,%eax
80103518:	74 f6                	je     80103510 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
8010351a:	69 05 20 4d 11 80 b0 	imul   $0xb0,0x80114d20,%eax
80103521:	00 00 00 
80103524:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010352a:	05 a0 47 11 80       	add    $0x801147a0,%eax
8010352f:	39 c3                	cmp    %eax,%ebx
80103531:	72 9d                	jb     801034d0 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103533:	83 ec 08             	sub    $0x8,%esp
80103536:	68 00 00 00 8e       	push   $0x8e000000
8010353b:	68 00 00 40 80       	push   $0x80400000
80103540:	e8 ab f4 ff ff       	call   801029f0 <kinit2>
  userinit();      // first user process
80103545:	e8 56 0e 00 00       	call   801043a0 <userinit>
  mpmain();        // finish this processor's setup
8010354a:	e8 81 fe ff ff       	call   801033d0 <mpmain>
8010354f:	90                   	nop

80103550 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103550:	55                   	push   %ebp
80103551:	89 e5                	mov    %esp,%ebp
80103553:	57                   	push   %edi
80103554:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103555:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010355b:	53                   	push   %ebx
  e = addr+len;
8010355c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010355f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103562:	39 de                	cmp    %ebx,%esi
80103564:	72 10                	jb     80103576 <mpsearch1+0x26>
80103566:	eb 50                	jmp    801035b8 <mpsearch1+0x68>
80103568:	90                   	nop
80103569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103570:	39 fb                	cmp    %edi,%ebx
80103572:	89 fe                	mov    %edi,%esi
80103574:	76 42                	jbe    801035b8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103576:	83 ec 04             	sub    $0x4,%esp
80103579:	8d 7e 10             	lea    0x10(%esi),%edi
8010357c:	6a 04                	push   $0x4
8010357e:	68 b8 90 10 80       	push   $0x801090b8
80103583:	56                   	push   %esi
80103584:	e8 c7 28 00 00       	call   80105e50 <memcmp>
80103589:	83 c4 10             	add    $0x10,%esp
8010358c:	85 c0                	test   %eax,%eax
8010358e:	75 e0                	jne    80103570 <mpsearch1+0x20>
80103590:	89 f1                	mov    %esi,%ecx
80103592:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103598:	0f b6 11             	movzbl (%ecx),%edx
8010359b:	83 c1 01             	add    $0x1,%ecx
8010359e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
801035a0:	39 f9                	cmp    %edi,%ecx
801035a2:	75 f4                	jne    80103598 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801035a4:	84 c0                	test   %al,%al
801035a6:	75 c8                	jne    80103570 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801035a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035ab:	89 f0                	mov    %esi,%eax
801035ad:	5b                   	pop    %ebx
801035ae:	5e                   	pop    %esi
801035af:	5f                   	pop    %edi
801035b0:	5d                   	pop    %ebp
801035b1:	c3                   	ret    
801035b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801035b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801035bb:	31 f6                	xor    %esi,%esi
}
801035bd:	89 f0                	mov    %esi,%eax
801035bf:	5b                   	pop    %ebx
801035c0:	5e                   	pop    %esi
801035c1:	5f                   	pop    %edi
801035c2:	5d                   	pop    %ebp
801035c3:	c3                   	ret    
801035c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801035ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801035d0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801035d0:	55                   	push   %ebp
801035d1:	89 e5                	mov    %esp,%ebp
801035d3:	57                   	push   %edi
801035d4:	56                   	push   %esi
801035d5:	53                   	push   %ebx
801035d6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801035d9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801035e0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801035e7:	c1 e0 08             	shl    $0x8,%eax
801035ea:	09 d0                	or     %edx,%eax
801035ec:	c1 e0 04             	shl    $0x4,%eax
801035ef:	85 c0                	test   %eax,%eax
801035f1:	75 1b                	jne    8010360e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801035f3:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801035fa:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103601:	c1 e0 08             	shl    $0x8,%eax
80103604:	09 d0                	or     %edx,%eax
80103606:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103609:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010360e:	ba 00 04 00 00       	mov    $0x400,%edx
80103613:	e8 38 ff ff ff       	call   80103550 <mpsearch1>
80103618:	85 c0                	test   %eax,%eax
8010361a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010361d:	0f 84 3d 01 00 00    	je     80103760 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103623:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103626:	8b 58 04             	mov    0x4(%eax),%ebx
80103629:	85 db                	test   %ebx,%ebx
8010362b:	0f 84 4f 01 00 00    	je     80103780 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103631:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103637:	83 ec 04             	sub    $0x4,%esp
8010363a:	6a 04                	push   $0x4
8010363c:	68 d5 90 10 80       	push   $0x801090d5
80103641:	56                   	push   %esi
80103642:	e8 09 28 00 00       	call   80105e50 <memcmp>
80103647:	83 c4 10             	add    $0x10,%esp
8010364a:	85 c0                	test   %eax,%eax
8010364c:	0f 85 2e 01 00 00    	jne    80103780 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
80103652:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103659:	3c 01                	cmp    $0x1,%al
8010365b:	0f 95 c2             	setne  %dl
8010365e:	3c 04                	cmp    $0x4,%al
80103660:	0f 95 c0             	setne  %al
80103663:	20 c2                	and    %al,%dl
80103665:	0f 85 15 01 00 00    	jne    80103780 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
8010366b:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
80103672:	66 85 ff             	test   %di,%di
80103675:	74 1a                	je     80103691 <mpinit+0xc1>
80103677:	89 f0                	mov    %esi,%eax
80103679:	01 f7                	add    %esi,%edi
  sum = 0;
8010367b:	31 d2                	xor    %edx,%edx
8010367d:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103680:	0f b6 08             	movzbl (%eax),%ecx
80103683:	83 c0 01             	add    $0x1,%eax
80103686:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103688:	39 c7                	cmp    %eax,%edi
8010368a:	75 f4                	jne    80103680 <mpinit+0xb0>
8010368c:	84 d2                	test   %dl,%dl
8010368e:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103691:	85 f6                	test   %esi,%esi
80103693:	0f 84 e7 00 00 00    	je     80103780 <mpinit+0x1b0>
80103699:	84 d2                	test   %dl,%dl
8010369b:	0f 85 df 00 00 00    	jne    80103780 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801036a1:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801036a7:	a3 9c 46 11 80       	mov    %eax,0x8011469c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801036ac:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
801036b3:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
801036b9:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801036be:	01 d6                	add    %edx,%esi
801036c0:	39 c6                	cmp    %eax,%esi
801036c2:	76 23                	jbe    801036e7 <mpinit+0x117>
    switch(*p){
801036c4:	0f b6 10             	movzbl (%eax),%edx
801036c7:	80 fa 04             	cmp    $0x4,%dl
801036ca:	0f 87 ca 00 00 00    	ja     8010379a <mpinit+0x1ca>
801036d0:	ff 24 95 fc 90 10 80 	jmp    *-0x7fef6f04(,%edx,4)
801036d7:	89 f6                	mov    %esi,%esi
801036d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801036e0:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801036e3:	39 c6                	cmp    %eax,%esi
801036e5:	77 dd                	ja     801036c4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801036e7:	85 db                	test   %ebx,%ebx
801036e9:	0f 84 9e 00 00 00    	je     8010378d <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801036ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801036f2:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
801036f6:	74 15                	je     8010370d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801036f8:	b8 70 00 00 00       	mov    $0x70,%eax
801036fd:	ba 22 00 00 00       	mov    $0x22,%edx
80103702:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103703:	ba 23 00 00 00       	mov    $0x23,%edx
80103708:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103709:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010370c:	ee                   	out    %al,(%dx)
  }
}
8010370d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103710:	5b                   	pop    %ebx
80103711:	5e                   	pop    %esi
80103712:	5f                   	pop    %edi
80103713:	5d                   	pop    %ebp
80103714:	c3                   	ret    
80103715:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
80103718:	8b 0d 20 4d 11 80    	mov    0x80114d20,%ecx
8010371e:	83 f9 07             	cmp    $0x7,%ecx
80103721:	7f 19                	jg     8010373c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103723:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103727:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010372d:	83 c1 01             	add    $0x1,%ecx
80103730:	89 0d 20 4d 11 80    	mov    %ecx,0x80114d20
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103736:	88 97 a0 47 11 80    	mov    %dl,-0x7feeb860(%edi)
      p += sizeof(struct mpproc);
8010373c:	83 c0 14             	add    $0x14,%eax
      continue;
8010373f:	e9 7c ff ff ff       	jmp    801036c0 <mpinit+0xf0>
80103744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103748:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010374c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010374f:	88 15 80 47 11 80    	mov    %dl,0x80114780
      continue;
80103755:	e9 66 ff ff ff       	jmp    801036c0 <mpinit+0xf0>
8010375a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
80103760:	ba 00 00 01 00       	mov    $0x10000,%edx
80103765:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010376a:	e8 e1 fd ff ff       	call   80103550 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010376f:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
80103771:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103774:	0f 85 a9 fe ff ff    	jne    80103623 <mpinit+0x53>
8010377a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103780:	83 ec 0c             	sub    $0xc,%esp
80103783:	68 bd 90 10 80       	push   $0x801090bd
80103788:	e8 03 cc ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010378d:	83 ec 0c             	sub    $0xc,%esp
80103790:	68 dc 90 10 80       	push   $0x801090dc
80103795:	e8 f6 cb ff ff       	call   80100390 <panic>
      ismp = 0;
8010379a:	31 db                	xor    %ebx,%ebx
8010379c:	e9 26 ff ff ff       	jmp    801036c7 <mpinit+0xf7>
801037a1:	66 90                	xchg   %ax,%ax
801037a3:	66 90                	xchg   %ax,%ax
801037a5:	66 90                	xchg   %ax,%ax
801037a7:	66 90                	xchg   %ax,%ax
801037a9:	66 90                	xchg   %ax,%ax
801037ab:	66 90                	xchg   %ax,%ax
801037ad:	66 90                	xchg   %ax,%ax
801037af:	90                   	nop

801037b0 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801037b0:	55                   	push   %ebp
801037b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801037b6:	ba 21 00 00 00       	mov    $0x21,%edx
801037bb:	89 e5                	mov    %esp,%ebp
801037bd:	ee                   	out    %al,(%dx)
801037be:	ba a1 00 00 00       	mov    $0xa1,%edx
801037c3:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801037c4:	5d                   	pop    %ebp
801037c5:	c3                   	ret    
801037c6:	66 90                	xchg   %ax,%ax
801037c8:	66 90                	xchg   %ax,%ax
801037ca:	66 90                	xchg   %ax,%ax
801037cc:	66 90                	xchg   %ax,%ax
801037ce:	66 90                	xchg   %ax,%ax

801037d0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801037d0:	55                   	push   %ebp
801037d1:	89 e5                	mov    %esp,%ebp
801037d3:	57                   	push   %edi
801037d4:	56                   	push   %esi
801037d5:	53                   	push   %ebx
801037d6:	83 ec 0c             	sub    $0xc,%esp
801037d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801037dc:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801037df:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801037e5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801037eb:	e8 90 d5 ff ff       	call   80100d80 <filealloc>
801037f0:	85 c0                	test   %eax,%eax
801037f2:	89 03                	mov    %eax,(%ebx)
801037f4:	74 22                	je     80103818 <pipealloc+0x48>
801037f6:	e8 85 d5 ff ff       	call   80100d80 <filealloc>
801037fb:	85 c0                	test   %eax,%eax
801037fd:	89 06                	mov    %eax,(%esi)
801037ff:	74 3f                	je     80103840 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103801:	e8 4a f2 ff ff       	call   80102a50 <kalloc>
80103806:	85 c0                	test   %eax,%eax
80103808:	89 c7                	mov    %eax,%edi
8010380a:	75 54                	jne    80103860 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010380c:	8b 03                	mov    (%ebx),%eax
8010380e:	85 c0                	test   %eax,%eax
80103810:	75 34                	jne    80103846 <pipealloc+0x76>
80103812:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
80103818:	8b 06                	mov    (%esi),%eax
8010381a:	85 c0                	test   %eax,%eax
8010381c:	74 0c                	je     8010382a <pipealloc+0x5a>
    fileclose(*f1);
8010381e:	83 ec 0c             	sub    $0xc,%esp
80103821:	50                   	push   %eax
80103822:	e8 19 d6 ff ff       	call   80100e40 <fileclose>
80103827:	83 c4 10             	add    $0x10,%esp
  return -1;
}
8010382a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010382d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103832:	5b                   	pop    %ebx
80103833:	5e                   	pop    %esi
80103834:	5f                   	pop    %edi
80103835:	5d                   	pop    %ebp
80103836:	c3                   	ret    
80103837:	89 f6                	mov    %esi,%esi
80103839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
80103840:	8b 03                	mov    (%ebx),%eax
80103842:	85 c0                	test   %eax,%eax
80103844:	74 e4                	je     8010382a <pipealloc+0x5a>
    fileclose(*f0);
80103846:	83 ec 0c             	sub    $0xc,%esp
80103849:	50                   	push   %eax
8010384a:	e8 f1 d5 ff ff       	call   80100e40 <fileclose>
  if(*f1)
8010384f:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
80103851:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103854:	85 c0                	test   %eax,%eax
80103856:	75 c6                	jne    8010381e <pipealloc+0x4e>
80103858:	eb d0                	jmp    8010382a <pipealloc+0x5a>
8010385a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
80103860:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
80103863:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010386a:	00 00 00 
  p->writeopen = 1;
8010386d:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103874:	00 00 00 
  p->nwrite = 0;
80103877:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010387e:	00 00 00 
  p->nread = 0;
80103881:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103888:	00 00 00 
  initlock(&p->lock, "pipe");
8010388b:	68 10 91 10 80       	push   $0x80109110
80103890:	50                   	push   %eax
80103891:	e8 1a 23 00 00       	call   80105bb0 <initlock>
  (*f0)->type = FD_PIPE;
80103896:	8b 03                	mov    (%ebx),%eax
  return 0;
80103898:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
8010389b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801038a1:	8b 03                	mov    (%ebx),%eax
801038a3:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801038a7:	8b 03                	mov    (%ebx),%eax
801038a9:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801038ad:	8b 03                	mov    (%ebx),%eax
801038af:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801038b2:	8b 06                	mov    (%esi),%eax
801038b4:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801038ba:	8b 06                	mov    (%esi),%eax
801038bc:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801038c0:	8b 06                	mov    (%esi),%eax
801038c2:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801038c6:	8b 06                	mov    (%esi),%eax
801038c8:	89 78 0c             	mov    %edi,0xc(%eax)
}
801038cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801038ce:	31 c0                	xor    %eax,%eax
}
801038d0:	5b                   	pop    %ebx
801038d1:	5e                   	pop    %esi
801038d2:	5f                   	pop    %edi
801038d3:	5d                   	pop    %ebp
801038d4:	c3                   	ret    
801038d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801038d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801038e0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801038e0:	55                   	push   %ebp
801038e1:	89 e5                	mov    %esp,%ebp
801038e3:	56                   	push   %esi
801038e4:	53                   	push   %ebx
801038e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801038e8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801038eb:	83 ec 0c             	sub    $0xc,%esp
801038ee:	53                   	push   %ebx
801038ef:	e8 fc 23 00 00       	call   80105cf0 <acquire>
  if(writable){
801038f4:	83 c4 10             	add    $0x10,%esp
801038f7:	85 f6                	test   %esi,%esi
801038f9:	74 45                	je     80103940 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
801038fb:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103901:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103904:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010390b:	00 00 00 
    wakeup(&p->nread);
8010390e:	50                   	push   %eax
8010390f:	e8 5c 18 00 00       	call   80105170 <wakeup>
80103914:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103917:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010391d:	85 d2                	test   %edx,%edx
8010391f:	75 0a                	jne    8010392b <pipeclose+0x4b>
80103921:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103927:	85 c0                	test   %eax,%eax
80103929:	74 35                	je     80103960 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010392b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010392e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103931:	5b                   	pop    %ebx
80103932:	5e                   	pop    %esi
80103933:	5d                   	pop    %ebp
    release(&p->lock);
80103934:	e9 77 24 00 00       	jmp    80105db0 <release>
80103939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103940:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103946:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
80103949:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103950:	00 00 00 
    wakeup(&p->nwrite);
80103953:	50                   	push   %eax
80103954:	e8 17 18 00 00       	call   80105170 <wakeup>
80103959:	83 c4 10             	add    $0x10,%esp
8010395c:	eb b9                	jmp    80103917 <pipeclose+0x37>
8010395e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103960:	83 ec 0c             	sub    $0xc,%esp
80103963:	53                   	push   %ebx
80103964:	e8 47 24 00 00       	call   80105db0 <release>
    kfree((char*)p);
80103969:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010396c:	83 c4 10             	add    $0x10,%esp
}
8010396f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103972:	5b                   	pop    %ebx
80103973:	5e                   	pop    %esi
80103974:	5d                   	pop    %ebp
    kfree((char*)p);
80103975:	e9 26 ef ff ff       	jmp    801028a0 <kfree>
8010397a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103980 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103980:	55                   	push   %ebp
80103981:	89 e5                	mov    %esp,%ebp
80103983:	57                   	push   %edi
80103984:	56                   	push   %esi
80103985:	53                   	push   %ebx
80103986:	83 ec 28             	sub    $0x28,%esp
80103989:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010398c:	53                   	push   %ebx
8010398d:	e8 5e 23 00 00       	call   80105cf0 <acquire>
  for(i = 0; i < n; i++){
80103992:	8b 45 10             	mov    0x10(%ebp),%eax
80103995:	83 c4 10             	add    $0x10,%esp
80103998:	85 c0                	test   %eax,%eax
8010399a:	0f 8e c9 00 00 00    	jle    80103a69 <pipewrite+0xe9>
801039a0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801039a3:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801039a9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
801039af:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801039b2:	03 4d 10             	add    0x10(%ebp),%ecx
801039b5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801039b8:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
801039be:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
801039c4:	39 d0                	cmp    %edx,%eax
801039c6:	75 71                	jne    80103a39 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
801039c8:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801039ce:	85 c0                	test   %eax,%eax
801039d0:	74 4e                	je     80103a20 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801039d2:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
801039d8:	eb 3a                	jmp    80103a14 <pipewrite+0x94>
801039da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
801039e0:	83 ec 0c             	sub    $0xc,%esp
801039e3:	57                   	push   %edi
801039e4:	e8 87 17 00 00       	call   80105170 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801039e9:	5a                   	pop    %edx
801039ea:	59                   	pop    %ecx
801039eb:	53                   	push   %ebx
801039ec:	56                   	push   %esi
801039ed:	e8 6e 14 00 00       	call   80104e60 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801039f2:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801039f8:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801039fe:	83 c4 10             	add    $0x10,%esp
80103a01:	05 00 02 00 00       	add    $0x200,%eax
80103a06:	39 c2                	cmp    %eax,%edx
80103a08:	75 36                	jne    80103a40 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
80103a0a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103a10:	85 c0                	test   %eax,%eax
80103a12:	74 0c                	je     80103a20 <pipewrite+0xa0>
80103a14:	e8 57 09 00 00       	call   80104370 <myproc>
80103a19:	8b 40 24             	mov    0x24(%eax),%eax
80103a1c:	85 c0                	test   %eax,%eax
80103a1e:	74 c0                	je     801039e0 <pipewrite+0x60>
        release(&p->lock);
80103a20:	83 ec 0c             	sub    $0xc,%esp
80103a23:	53                   	push   %ebx
80103a24:	e8 87 23 00 00       	call   80105db0 <release>
        return -1;
80103a29:	83 c4 10             	add    $0x10,%esp
80103a2c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103a31:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a34:	5b                   	pop    %ebx
80103a35:	5e                   	pop    %esi
80103a36:	5f                   	pop    %edi
80103a37:	5d                   	pop    %ebp
80103a38:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103a39:	89 c2                	mov    %eax,%edx
80103a3b:	90                   	nop
80103a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103a40:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103a43:	8d 42 01             	lea    0x1(%edx),%eax
80103a46:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103a4c:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103a52:	83 c6 01             	add    $0x1,%esi
80103a55:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
80103a59:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80103a5c:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103a5f:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103a63:	0f 85 4f ff ff ff    	jne    801039b8 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103a69:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103a6f:	83 ec 0c             	sub    $0xc,%esp
80103a72:	50                   	push   %eax
80103a73:	e8 f8 16 00 00       	call   80105170 <wakeup>
  release(&p->lock);
80103a78:	89 1c 24             	mov    %ebx,(%esp)
80103a7b:	e8 30 23 00 00       	call   80105db0 <release>
  return n;
80103a80:	83 c4 10             	add    $0x10,%esp
80103a83:	8b 45 10             	mov    0x10(%ebp),%eax
80103a86:	eb a9                	jmp    80103a31 <pipewrite+0xb1>
80103a88:	90                   	nop
80103a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103a90 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103a90:	55                   	push   %ebp
80103a91:	89 e5                	mov    %esp,%ebp
80103a93:	57                   	push   %edi
80103a94:	56                   	push   %esi
80103a95:	53                   	push   %ebx
80103a96:	83 ec 18             	sub    $0x18,%esp
80103a99:	8b 75 08             	mov    0x8(%ebp),%esi
80103a9c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
80103a9f:	56                   	push   %esi
80103aa0:	e8 4b 22 00 00       	call   80105cf0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103aa5:	83 c4 10             	add    $0x10,%esp
80103aa8:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103aae:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103ab4:	75 6a                	jne    80103b20 <piperead+0x90>
80103ab6:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
80103abc:	85 db                	test   %ebx,%ebx
80103abe:	0f 84 c4 00 00 00    	je     80103b88 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103ac4:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103aca:	eb 2d                	jmp    80103af9 <piperead+0x69>
80103acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ad0:	83 ec 08             	sub    $0x8,%esp
80103ad3:	56                   	push   %esi
80103ad4:	53                   	push   %ebx
80103ad5:	e8 86 13 00 00       	call   80104e60 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103ada:	83 c4 10             	add    $0x10,%esp
80103add:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103ae3:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103ae9:	75 35                	jne    80103b20 <piperead+0x90>
80103aeb:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103af1:	85 d2                	test   %edx,%edx
80103af3:	0f 84 8f 00 00 00    	je     80103b88 <piperead+0xf8>
    if(myproc()->killed){
80103af9:	e8 72 08 00 00       	call   80104370 <myproc>
80103afe:	8b 48 24             	mov    0x24(%eax),%ecx
80103b01:	85 c9                	test   %ecx,%ecx
80103b03:	74 cb                	je     80103ad0 <piperead+0x40>
      release(&p->lock);
80103b05:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103b08:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103b0d:	56                   	push   %esi
80103b0e:	e8 9d 22 00 00       	call   80105db0 <release>
      return -1;
80103b13:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103b16:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b19:	89 d8                	mov    %ebx,%eax
80103b1b:	5b                   	pop    %ebx
80103b1c:	5e                   	pop    %esi
80103b1d:	5f                   	pop    %edi
80103b1e:	5d                   	pop    %ebp
80103b1f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103b20:	8b 45 10             	mov    0x10(%ebp),%eax
80103b23:	85 c0                	test   %eax,%eax
80103b25:	7e 61                	jle    80103b88 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103b27:	31 db                	xor    %ebx,%ebx
80103b29:	eb 13                	jmp    80103b3e <piperead+0xae>
80103b2b:	90                   	nop
80103b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103b30:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103b36:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103b3c:	74 1f                	je     80103b5d <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103b3e:	8d 41 01             	lea    0x1(%ecx),%eax
80103b41:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103b47:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
80103b4d:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
80103b52:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103b55:	83 c3 01             	add    $0x1,%ebx
80103b58:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103b5b:	75 d3                	jne    80103b30 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103b5d:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103b63:	83 ec 0c             	sub    $0xc,%esp
80103b66:	50                   	push   %eax
80103b67:	e8 04 16 00 00       	call   80105170 <wakeup>
  release(&p->lock);
80103b6c:	89 34 24             	mov    %esi,(%esp)
80103b6f:	e8 3c 22 00 00       	call   80105db0 <release>
  return i;
80103b74:	83 c4 10             	add    $0x10,%esp
}
80103b77:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b7a:	89 d8                	mov    %ebx,%eax
80103b7c:	5b                   	pop    %ebx
80103b7d:	5e                   	pop    %esi
80103b7e:	5f                   	pop    %edi
80103b7f:	5d                   	pop    %ebp
80103b80:	c3                   	ret    
80103b81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b88:	31 db                	xor    %ebx,%ebx
80103b8a:	eb d1                	jmp    80103b5d <piperead+0xcd>
80103b8c:	66 90                	xchg   %ax,%ax
80103b8e:	66 90                	xchg   %ax,%ax

80103b90 <get_min_pass>:
  return 0;
}

static uint
get_min_pass()
{
80103b90:	55                   	push   %ebp
80103b91:	89 e5                	mov    %esp,%ebp
80103b93:	83 ec 14             	sub    $0x14,%esp
	// The ptable lock must be held
	if(!holding(&ptable.lock))
80103b96:	68 80 50 11 80       	push   $0x80115080
80103b9b:	e8 20 21 00 00       	call   80105cc0 <holding>
80103ba0:	83 c4 10             	add    $0x10,%esp
80103ba3:	85 c0                	test   %eax,%eax
80103ba5:	74 41                	je     80103be8 <get_min_pass+0x58>
		panic("panic in get_min_pass().");
	
	uint min_pass = mlfq_proc.mlfq_pass;
80103ba7:	a1 58 50 11 80       	mov    0x80115058,%eax
	struct proc* p;
	for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103bac:	ba b4 50 11 80       	mov    $0x801150b4,%edx
80103bb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		if (p->is_stride && p->state == RUNNABLE && p->pass_value < min_pass) {
80103bb8:	8b 8a 98 01 00 00    	mov    0x198(%edx),%ecx
80103bbe:	85 c9                	test   %ecx,%ecx
80103bc0:	74 16                	je     80103bd8 <get_min_pass+0x48>
80103bc2:	83 7a 0c 03          	cmpl   $0x3,0xc(%edx)
80103bc6:	75 10                	jne    80103bd8 <get_min_pass+0x48>
80103bc8:	8b 8a a0 01 00 00    	mov    0x1a0(%edx),%ecx
80103bce:	39 c8                	cmp    %ecx,%eax
80103bd0:	0f 47 c1             	cmova  %ecx,%eax
80103bd3:	90                   	nop
80103bd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103bd8:	81 c2 a8 01 00 00    	add    $0x1a8,%edx
80103bde:	81 fa b4 ba 11 80    	cmp    $0x8011bab4,%edx
80103be4:	72 d2                	jb     80103bb8 <get_min_pass+0x28>
			min_pass = p->pass_value;
		}
	}
	return min_pass;
}
80103be6:	c9                   	leave  
80103be7:	c3                   	ret    
		panic("panic in get_min_pass().");
80103be8:	83 ec 0c             	sub    $0xc,%esp
80103beb:	68 15 91 10 80       	push   $0x80109115
80103bf0:	e8 9b c7 ff ff       	call   80100390 <panic>
80103bf5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c00 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80103c00:	55                   	push   %ebp
80103c01:	89 e5                	mov    %esp,%ebp
80103c03:	56                   	push   %esi
80103c04:	89 c6                	mov    %eax,%esi
80103c06:	53                   	push   %ebx
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c07:	bb b4 50 11 80       	mov    $0x801150b4,%ebx
80103c0c:	eb 10                	jmp    80103c1e <wakeup1+0x1e>
80103c0e:	66 90                	xchg   %ax,%ax
80103c10:	81 c3 a8 01 00 00    	add    $0x1a8,%ebx
80103c16:	81 fb b4 ba 11 80    	cmp    $0x8011bab4,%ebx
80103c1c:	73 5f                	jae    80103c7d <wakeup1+0x7d>
    if(p->state == SLEEPING && p->chan == chan){
80103c1e:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80103c22:	75 ec                	jne    80103c10 <wakeup1+0x10>
80103c24:	39 73 20             	cmp    %esi,0x20(%ebx)
80103c27:	75 e7                	jne    80103c10 <wakeup1+0x10>
      if (!p->is_stride) {
80103c29:	8b 83 98 01 00 00    	mov    0x198(%ebx),%eax
80103c2f:	85 c0                	test   %eax,%eax
80103c31:	75 55                	jne    80103c88 <wakeup1+0x88>
				enqueue(p->lev, p);
80103c33:	8b 93 90 01 00 00    	mov    0x190(%ebx),%edx
	return mlfq_proc.queue_front[lev] == ((mlfq_proc.queue_rear[lev] + 1) % NPROC);
80103c39:	8d 8a c0 00 00 00    	lea    0xc0(%edx),%ecx
80103c3f:	8b 04 8d 4c 4d 11 80 	mov    -0x7feeb2b4(,%ecx,4),%eax
80103c46:	83 c0 01             	add    $0x1,%eax
80103c49:	83 e0 3f             	and    $0x3f,%eax
	if (is_full(lev))
80103c4c:	39 04 8d 40 4d 11 80 	cmp    %eax,-0x7feeb2c0(,%ecx,4)
80103c53:	74 40                	je     80103c95 <wakeup1+0x95>
	mlfq_proc.queue[lev][mlfq_proc.queue_rear[lev]] = proc;
80103c55:	c1 e2 06             	shl    $0x6,%edx
	mlfq_proc.queue_rear[lev] = ((mlfq_proc.queue_rear[lev] + 1) % NPROC);
80103c58:	89 04 8d 4c 4d 11 80 	mov    %eax,-0x7feeb2b4(,%ecx,4)
	mlfq_proc.queue[lev][mlfq_proc.queue_rear[lev]] = proc;
80103c5f:	01 d0                	add    %edx,%eax
80103c61:	89 1c 85 40 4d 11 80 	mov    %ebx,-0x7feeb2c0(,%eax,4)
			} else {
				p->pass_value = get_min_pass();
			}

			p->state = RUNNABLE;
80103c68:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c6f:	81 c3 a8 01 00 00    	add    $0x1a8,%ebx
80103c75:	81 fb b4 ba 11 80    	cmp    $0x8011bab4,%ebx
80103c7b:	72 a1                	jb     80103c1e <wakeup1+0x1e>
		}
}
80103c7d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c80:	5b                   	pop    %ebx
80103c81:	5e                   	pop    %esi
80103c82:	5d                   	pop    %ebp
80103c83:	c3                   	ret    
80103c84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
				p->pass_value = get_min_pass();
80103c88:	e8 03 ff ff ff       	call   80103b90 <get_min_pass>
80103c8d:	89 83 a0 01 00 00    	mov    %eax,0x1a0(%ebx)
80103c93:	eb d3                	jmp    80103c68 <wakeup1+0x68>
		panic("Queue is already full");
80103c95:	83 ec 0c             	sub    $0xc,%esp
80103c98:	68 2e 91 10 80       	push   $0x8010912e
80103c9d:	e8 ee c6 ff ff       	call   80100390 <panic>
80103ca2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103cb0 <allocproc>:
{
80103cb0:	55                   	push   %ebp
80103cb1:	89 e5                	mov    %esp,%ebp
80103cb3:	53                   	push   %ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103cb4:	bb b4 50 11 80       	mov    $0x801150b4,%ebx
{
80103cb9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103cbc:	68 80 50 11 80       	push   $0x80115080
80103cc1:	e8 2a 20 00 00       	call   80105cf0 <acquire>
80103cc6:	83 c4 10             	add    $0x10,%esp
80103cc9:	eb 13                	jmp    80103cde <allocproc+0x2e>
80103ccb:	90                   	nop
80103ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103cd0:	81 c3 a8 01 00 00    	add    $0x1a8,%ebx
80103cd6:	81 fb b4 ba 11 80    	cmp    $0x8011bab4,%ebx
80103cdc:	73 7a                	jae    80103d58 <allocproc+0xa8>
    if(p->state == UNUSED)
80103cde:	8b 43 0c             	mov    0xc(%ebx),%eax
80103ce1:	85 c0                	test   %eax,%eax
80103ce3:	75 eb                	jne    80103cd0 <allocproc+0x20>
  p->pid = nextpid++;
80103ce5:	a1 08 c0 10 80       	mov    0x8010c008,%eax
  release(&ptable.lock);
80103cea:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103ced:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103cf4:	8d 50 01             	lea    0x1(%eax),%edx
80103cf7:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
80103cfa:	68 80 50 11 80       	push   $0x80115080
  p->pid = nextpid++;
80103cff:	89 15 08 c0 10 80    	mov    %edx,0x8010c008
  release(&ptable.lock);
80103d05:	e8 a6 20 00 00       	call   80105db0 <release>
  if((p->kstack = kalloc()) == 0){
80103d0a:	e8 41 ed ff ff       	call   80102a50 <kalloc>
80103d0f:	83 c4 10             	add    $0x10,%esp
80103d12:	85 c0                	test   %eax,%eax
80103d14:	89 43 08             	mov    %eax,0x8(%ebx)
80103d17:	74 58                	je     80103d71 <allocproc+0xc1>
  sp -= sizeof *p->tf;
80103d19:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  memset(p->context, 0, sizeof *p->context);
80103d1f:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103d22:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103d27:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103d2a:	c7 40 14 8f 72 10 80 	movl   $0x8010728f,0x14(%eax)
  p->context = (struct context*)sp;
80103d31:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103d34:	6a 14                	push   $0x14
80103d36:	6a 00                	push   $0x0
80103d38:	50                   	push   %eax
80103d39:	e8 c2 20 00 00       	call   80105e00 <memset>
  p->context->eip = (uint)forkret;
80103d3e:	8b 43 1c             	mov    0x1c(%ebx),%eax
  return p;
80103d41:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103d44:	c7 40 10 80 3d 10 80 	movl   $0x80103d80,0x10(%eax)
}
80103d4b:	89 d8                	mov    %ebx,%eax
80103d4d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d50:	c9                   	leave  
80103d51:	c3                   	ret    
80103d52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80103d58:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103d5b:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103d5d:	68 80 50 11 80       	push   $0x80115080
80103d62:	e8 49 20 00 00       	call   80105db0 <release>
}
80103d67:	89 d8                	mov    %ebx,%eax
  return 0;
80103d69:	83 c4 10             	add    $0x10,%esp
}
80103d6c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d6f:	c9                   	leave  
80103d70:	c3                   	ret    
    p->state = UNUSED;
80103d71:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103d78:	31 db                	xor    %ebx,%ebx
80103d7a:	eb cf                	jmp    80103d4b <allocproc+0x9b>
80103d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103d80 <forkret>:
{
80103d80:	55                   	push   %ebp
80103d81:	89 e5                	mov    %esp,%ebp
80103d83:	83 ec 14             	sub    $0x14,%esp
  release(&ptable.lock);
80103d86:	68 80 50 11 80       	push   $0x80115080
80103d8b:	e8 20 20 00 00       	call   80105db0 <release>
  if (first) {
80103d90:	a1 00 c0 10 80       	mov    0x8010c000,%eax
80103d95:	83 c4 10             	add    $0x10,%esp
80103d98:	85 c0                	test   %eax,%eax
80103d9a:	75 04                	jne    80103da0 <forkret+0x20>
}
80103d9c:	c9                   	leave  
80103d9d:	c3                   	ret    
80103d9e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103da0:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103da3:	c7 05 00 c0 10 80 00 	movl   $0x0,0x8010c000
80103daa:	00 00 00 
    iinit(ROOTDEV);
80103dad:	6a 01                	push   $0x1
80103daf:	e8 1c da ff ff       	call   801017d0 <iinit>
    initlog(ROOTDEV);
80103db4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103dbb:	e8 d0 f2 ff ff       	call   80103090 <initlog>
80103dc0:	83 c4 10             	add    $0x10,%esp
}
80103dc3:	c9                   	leave  
80103dc4:	c3                   	ret    
80103dc5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103dd0 <TestAndSet>:
int TestAndSet(int*ptr, int new){
80103dd0:	55                   	push   %ebp
80103dd1:	89 e5                	mov    %esp,%ebp
80103dd3:	8b 55 08             	mov    0x8(%ebp),%edx
	*ptr = new;
80103dd6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
	int old = *ptr;
80103dd9:	8b 02                	mov    (%edx),%eax
	*ptr = new;
80103ddb:	89 0a                	mov    %ecx,(%edx)
}
80103ddd:	5d                   	pop    %ebp
80103dde:	c3                   	ret    
80103ddf:	90                   	nop

80103de0 <minit>:
{
80103de0:	55                   	push   %ebp
80103de1:	b8 40 4d 11 80       	mov    $0x80114d40,%eax
	mlfq_proc.mlfq_pass = 0;
80103de6:	c7 05 58 50 11 80 00 	movl   $0x0,0x80115058
80103ded:	00 00 00 
	mlfq_proc.mlfq_ticket = TOTAL_TICKET;	 
80103df0:	c7 05 60 50 11 80 64 	movl   $0x64,0x80115060
80103df7:	00 00 00 
	mlfq_proc.mlfq_stride = LARGENUM / mlfq_proc.mlfq_ticket; 
80103dfa:	c7 05 5c 50 11 80 64 	movl   $0x64,0x8011505c
80103e01:	00 00 00 
80103e04:	89 c1                	mov    %eax,%ecx
{
80103e06:	89 e5                	mov    %esp,%ebp
80103e08:	8d 90 00 01 00 00    	lea    0x100(%eax),%edx
		mlfq_proc.queue_front[i] = 0;
80103e0e:	c7 81 00 03 00 00 00 	movl   $0x0,0x300(%ecx)
80103e15:	00 00 00 
		mlfq_proc.queue_rear[i] = 0;
80103e18:	c7 81 0c 03 00 00 00 	movl   $0x0,0x30c(%ecx)
80103e1f:	00 00 00 
80103e22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			mlfq_proc.queue[i][np] = 0;
80103e28:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103e2e:	83 c0 04             	add    $0x4,%eax
		for (int np = 0; np < NPROC; np++) {
80103e31:	39 d0                	cmp    %edx,%eax
80103e33:	75 f3                	jne    80103e28 <minit+0x48>
80103e35:	83 c1 04             	add    $0x4,%ecx
	for (int i = 0; i < 3; ++i) {
80103e38:	3d 40 50 11 80       	cmp    $0x80115040,%eax
80103e3d:	75 c9                	jne    80103e08 <minit+0x28>
}
80103e3f:	5d                   	pop    %ebp
80103e40:	c3                   	ret    
80103e41:	eb 0d                	jmp    80103e50 <mlfq_pass_inc>
80103e43:	90                   	nop
80103e44:	90                   	nop
80103e45:	90                   	nop
80103e46:	90                   	nop
80103e47:	90                   	nop
80103e48:	90                   	nop
80103e49:	90                   	nop
80103e4a:	90                   	nop
80103e4b:	90                   	nop
80103e4c:	90                   	nop
80103e4d:	90                   	nop
80103e4e:	90                   	nop
80103e4f:	90                   	nop

80103e50 <mlfq_pass_inc>:
{
80103e50:	55                   	push   %ebp
	mlfq_proc.mlfq_pass += mlfq_proc.mlfq_stride;
80103e51:	a1 5c 50 11 80       	mov    0x8011505c,%eax
80103e56:	01 05 58 50 11 80    	add    %eax,0x80115058
{
80103e5c:	89 e5                	mov    %esp,%ebp
}
80103e5e:	5d                   	pop    %ebp
80103e5f:	c3                   	ret    

80103e60 <dequeue_delete>:
int dequeue_delete(int lev, struct proc* p){
80103e60:	55                   	push   %ebp
80103e61:	89 e5                	mov    %esp,%ebp
80103e63:	57                   	push   %edi
80103e64:	56                   	push   %esi
80103e65:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103e68:	53                   	push   %ebx
80103e69:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	return mlfq_proc.queue_front[lev] == mlfq_proc.queue_rear[lev];
80103e6c:	8d b9 c0 00 00 00    	lea    0xc0(%ecx),%edi
80103e72:	8b 34 bd 4c 4d 11 80 	mov    -0x7feeb2b4(,%edi,4),%esi
	if(is_empty(lev)){
80103e79:	39 34 bd 40 4d 11 80 	cmp    %esi,-0x7feeb2c0(,%edi,4)
80103e80:	74 52                	je     80103ed4 <dequeue_delete+0x74>
80103e82:	c1 e1 08             	shl    $0x8,%ecx
	for(int i =0 ; i<NPROC; i++){
80103e85:	31 c0                	xor    %eax,%eax
80103e87:	eb 0c                	jmp    80103e95 <dequeue_delete+0x35>
80103e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e90:	83 f8 40             	cmp    $0x40,%eax
80103e93:	74 2b                	je     80103ec0 <dequeue_delete+0x60>
		if(mlfq_proc.queue[lev][i] == p){
80103e95:	8b 94 81 40 4d 11 80 	mov    -0x7feeb2c0(%ecx,%eax,4),%edx
80103e9c:	83 c0 01             	add    $0x1,%eax
80103e9f:	39 da                	cmp    %ebx,%edx
80103ea1:	75 ed                	jne    80103e90 <dequeue_delete+0x30>
			for(int j = i; j<NPROC-1; j++){
80103ea3:	83 f8 40             	cmp    $0x40,%eax
80103ea6:	74 18                	je     80103ec0 <dequeue_delete+0x60>
				mlfq_proc.queue[lev][i] = mlfq_proc.queue[lev][i+1];
80103ea8:	8b 94 81 40 4d 11 80 	mov    -0x7feeb2c0(%ecx,%eax,4),%edx
	for(int i =0 ; i<NPROC; i++){
80103eaf:	83 f8 40             	cmp    $0x40,%eax
80103eb2:	89 94 81 3c 4d 11 80 	mov    %edx,-0x7feeb2c4(%ecx,%eax,4)
80103eb9:	75 da                	jne    80103e95 <dequeue_delete+0x35>
80103ebb:	90                   	nop
80103ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	mlfq_proc.queue_rear[lev] = ((mlfq_proc.queue_rear[lev] + 1) &NPROC);
80103ec0:	83 c6 01             	add    $0x1,%esi
	return 0;
80103ec3:	31 c0                	xor    %eax,%eax
	mlfq_proc.queue_rear[lev] = ((mlfq_proc.queue_rear[lev] + 1) &NPROC);
80103ec5:	83 e6 40             	and    $0x40,%esi
80103ec8:	89 34 bd 4c 4d 11 80 	mov    %esi,-0x7feeb2b4(,%edi,4)
}
80103ecf:	5b                   	pop    %ebx
80103ed0:	5e                   	pop    %esi
80103ed1:	5f                   	pop    %edi
80103ed2:	5d                   	pop    %ebp
80103ed3:	c3                   	ret    
		return -1;
80103ed4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103ed9:	eb f4                	jmp    80103ecf <dequeue_delete+0x6f>
80103edb:	90                   	nop
80103edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103ee0 <priority_boost>:
{
80103ee0:	55                   	push   %ebp
80103ee1:	89 e5                	mov    %esp,%ebp
80103ee3:	57                   	push   %edi
80103ee4:	56                   	push   %esi
80103ee5:	53                   	push   %ebx
80103ee6:	83 ec 1c             	sub    $0x1c,%esp
  if (boost_tick < BOOST_LIMIT)
80103ee9:	81 3d c0 c5 10 80 c7 	cmpl   $0xc7,0x8010c5c0
80103ef0:	00 00 00 
80103ef3:	0f 86 41 02 00 00    	jbe    8010413a <priority_boost+0x25a>
 	int flag = holding(&ptable.lock); 
80103ef9:	83 ec 0c             	sub    $0xc,%esp
  boost_tick = 0; 
80103efc:	c7 05 c0 c5 10 80 00 	movl   $0x0,0x8010c5c0
80103f03:	00 00 00 
 	int flag = holding(&ptable.lock); 
80103f06:	68 80 50 11 80       	push   $0x80115080
80103f0b:	e8 b0 1d 00 00       	call   80105cc0 <holding>
	if (!flag)
80103f10:	83 c4 10             	add    $0x10,%esp
80103f13:	85 c0                	test   %eax,%eax
 	int flag = holding(&ptable.lock); 
80103f15:	89 45 dc             	mov    %eax,-0x24(%ebp)
	if (!flag)
80103f18:	0f 84 e2 01 00 00    	je     80104100 <priority_boost+0x220>
{
80103f1e:	b8 b4 50 11 80       	mov    $0x801150b4,%eax
80103f23:	90                   	nop
80103f24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (p->is_stride) {
80103f28:	8b 88 98 01 00 00    	mov    0x198(%eax),%ecx
80103f2e:	85 c9                	test   %ecx,%ecx
80103f30:	75 1e                	jne    80103f50 <priority_boost+0x70>
    if (p->lev == 0)
80103f32:	8b 90 90 01 00 00    	mov    0x190(%eax),%edx
80103f38:	85 d2                	test   %edx,%edx
80103f3a:	74 14                	je     80103f50 <priority_boost+0x70>
		p->lev = 0; 
80103f3c:	c7 80 90 01 00 00 00 	movl   $0x0,0x190(%eax)
80103f43:	00 00 00 
    p->tick_cnt = 0; 
80103f46:	c7 80 94 01 00 00 00 	movl   $0x0,0x194(%eax)
80103f4d:	00 00 00 
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103f50:	05 a8 01 00 00       	add    $0x1a8,%eax
80103f55:	3d b4 ba 11 80       	cmp    $0x8011bab4,%eax
80103f5a:	72 cc                	jb     80103f28 <priority_boost+0x48>
	return mlfq_proc.queue_front[lev] == mlfq_proc.queue_rear[lev];
80103f5c:	8b 3d 50 50 11 80    	mov    0x80115050,%edi
80103f62:	a1 44 50 11 80       	mov    0x80115044,%eax
	if(is_empty(lev)) {
80103f67:	39 c7                	cmp    %eax,%edi
	return mlfq_proc.queue_front[lev] == mlfq_proc.queue_rear[lev];
80103f69:	89 7d e4             	mov    %edi,-0x1c(%ebp)
	if(is_empty(lev)) {
80103f6c:	0f 84 a3 00 00 00    	je     80104015 <priority_boost+0x135>
	mlfq_proc.queue_front[lev] = ((mlfq_proc.queue_front[lev] + 1) % NPROC);
80103f72:	83 c0 01             	add    $0x1,%eax
80103f75:	83 e0 3f             	and    $0x3f,%eax
	return mlfq_proc.queue[lev][mlfq_proc.queue_front[lev]];
80103f78:	8b 1c 85 40 4e 11 80 	mov    -0x7feeb1c0(,%eax,4),%ebx
	mlfq_proc.queue_front[lev] = ((mlfq_proc.queue_front[lev] + 1) % NPROC);
80103f7f:	a3 44 50 11 80       	mov    %eax,0x80115044
    if (!(p = dequeue(1))) { 
80103f84:	85 db                	test   %ebx,%ebx
80103f86:	0f 84 89 00 00 00    	je     80104015 <priority_boost+0x135>
	return mlfq_proc.queue_front[lev] == ((mlfq_proc.queue_rear[lev] + 1) % NPROC);
80103f8c:	8b 3d 4c 50 11 80    	mov    0x8011504c,%edi
80103f92:	8b 35 40 50 11 80    	mov    0x80115040,%esi
80103f98:	8d 4f 01             	lea    0x1(%edi),%ecx
80103f9b:	83 e1 3f             	and    $0x3f,%ecx
	if (is_full(lev))
80103f9e:	39 ce                	cmp    %ecx,%esi
80103fa0:	0f 84 7a 01 00 00    	je     80104120 <priority_boost+0x240>
80103fa6:	31 ff                	xor    %edi,%edi
80103fa8:	eb 2c                	jmp    80103fd6 <priority_boost+0xf6>
80103faa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	mlfq_proc.queue_front[lev] = ((mlfq_proc.queue_front[lev] + 1) % NPROC);
80103fb0:	83 c0 01             	add    $0x1,%eax
80103fb3:	83 e0 3f             	and    $0x3f,%eax
	return mlfq_proc.queue[lev][mlfq_proc.queue_front[lev]];
80103fb6:	8b 1c 85 40 4e 11 80 	mov    -0x7feeb1c0(,%eax,4),%ebx
    if (!(p = dequeue(1))) { 
80103fbd:	85 db                	test   %ebx,%ebx
80103fbf:	74 49                	je     8010400a <priority_boost+0x12a>
	return mlfq_proc.queue_front[lev] == ((mlfq_proc.queue_rear[lev] + 1) % NPROC);
80103fc1:	8d 51 01             	lea    0x1(%ecx),%edx
80103fc4:	bf 01 00 00 00       	mov    $0x1,%edi
80103fc9:	83 e2 3f             	and    $0x3f,%edx
	if (is_full(lev))
80103fcc:	39 f2                	cmp    %esi,%edx
80103fce:	0f 84 41 01 00 00    	je     80104115 <priority_boost+0x235>
80103fd4:	89 d1                	mov    %edx,%ecx
	if(is_empty(lev)) {
80103fd6:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
	mlfq_proc.queue[lev][mlfq_proc.queue_rear[lev]] = proc;
80103fd9:	89 1c 8d 40 4d 11 80 	mov    %ebx,-0x7feeb2c0(,%ecx,4)
	if(is_empty(lev)) {
80103fe0:	75 ce                	jne    80103fb0 <priority_boost+0xd0>
80103fe2:	89 f8                	mov    %edi,%eax
80103fe4:	89 0d 4c 50 11 80    	mov    %ecx,0x8011504c
80103fea:	84 c0                	test   %al,%al
80103fec:	74 27                	je     80104015 <priority_boost+0x135>
80103fee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
	return mlfq_proc.queue_front[lev] == mlfq_proc.queue_rear[lev];
80103ff1:	8b 35 54 50 11 80    	mov    0x80115054,%esi
80103ff7:	a3 44 50 11 80       	mov    %eax,0x80115044
80103ffc:	a1 48 50 11 80       	mov    0x80115048,%eax
	if(is_empty(lev)) {
80104001:	39 f0                	cmp    %esi,%eax
80104003:	75 1f                	jne    80104024 <priority_boost+0x144>
80104005:	e9 a3 00 00 00       	jmp    801040ad <priority_boost+0x1cd>
8010400a:	89 0d 4c 50 11 80    	mov    %ecx,0x8011504c
80104010:	a3 44 50 11 80       	mov    %eax,0x80115044
	return mlfq_proc.queue_front[lev] == mlfq_proc.queue_rear[lev];
80104015:	a1 48 50 11 80       	mov    0x80115048,%eax
8010401a:	8b 35 54 50 11 80    	mov    0x80115054,%esi
	if(is_empty(lev)) {
80104020:	39 f0                	cmp    %esi,%eax
80104022:	74 7e                	je     801040a2 <priority_boost+0x1c2>
	mlfq_proc.queue_front[lev] = ((mlfq_proc.queue_front[lev] + 1) % NPROC);
80104024:	83 c0 01             	add    $0x1,%eax
80104027:	83 e0 3f             	and    $0x3f,%eax
	return mlfq_proc.queue[lev][mlfq_proc.queue_front[lev]];
8010402a:	8b 1c 85 40 4f 11 80 	mov    -0x7feeb0c0(,%eax,4),%ebx
	mlfq_proc.queue_front[lev] = ((mlfq_proc.queue_front[lev] + 1) % NPROC);
80104031:	a3 48 50 11 80       	mov    %eax,0x80115048
    if (!(p = dequeue(2))) { 
80104036:	85 db                	test   %ebx,%ebx
80104038:	0f 84 99 00 00 00    	je     801040d7 <priority_boost+0x1f7>
	return mlfq_proc.queue_front[lev] == ((mlfq_proc.queue_rear[lev] + 1) % NPROC);
8010403e:	8b 0d 4c 50 11 80    	mov    0x8011504c,%ecx
80104044:	8b 3d 40 50 11 80    	mov    0x80115040,%edi
8010404a:	83 c1 01             	add    $0x1,%ecx
8010404d:	89 7d e0             	mov    %edi,-0x20(%ebp)
80104050:	83 e1 3f             	and    $0x3f,%ecx
	if (is_full(lev))
80104053:	39 f9                	cmp    %edi,%ecx
80104055:	0f 84 c5 00 00 00    	je     80104120 <priority_boost+0x240>
8010405b:	31 ff                	xor    %edi,%edi
8010405d:	eb 28                	jmp    80104087 <priority_boost+0x1a7>
8010405f:	90                   	nop
	mlfq_proc.queue_front[lev] = ((mlfq_proc.queue_front[lev] + 1) % NPROC);
80104060:	83 c0 01             	add    $0x1,%eax
80104063:	83 e0 3f             	and    $0x3f,%eax
	return mlfq_proc.queue[lev][mlfq_proc.queue_front[lev]];
80104066:	8b 1c 85 40 4f 11 80 	mov    -0x7feeb0c0(,%eax,4),%ebx
    if (!(p = dequeue(2))) { 
8010406d:	85 db                	test   %ebx,%ebx
8010406f:	74 5b                	je     801040cc <priority_boost+0x1ec>
	return mlfq_proc.queue_front[lev] == ((mlfq_proc.queue_rear[lev] + 1) % NPROC);
80104071:	8d 51 01             	lea    0x1(%ecx),%edx
80104074:	bf 01 00 00 00       	mov    $0x1,%edi
80104079:	83 e2 3f             	and    $0x3f,%edx
	if (is_full(lev))
8010407c:	3b 55 e0             	cmp    -0x20(%ebp),%edx
8010407f:	0f 84 a8 00 00 00    	je     8010412d <priority_boost+0x24d>
80104085:	89 d1                	mov    %edx,%ecx
	if(is_empty(lev)) {
80104087:	39 f0                	cmp    %esi,%eax
	mlfq_proc.queue[lev][mlfq_proc.queue_rear[lev]] = proc;
80104089:	89 1c 8d 40 4d 11 80 	mov    %ebx,-0x7feeb2c0(,%ecx,4)
	if(is_empty(lev)) {
80104090:	75 ce                	jne    80104060 <priority_boost+0x180>
80104092:	89 fb                	mov    %edi,%ebx
80104094:	84 db                	test   %bl,%bl
80104096:	0f 85 ab 00 00 00    	jne    80104147 <priority_boost+0x267>
8010409c:	89 0d 4c 50 11 80    	mov    %ecx,0x8011504c
	if (mlfq_proc.queue_front[1] != mlfq_proc.queue_rear[1] ||
801040a2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801040a5:	3b 05 44 50 11 80    	cmp    0x80115044,%eax
801040ab:	75 3d                	jne    801040ea <priority_boost+0x20a>
	if (!flag)
801040ad:	8b 45 dc             	mov    -0x24(%ebp),%eax
801040b0:	85 c0                	test   %eax,%eax
801040b2:	75 10                	jne    801040c4 <priority_boost+0x1e4>
		release(&ptable.lock);
801040b4:	83 ec 0c             	sub    $0xc,%esp
801040b7:	68 80 50 11 80       	push   $0x80115080
801040bc:	e8 ef 1c 00 00       	call   80105db0 <release>
801040c1:	83 c4 10             	add    $0x10,%esp
}
801040c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040c7:	5b                   	pop    %ebx
801040c8:	5e                   	pop    %esi
801040c9:	5f                   	pop    %edi
801040ca:	5d                   	pop    %ebp
801040cb:	c3                   	ret    
801040cc:	a3 48 50 11 80       	mov    %eax,0x80115048
801040d1:	89 0d 4c 50 11 80    	mov    %ecx,0x8011504c
	if (mlfq_proc.queue_front[1] != mlfq_proc.queue_rear[1] ||
801040d7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801040da:	39 05 44 50 11 80    	cmp    %eax,0x80115044
801040e0:	75 08                	jne    801040ea <priority_boost+0x20a>
801040e2:	39 35 48 50 11 80    	cmp    %esi,0x80115048
801040e8:	74 c3                	je     801040ad <priority_boost+0x1cd>
		panic("panic in priority boost().");
801040ea:	83 ec 0c             	sub    $0xc,%esp
801040ed:	68 5c 91 10 80       	push   $0x8010915c
801040f2:	e8 99 c2 ff ff       	call   80100390 <panic>
801040f7:	89 f6                	mov    %esi,%esi
801040f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  	acquire(&ptable.lock);
80104100:	83 ec 0c             	sub    $0xc,%esp
80104103:	68 80 50 11 80       	push   $0x80115080
80104108:	e8 e3 1b 00 00       	call   80105cf0 <acquire>
8010410d:	83 c4 10             	add    $0x10,%esp
80104110:	e9 09 fe ff ff       	jmp    80103f1e <priority_boost+0x3e>
80104115:	89 0d 4c 50 11 80    	mov    %ecx,0x8011504c
8010411b:	a3 44 50 11 80       	mov    %eax,0x80115044
		panic("Queue is already full");
80104120:	83 ec 0c             	sub    $0xc,%esp
80104123:	68 2e 91 10 80       	push   $0x8010912e
80104128:	e8 63 c2 ff ff       	call   80100390 <panic>
8010412d:	a3 48 50 11 80       	mov    %eax,0x80115048
80104132:	89 0d 4c 50 11 80    	mov    %ecx,0x8011504c
80104138:	eb e6                	jmp    80104120 <priority_boost+0x240>
    panic("panic in priority boost");
8010413a:	83 ec 0c             	sub    $0xc,%esp
8010413d:	68 44 91 10 80       	push   $0x80109144
80104142:	e8 49 c2 ff ff       	call   80100390 <panic>
80104147:	a3 48 50 11 80       	mov    %eax,0x80115048
8010414c:	e9 4b ff ff ff       	jmp    8010409c <priority_boost+0x1bc>
80104151:	eb 0d                	jmp    80104160 <pinit>
80104153:	90                   	nop
80104154:	90                   	nop
80104155:	90                   	nop
80104156:	90                   	nop
80104157:	90                   	nop
80104158:	90                   	nop
80104159:	90                   	nop
8010415a:	90                   	nop
8010415b:	90                   	nop
8010415c:	90                   	nop
8010415d:	90                   	nop
8010415e:	90                   	nop
8010415f:	90                   	nop

80104160 <pinit>:
{
80104160:	55                   	push   %ebp
80104161:	89 e5                	mov    %esp,%ebp
80104163:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80104166:	68 77 91 10 80       	push   $0x80109177
8010416b:	68 80 50 11 80       	push   $0x80115080
80104170:	e8 3b 1a 00 00       	call   80105bb0 <initlock>
}
80104175:	83 c4 10             	add    $0x10,%esp
80104178:	c9                   	leave  
80104179:	c3                   	ret    
8010417a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104180 <mycpu>:
{
80104180:	55                   	push   %ebp
80104181:	89 e5                	mov    %esp,%ebp
80104183:	56                   	push   %esi
80104184:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104185:	9c                   	pushf  
80104186:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104187:	f6 c4 02             	test   $0x2,%ah
8010418a:	75 5e                	jne    801041ea <mycpu+0x6a>
  apicid = lapicid();
8010418c:	e8 2f eb ff ff       	call   80102cc0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80104191:	8b 35 20 4d 11 80    	mov    0x80114d20,%esi
80104197:	85 f6                	test   %esi,%esi
80104199:	7e 42                	jle    801041dd <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
8010419b:	0f b6 15 a0 47 11 80 	movzbl 0x801147a0,%edx
801041a2:	39 d0                	cmp    %edx,%eax
801041a4:	74 30                	je     801041d6 <mycpu+0x56>
801041a6:	b9 50 48 11 80       	mov    $0x80114850,%ecx
  for (i = 0; i < ncpu; ++i) {
801041ab:	31 d2                	xor    %edx,%edx
801041ad:	8d 76 00             	lea    0x0(%esi),%esi
801041b0:	83 c2 01             	add    $0x1,%edx
801041b3:	39 f2                	cmp    %esi,%edx
801041b5:	74 26                	je     801041dd <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
801041b7:	0f b6 19             	movzbl (%ecx),%ebx
801041ba:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
801041c0:	39 c3                	cmp    %eax,%ebx
801041c2:	75 ec                	jne    801041b0 <mycpu+0x30>
801041c4:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
801041ca:	05 a0 47 11 80       	add    $0x801147a0,%eax
}
801041cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801041d2:	5b                   	pop    %ebx
801041d3:	5e                   	pop    %esi
801041d4:	5d                   	pop    %ebp
801041d5:	c3                   	ret    
    if (cpus[i].apicid == apicid)
801041d6:	b8 a0 47 11 80       	mov    $0x801147a0,%eax
      return &cpus[i];
801041db:	eb f2                	jmp    801041cf <mycpu+0x4f>
  panic("unknown apicid\n");
801041dd:	83 ec 0c             	sub    $0xc,%esp
801041e0:	68 7e 91 10 80       	push   $0x8010917e
801041e5:	e8 a6 c1 ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
801041ea:	83 ec 0c             	sub    $0xc,%esp
801041ed:	68 c8 92 10 80       	push   $0x801092c8
801041f2:	e8 99 c1 ff ff       	call   80100390 <panic>
801041f7:	89 f6                	mov    %esi,%esi
801041f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104200 <cpuid>:
cpuid() {
80104200:	55                   	push   %ebp
80104201:	89 e5                	mov    %esp,%ebp
80104203:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80104206:	e8 75 ff ff ff       	call   80104180 <mycpu>
8010420b:	2d a0 47 11 80       	sub    $0x801147a0,%eax
}
80104210:	c9                   	leave  
  return mycpu()-cpus;
80104211:	c1 f8 04             	sar    $0x4,%eax
80104214:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010421a:	c3                   	ret    
8010421b:	90                   	nop
8010421c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104220 <getlev>:
{
80104220:	55                   	push   %ebp
80104221:	89 e5                	mov    %esp,%ebp
80104223:	53                   	push   %ebx
80104224:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104227:	e8 f4 19 00 00       	call   80105c20 <pushcli>
  c = mycpu();
8010422c:	e8 4f ff ff ff       	call   80104180 <mycpu>
  p = c->proc;
80104231:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104237:	e8 24 1a 00 00       	call   80105c60 <popcli>
	return myproc()->lev;
8010423c:	8b 83 90 01 00 00    	mov    0x190(%ebx),%eax
}
80104242:	83 c4 04             	add    $0x4,%esp
80104245:	5b                   	pop    %ebx
80104246:	5d                   	pop    %ebp
80104247:	c3                   	ret    
80104248:	90                   	nop
80104249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104250 <set_cpu_share>:
{
80104250:	55                   	push   %ebp
80104251:	89 e5                	mov    %esp,%ebp
80104253:	57                   	push   %edi
80104254:	56                   	push   %esi
80104255:	53                   	push   %ebx
80104256:	83 ec 0c             	sub    $0xc,%esp
80104259:	8b 5d 08             	mov    0x8(%ebp),%ebx
	if (ticket + total_stride_ticket > MAX_STRIDE_TICKET)
8010425c:	a1 bc c5 10 80       	mov    0x8010c5bc,%eax
80104261:	01 d8                	add    %ebx,%eax
80104263:	83 f8 50             	cmp    $0x50,%eax
80104266:	0f 87 c4 00 00 00    	ja     80104330 <set_cpu_share+0xe0>
	acquire(&ptable.lock);
8010426c:	83 ec 0c             	sub    $0xc,%esp
8010426f:	68 80 50 11 80       	push   $0x80115080
80104274:	e8 77 1a 00 00       	call   80105cf0 <acquire>
	if (ticket + total_stride_ticket > MAX_STRIDE_TICKET) {
80104279:	a1 bc c5 10 80       	mov    0x8010c5bc,%eax
8010427e:	83 c4 10             	add    $0x10,%esp
80104281:	01 d8                	add    %ebx,%eax
80104283:	83 f8 50             	cmp    $0x50,%eax
80104286:	0f 87 b4 00 00 00    	ja     80104340 <set_cpu_share+0xf0>
	p->stride = LARGENUM / ticket;
8010428c:	be 10 27 00 00       	mov    $0x2710,%esi
  pushcli();
80104291:	e8 8a 19 00 00       	call   80105c20 <pushcli>
  c = mycpu();
80104296:	e8 e5 fe ff ff       	call   80104180 <mycpu>
  p = c->proc;
8010429b:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
801042a1:	e8 ba 19 00 00       	call   80105c60 <popcli>
	p->stride = LARGENUM / ticket;
801042a6:	89 f0                	mov    %esi,%eax
	havestride++;	
801042a8:	83 05 b8 c5 10 80 01 	addl   $0x1,0x8010c5b8
	total_stride_ticket += ticket;
801042af:	01 1d bc c5 10 80    	add    %ebx,0x8010c5bc
	p->stride = LARGENUM / ticket;
801042b5:	99                   	cltd   
	p->lev = -1;
801042b6:	c7 87 90 01 00 00 ff 	movl   $0xffffffff,0x190(%edi)
801042bd:	ff ff ff 
	p->tick_cnt = 0;
801042c0:	c7 87 94 01 00 00 00 	movl   $0x0,0x194(%edi)
801042c7:	00 00 00 
	p->stride = LARGENUM / ticket;
801042ca:	f7 fb                	idiv   %ebx
	p->is_stride = 1;
801042cc:	c7 87 98 01 00 00 01 	movl   $0x1,0x198(%edi)
801042d3:	00 00 00 
	p->ticket = ticket;
801042d6:	89 9f a4 01 00 00    	mov    %ebx,0x1a4(%edi)
	p->stride = LARGENUM / ticket;
801042dc:	89 87 9c 01 00 00    	mov    %eax,0x19c(%edi)
	p->pass_value = get_min_pass();
801042e2:	e8 a9 f8 ff ff       	call   80103b90 <get_min_pass>
801042e7:	89 87 a0 01 00 00    	mov    %eax,0x1a0(%edi)
	mlfq_proc.mlfq_ticket -= ticket;
801042ed:	8b 0d 60 50 11 80    	mov    0x80115060,%ecx
	mlfq_proc.mlfq_stride = LARGENUM / mlfq_proc.mlfq_ticket;
801042f3:	31 d2                	xor    %edx,%edx
801042f5:	89 f0                	mov    %esi,%eax
	mlfq_proc.mlfq_ticket -= ticket;
801042f7:	29 d9                	sub    %ebx,%ecx
	mlfq_proc.mlfq_stride = LARGENUM / mlfq_proc.mlfq_ticket;
801042f9:	f7 f1                	div    %ecx
	mlfq_proc.mlfq_ticket -= ticket;
801042fb:	89 0d 60 50 11 80    	mov    %ecx,0x80115060
	if (mlfq_proc.mlfq_ticket + total_stride_ticket != TOTAL_TICKET)
80104301:	03 0d bc c5 10 80    	add    0x8010c5bc,%ecx
80104307:	83 f9 64             	cmp    $0x64,%ecx
	mlfq_proc.mlfq_stride = LARGENUM / mlfq_proc.mlfq_ticket;
8010430a:	a3 5c 50 11 80       	mov    %eax,0x8011505c
	if (mlfq_proc.mlfq_ticket + total_stride_ticket != TOTAL_TICKET)
8010430f:	75 46                	jne    80104357 <set_cpu_share+0x107>
	release(&ptable.lock);
80104311:	83 ec 0c             	sub    $0xc,%esp
80104314:	68 80 50 11 80       	push   $0x80115080
80104319:	e8 92 1a 00 00       	call   80105db0 <release>
	return 0;
8010431e:	83 c4 10             	add    $0x10,%esp
80104321:	31 c0                	xor    %eax,%eax
}
80104323:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104326:	5b                   	pop    %ebx
80104327:	5e                   	pop    %esi
80104328:	5f                   	pop    %edi
80104329:	5d                   	pop    %ebp
8010432a:	c3                   	ret    
8010432b:	90                   	nop
8010432c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		return -1;
80104330:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104335:	eb ec                	jmp    80104323 <set_cpu_share+0xd3>
80104337:	89 f6                	mov    %esi,%esi
80104339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		release(&ptable.lock);
80104340:	83 ec 0c             	sub    $0xc,%esp
80104343:	68 80 50 11 80       	push   $0x80115080
80104348:	e8 63 1a 00 00       	call   80105db0 <release>
		return -1;
8010434d:	83 c4 10             	add    $0x10,%esp
80104350:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104355:	eb cc                	jmp    80104323 <set_cpu_share+0xd3>
		panic("panic in set_cpu_share().");
80104357:	83 ec 0c             	sub    $0xc,%esp
8010435a:	68 8e 91 10 80       	push   $0x8010918e
8010435f:	e8 2c c0 ff ff       	call   80100390 <panic>
80104364:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010436a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104370 <myproc>:
myproc(void) {
80104370:	55                   	push   %ebp
80104371:	89 e5                	mov    %esp,%ebp
80104373:	53                   	push   %ebx
80104374:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104377:	e8 a4 18 00 00       	call   80105c20 <pushcli>
  c = mycpu();
8010437c:	e8 ff fd ff ff       	call   80104180 <mycpu>
  p = c->proc;
80104381:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104387:	e8 d4 18 00 00       	call   80105c60 <popcli>
}
8010438c:	83 c4 04             	add    $0x4,%esp
8010438f:	89 d8                	mov    %ebx,%eax
80104391:	5b                   	pop    %ebx
80104392:	5d                   	pop    %ebp
80104393:	c3                   	ret    
80104394:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010439a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801043a0 <userinit>:
{
801043a0:	55                   	push   %ebp
801043a1:	89 e5                	mov    %esp,%ebp
801043a3:	53                   	push   %ebx
801043a4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
801043a7:	e8 04 f9 ff ff       	call   80103cb0 <allocproc>
801043ac:	89 c3                	mov    %eax,%ebx
  initproc = p;
801043ae:	a3 c4 c5 10 80       	mov    %eax,0x8010c5c4
  if((p->pgdir = setupkvm()) == 0)
801043b3:	e8 68 45 00 00       	call   80108920 <setupkvm>
801043b8:	85 c0                	test   %eax,%eax
801043ba:	89 43 04             	mov    %eax,0x4(%ebx)
801043bd:	0f 84 32 01 00 00    	je     801044f5 <userinit+0x155>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801043c3:	83 ec 04             	sub    $0x4,%esp
801043c6:	68 2c 00 00 00       	push   $0x2c
801043cb:	68 60 c4 10 80       	push   $0x8010c460
801043d0:	50                   	push   %eax
801043d1:	e8 2a 42 00 00       	call   80108600 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
801043d6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
801043d9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801043df:	6a 4c                	push   $0x4c
801043e1:	6a 00                	push   $0x0
801043e3:	ff 73 18             	pushl  0x18(%ebx)
801043e6:	e8 15 1a 00 00       	call   80105e00 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801043eb:	8b 43 18             	mov    0x18(%ebx),%eax
801043ee:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801043f3:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
801043f8:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801043fb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801043ff:	8b 43 18             	mov    0x18(%ebx),%eax
80104402:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80104406:	8b 43 18             	mov    0x18(%ebx),%eax
80104409:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010440d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104411:	8b 43 18             	mov    0x18(%ebx),%eax
80104414:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104418:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010441c:	8b 43 18             	mov    0x18(%ebx),%eax
8010441f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104426:	8b 43 18             	mov    0x18(%ebx),%eax
80104429:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80104430:	8b 43 18             	mov    0x18(%ebx),%eax
80104433:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
8010443a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010443d:	6a 10                	push   $0x10
8010443f:	68 c1 91 10 80       	push   $0x801091c1
80104444:	50                   	push   %eax
80104445:	e8 96 1b 00 00       	call   80105fe0 <safestrcpy>
  p->cwd = namei("/");
8010444a:	c7 04 24 ca 91 10 80 	movl   $0x801091ca,(%esp)
80104451:	e8 1a e0 ff ff       	call   80102470 <namei>
	p->lev = 0;
80104456:	c7 83 90 01 00 00 00 	movl   $0x0,0x190(%ebx)
8010445d:	00 00 00 
  p->cwd = namei("/");
80104460:	89 43 68             	mov    %eax,0x68(%ebx)
	p->tick_cnt = 0;
80104463:	c7 83 94 01 00 00 00 	movl   $0x0,0x194(%ebx)
8010446a:	00 00 00 
	p->is_stride = 0;
8010446d:	c7 83 98 01 00 00 00 	movl   $0x0,0x198(%ebx)
80104474:	00 00 00 
	p->stride = 0;
80104477:	c7 83 9c 01 00 00 00 	movl   $0x0,0x19c(%ebx)
8010447e:	00 00 00 
	p->pass_value = 0;
80104481:	c7 83 a0 01 00 00 00 	movl   $0x0,0x1a0(%ebx)
80104488:	00 00 00 
	p->ticket = 0;
8010448b:	c7 83 a4 01 00 00 00 	movl   $0x0,0x1a4(%ebx)
80104492:	00 00 00 
  acquire(&ptable.lock);
80104495:	c7 04 24 80 50 11 80 	movl   $0x80115080,(%esp)
8010449c:	e8 4f 18 00 00       	call   80105cf0 <acquire>
	enqueue(p->lev, p);
801044a1:	8b 93 90 01 00 00    	mov    0x190(%ebx),%edx
  p->state = RUNNABLE;
801044a7:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
	if (is_full(lev))
801044ae:	83 c4 10             	add    $0x10,%esp
	return mlfq_proc.queue_front[lev] == ((mlfq_proc.queue_rear[lev] + 1) % NPROC);
801044b1:	8d 8a c0 00 00 00    	lea    0xc0(%edx),%ecx
801044b7:	8b 04 8d 4c 4d 11 80 	mov    -0x7feeb2b4(,%ecx,4),%eax
801044be:	83 c0 01             	add    $0x1,%eax
801044c1:	83 e0 3f             	and    $0x3f,%eax
	if (is_full(lev))
801044c4:	39 04 8d 40 4d 11 80 	cmp    %eax,-0x7feeb2c0(,%ecx,4)
801044cb:	74 35                	je     80104502 <userinit+0x162>
  release(&ptable.lock);
801044cd:	83 ec 0c             	sub    $0xc,%esp
	mlfq_proc.queue[lev][mlfq_proc.queue_rear[lev]] = proc;
801044d0:	c1 e2 06             	shl    $0x6,%edx
	mlfq_proc.queue_rear[lev] = ((mlfq_proc.queue_rear[lev] + 1) % NPROC);
801044d3:	89 04 8d 4c 4d 11 80 	mov    %eax,-0x7feeb2b4(,%ecx,4)
  release(&ptable.lock);
801044da:	68 80 50 11 80       	push   $0x80115080
	mlfq_proc.queue[lev][mlfq_proc.queue_rear[lev]] = proc;
801044df:	01 d0                	add    %edx,%eax
801044e1:	89 1c 85 40 4d 11 80 	mov    %ebx,-0x7feeb2c0(,%eax,4)
  release(&ptable.lock);
801044e8:	e8 c3 18 00 00       	call   80105db0 <release>
}
801044ed:	83 c4 10             	add    $0x10,%esp
801044f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044f3:	c9                   	leave  
801044f4:	c3                   	ret    
    panic("userinit: out of memory?");
801044f5:	83 ec 0c             	sub    $0xc,%esp
801044f8:	68 a8 91 10 80       	push   $0x801091a8
801044fd:	e8 8e be ff ff       	call   80100390 <panic>
		panic("Queue is already full");
80104502:	83 ec 0c             	sub    $0xc,%esp
80104505:	68 2e 91 10 80       	push   $0x8010912e
8010450a:	e8 81 be ff ff       	call   80100390 <panic>
8010450f:	90                   	nop

80104510 <growproc>:
{
80104510:	55                   	push   %ebp
80104511:	89 e5                	mov    %esp,%ebp
80104513:	56                   	push   %esi
80104514:	53                   	push   %ebx
80104515:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80104518:	e8 03 17 00 00       	call   80105c20 <pushcli>
  c = mycpu();
8010451d:	e8 5e fc ff ff       	call   80104180 <mycpu>
  p = c->proc;
80104522:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104528:	e8 33 17 00 00       	call   80105c60 <popcli>
  if(n > 0){
8010452d:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80104530:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80104532:	7f 1c                	jg     80104550 <growproc+0x40>
  } else if(n < 0){
80104534:	75 3a                	jne    80104570 <growproc+0x60>
  switchuvm(curproc);
80104536:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80104539:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
8010453b:	53                   	push   %ebx
8010453c:	e8 af 3f 00 00       	call   801084f0 <switchuvm>
  return 0;
80104541:	83 c4 10             	add    $0x10,%esp
80104544:	31 c0                	xor    %eax,%eax
}
80104546:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104549:	5b                   	pop    %ebx
8010454a:	5e                   	pop    %esi
8010454b:	5d                   	pop    %ebp
8010454c:	c3                   	ret    
8010454d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104550:	83 ec 04             	sub    $0x4,%esp
80104553:	01 c6                	add    %eax,%esi
80104555:	56                   	push   %esi
80104556:	50                   	push   %eax
80104557:	ff 73 04             	pushl  0x4(%ebx)
8010455a:	e8 e1 41 00 00       	call   80108740 <allocuvm>
8010455f:	83 c4 10             	add    $0x10,%esp
80104562:	85 c0                	test   %eax,%eax
80104564:	75 d0                	jne    80104536 <growproc+0x26>
      return -1;
80104566:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010456b:	eb d9                	jmp    80104546 <growproc+0x36>
8010456d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104570:	83 ec 04             	sub    $0x4,%esp
80104573:	01 c6                	add    %eax,%esi
80104575:	56                   	push   %esi
80104576:	50                   	push   %eax
80104577:	ff 73 04             	pushl  0x4(%ebx)
8010457a:	e8 f1 42 00 00       	call   80108870 <deallocuvm>
8010457f:	83 c4 10             	add    $0x10,%esp
80104582:	85 c0                	test   %eax,%eax
80104584:	75 b0                	jne    80104536 <growproc+0x26>
80104586:	eb de                	jmp    80104566 <growproc+0x56>
80104588:	90                   	nop
80104589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104590 <fork>:
{
80104590:	55                   	push   %ebp
80104591:	89 e5                	mov    %esp,%ebp
80104593:	57                   	push   %edi
80104594:	56                   	push   %esi
80104595:	53                   	push   %ebx
80104596:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80104599:	e8 82 16 00 00       	call   80105c20 <pushcli>
  c = mycpu();
8010459e:	e8 dd fb ff ff       	call   80104180 <mycpu>
  p = c->proc;
801045a3:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
801045a9:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  popcli();
801045ac:	e8 af 16 00 00       	call   80105c60 <popcli>
  if((np = allocproc()) == 0){
801045b1:	e8 fa f6 ff ff       	call   80103cb0 <allocproc>
801045b6:	85 c0                	test   %eax,%eax
801045b8:	0f 84 4b 01 00 00    	je     80104709 <fork+0x179>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
801045be:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801045c1:	83 ec 08             	sub    $0x8,%esp
801045c4:	89 c3                	mov    %eax,%ebx
801045c6:	ff 32                	pushl  (%edx)
801045c8:	ff 72 04             	pushl  0x4(%edx)
801045cb:	e8 20 44 00 00       	call   801089f0 <copyuvm>
801045d0:	83 c4 10             	add    $0x10,%esp
801045d3:	85 c0                	test   %eax,%eax
801045d5:	89 43 04             	mov    %eax,0x4(%ebx)
801045d8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801045db:	0f 84 2f 01 00 00    	je     80104710 <fork+0x180>
  np->sz = curproc->sz;
801045e1:	8b 02                	mov    (%edx),%eax
  *np->tf = *curproc->tf;
801045e3:	8b 7b 18             	mov    0x18(%ebx),%edi
801045e6:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->parent = curproc;
801045eb:	89 53 14             	mov    %edx,0x14(%ebx)
  np->sz = curproc->sz;
801045ee:	89 03                	mov    %eax,(%ebx)
  *np->tf = *curproc->tf;
801045f0:	8b 72 18             	mov    0x18(%edx),%esi
801045f3:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
801045f5:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
801045f7:	8b 43 18             	mov    0x18(%ebx),%eax
801045fa:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80104601:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
80104608:	8b 44 b2 28          	mov    0x28(%edx,%esi,4),%eax
8010460c:	85 c0                	test   %eax,%eax
8010460e:	74 16                	je     80104626 <fork+0x96>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104610:	83 ec 0c             	sub    $0xc,%esp
80104613:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80104616:	50                   	push   %eax
80104617:	e8 d4 c7 ff ff       	call   80100df0 <filedup>
8010461c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010461f:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
80104623:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NOFILE; i++)
80104626:	83 c6 01             	add    $0x1,%esi
80104629:	83 fe 10             	cmp    $0x10,%esi
8010462c:	75 da                	jne    80104608 <fork+0x78>
  np->cwd = idup(curproc->cwd);
8010462e:	83 ec 0c             	sub    $0xc,%esp
80104631:	ff 72 68             	pushl  0x68(%edx)
80104634:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80104637:	e8 64 d3 ff ff       	call   801019a0 <idup>
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010463c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  np->cwd = idup(curproc->cwd);
8010463f:	89 43 68             	mov    %eax,0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104642:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104645:	83 c4 0c             	add    $0xc,%esp
80104648:	6a 10                	push   $0x10
8010464a:	83 c2 6c             	add    $0x6c,%edx
8010464d:	52                   	push   %edx
8010464e:	50                   	push   %eax
8010464f:	e8 8c 19 00 00       	call   80105fe0 <safestrcpy>
  np->d_storage.size=0;
80104654:	c7 83 8c 01 00 00 00 	movl   $0x0,0x18c(%ebx)
8010465b:	00 00 00 
	np->lev = 0;
8010465e:	c7 83 90 01 00 00 00 	movl   $0x0,0x190(%ebx)
80104665:	00 00 00 
	np->tick_cnt = 0;
80104668:	c7 83 94 01 00 00 00 	movl   $0x0,0x194(%ebx)
8010466f:	00 00 00 
	np->is_stride = 0;
80104672:	c7 83 98 01 00 00 00 	movl   $0x0,0x198(%ebx)
80104679:	00 00 00 
	np->stride = 0;
8010467c:	c7 83 9c 01 00 00 00 	movl   $0x0,0x19c(%ebx)
80104683:	00 00 00 
	np->pass_value = 0;
80104686:	c7 83 a0 01 00 00 00 	movl   $0x0,0x1a0(%ebx)
8010468d:	00 00 00 
	np->ticket = 0;
80104690:	c7 83 a4 01 00 00 00 	movl   $0x0,0x1a4(%ebx)
80104697:	00 00 00 
	np->tid = 0;
8010469a:	c7 43 7c 00 00 00 00 	movl   $0x0,0x7c(%ebx)
  pid = np->pid;
801046a1:	8b 73 10             	mov    0x10(%ebx),%esi
  acquire(&ptable.lock);
801046a4:	c7 04 24 80 50 11 80 	movl   $0x80115080,(%esp)
801046ab:	e8 40 16 00 00       	call   80105cf0 <acquire>
	enqueue(np->lev, np);
801046b0:	8b 93 90 01 00 00    	mov    0x190(%ebx),%edx
  np->state = RUNNABLE;
801046b6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
	if (is_full(lev))
801046bd:	83 c4 10             	add    $0x10,%esp
	return mlfq_proc.queue_front[lev] == ((mlfq_proc.queue_rear[lev] + 1) % NPROC);
801046c0:	8d 8a c0 00 00 00    	lea    0xc0(%edx),%ecx
801046c6:	8b 04 8d 4c 4d 11 80 	mov    -0x7feeb2b4(,%ecx,4),%eax
801046cd:	83 c0 01             	add    $0x1,%eax
801046d0:	83 e0 3f             	and    $0x3f,%eax
	if (is_full(lev))
801046d3:	39 04 8d 40 4d 11 80 	cmp    %eax,-0x7feeb2c0(,%ecx,4)
801046da:	74 57                	je     80104733 <fork+0x1a3>
  release(&ptable.lock);
801046dc:	83 ec 0c             	sub    $0xc,%esp
	mlfq_proc.queue[lev][mlfq_proc.queue_rear[lev]] = proc;
801046df:	c1 e2 06             	shl    $0x6,%edx
	mlfq_proc.queue_rear[lev] = ((mlfq_proc.queue_rear[lev] + 1) % NPROC);
801046e2:	89 04 8d 4c 4d 11 80 	mov    %eax,-0x7feeb2b4(,%ecx,4)
  release(&ptable.lock);
801046e9:	68 80 50 11 80       	push   $0x80115080
	mlfq_proc.queue[lev][mlfq_proc.queue_rear[lev]] = proc;
801046ee:	01 d0                	add    %edx,%eax
801046f0:	89 1c 85 40 4d 11 80 	mov    %ebx,-0x7feeb2c0(,%eax,4)
  release(&ptable.lock);
801046f7:	e8 b4 16 00 00       	call   80105db0 <release>
  return pid;
801046fc:	83 c4 10             	add    $0x10,%esp
}
801046ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104702:	89 f0                	mov    %esi,%eax
80104704:	5b                   	pop    %ebx
80104705:	5e                   	pop    %esi
80104706:	5f                   	pop    %edi
80104707:	5d                   	pop    %ebp
80104708:	c3                   	ret    
    return -1;
80104709:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010470e:	eb ef                	jmp    801046ff <fork+0x16f>
    kfree(np->kstack);
80104710:	83 ec 0c             	sub    $0xc,%esp
80104713:	ff 73 08             	pushl  0x8(%ebx)
    return -1;
80104716:	be ff ff ff ff       	mov    $0xffffffff,%esi
    kfree(np->kstack);
8010471b:	e8 80 e1 ff ff       	call   801028a0 <kfree>
    np->kstack = 0;
80104720:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80104727:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
8010472e:	83 c4 10             	add    $0x10,%esp
80104731:	eb cc                	jmp    801046ff <fork+0x16f>
		panic("Queue is already full");
80104733:	83 ec 0c             	sub    $0xc,%esp
80104736:	68 2e 91 10 80       	push   $0x8010912e
8010473b:	e8 50 bc ff ff       	call   80100390 <panic>

80104740 <scheduler>:
{
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
80104743:	57                   	push   %edi
80104744:	56                   	push   %esi
80104745:	53                   	push   %ebx
80104746:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80104749:	e8 32 fa ff ff       	call   80104180 <mycpu>
			swtch(&(c->scheduler), p->context);
8010474e:	8d 70 04             	lea    0x4(%eax),%esi
  struct cpu *c = mycpu();
80104751:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
80104753:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
8010475a:	00 00 00 
8010475d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80104760:	fb                   	sti    
    acquire(&ptable.lock);
80104761:	83 ec 0c             	sub    $0xc,%esp
	for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104764:	bf b4 50 11 80       	mov    $0x801150b4,%edi
    acquire(&ptable.lock);
80104769:	68 80 50 11 80       	push   $0x80115080
8010476e:	e8 7d 15 00 00       	call   80105cf0 <acquire>
		min_pass = get_min_pass();
80104773:	e8 18 f4 ff ff       	call   80103b90 <get_min_pass>
		if (min_pass == mlfq_proc.mlfq_pass) {
80104778:	8b 15 58 50 11 80    	mov    0x80115058,%edx
8010477e:	83 c4 10             	add    $0x10,%esp
80104781:	39 c2                	cmp    %eax,%edx
80104783:	75 1d                	jne    801047a2 <scheduler+0x62>
80104785:	e9 8e 00 00 00       	jmp    80104818 <scheduler+0xd8>
8010478a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104790:	81 c7 a8 01 00 00    	add    $0x1a8,%edi
80104796:	81 ff b4 ba 11 80    	cmp    $0x8011bab4,%edi
8010479c:	0f 83 53 01 00 00    	jae    801048f5 <scheduler+0x1b5>
		if (p->state != RUNNABLE || !p->is_stride || p->pass_value != min_pass)
801047a2:	83 7f 0c 03          	cmpl   $0x3,0xc(%edi)
801047a6:	75 e8                	jne    80104790 <scheduler+0x50>
801047a8:	8b 8f 98 01 00 00    	mov    0x198(%edi),%ecx
801047ae:	85 c9                	test   %ecx,%ecx
801047b0:	74 de                	je     80104790 <scheduler+0x50>
801047b2:	3b 87 a0 01 00 00    	cmp    0x1a0(%edi),%eax
801047b8:	75 d6                	jne    80104790 <scheduler+0x50>
		if (mlfq_proc.mlfq_pass >= MAX_PASS && min_pass >= MAX_PASS) {
801047ba:	81 fa fe ff ff 0f    	cmp    $0xffffffe,%edx
801047c0:	76 0b                	jbe    801047cd <scheduler+0x8d>
801047c2:	3d fe ff ff 0f       	cmp    $0xffffffe,%eax
801047c7:	0f 87 eb 00 00 00    	ja     801048b8 <scheduler+0x178>
			switchuvm(p);
801047cd:	83 ec 0c             	sub    $0xc,%esp
			c->proc = p;
801047d0:	89 bb ac 00 00 00    	mov    %edi,0xac(%ebx)
			switchuvm(p);
801047d6:	57                   	push   %edi
801047d7:	e8 14 3d 00 00       	call   801084f0 <switchuvm>
			p->state = RUNNING;
801047dc:	c7 47 0c 04 00 00 00 	movl   $0x4,0xc(%edi)
			swtch(&(c->scheduler), p->context);
801047e3:	58                   	pop    %eax
801047e4:	5a                   	pop    %edx
801047e5:	ff 77 1c             	pushl  0x1c(%edi)
801047e8:	56                   	push   %esi
801047e9:	e8 4d 18 00 00       	call   8010603b <swtch>
			switchkvm();
801047ee:	e8 dd 3c 00 00       	call   801084d0 <switchkvm>
			c->proc = 0;
801047f3:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
801047fa:	00 00 00 
    release(&ptable.lock);
801047fd:	c7 04 24 80 50 11 80 	movl   $0x80115080,(%esp)
80104804:	e8 a7 15 00 00       	call   80105db0 <release>
80104809:	83 c4 10             	add    $0x10,%esp
8010480c:	e9 4f ff ff ff       	jmp    80104760 <scheduler+0x20>
80104811:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	return mlfq_proc.queue_front[lev] == mlfq_proc.queue_rear[lev];
80104818:	8b 0d 40 50 11 80    	mov    0x80115040,%ecx
	if(is_empty(lev)) {
8010481e:	3b 0d 4c 50 11 80    	cmp    0x8011504c,%ecx
80104824:	74 1b                	je     80104841 <scheduler+0x101>
	mlfq_proc.queue_front[lev] = ((mlfq_proc.queue_front[lev] + 1) % NPROC);
80104826:	83 c1 01             	add    $0x1,%ecx
80104829:	83 e1 3f             	and    $0x3f,%ecx
	return mlfq_proc.queue[lev][mlfq_proc.queue_front[lev]];
8010482c:	8b 3c 8d 40 4d 11 80 	mov    -0x7feeb2c0(,%ecx,4),%edi
	mlfq_proc.queue_front[lev] = ((mlfq_proc.queue_front[lev] + 1) % NPROC);
80104833:	89 0d 40 50 11 80    	mov    %ecx,0x80115040
		if (!(p = dequeue(lev))) {
80104839:	85 ff                	test   %edi,%edi
8010483b:	0f 85 79 ff ff ff    	jne    801047ba <scheduler+0x7a>
	return mlfq_proc.queue_front[lev] == mlfq_proc.queue_rear[lev];
80104841:	8b 0d 44 50 11 80    	mov    0x80115044,%ecx
	if(is_empty(lev)) {
80104847:	3b 0d 50 50 11 80    	cmp    0x80115050,%ecx
8010484d:	74 1b                	je     8010486a <scheduler+0x12a>
	mlfq_proc.queue_front[lev] = ((mlfq_proc.queue_front[lev] + 1) % NPROC);
8010484f:	83 c1 01             	add    $0x1,%ecx
80104852:	83 e1 3f             	and    $0x3f,%ecx
	return mlfq_proc.queue[lev][mlfq_proc.queue_front[lev]];
80104855:	8b 3c 8d 40 4e 11 80 	mov    -0x7feeb1c0(,%ecx,4),%edi
	mlfq_proc.queue_front[lev] = ((mlfq_proc.queue_front[lev] + 1) % NPROC);
8010485c:	89 0d 44 50 11 80    	mov    %ecx,0x80115044
		if (!(p = dequeue(lev))) {
80104862:	85 ff                	test   %edi,%edi
80104864:	0f 85 50 ff ff ff    	jne    801047ba <scheduler+0x7a>
	return mlfq_proc.queue_front[lev] == mlfq_proc.queue_rear[lev];
8010486a:	8b 0d 48 50 11 80    	mov    0x80115048,%ecx
	if(is_empty(lev)) {
80104870:	3b 0d 54 50 11 80    	cmp    0x80115054,%ecx
80104876:	74 1b                	je     80104893 <scheduler+0x153>
	mlfq_proc.queue_front[lev] = ((mlfq_proc.queue_front[lev] + 1) % NPROC);
80104878:	83 c1 01             	add    $0x1,%ecx
8010487b:	83 e1 3f             	and    $0x3f,%ecx
	return mlfq_proc.queue[lev][mlfq_proc.queue_front[lev]];
8010487e:	8b 3c 8d 40 4f 11 80 	mov    -0x7feeb0c0(,%ecx,4),%edi
	mlfq_proc.queue_front[lev] = ((mlfq_proc.queue_front[lev] + 1) % NPROC);
80104885:	89 0d 48 50 11 80    	mov    %ecx,0x80115048
		if (!(p = dequeue(lev))) {
8010488b:	85 ff                	test   %edi,%edi
8010488d:	0f 85 27 ff ff ff    	jne    801047ba <scheduler+0x7a>
	mlfq_proc.mlfq_pass += mlfq_proc.mlfq_stride;
80104893:	03 05 5c 50 11 80    	add    0x8011505c,%eax
				release(&ptable.lock);
80104899:	83 ec 0c             	sub    $0xc,%esp
8010489c:	68 80 50 11 80       	push   $0x80115080
	mlfq_proc.mlfq_pass += mlfq_proc.mlfq_stride;
801048a1:	a3 58 50 11 80       	mov    %eax,0x80115058
				release(&ptable.lock);
801048a6:	e8 05 15 00 00       	call   80105db0 <release>
	asm volatile("hlt");
801048ab:	f4                   	hlt    
				continue;
801048ac:	83 c4 10             	add    $0x10,%esp
801048af:	e9 ac fe ff ff       	jmp    80104760 <scheduler+0x20>
801048b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	mlfq_proc.mlfq_pass = 0 ;
801048b8:	c7 05 58 50 11 80 00 	movl   $0x0,0x80115058
801048bf:	00 00 00 
	for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801048c2:	b8 b4 50 11 80       	mov    $0x801150b4,%eax
801048c7:	89 f6                	mov    %esi,%esi
801048c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		if (p->stride)
801048d0:	8b 88 9c 01 00 00    	mov    0x19c(%eax),%ecx
801048d6:	85 c9                	test   %ecx,%ecx
801048d8:	74 0a                	je     801048e4 <scheduler+0x1a4>
			p->pass_value = 0;
801048da:	c7 80 a0 01 00 00 00 	movl   $0x0,0x1a0(%eax)
801048e1:	00 00 00 
	for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801048e4:	05 a8 01 00 00       	add    $0x1a8,%eax
801048e9:	3d b4 ba 11 80       	cmp    $0x8011bab4,%eax
801048ee:	72 e0                	jb     801048d0 <scheduler+0x190>
801048f0:	e9 d8 fe ff ff       	jmp    801047cd <scheduler+0x8d>
	panic("panic in find_stride_proc().");
801048f5:	83 ec 0c             	sub    $0xc,%esp
801048f8:	68 cc 91 10 80       	push   $0x801091cc
801048fd:	e8 8e ba ff ff       	call   80100390 <panic>
80104902:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104910 <sched>:
{
80104910:	55                   	push   %ebp
80104911:	89 e5                	mov    %esp,%ebp
80104913:	56                   	push   %esi
80104914:	53                   	push   %ebx
  pushcli();
80104915:	e8 06 13 00 00       	call   80105c20 <pushcli>
  c = mycpu();
8010491a:	e8 61 f8 ff ff       	call   80104180 <mycpu>
  p = c->proc;
8010491f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104925:	e8 36 13 00 00       	call   80105c60 <popcli>
  if(!holding(&ptable.lock))
8010492a:	83 ec 0c             	sub    $0xc,%esp
8010492d:	68 80 50 11 80       	push   $0x80115080
80104932:	e8 89 13 00 00       	call   80105cc0 <holding>
80104937:	83 c4 10             	add    $0x10,%esp
8010493a:	85 c0                	test   %eax,%eax
8010493c:	74 4f                	je     8010498d <sched+0x7d>
  if(mycpu()->ncli != 1)
8010493e:	e8 3d f8 ff ff       	call   80104180 <mycpu>
80104943:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010494a:	75 68                	jne    801049b4 <sched+0xa4>
  if(p->state == RUNNING)
8010494c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104950:	74 55                	je     801049a7 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104952:	9c                   	pushf  
80104953:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104954:	f6 c4 02             	test   $0x2,%ah
80104957:	75 41                	jne    8010499a <sched+0x8a>
  intena = mycpu()->intena;
80104959:	e8 22 f8 ff ff       	call   80104180 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
8010495e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104961:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104967:	e8 14 f8 ff ff       	call   80104180 <mycpu>
8010496c:	83 ec 08             	sub    $0x8,%esp
8010496f:	ff 70 04             	pushl  0x4(%eax)
80104972:	53                   	push   %ebx
80104973:	e8 c3 16 00 00       	call   8010603b <swtch>
  mycpu()->intena = intena;
80104978:	e8 03 f8 ff ff       	call   80104180 <mycpu>
}
8010497d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104980:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104986:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104989:	5b                   	pop    %ebx
8010498a:	5e                   	pop    %esi
8010498b:	5d                   	pop    %ebp
8010498c:	c3                   	ret    
    panic("sched ptable.lock");
8010498d:	83 ec 0c             	sub    $0xc,%esp
80104990:	68 e9 91 10 80       	push   $0x801091e9
80104995:	e8 f6 b9 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
8010499a:	83 ec 0c             	sub    $0xc,%esp
8010499d:	68 15 92 10 80       	push   $0x80109215
801049a2:	e8 e9 b9 ff ff       	call   80100390 <panic>
    panic("sched running");
801049a7:	83 ec 0c             	sub    $0xc,%esp
801049aa:	68 07 92 10 80       	push   $0x80109207
801049af:	e8 dc b9 ff ff       	call   80100390 <panic>
    panic("sched locks");
801049b4:	83 ec 0c             	sub    $0xc,%esp
801049b7:	68 fb 91 10 80       	push   $0x801091fb
801049bc:	e8 cf b9 ff ff       	call   80100390 <panic>
801049c1:	eb 0d                	jmp    801049d0 <yield>
801049c3:	90                   	nop
801049c4:	90                   	nop
801049c5:	90                   	nop
801049c6:	90                   	nop
801049c7:	90                   	nop
801049c8:	90                   	nop
801049c9:	90                   	nop
801049ca:	90                   	nop
801049cb:	90                   	nop
801049cc:	90                   	nop
801049cd:	90                   	nop
801049ce:	90                   	nop
801049cf:	90                   	nop

801049d0 <yield>:
{
801049d0:	55                   	push   %ebp
801049d1:	89 e5                	mov    %esp,%ebp
801049d3:	53                   	push   %ebx
801049d4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801049d7:	68 80 50 11 80       	push   $0x80115080
801049dc:	e8 0f 13 00 00       	call   80105cf0 <acquire>
  pushcli();
801049e1:	e8 3a 12 00 00       	call   80105c20 <pushcli>
  c = mycpu();
801049e6:	e8 95 f7 ff ff       	call   80104180 <mycpu>
  p = c->proc;
801049eb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801049f1:	e8 6a 12 00 00       	call   80105c60 <popcli>
  myproc()->state = RUNNABLE;
801049f6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  pushcli();
801049fd:	e8 1e 12 00 00       	call   80105c20 <pushcli>
  c = mycpu();
80104a02:	e8 79 f7 ff ff       	call   80104180 <mycpu>
  p = c->proc;
80104a07:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104a0d:	e8 4e 12 00 00       	call   80105c60 <popcli>
	if(!p->is_stride)
80104a12:	83 c4 10             	add    $0x10,%esp
80104a15:	8b 83 98 01 00 00    	mov    0x198(%ebx),%eax
80104a1b:	85 c0                	test   %eax,%eax
80104a1d:	74 59                	je     80104a78 <yield+0xa8>
	if (boost_tick >= BOOST_LIMIT) {
80104a1f:	81 3d c0 c5 10 80 c7 	cmpl   $0xc7,0x8010c5c0
80104a26:	00 00 00 
80104a29:	0f 86 e1 00 00 00    	jbe    80104b10 <yield+0x140>
		priority_boost();
80104a2f:	e8 ac f4 ff ff       	call   80103ee0 <priority_boost>
	p->tick_cnt += 1;
80104a34:	8b 8b 94 01 00 00    	mov    0x194(%ebx),%ecx
80104a3a:	8b 83 98 01 00 00    	mov    0x198(%ebx),%eax
80104a40:	8d 51 01             	lea    0x1(%ecx),%edx
	if (p->is_stride) {
80104a43:	85 c0                	test   %eax,%eax
	p->tick_cnt += 1;
80104a45:	89 93 94 01 00 00    	mov    %edx,0x194(%ebx)
	if (p->is_stride) {
80104a4b:	74 4e                	je     80104a9b <yield+0xcb>
		p->pass_value += p->stride;
80104a4d:	8b 83 9c 01 00 00    	mov    0x19c(%ebx),%eax
80104a53:	01 83 a0 01 00 00    	add    %eax,0x1a0(%ebx)
  sched();
80104a59:	e8 b2 fe ff ff       	call   80104910 <sched>
  release(&ptable.lock);
80104a5e:	83 ec 0c             	sub    $0xc,%esp
80104a61:	68 80 50 11 80       	push   $0x80115080
80104a66:	e8 45 13 00 00       	call   80105db0 <release>
}
80104a6b:	31 c0                	xor    %eax,%eax
80104a6d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a70:	c9                   	leave  
80104a71:	c3                   	ret    
80104a72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		boost_tick += 1;
80104a78:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
80104a7d:	83 c0 01             	add    $0x1,%eax
	if (boost_tick >= BOOST_LIMIT) {
80104a80:	3d c7 00 00 00       	cmp    $0xc7,%eax
		boost_tick += 1;
80104a85:	a3 c0 c5 10 80       	mov    %eax,0x8010c5c0
	if (boost_tick >= BOOST_LIMIT) {
80104a8a:	77 a3                	ja     80104a2f <yield+0x5f>
	p->tick_cnt += 1;
80104a8c:	8b 83 94 01 00 00    	mov    0x194(%ebx),%eax
80104a92:	8d 50 01             	lea    0x1(%eax),%edx
80104a95:	89 93 94 01 00 00    	mov    %edx,0x194(%ebx)
		if (p->lev < MAX_MLFQ_LEV - 1 && p->tick_cnt >= TIME_ALLOTMENT[p->lev]) {
80104a9b:	8b 83 90 01 00 00    	mov    0x190(%ebx),%eax
80104aa1:	83 f8 01             	cmp    $0x1,%eax
80104aa4:	7e 4a                	jle    80104af0 <yield+0x120>
		} else if (p->lev == MAX_MLFQ_LEV - 1 && p->tick_cnt >= TIME_QUANTUM[p->lev]) {
80104aa6:	83 f8 02             	cmp    $0x2,%eax
80104aa9:	75 05                	jne    80104ab0 <yield+0xe0>
80104aab:	83 fa 13             	cmp    $0x13,%edx
80104aae:	77 70                	ja     80104b20 <yield+0x150>
	return mlfq_proc.queue_front[lev] == ((mlfq_proc.queue_rear[lev] + 1) % NPROC);
80104ab0:	8d 88 c0 00 00 00    	lea    0xc0(%eax),%ecx
80104ab6:	8b 14 8d 4c 4d 11 80 	mov    -0x7feeb2b4(,%ecx,4),%edx
80104abd:	83 c2 01             	add    $0x1,%edx
80104ac0:	83 e2 3f             	and    $0x3f,%edx
	if (is_full(lev))
80104ac3:	39 14 8d 40 4d 11 80 	cmp    %edx,-0x7feeb2c0(,%ecx,4)
80104aca:	74 63                	je     80104b2f <yield+0x15f>
	mlfq_proc.queue[lev][mlfq_proc.queue_rear[lev]] = proc;
80104acc:	c1 e0 06             	shl    $0x6,%eax
	mlfq_proc.queue_rear[lev] = ((mlfq_proc.queue_rear[lev] + 1) % NPROC);
80104acf:	89 14 8d 4c 4d 11 80 	mov    %edx,-0x7feeb2b4(,%ecx,4)
	mlfq_proc.queue[lev][mlfq_proc.queue_rear[lev]] = proc;
80104ad6:	01 d0                	add    %edx,%eax
80104ad8:	89 1c 85 40 4d 11 80 	mov    %ebx,-0x7feeb2c0(,%eax,4)
	mlfq_proc.mlfq_pass += mlfq_proc.mlfq_stride;
80104adf:	a1 5c 50 11 80       	mov    0x8011505c,%eax
80104ae4:	01 05 58 50 11 80    	add    %eax,0x80115058
80104aea:	e9 6a ff ff ff       	jmp    80104a59 <yield+0x89>
80104aef:	90                   	nop
		if (p->lev < MAX_MLFQ_LEV - 1 && p->tick_cnt >= TIME_ALLOTMENT[p->lev]) {
80104af0:	39 14 85 08 93 10 80 	cmp    %edx,-0x7fef6cf8(,%eax,4)
80104af7:	77 b7                	ja     80104ab0 <yield+0xe0>
			p->lev++;
80104af9:	83 c0 01             	add    $0x1,%eax
			p->tick_cnt = 0;
80104afc:	c7 83 94 01 00 00 00 	movl   $0x0,0x194(%ebx)
80104b03:	00 00 00 
			p->lev++;
80104b06:	89 83 90 01 00 00    	mov    %eax,0x190(%ebx)
			p->tick_cnt = 0;
80104b0c:	eb a2                	jmp    80104ab0 <yield+0xe0>
80104b0e:	66 90                	xchg   %ax,%ax
	p->tick_cnt += 1;
80104b10:	83 83 94 01 00 00 01 	addl   $0x1,0x194(%ebx)
80104b17:	e9 31 ff ff ff       	jmp    80104a4d <yield+0x7d>
80104b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
			p->tick_cnt = 0;
80104b20:	c7 83 94 01 00 00 00 	movl   $0x0,0x194(%ebx)
80104b27:	00 00 00 
80104b2a:	e9 81 ff ff ff       	jmp    80104ab0 <yield+0xe0>
		panic("Queue is already full");
80104b2f:	83 ec 0c             	sub    $0xc,%esp
80104b32:	68 2e 91 10 80       	push   $0x8010912e
80104b37:	e8 54 b8 ff ff       	call   80100390 <panic>
80104b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104b40 <exit>:
{
80104b40:	55                   	push   %ebp
80104b41:	89 e5                	mov    %esp,%ebp
80104b43:	57                   	push   %edi
80104b44:	56                   	push   %esi
80104b45:	53                   	push   %ebx
80104b46:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80104b49:	e8 d2 10 00 00       	call   80105c20 <pushcli>
  c = mycpu();
80104b4e:	e8 2d f6 ff ff       	call   80104180 <mycpu>
  p = c->proc;
80104b53:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104b59:	e8 02 11 00 00       	call   80105c60 <popcli>
  if(curproc == initproc)
80104b5e:	39 1d c4 c5 10 80    	cmp    %ebx,0x8010c5c4
80104b64:	0f 84 ee 01 00 00    	je     80104d58 <exit+0x218>
  if(curproc->lwpGroupid != 0){ //lwp or process have lwp ,not general process
80104b6a:	8b 8b 80 00 00 00    	mov    0x80(%ebx),%ecx
80104b70:	85 c9                	test   %ecx,%ecx
80104b72:	0f 84 e8 00 00 00    	je     80104c60 <exit+0x120>
	for(p = ptable.proc ; p < &ptable.proc[NPROC]; p++){
80104b78:	bf b4 50 11 80       	mov    $0x801150b4,%edi
80104b7d:	eb 13                	jmp    80104b92 <exit+0x52>
80104b7f:	90                   	nop
80104b80:	81 c7 a8 01 00 00    	add    $0x1a8,%edi
80104b86:	81 ff b4 ba 11 80    	cmp    $0x8011bab4,%edi
80104b8c:	0f 83 ce 00 00 00    	jae    80104c60 <exit+0x120>
	  if(p->lwpGroupid == curproc->lwpGroupid && p != curproc){ //all thread in same lwpGroupid
80104b92:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax
80104b98:	39 87 80 00 00 00    	cmp    %eax,0x80(%edi)
80104b9e:	75 e0                	jne    80104b80 <exit+0x40>
80104ba0:	39 fb                	cmp    %edi,%ebx
80104ba2:	74 dc                	je     80104b80 <exit+0x40>
80104ba4:	8d 47 68             	lea    0x68(%edi),%eax
80104ba7:	8d 77 28             	lea    0x28(%edi),%esi
80104baa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104bad:	8d 76 00             	lea    0x0(%esi),%esi
			if(p->ofile[fd]){
80104bb0:	8b 16                	mov    (%esi),%edx
80104bb2:	85 d2                	test   %edx,%edx
80104bb4:	74 12                	je     80104bc8 <exit+0x88>
				fileclose(p->ofile[fd]);
80104bb6:	83 ec 0c             	sub    $0xc,%esp
80104bb9:	52                   	push   %edx
80104bba:	e8 81 c2 ff ff       	call   80100e40 <fileclose>
				p->ofile[fd] = 0;
80104bbf:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80104bc5:	83 c4 10             	add    $0x10,%esp
80104bc8:	83 c6 04             	add    $0x4,%esi
		for(fd =0; fd < NOFILE; fd++){
80104bcb:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
80104bce:	75 e0                	jne    80104bb0 <exit+0x70>
		begin_op();
80104bd0:	e8 5b e5 ff ff       	call   80103130 <begin_op>
		iput(p->cwd);
80104bd5:	83 ec 0c             	sub    $0xc,%esp
80104bd8:	ff 77 68             	pushl  0x68(%edi)
80104bdb:	e8 20 cf ff ff       	call   80101b00 <iput>
		end_op();
80104be0:	e8 bb e5 ff ff       	call   801031a0 <end_op>
		if (p->is_stride) { //dequeue from StrideQ
80104be5:	8b 97 98 01 00 00    	mov    0x198(%edi),%edx
80104beb:	83 c4 10             	add    $0x10,%esp
		p->cwd = 0;
80104bee:	c7 47 68 00 00 00 00 	movl   $0x0,0x68(%edi)
		if (p->is_stride) { //dequeue from StrideQ
80104bf5:	85 d2                	test   %edx,%edx
80104bf7:	74 2d                	je     80104c26 <exit+0xe6>
			total_stride_ticket -= p->ticket;
80104bf9:	8b b7 a4 01 00 00    	mov    0x1a4(%edi),%esi
80104bff:	29 35 bc c5 10 80    	sub    %esi,0x8010c5bc
			mlfq_proc.mlfq_stride = LARGENUM / mlfq_proc.mlfq_ticket;
80104c05:	b8 10 27 00 00       	mov    $0x2710,%eax
			mlfq_proc.mlfq_ticket += p->ticket;
80104c0a:	03 35 60 50 11 80    	add    0x80115060,%esi
			mlfq_proc.mlfq_stride = LARGENUM / mlfq_proc.mlfq_ticket;
80104c10:	31 d2                	xor    %edx,%edx
			havestride--;
80104c12:	83 2d b8 c5 10 80 01 	subl   $0x1,0x8010c5b8
			mlfq_proc.mlfq_stride = LARGENUM / mlfq_proc.mlfq_ticket;
80104c19:	f7 f6                	div    %esi
			mlfq_proc.mlfq_ticket += p->ticket;
80104c1b:	89 35 60 50 11 80    	mov    %esi,0x80115060
			mlfq_proc.mlfq_stride = LARGENUM / mlfq_proc.mlfq_ticket;
80104c21:	a3 5c 50 11 80       	mov    %eax,0x8011505c
		acquire(&ptable.lock);
80104c26:	83 ec 0c             	sub    $0xc,%esp
	for(p = ptable.proc ; p < &ptable.proc[NPROC]; p++){
80104c29:	81 c7 a8 01 00 00    	add    $0x1a8,%edi
		acquire(&ptable.lock);
80104c2f:	68 80 50 11 80       	push   $0x80115080
80104c34:	e8 b7 10 00 00       	call   80105cf0 <acquire>
		p->state = ZOMBIE;
80104c39:	c7 87 64 fe ff ff 05 	movl   $0x5,-0x19c(%edi)
80104c40:	00 00 00 
		release(&ptable.lock);
80104c43:	c7 04 24 80 50 11 80 	movl   $0x80115080,(%esp)
80104c4a:	e8 61 11 00 00       	call   80105db0 <release>
80104c4f:	83 c4 10             	add    $0x10,%esp
	for(p = ptable.proc ; p < &ptable.proc[NPROC]; p++){
80104c52:	81 ff b4 ba 11 80    	cmp    $0x8011bab4,%edi
80104c58:	0f 82 34 ff ff ff    	jb     80104b92 <exit+0x52>
80104c5e:	66 90                	xchg   %ax,%ax
80104c60:	8d 73 28             	lea    0x28(%ebx),%esi
80104c63:	8d 7b 68             	lea    0x68(%ebx),%edi
80104c66:	8d 76 00             	lea    0x0(%esi),%esi
80104c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(curproc->ofile[fd]){
80104c70:	8b 06                	mov    (%esi),%eax
80104c72:	85 c0                	test   %eax,%eax
80104c74:	74 12                	je     80104c88 <exit+0x148>
      fileclose(curproc->ofile[fd]);
80104c76:	83 ec 0c             	sub    $0xc,%esp
80104c79:	50                   	push   %eax
80104c7a:	e8 c1 c1 ff ff       	call   80100e40 <fileclose>
      curproc->ofile[fd] = 0;
80104c7f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80104c85:	83 c4 10             	add    $0x10,%esp
80104c88:	83 c6 04             	add    $0x4,%esi
  for(fd = 0; fd < NOFILE; fd++){
80104c8b:	39 fe                	cmp    %edi,%esi
80104c8d:	75 e1                	jne    80104c70 <exit+0x130>
  begin_op();
80104c8f:	e8 9c e4 ff ff       	call   80103130 <begin_op>
  iput(curproc->cwd);
80104c94:	83 ec 0c             	sub    $0xc,%esp
80104c97:	ff 73 68             	pushl  0x68(%ebx)
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c9a:	be b4 50 11 80       	mov    $0x801150b4,%esi
  iput(curproc->cwd);
80104c9f:	e8 5c ce ff ff       	call   80101b00 <iput>
  end_op();
80104ca4:	e8 f7 e4 ff ff       	call   801031a0 <end_op>
  curproc->cwd = 0;
80104ca9:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80104cb0:	c7 04 24 80 50 11 80 	movl   $0x80115080,(%esp)
80104cb7:	e8 34 10 00 00       	call   80105cf0 <acquire>
  wakeup1(curproc->parent);
80104cbc:	8b 43 14             	mov    0x14(%ebx),%eax
80104cbf:	e8 3c ef ff ff       	call   80103c00 <wakeup1>
80104cc4:	83 c4 10             	add    $0x10,%esp
80104cc7:	eb 15                	jmp    80104cde <exit+0x19e>
80104cc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104cd0:	81 c6 a8 01 00 00    	add    $0x1a8,%esi
80104cd6:	81 fe b4 ba 11 80    	cmp    $0x8011bab4,%esi
80104cdc:	73 2a                	jae    80104d08 <exit+0x1c8>
	    if(p->parent == curproc){
80104cde:	39 5e 14             	cmp    %ebx,0x14(%esi)
80104ce1:	75 ed                	jne    80104cd0 <exit+0x190>
	      if(p->state == ZOMBIE)
80104ce3:	83 7e 0c 05          	cmpl   $0x5,0xc(%esi)
	      p->parent = initproc;
80104ce7:	a1 c4 c5 10 80       	mov    0x8010c5c4,%eax
80104cec:	89 46 14             	mov    %eax,0x14(%esi)
	      if(p->state == ZOMBIE)
80104cef:	75 df                	jne    80104cd0 <exit+0x190>
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104cf1:	81 c6 a8 01 00 00    	add    $0x1a8,%esi
	        wakeup1(initproc);
80104cf7:	e8 04 ef ff ff       	call   80103c00 <wakeup1>
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104cfc:	81 fe b4 ba 11 80    	cmp    $0x8011bab4,%esi
80104d02:	72 da                	jb     80104cde <exit+0x19e>
80104d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if (curproc->is_stride) { //dequeue from StrideQ
80104d08:	8b 83 98 01 00 00    	mov    0x198(%ebx),%eax
80104d0e:	85 c0                	test   %eax,%eax
80104d10:	74 2d                	je     80104d3f <exit+0x1ff>
		total_stride_ticket -= curproc->ticket;
80104d12:	8b 8b a4 01 00 00    	mov    0x1a4(%ebx),%ecx
80104d18:	29 0d bc c5 10 80    	sub    %ecx,0x8010c5bc
		mlfq_proc.mlfq_stride = LARGENUM / mlfq_proc.mlfq_ticket;
80104d1e:	b8 10 27 00 00       	mov    $0x2710,%eax
		mlfq_proc.mlfq_ticket += curproc->ticket;
80104d23:	03 0d 60 50 11 80    	add    0x80115060,%ecx
		mlfq_proc.mlfq_stride = LARGENUM / mlfq_proc.mlfq_ticket;
80104d29:	31 d2                	xor    %edx,%edx
		havestride--; //why?
80104d2b:	83 2d b8 c5 10 80 01 	subl   $0x1,0x8010c5b8
		mlfq_proc.mlfq_stride = LARGENUM / mlfq_proc.mlfq_ticket;
80104d32:	f7 f1                	div    %ecx
		mlfq_proc.mlfq_ticket += curproc->ticket;
80104d34:	89 0d 60 50 11 80    	mov    %ecx,0x80115060
		mlfq_proc.mlfq_stride = LARGENUM / mlfq_proc.mlfq_ticket;
80104d3a:	a3 5c 50 11 80       	mov    %eax,0x8011505c
	curproc->state = ZOMBIE;	
80104d3f:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
	sched();
80104d46:	e8 c5 fb ff ff       	call   80104910 <sched>
	panic("zombie exit");
80104d4b:	83 ec 0c             	sub    $0xc,%esp
80104d4e:	68 74 92 10 80       	push   $0x80109274
80104d53:	e8 38 b6 ff ff       	call   80100390 <panic>
    panic("init exiting");
80104d58:	83 ec 0c             	sub    $0xc,%esp
80104d5b:	68 29 92 10 80       	push   $0x80109229
80104d60:	e8 2b b6 ff ff       	call   80100390 <panic>
80104d65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d70 <tick_yield>:
{
80104d70:	55                   	push   %ebp
80104d71:	89 e5                	mov    %esp,%ebp
80104d73:	56                   	push   %esi
80104d74:	53                   	push   %ebx
  acquire(&ptable.lock);  //DOC: yieldlock
80104d75:	83 ec 0c             	sub    $0xc,%esp
80104d78:	68 80 50 11 80       	push   $0x80115080
80104d7d:	e8 6e 0f 00 00       	call   80105cf0 <acquire>
  pushcli();
80104d82:	e8 99 0e 00 00       	call   80105c20 <pushcli>
  c = mycpu();
80104d87:	e8 f4 f3 ff ff       	call   80104180 <mycpu>
  p = c->proc;
80104d8c:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104d92:	e8 c9 0e 00 00       	call   80105c60 <popcli>
  pushcli();
80104d97:	e8 84 0e 00 00       	call   80105c20 <pushcli>
  c = mycpu();
80104d9c:	e8 df f3 ff ff       	call   80104180 <mycpu>
  p = c->proc;
80104da1:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104da7:	e8 b4 0e 00 00       	call   80105c60 <popcli>
	if (!p->is_stride) {
80104dac:	83 c4 10             	add    $0x10,%esp
	myproc()->state = RUNNABLE;
80104daf:	c7 46 0c 03 00 00 00 	movl   $0x3,0xc(%esi)
	if (!p->is_stride) {
80104db6:	8b 83 98 01 00 00    	mov    0x198(%ebx),%eax
80104dbc:	85 c0                	test   %eax,%eax
80104dbe:	75 49                	jne    80104e09 <tick_yield+0x99>
		if (p->lev < MAX_MLFQ_LEV - 1 && p->tick_cnt >= TIME_ALLOTMENT[p->lev]) {
80104dc0:	8b 83 90 01 00 00    	mov    0x190(%ebx),%eax
80104dc6:	83 f8 01             	cmp    $0x1,%eax
80104dc9:	7e 5d                	jle    80104e28 <tick_yield+0xb8>
		} else if (p->lev == MAX_MLFQ_LEV - 1) {
80104dcb:	83 f8 02             	cmp    $0x2,%eax
80104dce:	75 0a                	jne    80104dda <tick_yield+0x6a>
			p->tick_cnt = 0;
80104dd0:	c7 83 94 01 00 00 00 	movl   $0x0,0x194(%ebx)
80104dd7:	00 00 00 
	return mlfq_proc.queue_front[lev] == ((mlfq_proc.queue_rear[lev] + 1) % NPROC);
80104dda:	8d 88 c0 00 00 00    	lea    0xc0(%eax),%ecx
80104de0:	8b 34 8d 4c 4d 11 80 	mov    -0x7feeb2b4(,%ecx,4),%esi
80104de7:	8d 56 01             	lea    0x1(%esi),%edx
80104dea:	83 e2 3f             	and    $0x3f,%edx
	if (is_full(lev))
80104ded:	39 14 8d 40 4d 11 80 	cmp    %edx,-0x7feeb2c0(,%ecx,4)
80104df4:	74 56                	je     80104e4c <tick_yield+0xdc>
	mlfq_proc.queue[lev][mlfq_proc.queue_rear[lev]] = proc;
80104df6:	c1 e0 06             	shl    $0x6,%eax
	mlfq_proc.queue_rear[lev] = ((mlfq_proc.queue_rear[lev] + 1) % NPROC);
80104df9:	89 14 8d 4c 4d 11 80 	mov    %edx,-0x7feeb2b4(,%ecx,4)
	mlfq_proc.queue[lev][mlfq_proc.queue_rear[lev]] = proc;
80104e00:	01 d0                	add    %edx,%eax
80104e02:	89 1c 85 40 4d 11 80 	mov    %ebx,-0x7feeb2c0(,%eax,4)
  sched();
80104e09:	e8 02 fb ff ff       	call   80104910 <sched>
  release(&ptable.lock);
80104e0e:	83 ec 0c             	sub    $0xc,%esp
80104e11:	68 80 50 11 80       	push   $0x80115080
80104e16:	e8 95 0f 00 00       	call   80105db0 <release>
}
80104e1b:	83 c4 10             	add    $0x10,%esp
80104e1e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e21:	5b                   	pop    %ebx
80104e22:	5e                   	pop    %esi
80104e23:	5d                   	pop    %ebp
80104e24:	c3                   	ret    
80104e25:	8d 76 00             	lea    0x0(%esi),%esi
		if (p->lev < MAX_MLFQ_LEV - 1 && p->tick_cnt >= TIME_ALLOTMENT[p->lev]) {
80104e28:	8b 0c 85 08 93 10 80 	mov    -0x7fef6cf8(,%eax,4),%ecx
80104e2f:	39 8b 94 01 00 00    	cmp    %ecx,0x194(%ebx)
80104e35:	72 a3                	jb     80104dda <tick_yield+0x6a>
			p->lev++;
80104e37:	83 c0 01             	add    $0x1,%eax
			p->tick_cnt = 0;
80104e3a:	c7 83 94 01 00 00 00 	movl   $0x0,0x194(%ebx)
80104e41:	00 00 00 
			p->lev++;
80104e44:	89 83 90 01 00 00    	mov    %eax,0x190(%ebx)
			p->tick_cnt = 0;
80104e4a:	eb 8e                	jmp    80104dda <tick_yield+0x6a>
		panic("Queue is already full");
80104e4c:	83 ec 0c             	sub    $0xc,%esp
80104e4f:	68 2e 91 10 80       	push   $0x8010912e
80104e54:	e8 37 b5 ff ff       	call   80100390 <panic>
80104e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104e60 <sleep>:
{
80104e60:	55                   	push   %ebp
80104e61:	89 e5                	mov    %esp,%ebp
80104e63:	57                   	push   %edi
80104e64:	56                   	push   %esi
80104e65:	53                   	push   %ebx
80104e66:	83 ec 0c             	sub    $0xc,%esp
80104e69:	8b 7d 08             	mov    0x8(%ebp),%edi
80104e6c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80104e6f:	e8 ac 0d 00 00       	call   80105c20 <pushcli>
  c = mycpu();
80104e74:	e8 07 f3 ff ff       	call   80104180 <mycpu>
  p = c->proc;
80104e79:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104e7f:	e8 dc 0d 00 00       	call   80105c60 <popcli>
  if(p == 0)
80104e84:	85 db                	test   %ebx,%ebx
80104e86:	0f 84 87 00 00 00    	je     80104f13 <sleep+0xb3>
  if(lk == 0)
80104e8c:	85 f6                	test   %esi,%esi
80104e8e:	74 76                	je     80104f06 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104e90:	81 fe 80 50 11 80    	cmp    $0x80115080,%esi
80104e96:	74 50                	je     80104ee8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104e98:	83 ec 0c             	sub    $0xc,%esp
80104e9b:	68 80 50 11 80       	push   $0x80115080
80104ea0:	e8 4b 0e 00 00       	call   80105cf0 <acquire>
    release(lk);
80104ea5:	89 34 24             	mov    %esi,(%esp)
80104ea8:	e8 03 0f 00 00       	call   80105db0 <release>
  p->chan = chan;
80104ead:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104eb0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104eb7:	e8 54 fa ff ff       	call   80104910 <sched>
  p->chan = 0;
80104ebc:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104ec3:	c7 04 24 80 50 11 80 	movl   $0x80115080,(%esp)
80104eca:	e8 e1 0e 00 00       	call   80105db0 <release>
    acquire(lk);
80104ecf:	89 75 08             	mov    %esi,0x8(%ebp)
80104ed2:	83 c4 10             	add    $0x10,%esp
}
80104ed5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ed8:	5b                   	pop    %ebx
80104ed9:	5e                   	pop    %esi
80104eda:	5f                   	pop    %edi
80104edb:	5d                   	pop    %ebp
    acquire(lk);
80104edc:	e9 0f 0e 00 00       	jmp    80105cf0 <acquire>
80104ee1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104ee8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104eeb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104ef2:	e8 19 fa ff ff       	call   80104910 <sched>
  p->chan = 0;
80104ef7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104efe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f01:	5b                   	pop    %ebx
80104f02:	5e                   	pop    %esi
80104f03:	5f                   	pop    %edi
80104f04:	5d                   	pop    %ebp
80104f05:	c3                   	ret    
    panic("sleep without lk");
80104f06:	83 ec 0c             	sub    $0xc,%esp
80104f09:	68 3c 92 10 80       	push   $0x8010923c
80104f0e:	e8 7d b4 ff ff       	call   80100390 <panic>
    panic("sleep");
80104f13:	83 ec 0c             	sub    $0xc,%esp
80104f16:	68 36 92 10 80       	push   $0x80109236
80104f1b:	e8 70 b4 ff ff       	call   80100390 <panic>

80104f20 <wait>:
{
80104f20:	55                   	push   %ebp
80104f21:	89 e5                	mov    %esp,%ebp
80104f23:	56                   	push   %esi
80104f24:	53                   	push   %ebx
  pushcli();
80104f25:	e8 f6 0c 00 00       	call   80105c20 <pushcli>
  c = mycpu();
80104f2a:	e8 51 f2 ff ff       	call   80104180 <mycpu>
  p = c->proc;
80104f2f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104f35:	e8 26 0d 00 00       	call   80105c60 <popcli>
  acquire(&ptable.lock);
80104f3a:	83 ec 0c             	sub    $0xc,%esp
80104f3d:	68 80 50 11 80       	push   $0x80115080
80104f42:	e8 a9 0d 00 00       	call   80105cf0 <acquire>
80104f47:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80104f4a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104f4c:	be b4 50 11 80       	mov    $0x801150b4,%esi
80104f51:	eb 13                	jmp    80104f66 <wait+0x46>
80104f53:	90                   	nop
80104f54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104f58:	81 c6 a8 01 00 00    	add    $0x1a8,%esi
80104f5e:	81 fe b4 ba 11 80    	cmp    $0x8011bab4,%esi
80104f64:	73 1e                	jae    80104f84 <wait+0x64>
      if(p->parent != curproc)
80104f66:	39 5e 14             	cmp    %ebx,0x14(%esi)
80104f69:	75 ed                	jne    80104f58 <wait+0x38>
      if(p->state == ZOMBIE){
80104f6b:	83 7e 0c 05          	cmpl   $0x5,0xc(%esi)
80104f6f:	74 3f                	je     80104fb0 <wait+0x90>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104f71:	81 c6 a8 01 00 00    	add    $0x1a8,%esi
      havekids = 1;
80104f77:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104f7c:	81 fe b4 ba 11 80    	cmp    $0x8011bab4,%esi
80104f82:	72 e2                	jb     80104f66 <wait+0x46>
    if(!havekids || curproc->killed){
80104f84:	85 c0                	test   %eax,%eax
80104f86:	0f 84 ca 01 00 00    	je     80105156 <wait+0x236>
80104f8c:	8b 43 24             	mov    0x24(%ebx),%eax
80104f8f:	85 c0                	test   %eax,%eax
80104f91:	0f 85 bf 01 00 00    	jne    80105156 <wait+0x236>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104f97:	83 ec 08             	sub    $0x8,%esp
80104f9a:	68 80 50 11 80       	push   $0x80115080
80104f9f:	53                   	push   %ebx
80104fa0:	e8 bb fe ff ff       	call   80104e60 <sleep>
    havekids = 0;
80104fa5:	83 c4 10             	add    $0x10,%esp
80104fa8:	eb a0                	jmp    80104f4a <wait+0x2a>
80104faa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		for(t = ptable.proc; t<&ptable.proc[NPROC]; t++){
80104fb0:	bb b4 50 11 80       	mov    $0x801150b4,%ebx
80104fb5:	eb 1b                	jmp    80104fd2 <wait+0xb2>
80104fb7:	89 f6                	mov    %esi,%esi
80104fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104fc0:	81 c3 a8 01 00 00    	add    $0x1a8,%ebx
80104fc6:	81 fb b4 ba 11 80    	cmp    $0x8011bab4,%ebx
80104fcc:	0f 83 c6 00 00 00    	jae    80105098 <wait+0x178>
			if(t->parent == p && t->state == ZOMBIE){
80104fd2:	39 73 14             	cmp    %esi,0x14(%ebx)
80104fd5:	75 e9                	jne    80104fc0 <wait+0xa0>
80104fd7:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104fdb:	75 e3                	jne    80104fc0 <wait+0xa0>
				kfree(t->kstack);
80104fdd:	83 ec 0c             	sub    $0xc,%esp
80104fe0:	ff 73 08             	pushl  0x8(%ebx)
		for(t = ptable.proc; t<&ptable.proc[NPROC]; t++){
80104fe3:	81 c3 a8 01 00 00    	add    $0x1a8,%ebx
				kfree(t->kstack);
80104fe9:	e8 b2 d8 ff ff       	call   801028a0 <kfree>
				deallocuvm(t->pgdir, t->lwpstack, t->lwpstack - 2*PGSIZE);
80104fee:	8b 83 dc fe ff ff    	mov    -0x124(%ebx),%eax
80104ff4:	83 c4 0c             	add    $0xc,%esp
				t->kstack = 0;
80104ff7:	c7 83 60 fe ff ff 00 	movl   $0x0,-0x1a0(%ebx)
80104ffe:	00 00 00 
				t->pid = 0;
80105001:	c7 83 68 fe ff ff 00 	movl   $0x0,-0x198(%ebx)
80105008:	00 00 00 
				t->parent = 0;
8010500b:	c7 83 6c fe ff ff 00 	movl   $0x0,-0x194(%ebx)
80105012:	00 00 00 
				t->name[0] = 0;
80105015:	c6 83 c4 fe ff ff 00 	movb   $0x0,-0x13c(%ebx)
				t->killed = 0;
8010501c:	c7 83 7c fe ff ff 00 	movl   $0x0,-0x184(%ebx)
80105023:	00 00 00 
				deallocuvm(t->pgdir, t->lwpstack, t->lwpstack - 2*PGSIZE);
80105026:	8d 90 00 e0 ff ff    	lea    -0x2000(%eax),%edx
				t->lev = 0;
8010502c:	c7 43 e8 00 00 00 00 	movl   $0x0,-0x18(%ebx)
				t->tick_cnt = 0;
80105033:	c7 43 ec 00 00 00 00 	movl   $0x0,-0x14(%ebx)
				t->is_stride = 0;
8010503a:	c7 43 f0 00 00 00 00 	movl   $0x0,-0x10(%ebx)
				t->pass_value = 0;
80105041:	c7 43 f8 00 00 00 00 	movl   $0x0,-0x8(%ebx)
				t->ticket = 0;
80105048:	c7 43 fc 00 00 00 00 	movl   $0x0,-0x4(%ebx)
				t->state = UNUSED;
8010504f:	c7 83 64 fe ff ff 00 	movl   $0x0,-0x19c(%ebx)
80105056:	00 00 00 
				t->lwpGroupid = 0;
80105059:	c7 83 d8 fe ff ff 00 	movl   $0x0,-0x128(%ebx)
80105060:	00 00 00 
				deallocuvm(t->pgdir, t->lwpstack, t->lwpstack - 2*PGSIZE);
80105063:	52                   	push   %edx
80105064:	50                   	push   %eax
80105065:	ff b3 5c fe ff ff    	pushl  -0x1a4(%ebx)
8010506b:	e8 00 38 00 00       	call   80108870 <deallocuvm>
				t->sz = 0;
80105070:	c7 83 58 fe ff ff 00 	movl   $0x0,-0x1a8(%ebx)
80105077:	00 00 00 
				t->lwpstack = 0;
8010507a:	c7 83 dc fe ff ff 00 	movl   $0x0,-0x124(%ebx)
80105081:	00 00 00 
80105084:	83 c4 10             	add    $0x10,%esp
		for(t = ptable.proc; t<&ptable.proc[NPROC]; t++){
80105087:	81 fb b4 ba 11 80    	cmp    $0x8011bab4,%ebx
8010508d:	0f 82 3f ff ff ff    	jb     80104fd2 <wait+0xb2>
80105093:	90                   	nop
80105094:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80105098:	83 ec 0c             	sub    $0xc,%esp
8010509b:	ff 76 08             	pushl  0x8(%esi)
        pid = p->pid;
8010509e:	8b 5e 10             	mov    0x10(%esi),%ebx
        kfree(p->kstack);
801050a1:	e8 fa d7 ff ff       	call   801028a0 <kfree>
        freevm(p->pgdir);
801050a6:	5a                   	pop    %edx
801050a7:	ff 76 04             	pushl  0x4(%esi)
        p->kstack = 0;
801050aa:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
        freevm(p->pgdir);
801050b1:	e8 ea 37 00 00       	call   801088a0 <freevm>
	return mlfq_proc.queue_front[lev] == mlfq_proc.queue_rear[lev];
801050b6:	8b 86 90 01 00 00    	mov    0x190(%esi),%eax
	if(is_empty(lev)) {
801050bc:	83 c4 10             	add    $0x10,%esp
        p->pid = 0;
801050bf:	c7 46 10 00 00 00 00 	movl   $0x0,0x10(%esi)
        p->parent = 0;
801050c6:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
        p->name[0] = 0;
801050cd:	c6 46 6c 00          	movb   $0x0,0x6c(%esi)
        p->killed = 0;
801050d1:	c7 46 24 00 00 00 00 	movl   $0x0,0x24(%esi)
	return mlfq_proc.queue_front[lev] == mlfq_proc.queue_rear[lev];
801050d8:	05 c0 00 00 00       	add    $0xc0,%eax
801050dd:	8b 14 85 40 4d 11 80 	mov    -0x7feeb2c0(,%eax,4),%edx
	if(is_empty(lev)) {
801050e4:	3b 14 85 4c 4d 11 80 	cmp    -0x7feeb2b4(,%eax,4),%edx
801050eb:	74 0d                	je     801050fa <wait+0x1da>
	mlfq_proc.queue_front[lev] = ((mlfq_proc.queue_front[lev] + 1) % NPROC);
801050ed:	83 c2 01             	add    $0x1,%edx
801050f0:	83 e2 3f             	and    $0x3f,%edx
801050f3:	89 14 85 40 4d 11 80 	mov    %edx,-0x7feeb2c0(,%eax,4)
        release(&ptable.lock);
801050fa:	83 ec 0c             	sub    $0xc,%esp
				p->lev = 0;
801050fd:	c7 86 90 01 00 00 00 	movl   $0x0,0x190(%esi)
80105104:	00 00 00 
				p->tick_cnt = 0;
80105107:	c7 86 94 01 00 00 00 	movl   $0x0,0x194(%esi)
8010510e:	00 00 00 
        release(&ptable.lock);
80105111:	68 80 50 11 80       	push   $0x80115080
				p->is_stride = 0;
80105116:	c7 86 98 01 00 00 00 	movl   $0x0,0x198(%esi)
8010511d:	00 00 00 
				p->stride = 0;
80105120:	c7 86 9c 01 00 00 00 	movl   $0x0,0x19c(%esi)
80105127:	00 00 00 
				p->pass_value = 0;
8010512a:	c7 86 a0 01 00 00 00 	movl   $0x0,0x1a0(%esi)
80105131:	00 00 00 
				p->ticket = 0;
80105134:	c7 86 a4 01 00 00 00 	movl   $0x0,0x1a4(%esi)
8010513b:	00 00 00 
        p->state = UNUSED;
8010513e:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
        release(&ptable.lock);
80105145:	e8 66 0c 00 00       	call   80105db0 <release>
        return pid;
8010514a:	83 c4 10             	add    $0x10,%esp
}
8010514d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105150:	89 d8                	mov    %ebx,%eax
80105152:	5b                   	pop    %ebx
80105153:	5e                   	pop    %esi
80105154:	5d                   	pop    %ebp
80105155:	c3                   	ret    
      release(&ptable.lock);
80105156:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80105159:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&ptable.lock);
8010515e:	68 80 50 11 80       	push   $0x80115080
80105163:	e8 48 0c 00 00       	call   80105db0 <release>
      return -1;
80105168:	83 c4 10             	add    $0x10,%esp
8010516b:	eb e0                	jmp    8010514d <wait+0x22d>
8010516d:	8d 76 00             	lea    0x0(%esi),%esi

80105170 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80105170:	55                   	push   %ebp
80105171:	89 e5                	mov    %esp,%ebp
80105173:	53                   	push   %ebx
80105174:	83 ec 10             	sub    $0x10,%esp
80105177:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010517a:	68 80 50 11 80       	push   $0x80115080
8010517f:	e8 6c 0b 00 00       	call   80105cf0 <acquire>
  wakeup1(chan);
80105184:	89 d8                	mov    %ebx,%eax
80105186:	e8 75 ea ff ff       	call   80103c00 <wakeup1>
  release(&ptable.lock);
8010518b:	83 c4 10             	add    $0x10,%esp
8010518e:	c7 45 08 80 50 11 80 	movl   $0x80115080,0x8(%ebp)
}
80105195:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105198:	c9                   	leave  
  release(&ptable.lock);
80105199:	e9 12 0c 00 00       	jmp    80105db0 <release>
8010519e:	66 90                	xchg   %ax,%ax

801051a0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801051a0:	55                   	push   %ebp
801051a1:	89 e5                	mov    %esp,%ebp
801051a3:	56                   	push   %esi
801051a4:	53                   	push   %ebx
801051a5:	8b 75 08             	mov    0x8(%ebp),%esi
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801051a8:	bb b4 50 11 80       	mov    $0x801150b4,%ebx
  acquire(&ptable.lock);
801051ad:	83 ec 0c             	sub    $0xc,%esp
801051b0:	68 80 50 11 80       	push   $0x80115080
801051b5:	e8 36 0b 00 00       	call   80105cf0 <acquire>
801051ba:	83 c4 10             	add    $0x10,%esp
801051bd:	eb 0f                	jmp    801051ce <kill+0x2e>
801051bf:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801051c0:	81 c3 a8 01 00 00    	add    $0x1a8,%ebx
801051c6:	81 fb b4 ba 11 80    	cmp    $0x8011bab4,%ebx
801051cc:	73 72                	jae    80105240 <kill+0xa0>
    if(p->pid == pid){
801051ce:	39 73 10             	cmp    %esi,0x10(%ebx)
801051d1:	75 ed                	jne    801051c0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING) {
801051d3:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
      p->killed = 1;
801051d7:	c7 43 24 01 00 00 00 	movl   $0x1,0x24(%ebx)
      if(p->state == SLEEPING) {
801051de:	75 46                	jne    80105226 <kill+0x86>
				if (!p->is_stride) {
801051e0:	8b 83 98 01 00 00    	mov    0x198(%ebx),%eax
801051e6:	85 c0                	test   %eax,%eax
801051e8:	75 76                	jne    80105260 <kill+0xc0>
					enqueue(p->lev, p);
801051ea:	8b 93 90 01 00 00    	mov    0x190(%ebx),%edx
	return mlfq_proc.queue_front[lev] == ((mlfq_proc.queue_rear[lev] + 1) % NPROC);
801051f0:	8d 8a c0 00 00 00    	lea    0xc0(%edx),%ecx
801051f6:	8b 04 8d 4c 4d 11 80 	mov    -0x7feeb2b4(,%ecx,4),%eax
801051fd:	83 c0 01             	add    $0x1,%eax
80105200:	83 e0 3f             	and    $0x3f,%eax
	if (is_full(lev))
80105203:	39 04 8d 40 4d 11 80 	cmp    %eax,-0x7feeb2c0(,%ecx,4)
8010520a:	74 61                	je     8010526d <kill+0xcd>
	mlfq_proc.queue[lev][mlfq_proc.queue_rear[lev]] = proc;
8010520c:	c1 e2 06             	shl    $0x6,%edx
	mlfq_proc.queue_rear[lev] = ((mlfq_proc.queue_rear[lev] + 1) % NPROC);
8010520f:	89 04 8d 4c 4d 11 80 	mov    %eax,-0x7feeb2b4(,%ecx,4)
	mlfq_proc.queue[lev][mlfq_proc.queue_rear[lev]] = proc;
80105216:	01 d0                	add    %edx,%eax
80105218:	89 1c 85 40 4d 11 80 	mov    %ebx,-0x7feeb2c0(,%eax,4)
				} else {
					p->pass_value = get_min_pass();
				}
        p->state = RUNNABLE;
8010521f:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
			}
      release(&ptable.lock);
80105226:	83 ec 0c             	sub    $0xc,%esp
80105229:	68 80 50 11 80       	push   $0x80115080
8010522e:	e8 7d 0b 00 00       	call   80105db0 <release>
      return 0;
80105233:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ptable.lock);
  return -1;
}
80105236:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return 0;
80105239:	31 c0                	xor    %eax,%eax
}
8010523b:	5b                   	pop    %ebx
8010523c:	5e                   	pop    %esi
8010523d:	5d                   	pop    %ebp
8010523e:	c3                   	ret    
8010523f:	90                   	nop
  release(&ptable.lock);
80105240:	83 ec 0c             	sub    $0xc,%esp
80105243:	68 80 50 11 80       	push   $0x80115080
80105248:	e8 63 0b 00 00       	call   80105db0 <release>
  return -1;
8010524d:	83 c4 10             	add    $0x10,%esp
}
80105250:	8d 65 f8             	lea    -0x8(%ebp),%esp
  return -1;
80105253:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105258:	5b                   	pop    %ebx
80105259:	5e                   	pop    %esi
8010525a:	5d                   	pop    %ebp
8010525b:	c3                   	ret    
8010525c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
					p->pass_value = get_min_pass();
80105260:	e8 2b e9 ff ff       	call   80103b90 <get_min_pass>
80105265:	89 83 a0 01 00 00    	mov    %eax,0x1a0(%ebx)
8010526b:	eb b2                	jmp    8010521f <kill+0x7f>
		panic("Queue is already full");
8010526d:	83 ec 0c             	sub    $0xc,%esp
80105270:	68 2e 91 10 80       	push   $0x8010912e
80105275:	e8 16 b1 ff ff       	call   80100390 <panic>
8010527a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105280 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80105280:	55                   	push   %ebp
80105281:	89 e5                	mov    %esp,%ebp
80105283:	57                   	push   %edi
80105284:	56                   	push   %esi
80105285:	53                   	push   %ebx
80105286:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105289:	bb b4 50 11 80       	mov    $0x801150b4,%ebx
{
8010528e:	83 ec 3c             	sub    $0x3c,%esp
80105291:	eb 27                	jmp    801052ba <procdump+0x3a>
80105293:	90                   	nop
80105294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80105298:	83 ec 0c             	sub    $0xc,%esp
8010529b:	68 3b 96 10 80       	push   $0x8010963b
801052a0:	e8 bb b3 ff ff       	call   80100660 <cprintf>
801052a5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801052a8:	81 c3 a8 01 00 00    	add    $0x1a8,%ebx
801052ae:	81 fb b4 ba 11 80    	cmp    $0x8011bab4,%ebx
801052b4:	0f 83 86 00 00 00    	jae    80105340 <procdump+0xc0>
    if(p->state == UNUSED)
801052ba:	8b 43 0c             	mov    0xc(%ebx),%eax
801052bd:	85 c0                	test   %eax,%eax
801052bf:	74 e7                	je     801052a8 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801052c1:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
801052c4:	ba 4d 92 10 80       	mov    $0x8010924d,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801052c9:	77 11                	ja     801052dc <procdump+0x5c>
801052cb:	8b 14 85 f0 92 10 80 	mov    -0x7fef6d10(,%eax,4),%edx
      state = "???";
801052d2:	b8 4d 92 10 80       	mov    $0x8010924d,%eax
801052d7:	85 d2                	test   %edx,%edx
801052d9:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801052dc:	8d 43 6c             	lea    0x6c(%ebx),%eax
801052df:	50                   	push   %eax
801052e0:	52                   	push   %edx
801052e1:	ff 73 10             	pushl  0x10(%ebx)
801052e4:	68 51 92 10 80       	push   $0x80109251
801052e9:	e8 72 b3 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
801052ee:	83 c4 10             	add    $0x10,%esp
801052f1:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
801052f5:	75 a1                	jne    80105298 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801052f7:	8d 45 c0             	lea    -0x40(%ebp),%eax
801052fa:	83 ec 08             	sub    $0x8,%esp
801052fd:	8d 7d c0             	lea    -0x40(%ebp),%edi
80105300:	50                   	push   %eax
80105301:	8b 43 1c             	mov    0x1c(%ebx),%eax
80105304:	8b 40 0c             	mov    0xc(%eax),%eax
80105307:	83 c0 08             	add    $0x8,%eax
8010530a:	50                   	push   %eax
8010530b:	e8 c0 08 00 00       	call   80105bd0 <getcallerpcs>
80105310:	83 c4 10             	add    $0x10,%esp
80105313:	90                   	nop
80105314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80105318:	8b 17                	mov    (%edi),%edx
8010531a:	85 d2                	test   %edx,%edx
8010531c:	0f 84 76 ff ff ff    	je     80105298 <procdump+0x18>
        cprintf(" %p", pc[i]);
80105322:	83 ec 08             	sub    $0x8,%esp
80105325:	83 c7 04             	add    $0x4,%edi
80105328:	52                   	push   %edx
80105329:	68 01 8c 10 80       	push   $0x80108c01
8010532e:	e8 2d b3 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80105333:	83 c4 10             	add    $0x10,%esp
80105336:	39 fe                	cmp    %edi,%esi
80105338:	75 de                	jne    80105318 <procdump+0x98>
8010533a:	e9 59 ff ff ff       	jmp    80105298 <procdump+0x18>
8010533f:	90                   	nop
  }
}
80105340:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105343:	5b                   	pop    %ebx
80105344:	5e                   	pop    %esi
80105345:	5f                   	pop    %edi
80105346:	5d                   	pop    %ebp
80105347:	c3                   	ret    
80105348:	90                   	nop
80105349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105350 <thread_create>:

int thread_create(thread_t *thread, void *(*start_routine)(void*), void *arg) {
80105350:	55                   	push   %ebp
80105351:	89 e5                	mov    %esp,%ebp
80105353:	57                   	push   %edi
80105354:	56                   	push   %esi
80105355:	53                   	push   %ebx
80105356:	83 ec 2c             	sub    $0x2c,%esp
  pushcli();
80105359:	e8 c2 08 00 00       	call   80105c20 <pushcli>
  c = mycpu();
8010535e:	e8 1d ee ff ff       	call   80104180 <mycpu>
  p = c->proc;
80105363:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80105369:	e8 f2 08 00 00       	call   80105c60 <popcli>
	
	struct proc *np;
	struct proc *curproc = myproc();
	uint sp, ustack[3];
	
	if((np = allocproc()) == 0){ //fork()할때 쓰는 함수allocproc()그래서 forkret이 자동으로 context->eip부분에 들어가있다.
8010536e:	e8 3d e9 ff ff       	call   80103cb0 <allocproc>
80105373:	85 c0                	test   %eax,%eax
80105375:	0f 84 27 02 00 00    	je     801055a2 <thread_create+0x252>
    return -1;
	}

	if (growproc(2*PGSIZE) < 0) {
8010537b:	83 ec 0c             	sub    $0xc,%esp
8010537e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80105381:	68 00 20 00 00       	push   $0x2000
80105386:	e8 85 f1 ff ff       	call   80104510 <growproc>
8010538b:	83 c4 10             	add    $0x10,%esp
8010538e:	85 c0                	test   %eax,%eax
80105390:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80105393:	0f 88 de 01 00 00    	js     80105577 <thread_create+0x227>
		cprintf("error in growproc\n");
		return -1;
	}
	
	//make guard page by setting about PTE_U 
	clearpteu(curproc->pgdir, (char *)(curproc->sz - 2*PGSIZE));
80105399:	8b 03                	mov    (%ebx),%eax
8010539b:	83 ec 08             	sub    $0x8,%esp
8010539e:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801053a1:	2d 00 20 00 00       	sub    $0x2000,%eax
801053a6:	50                   	push   %eax
801053a7:	ff 73 04             	pushl  0x4(%ebx)
801053aa:	e8 11 36 00 00       	call   801089c0 <clearpteu>
	
	sp = curproc->sz;
801053af:	8b 03                	mov    (%ebx),%eax
	np->lwpstack = sp;
801053b1:	8b 55 d4             	mov    -0x2c(%ebp),%edx
	
	
	ustack[0] = 0xffffffff;//fake
	ustack[1] = (uint)arg;
801053b4:	8b 4d 10             	mov    0x10(%ebp),%ecx
	ustack[0] = 0xffffffff;//fake
801053b7:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%ebp)
	np->lwpstack = sp;
801053be:	89 82 84 00 00 00    	mov    %eax,0x84(%edx)
	sp -= 8;
801053c4:	83 e8 08             	sub    $0x8,%eax

	if(copyout(curproc->pgdir, sp, ustack, 8) < 0)
801053c7:	6a 08                	push   $0x8
	sp -= 8;
801053c9:	89 c7                	mov    %eax,%edi
801053cb:	89 45 d4             	mov    %eax,-0x2c(%ebp)
	if(copyout(curproc->pgdir, sp, ustack, 8) < 0)
801053ce:	8d 45 dc             	lea    -0x24(%ebp),%eax
	ustack[1] = (uint)arg;
801053d1:	89 4d e0             	mov    %ecx,-0x20(%ebp)
	np->lwpstack = sp;
801053d4:	89 55 d0             	mov    %edx,-0x30(%ebp)
	if(copyout(curproc->pgdir, sp, ustack, 8) < 0)
801053d7:	50                   	push   %eax
801053d8:	57                   	push   %edi
801053d9:	ff 73 04             	pushl  0x4(%ebx)
801053dc:	e8 3f 37 00 00       	call   80108b20 <copyout>
801053e1:	83 c4 20             	add    $0x20,%esp
801053e4:	85 c0                	test   %eax,%eax
801053e6:	0f 88 b6 01 00 00    	js     801055a2 <thread_create+0x252>
		return -1;

	np->pgdir = curproc->pgdir;
801053ec:	8b 43 04             	mov    0x4(%ebx),%eax
801053ef:	8b 55 d0             	mov    -0x30(%ebp),%edx
	*np->tf = *curproc->tf;
801053f2:	b9 13 00 00 00       	mov    $0x13,%ecx
	np->pgdir = curproc->pgdir;
801053f7:	89 42 04             	mov    %eax,0x4(%edx)
	*np->tf = *curproc->tf;
801053fa:	8b 7a 18             	mov    0x18(%edx),%edi
801053fd:	8b 73 18             	mov    0x18(%ebx),%esi
80105400:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	
	np->tid = nexttid++;
80105402:	a1 04 c0 10 80       	mov    0x8010c004,%eax
80105407:	8d 48 01             	lea    0x1(%eax),%ecx
8010540a:	89 42 7c             	mov    %eax,0x7c(%edx)
8010540d:	89 0d 04 c0 10 80    	mov    %ecx,0x8010c004
	*thread = np->tid;//
80105413:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105416:	89 01                	mov    %eax,(%ecx)

	//
//	curproc->d_storage.size =0;

	if (curproc->tid == 0) {
80105418:	8b 43 7c             	mov    0x7c(%ebx),%eax
8010541b:	85 c0                	test   %eax,%eax
8010541d:	0f 84 3d 01 00 00    	je     80105560 <thread_create+0x210>
		np->lwpGroupid = curproc->pid;
		curproc->lwpGroupid = curproc->pid;
	} else {
		np->lwpGroupid = curproc->lwpGroupid;
80105423:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax
80105429:	89 82 80 00 00 00    	mov    %eax,0x80(%edx)
	}

	np->sz = curproc->sz; //O
8010542f:	8b 03                	mov    (%ebx),%eax
	np->parent = curproc;


	*np->tf = *curproc->tf;
80105431:	8b 7a 18             	mov    0x18(%edx),%edi
80105434:	b9 13 00 00 00       	mov    $0x13,%ecx
	np->parent = curproc;
80105439:	89 5a 14             	mov    %ebx,0x14(%edx)
	np->sz = curproc->sz; //O
8010543c:	89 02                	mov    %eax,(%edx)
	*np->tf = *curproc->tf;
8010543e:	8b 73 18             	mov    0x18(%ebx),%esi
80105441:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	np->tf->eip = (uint)start_routine;
80105443:	8b 4d 0c             	mov    0xc(%ebp),%ecx

	// Clear %eax so that thread_create() returns 0 in the LWP.
	np->tf->eax=0;
	
	// 파일관련 복사
	for(int i = 0; i < NOFILE; i++){
80105446:	31 f6                	xor    %esi,%esi
80105448:	89 d7                	mov    %edx,%edi
	np->tf->eip = (uint)start_routine;
8010544a:	8b 42 18             	mov    0x18(%edx),%eax
8010544d:	89 48 38             	mov    %ecx,0x38(%eax)
	np->tf->esp = sp;
80105450:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
80105453:	8b 42 18             	mov    0x18(%edx),%eax
80105456:	89 48 44             	mov    %ecx,0x44(%eax)
	np->tf->eax=0;
80105459:	8b 42 18             	mov    0x18(%edx),%eax
8010545c:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80105463:	90                   	nop
80105464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		if(curproc->ofile[i])
80105468:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
8010546c:	85 c0                	test   %eax,%eax
8010546e:	74 10                	je     80105480 <thread_create+0x130>
			np->ofile[i] = filedup(curproc->ofile[i]);
80105470:	83 ec 0c             	sub    $0xc,%esp
80105473:	50                   	push   %eax
80105474:	e8 77 b9 ff ff       	call   80100df0 <filedup>
80105479:	83 c4 10             	add    $0x10,%esp
8010547c:	89 44 b7 28          	mov    %eax,0x28(%edi,%esi,4)
	for(int i = 0; i < NOFILE; i++){
80105480:	83 c6 01             	add    $0x1,%esi
80105483:	83 fe 10             	cmp    $0x10,%esi
80105486:	75 e0                	jne    80105468 <thread_create+0x118>
	}
	np->cwd = idup(curproc->cwd);
80105488:	83 ec 0c             	sub    $0xc,%esp
8010548b:	ff 73 68             	pushl  0x68(%ebx)
8010548e:	89 7d d4             	mov    %edi,-0x2c(%ebp)
80105491:	e8 0a c5 ff ff       	call   801019a0 <idup>
80105496:	8b 55 d4             	mov    -0x2c(%ebp),%edx
	
	//이름 복사
	safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80105499:	83 c4 0c             	add    $0xc,%esp
	np->cwd = idup(curproc->cwd);
8010549c:	89 42 68             	mov    %eax,0x68(%edx)
	safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010549f:	8d 43 6c             	lea    0x6c(%ebx),%eax
801054a2:	6a 10                	push   $0x10
801054a4:	50                   	push   %eax
801054a5:	8d 42 6c             	lea    0x6c(%edx),%eax
801054a8:	50                   	push   %eax
801054a9:	e8 32 0b 00 00       	call   80105fe0 <safestrcpy>

	np->lev = curproc->lev;
801054ae:	8b 83 90 01 00 00    	mov    0x190(%ebx),%eax
801054b4:	8b 55 d4             	mov    -0x2c(%ebp),%edx
801054b7:	89 82 90 01 00 00    	mov    %eax,0x190(%edx)
	np->tick_cnt = 0;
801054bd:	c7 82 94 01 00 00 00 	movl   $0x0,0x194(%edx)
801054c4:	00 00 00 
	np->is_stride = 0;
801054c7:	c7 82 98 01 00 00 00 	movl   $0x0,0x198(%edx)
801054ce:	00 00 00 
	np->stride = 0;
801054d1:	c7 82 9c 01 00 00 00 	movl   $0x0,0x19c(%edx)
801054d8:	00 00 00 
	np->pass_value = 0;
801054db:	c7 82 a0 01 00 00 00 	movl   $0x0,0x1a0(%edx)
801054e2:	00 00 00 
	np->ticket = 0;
801054e5:	c7 82 a4 01 00 00 00 	movl   $0x0,0x1a4(%edx)
801054ec:	00 00 00 

	acquire(&ptable.lock);
801054ef:	c7 04 24 80 50 11 80 	movl   $0x80115080,(%esp)
801054f6:	e8 f5 07 00 00       	call   80105cf0 <acquire>

	np->state = RUNNABLE;
801054fb:	8b 55 d4             	mov    -0x2c(%ebp),%edx
	if (is_full(lev))
801054fe:	83 c4 10             	add    $0x10,%esp
	enqueue(np->lev, np);
80105501:	8b 8a 90 01 00 00    	mov    0x190(%edx),%ecx
	np->state = RUNNABLE;
80105507:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
	return mlfq_proc.queue_front[lev] == ((mlfq_proc.queue_rear[lev] + 1) % NPROC);
8010550e:	8d 99 c0 00 00 00    	lea    0xc0(%ecx),%ebx
80105514:	8b 04 9d 4c 4d 11 80 	mov    -0x7feeb2b4(,%ebx,4),%eax
8010551b:	83 c0 01             	add    $0x1,%eax
8010551e:	83 e0 3f             	and    $0x3f,%eax
	if (is_full(lev))
80105521:	39 04 9d 40 4d 11 80 	cmp    %eax,-0x7feeb2c0(,%ebx,4)
80105528:	74 7f                	je     801055a9 <thread_create+0x259>
	
	release(&ptable.lock);
8010552a:	83 ec 0c             	sub    $0xc,%esp
	mlfq_proc.queue[lev][mlfq_proc.queue_rear[lev]] = proc;
8010552d:	c1 e1 06             	shl    $0x6,%ecx
	mlfq_proc.queue_rear[lev] = ((mlfq_proc.queue_rear[lev] + 1) % NPROC);
80105530:	89 04 9d 4c 4d 11 80 	mov    %eax,-0x7feeb2b4(,%ebx,4)
	release(&ptable.lock);
80105537:	68 80 50 11 80       	push   $0x80115080
	mlfq_proc.queue[lev][mlfq_proc.queue_rear[lev]] = proc;
8010553c:	01 c8                	add    %ecx,%eax
8010553e:	89 14 85 40 4d 11 80 	mov    %edx,-0x7feeb2c0(,%eax,4)
	release(&ptable.lock);
80105545:	e8 66 08 00 00       	call   80105db0 <release>
	
	return 0;
8010554a:	83 c4 10             	add    $0x10,%esp
8010554d:	31 c0                	xor    %eax,%eax
}
8010554f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105552:	5b                   	pop    %ebx
80105553:	5e                   	pop    %esi
80105554:	5f                   	pop    %edi
80105555:	5d                   	pop    %ebp
80105556:	c3                   	ret    
80105557:	89 f6                	mov    %esi,%esi
80105559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		np->lwpGroupid = curproc->pid;
80105560:	8b 43 10             	mov    0x10(%ebx),%eax
80105563:	89 82 80 00 00 00    	mov    %eax,0x80(%edx)
		curproc->lwpGroupid = curproc->pid;
80105569:	8b 43 10             	mov    0x10(%ebx),%eax
8010556c:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
80105572:	e9 b8 fe ff ff       	jmp    8010542f <thread_create+0xdf>
		kfree(np->kstack);
80105577:	83 ec 0c             	sub    $0xc,%esp
8010557a:	ff 72 08             	pushl  0x8(%edx)
8010557d:	e8 1e d3 ff ff       	call   801028a0 <kfree>
		np->kstack = 0;
80105582:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80105585:	c7 42 08 00 00 00 00 	movl   $0x0,0x8(%edx)
		np->state = UNUSED;
8010558c:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
		cprintf("error in growproc\n");
80105593:	c7 04 24 5a 92 10 80 	movl   $0x8010925a,(%esp)
8010559a:	e8 c1 b0 ff ff       	call   80100660 <cprintf>
		return -1;
8010559f:	83 c4 10             	add    $0x10,%esp
801055a2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055a7:	eb a6                	jmp    8010554f <thread_create+0x1ff>
		panic("Queue is already full");
801055a9:	83 ec 0c             	sub    $0xc,%esp
801055ac:	68 2e 91 10 80       	push   $0x8010912e
801055b1:	e8 da ad ff ff       	call   80100390 <panic>
801055b6:	8d 76 00             	lea    0x0(%esi),%esi
801055b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055c0 <thread_exit>:

void thread_exit(void *retval){
801055c0:	55                   	push   %ebp
801055c1:	89 e5                	mov    %esp,%ebp
801055c3:	57                   	push   %edi
801055c4:	56                   	push   %esi
801055c5:	53                   	push   %ebx
801055c6:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
801055c9:	e8 52 06 00 00       	call   80105c20 <pushcli>
  c = mycpu();
801055ce:	e8 ad eb ff ff       	call   80104180 <mycpu>
  p = c->proc;
801055d3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801055d9:	e8 82 06 00 00       	call   80105c60 <popcli>
801055de:	8d 5e 28             	lea    0x28(%esi),%ebx
801055e1:	8d 7e 68             	lea    0x68(%esi),%edi
801055e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct proc *curproc = myproc();
  struct proc *p;

  for(int fd=0; fd <NOFILE; fd++){
	  if(curproc->ofile[fd]){
801055e8:	8b 03                	mov    (%ebx),%eax
801055ea:	85 c0                	test   %eax,%eax
801055ec:	74 12                	je     80105600 <thread_exit+0x40>
		  fileclose(curproc->ofile[fd]);
801055ee:	83 ec 0c             	sub    $0xc,%esp
801055f1:	50                   	push   %eax
801055f2:	e8 49 b8 ff ff       	call   80100e40 <fileclose>
		  curproc->ofile[fd]=0;
801055f7:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801055fd:	83 c4 10             	add    $0x10,%esp
80105600:	83 c3 04             	add    $0x4,%ebx
  for(int fd=0; fd <NOFILE; fd++){
80105603:	39 df                	cmp    %ebx,%edi
80105605:	75 e1                	jne    801055e8 <thread_exit+0x28>
	  }
  }

  begin_op();
80105607:	e8 24 db ff ff       	call   80103130 <begin_op>
  iput(curproc->cwd);
8010560c:	83 ec 0c             	sub    $0xc,%esp
8010560f:	ff 76 68             	pushl  0x68(%esi)
  end_op();
  curproc->cwd = 0;

  acquire(&ptable.lock);

  for(p=ptable.proc; p<&ptable.proc[NPROC]; p++){
80105612:	bb b4 50 11 80       	mov    $0x801150b4,%ebx
  iput(curproc->cwd);
80105617:	e8 e4 c4 ff ff       	call   80101b00 <iput>
  end_op();
8010561c:	e8 7f db ff ff       	call   801031a0 <end_op>
  curproc->cwd = 0;
80105621:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80105628:	c7 04 24 80 50 11 80 	movl   $0x80115080,(%esp)
8010562f:	e8 bc 06 00 00       	call   80105cf0 <acquire>
80105634:	83 c4 10             	add    $0x10,%esp
80105637:	eb 15                	jmp    8010564e <thread_exit+0x8e>
80105639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p=ptable.proc; p<&ptable.proc[NPROC]; p++){
80105640:	81 c3 a8 01 00 00    	add    $0x1a8,%ebx
80105646:	81 fb b4 ba 11 80    	cmp    $0x8011bab4,%ebx
8010564c:	73 2a                	jae    80105678 <thread_exit+0xb8>
	  if(p->parent == curproc){
8010564e:	39 73 14             	cmp    %esi,0x14(%ebx)
80105651:	75 ed                	jne    80105640 <thread_exit+0x80>
		  p->parent = initproc;
		  if(p->state == ZOMBIE)
80105653:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
		  p->parent = initproc;
80105657:	a1 c4 c5 10 80       	mov    0x8010c5c4,%eax
8010565c:	89 43 14             	mov    %eax,0x14(%ebx)
		  if(p->state == ZOMBIE)
8010565f:	75 df                	jne    80105640 <thread_exit+0x80>
  for(p=ptable.proc; p<&ptable.proc[NPROC]; p++){
80105661:	81 c3 a8 01 00 00    	add    $0x1a8,%ebx
			  wakeup1(initproc);
80105667:	e8 94 e5 ff ff       	call   80103c00 <wakeup1>
  for(p=ptable.proc; p<&ptable.proc[NPROC]; p++){
8010566c:	81 fb b4 ba 11 80    	cmp    $0x8011bab4,%ebx
80105672:	72 da                	jb     8010564e <thread_exit+0x8e>
80105674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	  }
  }

  curproc->retval = retval; 
80105678:	8b 45 08             	mov    0x8(%ebp),%eax
  curproc->state = ZOMBIE;
8010567b:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  curproc->retval = retval; 
80105682:	89 86 88 00 00 00    	mov    %eax,0x88(%esi)

  wakeup1((void*)curproc->lwpGroupid);
80105688:	8b 86 80 00 00 00    	mov    0x80(%esi),%eax
8010568e:	e8 6d e5 ff ff       	call   80103c00 <wakeup1>
  sched();
80105693:	e8 78 f2 ff ff       	call   80104910 <sched>
    
  panic("thread_zombie exit");
80105698:	83 ec 0c             	sub    $0xc,%esp
8010569b:	68 6d 92 10 80       	push   $0x8010926d
801056a0:	e8 eb ac ff ff       	call   80100390 <panic>
801056a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801056a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801056b0 <thread_join>:
}	



int thread_join(thread_t thread, void **retval) {
801056b0:	55                   	push   %ebp
801056b1:	89 e5                	mov    %esp,%ebp
801056b3:	57                   	push   %edi
801056b4:	56                   	push   %esi
801056b5:	53                   	push   %ebx
801056b6:	83 ec 1c             	sub    $0x1c,%esp
801056b9:	8b 7d 08             	mov    0x8(%ebp),%edi
  pushcli();
801056bc:	e8 5f 05 00 00       	call   80105c20 <pushcli>
  c = mycpu();
801056c1:	e8 ba ea ff ff       	call   80104180 <mycpu>
  p = c->proc;
801056c6:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801056cc:	e8 8f 05 00 00       	call   80105c60 <popcli>
  struct proc *p, *otherp;
  int havethreads, bound, delete_top;
  struct proc *curproc = myproc();

  acquire(&ptable.lock);
801056d1:	83 ec 0c             	sub    $0xc,%esp
801056d4:	68 80 50 11 80       	push   $0x80115080
801056d9:	e8 12 06 00 00       	call   80105cf0 <acquire>
801056de:	83 c4 10             	add    $0x10,%esp
  for (;;) {
    havethreads = 0;
801056e1:	31 d2                	xor    %edx,%edx
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801056e3:	bb b4 50 11 80       	mov    $0x801150b4,%ebx
801056e8:	eb 2e                	jmp    80105718 <thread_join+0x68>
801056ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		*retval = p->retval;
        release(&ptable.lock);

        return 0;
      }
      sleep((void*)p->lwpGroupid, &ptable.lock);
801056f0:	83 ec 08             	sub    $0x8,%esp
801056f3:	68 80 50 11 80       	push   $0x80115080
801056f8:	50                   	push   %eax
801056f9:	e8 62 f7 ff ff       	call   80104e60 <sleep>
801056fe:	83 c4 10             	add    $0x10,%esp
      havethreads = 1; //find thread that should be join
80105701:	ba 01 00 00 00       	mov    $0x1,%edx
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105706:	81 c3 a8 01 00 00    	add    $0x1a8,%ebx
8010570c:	81 fb b4 ba 11 80    	cmp    $0x8011bab4,%ebx
80105712:	0f 83 ab 01 00 00    	jae    801058c3 <thread_join+0x213>
      if (p->lwpGroupid != curproc->pid || p->tid != thread) continue;
80105718:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax
8010571e:	3b 46 10             	cmp    0x10(%esi),%eax
80105721:	75 e3                	jne    80105706 <thread_join+0x56>
80105723:	39 7b 7c             	cmp    %edi,0x7c(%ebx)
80105726:	75 de                	jne    80105706 <thread_join+0x56>
	  if(p->state ==ZOMBIE){ //if is not currentyl ZOMBIE, sleep until they are ZOMBIE
80105728:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010572c:	75 c2                	jne    801056f0 <thread_join+0x40>
		kfree(p->kstack);
8010572e:	83 ec 0c             	sub    $0xc,%esp
80105731:	ff 73 08             	pushl  0x8(%ebx)
80105734:	8d be 8c 01 00 00    	lea    0x18c(%esi),%edi
8010573a:	e8 61 d1 ff ff       	call   801028a0 <kfree>
		deallocuvm(p->pgdir, p->lwpstack, p->lwpstack - 2*PGSIZE);//why p->sz allot?
8010573f:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80105745:	83 c4 0c             	add    $0xc,%esp
		p->kstack = 0;
80105748:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
		p->pid=0;
8010574f:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
		p->parent =0;
80105756:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
		p->name[0]=0;
8010575d:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
		p->killed = 0;
80105761:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
		deallocuvm(p->pgdir, p->lwpstack, p->lwpstack - 2*PGSIZE);//why p->sz allot?
80105768:	8d 90 00 e0 ff ff    	lea    -0x2000(%eax),%edx
		p->lev = 0;
8010576e:	c7 83 90 01 00 00 00 	movl   $0x0,0x190(%ebx)
80105775:	00 00 00 
		p->tick_cnt = 0;
80105778:	c7 83 94 01 00 00 00 	movl   $0x0,0x194(%ebx)
8010577f:	00 00 00 
		p->stride = 0;
80105782:	c7 83 9c 01 00 00 00 	movl   $0x0,0x19c(%ebx)
80105789:	00 00 00 
		p->pass_value = 0;
8010578c:	c7 83 a0 01 00 00 00 	movl   $0x0,0x1a0(%ebx)
80105793:	00 00 00 
		p->ticket = 0;
80105796:	c7 83 a4 01 00 00 00 	movl   $0x0,0x1a4(%ebx)
8010579d:	00 00 00 
		p->state = UNUSED;
801057a0:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
		p->lwpGroupid = 0;
801057a7:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
801057ae:	00 00 00 
		deallocuvm(p->pgdir, p->lwpstack, p->lwpstack - 2*PGSIZE);//why p->sz allot?
801057b1:	52                   	push   %edx
801057b2:	50                   	push   %eax
801057b3:	ff 73 04             	pushl  0x4(%ebx)
801057b6:	e8 b5 30 00 00       	call   80108870 <deallocuvm>
		bound = p->lwpstack;
801057bb:	8b 8b 84 00 00 00    	mov    0x84(%ebx),%ecx
		delete_top = 0;
801057c1:	31 c0                	xor    %eax,%eax
		while(bound == curproc->sz){//
801057c3:	83 c4 10             	add    $0x10,%esp
801057c6:	39 0e                	cmp    %ecx,(%esi)
801057c8:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801057cb:	89 c3                	mov    %eax,%ebx
801057cd:	75 5f                	jne    8010582e <thread_join+0x17e>
801057cf:	90                   	nop
			curproc->sz -= 2*PGSIZE;
801057d0:	8d 91 00 e0 ff ff    	lea    -0x2000(%ecx),%edx
			for(otherp = ptable.proc; otherp < &ptable.proc[NPROC]; otherp++){
801057d6:	b8 b4 50 11 80       	mov    $0x801150b4,%eax
			curproc->sz -= 2*PGSIZE;
801057db:	89 16                	mov    %edx,(%esi)
801057dd:	8d 76 00             	lea    0x0(%esi),%esi
			for(otherp = ptable.proc; otherp < &ptable.proc[NPROC]; otherp++){
801057e0:	05 a8 01 00 00       	add    $0x1a8,%eax
801057e5:	3d b4 ba 11 80       	cmp    $0x8011bab4,%eax
801057ea:	72 f4                	jb     801057e0 <thread_join+0x130>
				if(otherp->lwpGroupid == curproc->pid)
801057ec:	8b 5e 10             	mov    0x10(%esi),%ebx
801057ef:	39 98 80 00 00 00    	cmp    %ebx,0x80(%eax)
801057f5:	75 06                	jne    801057fd <thread_join+0x14d>
					otherp->sz -= 2*PGSIZE;
801057f7:	81 28 00 20 00 00    	subl   $0x2000,(%eax)
801057fd:	8d 86 8c 00 00 00    	lea    0x8c(%esi),%eax
			delete_top = 1;
80105803:	bb 01 00 00 00       	mov    $0x1,%ebx
80105808:	eb 0c                	jmp    80105816 <thread_join+0x166>
8010580a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105810:	8d 91 00 e0 ff ff    	lea    -0x2000(%ecx),%edx
					if(bound-2*PGSIZE == curproc->d_storage.sp[i]){
80105816:	3b 10                	cmp    (%eax),%edx
80105818:	75 09                	jne    80105823 <thread_join+0x173>
						curproc->d_storage.size--;
8010581a:	83 ae 8c 01 00 00 01 	subl   $0x1,0x18c(%esi)
80105821:	89 d1                	mov    %edx,%ecx
80105823:	83 c0 04             	add    $0x4,%eax
				for(int i = 0; i<NPROC ; i++){
80105826:	39 f8                	cmp    %edi,%eax
80105828:	75 e6                	jne    80105810 <thread_join+0x160>
		while(bound == curproc->sz){//
8010582a:	39 0e                	cmp    %ecx,(%esi)
8010582c:	74 a2                	je     801057d0 <thread_join+0x120>
8010582e:	89 d8                	mov    %ebx,%eax
80105830:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
		if(!delete_top)
80105833:	85 c0                	test   %eax,%eax
80105835:	75 16                	jne    8010584d <thread_join+0x19d>
			curproc->d_storage.sp[curproc->d_storage.size++] = bound;
80105837:	8b 86 8c 01 00 00    	mov    0x18c(%esi),%eax
8010583d:	8d 50 01             	lea    0x1(%eax),%edx
80105840:	89 96 8c 01 00 00    	mov    %edx,0x18c(%esi)
80105846:	89 8c 86 8c 00 00 00 	mov    %ecx,0x8c(%esi,%eax,4)
		if (p->is_stride) { //dequeue from StrideQ
8010584d:	8b 93 98 01 00 00    	mov    0x198(%ebx),%edx
		p->sz = 0;
80105853:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
		p->lwpstack = 0;
80105859:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80105860:	00 00 00 
		if (p->is_stride) { //dequeue from StrideQ
80105863:	85 d2                	test   %edx,%edx
80105865:	74 2d                	je     80105894 <thread_join+0x1e4>
			total_stride_ticket -= p->ticket;
80105867:	8b 8b a4 01 00 00    	mov    0x1a4(%ebx),%ecx
8010586d:	29 0d bc c5 10 80    	sub    %ecx,0x8010c5bc
			mlfq_proc.mlfq_stride = LARGENUM / mlfq_proc.mlfq_ticket;
80105873:	b8 10 27 00 00       	mov    $0x2710,%eax
			mlfq_proc.mlfq_ticket += p->ticket;
80105878:	03 0d 60 50 11 80    	add    0x80115060,%ecx
			mlfq_proc.mlfq_stride = LARGENUM / mlfq_proc.mlfq_ticket;
8010587e:	31 d2                	xor    %edx,%edx
			havestride--;
80105880:	83 2d b8 c5 10 80 01 	subl   $0x1,0x8010c5b8
			mlfq_proc.mlfq_stride = LARGENUM / mlfq_proc.mlfq_ticket;
80105887:	f7 f1                	div    %ecx
			mlfq_proc.mlfq_ticket += p->ticket;
80105889:	89 0d 60 50 11 80    	mov    %ecx,0x80115060
			mlfq_proc.mlfq_stride = LARGENUM / mlfq_proc.mlfq_ticket;
8010588f:	a3 5c 50 11 80       	mov    %eax,0x8011505c
		*retval = p->retval;
80105894:	8b 93 88 00 00 00    	mov    0x88(%ebx),%edx
8010589a:	8b 45 0c             	mov    0xc(%ebp),%eax
        release(&ptable.lock);
8010589d:	83 ec 0c             	sub    $0xc,%esp
		p->is_stride = 0;
801058a0:	c7 83 98 01 00 00 00 	movl   $0x0,0x198(%ebx)
801058a7:	00 00 00 
		*retval = p->retval;
801058aa:	89 10                	mov    %edx,(%eax)
        release(&ptable.lock);
801058ac:	68 80 50 11 80       	push   $0x80115080
801058b1:	e8 fa 04 00 00       	call   80105db0 <release>
        return 0;
801058b6:	83 c4 10             	add    $0x10,%esp
      release(&ptable.lock);
      return -1;
    }
  }
  return -1;
}
801058b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
801058bc:	31 c0                	xor    %eax,%eax
}
801058be:	5b                   	pop    %ebx
801058bf:	5e                   	pop    %esi
801058c0:	5f                   	pop    %edi
801058c1:	5d                   	pop    %ebp
801058c2:	c3                   	ret    
    if (!havethreads || curproc->killed) {
801058c3:	85 d2                	test   %edx,%edx
801058c5:	74 0b                	je     801058d2 <thread_join+0x222>
801058c7:	8b 46 24             	mov    0x24(%esi),%eax
801058ca:	85 c0                	test   %eax,%eax
801058cc:	0f 84 0f fe ff ff    	je     801056e1 <thread_join+0x31>
      release(&ptable.lock);
801058d2:	83 ec 0c             	sub    $0xc,%esp
801058d5:	68 80 50 11 80       	push   $0x80115080
801058da:	e8 d1 04 00 00       	call   80105db0 <release>
      return -1;
801058df:	83 c4 10             	add    $0x10,%esp
}
801058e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801058e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058ea:	5b                   	pop    %ebx
801058eb:	5e                   	pop    %esi
801058ec:	5f                   	pop    %edi
801058ed:	5d                   	pop    %ebp
801058ee:	c3                   	ret    
801058ef:	90                   	nop

801058f0 <xem_init>:



int xem_init(xem_t *xem){
801058f0:	55                   	push   %ebp
801058f1:	89 e5                	mov    %esp,%ebp
801058f3:	83 ec 08             	sub    $0x8,%esp
	xem->value = 1;
801058f6:	8b 45 08             	mov    0x8(%ebp),%eax
801058f9:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
	xem->guard = 0;
801058ff:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105902:	8d 41 08             	lea    0x8(%ecx),%eax
80105905:	8d 91 08 01 00 00    	lea    0x108(%ecx),%edx
8010590b:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
80105912:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	for(int i=0; i<NPROC; i++){
		xem->queue[i] = 0;
80105918:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010591e:	83 c0 04             	add    $0x4,%eax
	for(int i=0; i<NPROC; i++){
80105921:	39 d0                	cmp    %edx,%eax
80105923:	75 f3                	jne    80105918 <xem_init+0x28>
	}
	xem->front = 0;
	xem->rear = 0;
	cprintf("%d\n", xem->value);
80105925:	83 ec 08             	sub    $0x8,%esp
	xem->front = 0;
80105928:	c7 81 08 01 00 00 00 	movl   $0x0,0x108(%ecx)
8010592f:	00 00 00 
	xem->rear = 0;
80105932:	c7 81 0c 01 00 00 00 	movl   $0x0,0x10c(%ecx)
80105939:	00 00 00 
	cprintf("%d\n", xem->value);
8010593c:	ff 31                	pushl  (%ecx)
8010593e:	68 b4 90 10 80       	push   $0x801090b4
80105943:	e8 18 ad ff ff       	call   80100660 <cprintf>
	cprintf("initing xem.address == %p\n", &xem);
80105948:	58                   	pop    %eax
80105949:	8d 45 08             	lea    0x8(%ebp),%eax
8010594c:	5a                   	pop    %edx
8010594d:	50                   	push   %eax
8010594e:	68 80 92 10 80       	push   $0x80109280
80105953:	e8 08 ad ff ff       	call   80100660 <cprintf>
	cprintf("initing xem.address == %p\n", xem);
80105958:	59                   	pop    %ecx
80105959:	58                   	pop    %eax
8010595a:	ff 75 08             	pushl  0x8(%ebp)
8010595d:	68 80 92 10 80       	push   $0x80109280
80105962:	e8 f9 ac ff ff       	call   80100660 <cprintf>
	return 0;
}
80105967:	31 c0                	xor    %eax,%eax
80105969:	c9                   	leave  
8010596a:	c3                   	ret    
8010596b:	90                   	nop
8010596c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105970 <xem_wait>:

int xem_wait(xem_t* xem){
80105970:	55                   	push   %ebp
80105971:	89 e5                	mov    %esp,%ebp
80105973:	56                   	push   %esi
80105974:	53                   	push   %ebx
80105975:	8b 5d 08             	mov    0x8(%ebp),%ebx

	//	while(TestAndSet(&xem->guard, 1) == 1)
//		;
	if(xem->value > 0){
80105978:	8b 03                	mov    (%ebx),%eax
8010597a:	85 c0                	test   %eax,%eax
8010597c:	7e 1a                	jle    80105998 <xem_wait+0x28>
		xem->value--;
8010597e:	83 e8 01             	sub    $0x1,%eax
		xem->guard = 0;
80105981:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
		xem->value--;
80105988:	89 03                	mov    %eax,(%ebx)
		xem->queue[xem->rear++] = myproc()->pid; //pid -> queue
		xem->guard = 0;
		sleep(&myproc()->pid, &ptable.lock);//check chcek check
	}
	return xem->value;
}
8010598a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010598d:	5b                   	pop    %ebx
8010598e:	5e                   	pop    %esi
8010598f:	5d                   	pop    %ebp
80105990:	c3                   	ret    
80105991:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pushcli();
80105998:	e8 83 02 00 00       	call   80105c20 <pushcli>
  c = mycpu();
8010599d:	e8 de e7 ff ff       	call   80104180 <mycpu>
  p = c->proc;
801059a2:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801059a8:	e8 b3 02 00 00       	call   80105c60 <popcli>
		xem->queue[xem->rear++] = myproc()->pid; //pid -> queue
801059ad:	8b 83 0c 01 00 00    	mov    0x10c(%ebx),%eax
801059b3:	8d 50 01             	lea    0x1(%eax),%edx
801059b6:	89 93 0c 01 00 00    	mov    %edx,0x10c(%ebx)
801059bc:	8b 56 10             	mov    0x10(%esi),%edx
801059bf:	89 54 83 08          	mov    %edx,0x8(%ebx,%eax,4)
		xem->guard = 0;
801059c3:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
  pushcli();
801059ca:	e8 51 02 00 00       	call   80105c20 <pushcli>
  c = mycpu();
801059cf:	e8 ac e7 ff ff       	call   80104180 <mycpu>
  p = c->proc;
801059d4:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801059da:	e8 81 02 00 00       	call   80105c60 <popcli>
		sleep(&myproc()->pid, &ptable.lock);//check chcek check
801059df:	83 ec 08             	sub    $0x8,%esp
801059e2:	83 c6 10             	add    $0x10,%esi
801059e5:	68 80 50 11 80       	push   $0x80115080
801059ea:	56                   	push   %esi
801059eb:	e8 70 f4 ff ff       	call   80104e60 <sleep>
801059f0:	8b 03                	mov    (%ebx),%eax
801059f2:	83 c4 10             	add    $0x10,%esp
}
801059f5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801059f8:	5b                   	pop    %ebx
801059f9:	5e                   	pop    %esi
801059fa:	5d                   	pop    %ebp
801059fb:	c3                   	ret    
801059fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105a00 <xem_unlock>:

int xem_unlock(xem_t* xem){
80105a00:	55                   	push   %ebp
80105a01:	89 e5                	mov    %esp,%ebp
80105a03:	56                   	push   %esi
80105a04:	53                   	push   %ebx
80105a05:	8b 5d 08             	mov    0x8(%ebp),%ebx
	struct proc* findproc = 0;
	while(TestAndSet(&xem->guard, 1) == 1) //only if xem->guard 0, function change xem->value.
80105a08:	83 7b 04 01          	cmpl   $0x1,0x4(%ebx)
80105a0c:	75 02                	jne    80105a10 <xem_unlock+0x10>
80105a0e:	eb fe                	jmp    80105a0e <xem_unlock+0xe>
		;
	if(xem->rear == xem->front){ //queue empty
80105a10:	8b 93 08 01 00 00    	mov    0x108(%ebx),%edx
80105a16:	39 93 0c 01 00 00    	cmp    %edx,0x10c(%ebx)
80105a1c:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
80105a23:	74 46                	je     80105a6b <xem_unlock+0x6b>
80105a25:	b8 b4 50 11 80       	mov    $0x801150b4,%eax
	struct proc* findproc = 0;
80105a2a:	31 c9                	xor    %ecx,%ecx
80105a2c:	eb 08                	jmp    80105a36 <xem_unlock+0x36>
80105a2e:	66 90                	xchg   %ax,%ax
80105a30:	8b 93 08 01 00 00    	mov    0x108(%ebx),%edx
		xem->value = 1;
	}else{ //queue not empty, xem->value == 0
		for(int i=0 ; i<NPROC ; i++){
			if(ptable.proc[i].pid == xem->queue[xem->front]){
80105a36:	8b 74 93 08          	mov    0x8(%ebx,%edx,4),%esi
80105a3a:	39 70 10             	cmp    %esi,0x10(%eax)
80105a3d:	75 0b                	jne    80105a4a <xem_unlock+0x4a>
				findproc = &ptable.proc[i];
				xem->front++;
80105a3f:	83 c2 01             	add    $0x1,%edx
80105a42:	89 c1                	mov    %eax,%ecx
80105a44:	89 93 08 01 00 00    	mov    %edx,0x108(%ebx)
80105a4a:	05 a8 01 00 00       	add    $0x1a8,%eax
		for(int i=0 ; i<NPROC ; i++){
80105a4f:	3d b4 ba 11 80       	cmp    $0x8011bab4,%eax
80105a54:	75 da                	jne    80105a30 <xem_unlock+0x30>
			}
		}
		wakeup(findproc); //%NPROC 
80105a56:	83 ec 0c             	sub    $0xc,%esp
80105a59:	51                   	push   %ecx
80105a5a:	e8 11 f7 ff ff       	call   80105170 <wakeup>
80105a5f:	8b 03                	mov    (%ebx),%eax
80105a61:	83 c4 10             	add    $0x10,%esp
	}
	return xem->value;
}
80105a64:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105a67:	5b                   	pop    %ebx
80105a68:	5e                   	pop    %esi
80105a69:	5d                   	pop    %ebp
80105a6a:	c3                   	ret    
		xem->value = 1;
80105a6b:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
}
80105a71:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105a74:	b8 01 00 00 00       	mov    $0x1,%eax
80105a79:	5b                   	pop    %ebx
80105a7a:	5e                   	pop    %esi
80105a7b:	5d                   	pop    %ebp
80105a7c:	c3                   	ret    
80105a7d:	66 90                	xchg   %ax,%ax
80105a7f:	90                   	nop

80105a80 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80105a80:	55                   	push   %ebp
80105a81:	89 e5                	mov    %esp,%ebp
80105a83:	53                   	push   %ebx
80105a84:	83 ec 0c             	sub    $0xc,%esp
80105a87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80105a8a:	68 20 93 10 80       	push   $0x80109320
80105a8f:	8d 43 04             	lea    0x4(%ebx),%eax
80105a92:	50                   	push   %eax
80105a93:	e8 18 01 00 00       	call   80105bb0 <initlock>
  lk->name = name;
80105a98:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80105a9b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80105aa1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80105aa4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80105aab:	89 43 38             	mov    %eax,0x38(%ebx)
}
80105aae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ab1:	c9                   	leave  
80105ab2:	c3                   	ret    
80105ab3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ac0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80105ac0:	55                   	push   %ebp
80105ac1:	89 e5                	mov    %esp,%ebp
80105ac3:	56                   	push   %esi
80105ac4:	53                   	push   %ebx
80105ac5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105ac8:	83 ec 0c             	sub    $0xc,%esp
80105acb:	8d 73 04             	lea    0x4(%ebx),%esi
80105ace:	56                   	push   %esi
80105acf:	e8 1c 02 00 00       	call   80105cf0 <acquire>
  while (lk->locked) {
80105ad4:	8b 13                	mov    (%ebx),%edx
80105ad6:	83 c4 10             	add    $0x10,%esp
80105ad9:	85 d2                	test   %edx,%edx
80105adb:	74 16                	je     80105af3 <acquiresleep+0x33>
80105add:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80105ae0:	83 ec 08             	sub    $0x8,%esp
80105ae3:	56                   	push   %esi
80105ae4:	53                   	push   %ebx
80105ae5:	e8 76 f3 ff ff       	call   80104e60 <sleep>
  while (lk->locked) {
80105aea:	8b 03                	mov    (%ebx),%eax
80105aec:	83 c4 10             	add    $0x10,%esp
80105aef:	85 c0                	test   %eax,%eax
80105af1:	75 ed                	jne    80105ae0 <acquiresleep+0x20>
  }
  lk->locked = 1;
80105af3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80105af9:	e8 72 e8 ff ff       	call   80104370 <myproc>
80105afe:	8b 40 10             	mov    0x10(%eax),%eax
80105b01:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80105b04:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105b07:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105b0a:	5b                   	pop    %ebx
80105b0b:	5e                   	pop    %esi
80105b0c:	5d                   	pop    %ebp
  release(&lk->lk);
80105b0d:	e9 9e 02 00 00       	jmp    80105db0 <release>
80105b12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b20 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80105b20:	55                   	push   %ebp
80105b21:	89 e5                	mov    %esp,%ebp
80105b23:	56                   	push   %esi
80105b24:	53                   	push   %ebx
80105b25:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105b28:	83 ec 0c             	sub    $0xc,%esp
80105b2b:	8d 73 04             	lea    0x4(%ebx),%esi
80105b2e:	56                   	push   %esi
80105b2f:	e8 bc 01 00 00       	call   80105cf0 <acquire>
  lk->locked = 0;
80105b34:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80105b3a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80105b41:	89 1c 24             	mov    %ebx,(%esp)
80105b44:	e8 27 f6 ff ff       	call   80105170 <wakeup>
  release(&lk->lk);
80105b49:	89 75 08             	mov    %esi,0x8(%ebp)
80105b4c:	83 c4 10             	add    $0x10,%esp
}
80105b4f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105b52:	5b                   	pop    %ebx
80105b53:	5e                   	pop    %esi
80105b54:	5d                   	pop    %ebp
  release(&lk->lk);
80105b55:	e9 56 02 00 00       	jmp    80105db0 <release>
80105b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105b60 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80105b60:	55                   	push   %ebp
80105b61:	89 e5                	mov    %esp,%ebp
80105b63:	57                   	push   %edi
80105b64:	56                   	push   %esi
80105b65:	53                   	push   %ebx
80105b66:	31 ff                	xor    %edi,%edi
80105b68:	83 ec 18             	sub    $0x18,%esp
80105b6b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80105b6e:	8d 73 04             	lea    0x4(%ebx),%esi
80105b71:	56                   	push   %esi
80105b72:	e8 79 01 00 00       	call   80105cf0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80105b77:	8b 03                	mov    (%ebx),%eax
80105b79:	83 c4 10             	add    $0x10,%esp
80105b7c:	85 c0                	test   %eax,%eax
80105b7e:	74 13                	je     80105b93 <holdingsleep+0x33>
80105b80:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80105b83:	e8 e8 e7 ff ff       	call   80104370 <myproc>
80105b88:	39 58 10             	cmp    %ebx,0x10(%eax)
80105b8b:	0f 94 c0             	sete   %al
80105b8e:	0f b6 c0             	movzbl %al,%eax
80105b91:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80105b93:	83 ec 0c             	sub    $0xc,%esp
80105b96:	56                   	push   %esi
80105b97:	e8 14 02 00 00       	call   80105db0 <release>
  return r;
}
80105b9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b9f:	89 f8                	mov    %edi,%eax
80105ba1:	5b                   	pop    %ebx
80105ba2:	5e                   	pop    %esi
80105ba3:	5f                   	pop    %edi
80105ba4:	5d                   	pop    %ebp
80105ba5:	c3                   	ret    
80105ba6:	66 90                	xchg   %ax,%ax
80105ba8:	66 90                	xchg   %ax,%ax
80105baa:	66 90                	xchg   %ax,%ax
80105bac:	66 90                	xchg   %ax,%ax
80105bae:	66 90                	xchg   %ax,%ax

80105bb0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105bb0:	55                   	push   %ebp
80105bb1:	89 e5                	mov    %esp,%ebp
80105bb3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80105bb6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80105bb9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80105bbf:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80105bc2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105bc9:	5d                   	pop    %ebp
80105bca:	c3                   	ret    
80105bcb:	90                   	nop
80105bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105bd0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105bd0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105bd1:	31 d2                	xor    %edx,%edx
{
80105bd3:	89 e5                	mov    %esp,%ebp
80105bd5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80105bd6:	8b 45 08             	mov    0x8(%ebp),%eax
{
80105bd9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80105bdc:	83 e8 08             	sub    $0x8,%eax
80105bdf:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105be0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80105be6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80105bec:	77 1a                	ja     80105c08 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
80105bee:	8b 58 04             	mov    0x4(%eax),%ebx
80105bf1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80105bf4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80105bf7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105bf9:	83 fa 0a             	cmp    $0xa,%edx
80105bfc:	75 e2                	jne    80105be0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80105bfe:	5b                   	pop    %ebx
80105bff:	5d                   	pop    %ebp
80105c00:	c3                   	ret    
80105c01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c08:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80105c0b:	83 c1 28             	add    $0x28,%ecx
80105c0e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80105c10:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105c16:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80105c19:	39 c1                	cmp    %eax,%ecx
80105c1b:	75 f3                	jne    80105c10 <getcallerpcs+0x40>
}
80105c1d:	5b                   	pop    %ebx
80105c1e:	5d                   	pop    %ebp
80105c1f:	c3                   	ret    

80105c20 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105c20:	55                   	push   %ebp
80105c21:	89 e5                	mov    %esp,%ebp
80105c23:	53                   	push   %ebx
80105c24:	83 ec 04             	sub    $0x4,%esp
80105c27:	9c                   	pushf  
80105c28:	5b                   	pop    %ebx
  asm volatile("cli");
80105c29:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80105c2a:	e8 51 e5 ff ff       	call   80104180 <mycpu>
80105c2f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80105c35:	85 c0                	test   %eax,%eax
80105c37:	75 11                	jne    80105c4a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80105c39:	81 e3 00 02 00 00    	and    $0x200,%ebx
80105c3f:	e8 3c e5 ff ff       	call   80104180 <mycpu>
80105c44:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
80105c4a:	e8 31 e5 ff ff       	call   80104180 <mycpu>
80105c4f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80105c56:	83 c4 04             	add    $0x4,%esp
80105c59:	5b                   	pop    %ebx
80105c5a:	5d                   	pop    %ebp
80105c5b:	c3                   	ret    
80105c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c60 <popcli>:

void
popcli(void)
{
80105c60:	55                   	push   %ebp
80105c61:	89 e5                	mov    %esp,%ebp
80105c63:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105c66:	9c                   	pushf  
80105c67:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80105c68:	f6 c4 02             	test   $0x2,%ah
80105c6b:	75 35                	jne    80105ca2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80105c6d:	e8 0e e5 ff ff       	call   80104180 <mycpu>
80105c72:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80105c79:	78 34                	js     80105caf <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105c7b:	e8 00 e5 ff ff       	call   80104180 <mycpu>
80105c80:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105c86:	85 d2                	test   %edx,%edx
80105c88:	74 06                	je     80105c90 <popcli+0x30>
    sti();
}
80105c8a:	c9                   	leave  
80105c8b:	c3                   	ret    
80105c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105c90:	e8 eb e4 ff ff       	call   80104180 <mycpu>
80105c95:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80105c9b:	85 c0                	test   %eax,%eax
80105c9d:	74 eb                	je     80105c8a <popcli+0x2a>
  asm volatile("sti");
80105c9f:	fb                   	sti    
}
80105ca0:	c9                   	leave  
80105ca1:	c3                   	ret    
    panic("popcli - interruptible");
80105ca2:	83 ec 0c             	sub    $0xc,%esp
80105ca5:	68 2b 93 10 80       	push   $0x8010932b
80105caa:	e8 e1 a6 ff ff       	call   80100390 <panic>
    panic("popcli");
80105caf:	83 ec 0c             	sub    $0xc,%esp
80105cb2:	68 42 93 10 80       	push   $0x80109342
80105cb7:	e8 d4 a6 ff ff       	call   80100390 <panic>
80105cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105cc0 <holding>:
{
80105cc0:	55                   	push   %ebp
80105cc1:	89 e5                	mov    %esp,%ebp
80105cc3:	56                   	push   %esi
80105cc4:	53                   	push   %ebx
80105cc5:	8b 75 08             	mov    0x8(%ebp),%esi
80105cc8:	31 db                	xor    %ebx,%ebx
  pushcli();
80105cca:	e8 51 ff ff ff       	call   80105c20 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105ccf:	8b 06                	mov    (%esi),%eax
80105cd1:	85 c0                	test   %eax,%eax
80105cd3:	74 10                	je     80105ce5 <holding+0x25>
80105cd5:	8b 5e 08             	mov    0x8(%esi),%ebx
80105cd8:	e8 a3 e4 ff ff       	call   80104180 <mycpu>
80105cdd:	39 c3                	cmp    %eax,%ebx
80105cdf:	0f 94 c3             	sete   %bl
80105ce2:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80105ce5:	e8 76 ff ff ff       	call   80105c60 <popcli>
}
80105cea:	89 d8                	mov    %ebx,%eax
80105cec:	5b                   	pop    %ebx
80105ced:	5e                   	pop    %esi
80105cee:	5d                   	pop    %ebp
80105cef:	c3                   	ret    

80105cf0 <acquire>:
{
80105cf0:	55                   	push   %ebp
80105cf1:	89 e5                	mov    %esp,%ebp
80105cf3:	56                   	push   %esi
80105cf4:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80105cf5:	e8 26 ff ff ff       	call   80105c20 <pushcli>
  if(holding(lk))
80105cfa:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105cfd:	83 ec 0c             	sub    $0xc,%esp
80105d00:	53                   	push   %ebx
80105d01:	e8 ba ff ff ff       	call   80105cc0 <holding>
80105d06:	83 c4 10             	add    $0x10,%esp
80105d09:	85 c0                	test   %eax,%eax
80105d0b:	0f 85 83 00 00 00    	jne    80105d94 <acquire+0xa4>
80105d11:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80105d13:	ba 01 00 00 00       	mov    $0x1,%edx
80105d18:	eb 09                	jmp    80105d23 <acquire+0x33>
80105d1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105d20:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105d23:	89 d0                	mov    %edx,%eax
80105d25:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80105d28:	85 c0                	test   %eax,%eax
80105d2a:	75 f4                	jne    80105d20 <acquire+0x30>
  __sync_synchronize();
80105d2c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80105d31:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105d34:	e8 47 e4 ff ff       	call   80104180 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80105d39:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
80105d3c:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80105d3f:	89 e8                	mov    %ebp,%eax
80105d41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105d48:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
80105d4e:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80105d54:	77 1a                	ja     80105d70 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80105d56:	8b 48 04             	mov    0x4(%eax),%ecx
80105d59:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
80105d5c:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80105d5f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105d61:	83 fe 0a             	cmp    $0xa,%esi
80105d64:	75 e2                	jne    80105d48 <acquire+0x58>
}
80105d66:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105d69:	5b                   	pop    %ebx
80105d6a:	5e                   	pop    %esi
80105d6b:	5d                   	pop    %ebp
80105d6c:	c3                   	ret    
80105d6d:	8d 76 00             	lea    0x0(%esi),%esi
80105d70:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80105d73:	83 c2 28             	add    $0x28,%edx
80105d76:	8d 76 00             	lea    0x0(%esi),%esi
80105d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80105d80:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105d86:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80105d89:	39 d0                	cmp    %edx,%eax
80105d8b:	75 f3                	jne    80105d80 <acquire+0x90>
}
80105d8d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105d90:	5b                   	pop    %ebx
80105d91:	5e                   	pop    %esi
80105d92:	5d                   	pop    %ebp
80105d93:	c3                   	ret    
    panic("acquire");
80105d94:	83 ec 0c             	sub    $0xc,%esp
80105d97:	68 49 93 10 80       	push   $0x80109349
80105d9c:	e8 ef a5 ff ff       	call   80100390 <panic>
80105da1:	eb 0d                	jmp    80105db0 <release>
80105da3:	90                   	nop
80105da4:	90                   	nop
80105da5:	90                   	nop
80105da6:	90                   	nop
80105da7:	90                   	nop
80105da8:	90                   	nop
80105da9:	90                   	nop
80105daa:	90                   	nop
80105dab:	90                   	nop
80105dac:	90                   	nop
80105dad:	90                   	nop
80105dae:	90                   	nop
80105daf:	90                   	nop

80105db0 <release>:
{
80105db0:	55                   	push   %ebp
80105db1:	89 e5                	mov    %esp,%ebp
80105db3:	53                   	push   %ebx
80105db4:	83 ec 10             	sub    $0x10,%esp
80105db7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80105dba:	53                   	push   %ebx
80105dbb:	e8 00 ff ff ff       	call   80105cc0 <holding>
80105dc0:	83 c4 10             	add    $0x10,%esp
80105dc3:	85 c0                	test   %eax,%eax
80105dc5:	74 22                	je     80105de9 <release+0x39>
  lk->pcs[0] = 0;
80105dc7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105dce:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105dd5:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80105dda:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105de0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105de3:	c9                   	leave  
  popcli();
80105de4:	e9 77 fe ff ff       	jmp    80105c60 <popcli>
    panic("release");
80105de9:	83 ec 0c             	sub    $0xc,%esp
80105dec:	68 51 93 10 80       	push   $0x80109351
80105df1:	e8 9a a5 ff ff       	call   80100390 <panic>
80105df6:	66 90                	xchg   %ax,%ax
80105df8:	66 90                	xchg   %ax,%ax
80105dfa:	66 90                	xchg   %ax,%ax
80105dfc:	66 90                	xchg   %ax,%ax
80105dfe:	66 90                	xchg   %ax,%ax

80105e00 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105e00:	55                   	push   %ebp
80105e01:	89 e5                	mov    %esp,%ebp
80105e03:	57                   	push   %edi
80105e04:	53                   	push   %ebx
80105e05:	8b 55 08             	mov    0x8(%ebp),%edx
80105e08:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80105e0b:	f6 c2 03             	test   $0x3,%dl
80105e0e:	75 05                	jne    80105e15 <memset+0x15>
80105e10:	f6 c1 03             	test   $0x3,%cl
80105e13:	74 13                	je     80105e28 <memset+0x28>
  asm volatile("cld; rep stosb" :
80105e15:	89 d7                	mov    %edx,%edi
80105e17:	8b 45 0c             	mov    0xc(%ebp),%eax
80105e1a:	fc                   	cld    
80105e1b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80105e1d:	5b                   	pop    %ebx
80105e1e:	89 d0                	mov    %edx,%eax
80105e20:	5f                   	pop    %edi
80105e21:	5d                   	pop    %ebp
80105e22:	c3                   	ret    
80105e23:	90                   	nop
80105e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80105e28:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80105e2c:	c1 e9 02             	shr    $0x2,%ecx
80105e2f:	89 f8                	mov    %edi,%eax
80105e31:	89 fb                	mov    %edi,%ebx
80105e33:	c1 e0 18             	shl    $0x18,%eax
80105e36:	c1 e3 10             	shl    $0x10,%ebx
80105e39:	09 d8                	or     %ebx,%eax
80105e3b:	09 f8                	or     %edi,%eax
80105e3d:	c1 e7 08             	shl    $0x8,%edi
80105e40:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80105e42:	89 d7                	mov    %edx,%edi
80105e44:	fc                   	cld    
80105e45:	f3 ab                	rep stos %eax,%es:(%edi)
}
80105e47:	5b                   	pop    %ebx
80105e48:	89 d0                	mov    %edx,%eax
80105e4a:	5f                   	pop    %edi
80105e4b:	5d                   	pop    %ebp
80105e4c:	c3                   	ret    
80105e4d:	8d 76 00             	lea    0x0(%esi),%esi

80105e50 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105e50:	55                   	push   %ebp
80105e51:	89 e5                	mov    %esp,%ebp
80105e53:	57                   	push   %edi
80105e54:	56                   	push   %esi
80105e55:	53                   	push   %ebx
80105e56:	8b 5d 10             	mov    0x10(%ebp),%ebx
80105e59:	8b 75 08             	mov    0x8(%ebp),%esi
80105e5c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105e5f:	85 db                	test   %ebx,%ebx
80105e61:	74 29                	je     80105e8c <memcmp+0x3c>
    if(*s1 != *s2)
80105e63:	0f b6 16             	movzbl (%esi),%edx
80105e66:	0f b6 0f             	movzbl (%edi),%ecx
80105e69:	38 d1                	cmp    %dl,%cl
80105e6b:	75 2b                	jne    80105e98 <memcmp+0x48>
80105e6d:	b8 01 00 00 00       	mov    $0x1,%eax
80105e72:	eb 14                	jmp    80105e88 <memcmp+0x38>
80105e74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e78:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80105e7c:	83 c0 01             	add    $0x1,%eax
80105e7f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80105e84:	38 ca                	cmp    %cl,%dl
80105e86:	75 10                	jne    80105e98 <memcmp+0x48>
  while(n-- > 0){
80105e88:	39 d8                	cmp    %ebx,%eax
80105e8a:	75 ec                	jne    80105e78 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80105e8c:	5b                   	pop    %ebx
  return 0;
80105e8d:	31 c0                	xor    %eax,%eax
}
80105e8f:	5e                   	pop    %esi
80105e90:	5f                   	pop    %edi
80105e91:	5d                   	pop    %ebp
80105e92:	c3                   	ret    
80105e93:	90                   	nop
80105e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80105e98:	0f b6 c2             	movzbl %dl,%eax
}
80105e9b:	5b                   	pop    %ebx
      return *s1 - *s2;
80105e9c:	29 c8                	sub    %ecx,%eax
}
80105e9e:	5e                   	pop    %esi
80105e9f:	5f                   	pop    %edi
80105ea0:	5d                   	pop    %ebp
80105ea1:	c3                   	ret    
80105ea2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105eb0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105eb0:	55                   	push   %ebp
80105eb1:	89 e5                	mov    %esp,%ebp
80105eb3:	56                   	push   %esi
80105eb4:	53                   	push   %ebx
80105eb5:	8b 45 08             	mov    0x8(%ebp),%eax
80105eb8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80105ebb:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80105ebe:	39 c3                	cmp    %eax,%ebx
80105ec0:	73 26                	jae    80105ee8 <memmove+0x38>
80105ec2:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80105ec5:	39 c8                	cmp    %ecx,%eax
80105ec7:	73 1f                	jae    80105ee8 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80105ec9:	85 f6                	test   %esi,%esi
80105ecb:	8d 56 ff             	lea    -0x1(%esi),%edx
80105ece:	74 0f                	je     80105edf <memmove+0x2f>
      *--d = *--s;
80105ed0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105ed4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80105ed7:	83 ea 01             	sub    $0x1,%edx
80105eda:	83 fa ff             	cmp    $0xffffffff,%edx
80105edd:	75 f1                	jne    80105ed0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80105edf:	5b                   	pop    %ebx
80105ee0:	5e                   	pop    %esi
80105ee1:	5d                   	pop    %ebp
80105ee2:	c3                   	ret    
80105ee3:	90                   	nop
80105ee4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80105ee8:	31 d2                	xor    %edx,%edx
80105eea:	85 f6                	test   %esi,%esi
80105eec:	74 f1                	je     80105edf <memmove+0x2f>
80105eee:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80105ef0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105ef4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80105ef7:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
80105efa:	39 d6                	cmp    %edx,%esi
80105efc:	75 f2                	jne    80105ef0 <memmove+0x40>
}
80105efe:	5b                   	pop    %ebx
80105eff:	5e                   	pop    %esi
80105f00:	5d                   	pop    %ebp
80105f01:	c3                   	ret    
80105f02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105f10 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105f10:	55                   	push   %ebp
80105f11:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80105f13:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80105f14:	eb 9a                	jmp    80105eb0 <memmove>
80105f16:	8d 76 00             	lea    0x0(%esi),%esi
80105f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105f20 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80105f20:	55                   	push   %ebp
80105f21:	89 e5                	mov    %esp,%ebp
80105f23:	57                   	push   %edi
80105f24:	56                   	push   %esi
80105f25:	8b 7d 10             	mov    0x10(%ebp),%edi
80105f28:	53                   	push   %ebx
80105f29:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105f2c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
80105f2f:	85 ff                	test   %edi,%edi
80105f31:	74 2f                	je     80105f62 <strncmp+0x42>
80105f33:	0f b6 01             	movzbl (%ecx),%eax
80105f36:	0f b6 1e             	movzbl (%esi),%ebx
80105f39:	84 c0                	test   %al,%al
80105f3b:	74 37                	je     80105f74 <strncmp+0x54>
80105f3d:	38 c3                	cmp    %al,%bl
80105f3f:	75 33                	jne    80105f74 <strncmp+0x54>
80105f41:	01 f7                	add    %esi,%edi
80105f43:	eb 13                	jmp    80105f58 <strncmp+0x38>
80105f45:	8d 76 00             	lea    0x0(%esi),%esi
80105f48:	0f b6 01             	movzbl (%ecx),%eax
80105f4b:	84 c0                	test   %al,%al
80105f4d:	74 21                	je     80105f70 <strncmp+0x50>
80105f4f:	0f b6 1a             	movzbl (%edx),%ebx
80105f52:	89 d6                	mov    %edx,%esi
80105f54:	38 d8                	cmp    %bl,%al
80105f56:	75 1c                	jne    80105f74 <strncmp+0x54>
    n--, p++, q++;
80105f58:	8d 56 01             	lea    0x1(%esi),%edx
80105f5b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80105f5e:	39 fa                	cmp    %edi,%edx
80105f60:	75 e6                	jne    80105f48 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80105f62:	5b                   	pop    %ebx
    return 0;
80105f63:	31 c0                	xor    %eax,%eax
}
80105f65:	5e                   	pop    %esi
80105f66:	5f                   	pop    %edi
80105f67:	5d                   	pop    %ebp
80105f68:	c3                   	ret    
80105f69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f70:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80105f74:	29 d8                	sub    %ebx,%eax
}
80105f76:	5b                   	pop    %ebx
80105f77:	5e                   	pop    %esi
80105f78:	5f                   	pop    %edi
80105f79:	5d                   	pop    %ebp
80105f7a:	c3                   	ret    
80105f7b:	90                   	nop
80105f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105f80 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105f80:	55                   	push   %ebp
80105f81:	89 e5                	mov    %esp,%ebp
80105f83:	56                   	push   %esi
80105f84:	53                   	push   %ebx
80105f85:	8b 45 08             	mov    0x8(%ebp),%eax
80105f88:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80105f8b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80105f8e:	89 c2                	mov    %eax,%edx
80105f90:	eb 19                	jmp    80105fab <strncpy+0x2b>
80105f92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105f98:	83 c3 01             	add    $0x1,%ebx
80105f9b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
80105f9f:	83 c2 01             	add    $0x1,%edx
80105fa2:	84 c9                	test   %cl,%cl
80105fa4:	88 4a ff             	mov    %cl,-0x1(%edx)
80105fa7:	74 09                	je     80105fb2 <strncpy+0x32>
80105fa9:	89 f1                	mov    %esi,%ecx
80105fab:	85 c9                	test   %ecx,%ecx
80105fad:	8d 71 ff             	lea    -0x1(%ecx),%esi
80105fb0:	7f e6                	jg     80105f98 <strncpy+0x18>
    ;
  while(n-- > 0)
80105fb2:	31 c9                	xor    %ecx,%ecx
80105fb4:	85 f6                	test   %esi,%esi
80105fb6:	7e 17                	jle    80105fcf <strncpy+0x4f>
80105fb8:	90                   	nop
80105fb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80105fc0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80105fc4:	89 f3                	mov    %esi,%ebx
80105fc6:	83 c1 01             	add    $0x1,%ecx
80105fc9:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
80105fcb:	85 db                	test   %ebx,%ebx
80105fcd:	7f f1                	jg     80105fc0 <strncpy+0x40>
  return os;
}
80105fcf:	5b                   	pop    %ebx
80105fd0:	5e                   	pop    %esi
80105fd1:	5d                   	pop    %ebp
80105fd2:	c3                   	ret    
80105fd3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105fe0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105fe0:	55                   	push   %ebp
80105fe1:	89 e5                	mov    %esp,%ebp
80105fe3:	56                   	push   %esi
80105fe4:	53                   	push   %ebx
80105fe5:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105fe8:	8b 45 08             	mov    0x8(%ebp),%eax
80105feb:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80105fee:	85 c9                	test   %ecx,%ecx
80105ff0:	7e 26                	jle    80106018 <safestrcpy+0x38>
80105ff2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80105ff6:	89 c1                	mov    %eax,%ecx
80105ff8:	eb 17                	jmp    80106011 <safestrcpy+0x31>
80105ffa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80106000:	83 c2 01             	add    $0x1,%edx
80106003:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80106007:	83 c1 01             	add    $0x1,%ecx
8010600a:	84 db                	test   %bl,%bl
8010600c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010600f:	74 04                	je     80106015 <safestrcpy+0x35>
80106011:	39 f2                	cmp    %esi,%edx
80106013:	75 eb                	jne    80106000 <safestrcpy+0x20>
    ;
  *s = 0;
80106015:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80106018:	5b                   	pop    %ebx
80106019:	5e                   	pop    %esi
8010601a:	5d                   	pop    %ebp
8010601b:	c3                   	ret    
8010601c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106020 <strlen>:

int
strlen(const char *s)
{
80106020:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80106021:	31 c0                	xor    %eax,%eax
{
80106023:	89 e5                	mov    %esp,%ebp
80106025:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80106028:	80 3a 00             	cmpb   $0x0,(%edx)
8010602b:	74 0c                	je     80106039 <strlen+0x19>
8010602d:	8d 76 00             	lea    0x0(%esi),%esi
80106030:	83 c0 01             	add    $0x1,%eax
80106033:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80106037:	75 f7                	jne    80106030 <strlen+0x10>
    ;
  return n;
}
80106039:	5d                   	pop    %ebp
8010603a:	c3                   	ret    

8010603b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010603b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010603f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80106043:	55                   	push   %ebp
  pushl %ebx
80106044:	53                   	push   %ebx
  pushl %esi
80106045:	56                   	push   %esi
  pushl %edi
80106046:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80106047:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80106049:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
8010604b:	5f                   	pop    %edi
  popl %esi
8010604c:	5e                   	pop    %esi
  popl %ebx
8010604d:	5b                   	pop    %ebx
  popl %ebp
8010604e:	5d                   	pop    %ebp
  ret
8010604f:	c3                   	ret    

80106050 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80106050:	55                   	push   %ebp
80106051:	89 e5                	mov    %esp,%ebp
80106053:	53                   	push   %ebx
80106054:	83 ec 04             	sub    $0x4,%esp
80106057:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010605a:	e8 11 e3 ff ff       	call   80104370 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010605f:	8b 00                	mov    (%eax),%eax
80106061:	39 d8                	cmp    %ebx,%eax
80106063:	76 1b                	jbe    80106080 <fetchint+0x30>
80106065:	8d 53 04             	lea    0x4(%ebx),%edx
80106068:	39 d0                	cmp    %edx,%eax
8010606a:	72 14                	jb     80106080 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010606c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010606f:	8b 13                	mov    (%ebx),%edx
80106071:	89 10                	mov    %edx,(%eax)
  return 0;
80106073:	31 c0                	xor    %eax,%eax
}
80106075:	83 c4 04             	add    $0x4,%esp
80106078:	5b                   	pop    %ebx
80106079:	5d                   	pop    %ebp
8010607a:	c3                   	ret    
8010607b:	90                   	nop
8010607c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106080:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106085:	eb ee                	jmp    80106075 <fetchint+0x25>
80106087:	89 f6                	mov    %esi,%esi
80106089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106090 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80106090:	55                   	push   %ebp
80106091:	89 e5                	mov    %esp,%ebp
80106093:	53                   	push   %ebx
80106094:	83 ec 04             	sub    $0x4,%esp
80106097:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010609a:	e8 d1 e2 ff ff       	call   80104370 <myproc>

  if(addr >= curproc->sz)
8010609f:	39 18                	cmp    %ebx,(%eax)
801060a1:	76 29                	jbe    801060cc <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
801060a3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801060a6:	89 da                	mov    %ebx,%edx
801060a8:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
801060aa:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
801060ac:	39 c3                	cmp    %eax,%ebx
801060ae:	73 1c                	jae    801060cc <fetchstr+0x3c>
    if(*s == 0)
801060b0:	80 3b 00             	cmpb   $0x0,(%ebx)
801060b3:	75 10                	jne    801060c5 <fetchstr+0x35>
801060b5:	eb 39                	jmp    801060f0 <fetchstr+0x60>
801060b7:	89 f6                	mov    %esi,%esi
801060b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801060c0:	80 3a 00             	cmpb   $0x0,(%edx)
801060c3:	74 1b                	je     801060e0 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
801060c5:	83 c2 01             	add    $0x1,%edx
801060c8:	39 d0                	cmp    %edx,%eax
801060ca:	77 f4                	ja     801060c0 <fetchstr+0x30>
    return -1;
801060cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
801060d1:	83 c4 04             	add    $0x4,%esp
801060d4:	5b                   	pop    %ebx
801060d5:	5d                   	pop    %ebp
801060d6:	c3                   	ret    
801060d7:	89 f6                	mov    %esi,%esi
801060d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801060e0:	83 c4 04             	add    $0x4,%esp
801060e3:	89 d0                	mov    %edx,%eax
801060e5:	29 d8                	sub    %ebx,%eax
801060e7:	5b                   	pop    %ebx
801060e8:	5d                   	pop    %ebp
801060e9:	c3                   	ret    
801060ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
801060f0:	31 c0                	xor    %eax,%eax
      return s - *pp;
801060f2:	eb dd                	jmp    801060d1 <fetchstr+0x41>
801060f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801060fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106100 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80106100:	55                   	push   %ebp
80106101:	89 e5                	mov    %esp,%ebp
80106103:	56                   	push   %esi
80106104:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80106105:	e8 66 e2 ff ff       	call   80104370 <myproc>
8010610a:	8b 40 18             	mov    0x18(%eax),%eax
8010610d:	8b 55 08             	mov    0x8(%ebp),%edx
80106110:	8b 40 44             	mov    0x44(%eax),%eax
80106113:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80106116:	e8 55 e2 ff ff       	call   80104370 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010611b:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010611d:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80106120:	39 c6                	cmp    %eax,%esi
80106122:	73 1c                	jae    80106140 <argint+0x40>
80106124:	8d 53 08             	lea    0x8(%ebx),%edx
80106127:	39 d0                	cmp    %edx,%eax
80106129:	72 15                	jb     80106140 <argint+0x40>
  *ip = *(int*)(addr);
8010612b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010612e:	8b 53 04             	mov    0x4(%ebx),%edx
80106131:	89 10                	mov    %edx,(%eax)
  return 0;
80106133:	31 c0                	xor    %eax,%eax
}
80106135:	5b                   	pop    %ebx
80106136:	5e                   	pop    %esi
80106137:	5d                   	pop    %ebp
80106138:	c3                   	ret    
80106139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106140:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80106145:	eb ee                	jmp    80106135 <argint+0x35>
80106147:	89 f6                	mov    %esi,%esi
80106149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106150 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80106150:	55                   	push   %ebp
80106151:	89 e5                	mov    %esp,%ebp
80106153:	56                   	push   %esi
80106154:	53                   	push   %ebx
80106155:	83 ec 10             	sub    $0x10,%esp
80106158:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010615b:	e8 10 e2 ff ff       	call   80104370 <myproc>
80106160:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80106162:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106165:	83 ec 08             	sub    $0x8,%esp
80106168:	50                   	push   %eax
80106169:	ff 75 08             	pushl  0x8(%ebp)
8010616c:	e8 8f ff ff ff       	call   80106100 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80106171:	83 c4 10             	add    $0x10,%esp
80106174:	85 c0                	test   %eax,%eax
80106176:	78 28                	js     801061a0 <argptr+0x50>
80106178:	85 db                	test   %ebx,%ebx
8010617a:	78 24                	js     801061a0 <argptr+0x50>
8010617c:	8b 16                	mov    (%esi),%edx
8010617e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106181:	39 c2                	cmp    %eax,%edx
80106183:	76 1b                	jbe    801061a0 <argptr+0x50>
80106185:	01 c3                	add    %eax,%ebx
80106187:	39 da                	cmp    %ebx,%edx
80106189:	72 15                	jb     801061a0 <argptr+0x50>
    return -1;
  *pp = (char*)i;
8010618b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010618e:	89 02                	mov    %eax,(%edx)
  return 0;
80106190:	31 c0                	xor    %eax,%eax
}
80106192:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106195:	5b                   	pop    %ebx
80106196:	5e                   	pop    %esi
80106197:	5d                   	pop    %ebp
80106198:	c3                   	ret    
80106199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801061a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061a5:	eb eb                	jmp    80106192 <argptr+0x42>
801061a7:	89 f6                	mov    %esi,%esi
801061a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801061b0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801061b0:	55                   	push   %ebp
801061b1:	89 e5                	mov    %esp,%ebp
801061b3:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
801061b6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801061b9:	50                   	push   %eax
801061ba:	ff 75 08             	pushl  0x8(%ebp)
801061bd:	e8 3e ff ff ff       	call   80106100 <argint>
801061c2:	83 c4 10             	add    $0x10,%esp
801061c5:	85 c0                	test   %eax,%eax
801061c7:	78 17                	js     801061e0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
801061c9:	83 ec 08             	sub    $0x8,%esp
801061cc:	ff 75 0c             	pushl  0xc(%ebp)
801061cf:	ff 75 f4             	pushl  -0xc(%ebp)
801061d2:	e8 b9 fe ff ff       	call   80106090 <fetchstr>
801061d7:	83 c4 10             	add    $0x10,%esp
}
801061da:	c9                   	leave  
801061db:	c3                   	ret    
801061dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801061e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801061e5:	c9                   	leave  
801061e6:	c3                   	ret    
801061e7:	89 f6                	mov    %esi,%esi
801061e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801061f0 <syscall>:
[SYS_xem_unlock]		sys_xem_unlock,
};

void
syscall(void)
{
801061f0:	55                   	push   %ebp
801061f1:	89 e5                	mov    %esp,%ebp
801061f3:	53                   	push   %ebx
801061f4:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
801061f7:	e8 74 e1 ff ff       	call   80104370 <myproc>
801061fc:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
801061fe:	8b 40 18             	mov    0x18(%eax),%eax
80106201:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80106204:	8d 50 ff             	lea    -0x1(%eax),%edx
80106207:	83 fa 1d             	cmp    $0x1d,%edx
8010620a:	77 1c                	ja     80106228 <syscall+0x38>
8010620c:	8b 14 85 80 93 10 80 	mov    -0x7fef6c80(,%eax,4),%edx
80106213:	85 d2                	test   %edx,%edx
80106215:	74 11                	je     80106228 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80106217:	ff d2                	call   *%edx
80106219:	8b 53 18             	mov    0x18(%ebx),%edx
8010621c:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
8010621f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106222:	c9                   	leave  
80106223:	c3                   	ret    
80106224:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80106228:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80106229:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
8010622c:	50                   	push   %eax
8010622d:	ff 73 10             	pushl  0x10(%ebx)
80106230:	68 59 93 10 80       	push   $0x80109359
80106235:	e8 26 a4 ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
8010623a:	8b 43 18             	mov    0x18(%ebx),%eax
8010623d:	83 c4 10             	add    $0x10,%esp
80106240:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80106247:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010624a:	c9                   	leave  
8010624b:	c3                   	ret    
8010624c:	66 90                	xchg   %ax,%ax
8010624e:	66 90                	xchg   %ax,%ax

80106250 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80106250:	55                   	push   %ebp
80106251:	89 e5                	mov    %esp,%ebp
80106253:	57                   	push   %edi
80106254:	56                   	push   %esi
80106255:	53                   	push   %ebx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80106256:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80106259:	83 ec 34             	sub    $0x34,%esp
8010625c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
8010625f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80106262:	56                   	push   %esi
80106263:	50                   	push   %eax
{
80106264:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80106267:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010626a:	e8 21 c2 ff ff       	call   80102490 <nameiparent>
8010626f:	83 c4 10             	add    $0x10,%esp
80106272:	85 c0                	test   %eax,%eax
80106274:	0f 84 46 01 00 00    	je     801063c0 <create+0x170>
    return 0;
  ilock(dp);
8010627a:	83 ec 0c             	sub    $0xc,%esp
8010627d:	89 c3                	mov    %eax,%ebx
8010627f:	50                   	push   %eax
80106280:	e8 4b b7 ff ff       	call   801019d0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80106285:	83 c4 0c             	add    $0xc,%esp
80106288:	6a 00                	push   $0x0
8010628a:	56                   	push   %esi
8010628b:	53                   	push   %ebx
8010628c:	e8 af be ff ff       	call   80102140 <dirlookup>
80106291:	83 c4 10             	add    $0x10,%esp
80106294:	85 c0                	test   %eax,%eax
80106296:	89 c7                	mov    %eax,%edi
80106298:	74 36                	je     801062d0 <create+0x80>
    iunlockput(dp);
8010629a:	83 ec 0c             	sub    $0xc,%esp
8010629d:	53                   	push   %ebx
8010629e:	e8 fd bb ff ff       	call   80101ea0 <iunlockput>
    ilock(ip);
801062a3:	89 3c 24             	mov    %edi,(%esp)
801062a6:	e8 25 b7 ff ff       	call   801019d0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801062ab:	83 c4 10             	add    $0x10,%esp
801062ae:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
801062b3:	0f 85 97 00 00 00    	jne    80106350 <create+0x100>
801062b9:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
801062be:	0f 85 8c 00 00 00    	jne    80106350 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801062c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801062c7:	89 f8                	mov    %edi,%eax
801062c9:	5b                   	pop    %ebx
801062ca:	5e                   	pop    %esi
801062cb:	5f                   	pop    %edi
801062cc:	5d                   	pop    %ebp
801062cd:	c3                   	ret    
801062ce:	66 90                	xchg   %ax,%ax
  if((ip = ialloc(dp->dev, type)) == 0)
801062d0:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
801062d4:	83 ec 08             	sub    $0x8,%esp
801062d7:	50                   	push   %eax
801062d8:	ff 33                	pushl  (%ebx)
801062da:	e8 81 b5 ff ff       	call   80101860 <ialloc>
801062df:	83 c4 10             	add    $0x10,%esp
801062e2:	85 c0                	test   %eax,%eax
801062e4:	89 c7                	mov    %eax,%edi
801062e6:	0f 84 e8 00 00 00    	je     801063d4 <create+0x184>
  ilock(ip);
801062ec:	83 ec 0c             	sub    $0xc,%esp
801062ef:	50                   	push   %eax
801062f0:	e8 db b6 ff ff       	call   801019d0 <ilock>
  ip->major = major;
801062f5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
801062f9:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
801062fd:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80106301:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80106305:	b8 01 00 00 00       	mov    $0x1,%eax
8010630a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
8010630e:	89 3c 24             	mov    %edi,(%esp)
80106311:	e8 0a b6 ff ff       	call   80101920 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80106316:	83 c4 10             	add    $0x10,%esp
80106319:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010631e:	74 50                	je     80106370 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80106320:	83 ec 04             	sub    $0x4,%esp
80106323:	ff 77 04             	pushl  0x4(%edi)
80106326:	56                   	push   %esi
80106327:	53                   	push   %ebx
80106328:	e8 83 c0 ff ff       	call   801023b0 <dirlink>
8010632d:	83 c4 10             	add    $0x10,%esp
80106330:	85 c0                	test   %eax,%eax
80106332:	0f 88 8f 00 00 00    	js     801063c7 <create+0x177>
  iunlockput(dp);
80106338:	83 ec 0c             	sub    $0xc,%esp
8010633b:	53                   	push   %ebx
8010633c:	e8 5f bb ff ff       	call   80101ea0 <iunlockput>
  return ip;
80106341:	83 c4 10             	add    $0x10,%esp
}
80106344:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106347:	89 f8                	mov    %edi,%eax
80106349:	5b                   	pop    %ebx
8010634a:	5e                   	pop    %esi
8010634b:	5f                   	pop    %edi
8010634c:	5d                   	pop    %ebp
8010634d:	c3                   	ret    
8010634e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80106350:	83 ec 0c             	sub    $0xc,%esp
80106353:	57                   	push   %edi
    return 0;
80106354:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80106356:	e8 45 bb ff ff       	call   80101ea0 <iunlockput>
    return 0;
8010635b:	83 c4 10             	add    $0x10,%esp
}
8010635e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106361:	89 f8                	mov    %edi,%eax
80106363:	5b                   	pop    %ebx
80106364:	5e                   	pop    %esi
80106365:	5f                   	pop    %edi
80106366:	5d                   	pop    %ebp
80106367:	c3                   	ret    
80106368:	90                   	nop
80106369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80106370:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80106375:	83 ec 0c             	sub    $0xc,%esp
80106378:	53                   	push   %ebx
80106379:	e8 a2 b5 ff ff       	call   80101920 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010637e:	83 c4 0c             	add    $0xc,%esp
80106381:	ff 77 04             	pushl  0x4(%edi)
80106384:	68 e7 91 10 80       	push   $0x801091e7
80106389:	57                   	push   %edi
8010638a:	e8 21 c0 ff ff       	call   801023b0 <dirlink>
8010638f:	83 c4 10             	add    $0x10,%esp
80106392:	85 c0                	test   %eax,%eax
80106394:	78 1c                	js     801063b2 <create+0x162>
80106396:	83 ec 04             	sub    $0x4,%esp
80106399:	ff 73 04             	pushl  0x4(%ebx)
8010639c:	68 17 94 10 80       	push   $0x80109417
801063a1:	57                   	push   %edi
801063a2:	e8 09 c0 ff ff       	call   801023b0 <dirlink>
801063a7:	83 c4 10             	add    $0x10,%esp
801063aa:	85 c0                	test   %eax,%eax
801063ac:	0f 89 6e ff ff ff    	jns    80106320 <create+0xd0>
      panic("create dots");
801063b2:	83 ec 0c             	sub    $0xc,%esp
801063b5:	68 0b 94 10 80       	push   $0x8010940b
801063ba:	e8 d1 9f ff ff       	call   80100390 <panic>
801063bf:	90                   	nop
    return 0;
801063c0:	31 ff                	xor    %edi,%edi
801063c2:	e9 fd fe ff ff       	jmp    801062c4 <create+0x74>
    panic("create: dirlink");
801063c7:	83 ec 0c             	sub    $0xc,%esp
801063ca:	68 1a 94 10 80       	push   $0x8010941a
801063cf:	e8 bc 9f ff ff       	call   80100390 <panic>
    panic("create: ialloc");
801063d4:	83 ec 0c             	sub    $0xc,%esp
801063d7:	68 fc 93 10 80       	push   $0x801093fc
801063dc:	e8 af 9f ff ff       	call   80100390 <panic>
801063e1:	eb 0d                	jmp    801063f0 <argfd.constprop.0>
801063e3:	90                   	nop
801063e4:	90                   	nop
801063e5:	90                   	nop
801063e6:	90                   	nop
801063e7:	90                   	nop
801063e8:	90                   	nop
801063e9:	90                   	nop
801063ea:	90                   	nop
801063eb:	90                   	nop
801063ec:	90                   	nop
801063ed:	90                   	nop
801063ee:	90                   	nop
801063ef:	90                   	nop

801063f0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
801063f0:	55                   	push   %ebp
801063f1:	89 e5                	mov    %esp,%ebp
801063f3:	56                   	push   %esi
801063f4:	53                   	push   %ebx
801063f5:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
801063f7:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
801063fa:	89 d6                	mov    %edx,%esi
801063fc:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801063ff:	50                   	push   %eax
80106400:	6a 00                	push   $0x0
80106402:	e8 f9 fc ff ff       	call   80106100 <argint>
80106407:	83 c4 10             	add    $0x10,%esp
8010640a:	85 c0                	test   %eax,%eax
8010640c:	78 2a                	js     80106438 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010640e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80106412:	77 24                	ja     80106438 <argfd.constprop.0+0x48>
80106414:	e8 57 df ff ff       	call   80104370 <myproc>
80106419:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010641c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80106420:	85 c0                	test   %eax,%eax
80106422:	74 14                	je     80106438 <argfd.constprop.0+0x48>
  if(pfd)
80106424:	85 db                	test   %ebx,%ebx
80106426:	74 02                	je     8010642a <argfd.constprop.0+0x3a>
    *pfd = fd;
80106428:	89 13                	mov    %edx,(%ebx)
    *pf = f;
8010642a:	89 06                	mov    %eax,(%esi)
  return 0;
8010642c:	31 c0                	xor    %eax,%eax
}
8010642e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106431:	5b                   	pop    %ebx
80106432:	5e                   	pop    %esi
80106433:	5d                   	pop    %ebp
80106434:	c3                   	ret    
80106435:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106438:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010643d:	eb ef                	jmp    8010642e <argfd.constprop.0+0x3e>
8010643f:	90                   	nop

80106440 <sys_dup>:
{
80106440:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80106441:	31 c0                	xor    %eax,%eax
{
80106443:	89 e5                	mov    %esp,%ebp
80106445:	56                   	push   %esi
80106446:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80106447:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
8010644a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
8010644d:	e8 9e ff ff ff       	call   801063f0 <argfd.constprop.0>
80106452:	85 c0                	test   %eax,%eax
80106454:	78 42                	js     80106498 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
80106456:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106459:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010645b:	e8 10 df ff ff       	call   80104370 <myproc>
80106460:	eb 0e                	jmp    80106470 <sys_dup+0x30>
80106462:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106468:	83 c3 01             	add    $0x1,%ebx
8010646b:	83 fb 10             	cmp    $0x10,%ebx
8010646e:	74 28                	je     80106498 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80106470:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80106474:	85 d2                	test   %edx,%edx
80106476:	75 f0                	jne    80106468 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80106478:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
8010647c:	83 ec 0c             	sub    $0xc,%esp
8010647f:	ff 75 f4             	pushl  -0xc(%ebp)
80106482:	e8 69 a9 ff ff       	call   80100df0 <filedup>
  return fd;
80106487:	83 c4 10             	add    $0x10,%esp
}
8010648a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010648d:	89 d8                	mov    %ebx,%eax
8010648f:	5b                   	pop    %ebx
80106490:	5e                   	pop    %esi
80106491:	5d                   	pop    %ebp
80106492:	c3                   	ret    
80106493:	90                   	nop
80106494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106498:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
8010649b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
801064a0:	89 d8                	mov    %ebx,%eax
801064a2:	5b                   	pop    %ebx
801064a3:	5e                   	pop    %esi
801064a4:	5d                   	pop    %ebp
801064a5:	c3                   	ret    
801064a6:	8d 76 00             	lea    0x0(%esi),%esi
801064a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801064b0 <sys_read>:
{
801064b0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801064b1:	31 c0                	xor    %eax,%eax
{
801064b3:	89 e5                	mov    %esp,%ebp
801064b5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801064b8:	8d 55 ec             	lea    -0x14(%ebp),%edx
801064bb:	e8 30 ff ff ff       	call   801063f0 <argfd.constprop.0>
801064c0:	85 c0                	test   %eax,%eax
801064c2:	78 4c                	js     80106510 <sys_read+0x60>
801064c4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801064c7:	83 ec 08             	sub    $0x8,%esp
801064ca:	50                   	push   %eax
801064cb:	6a 02                	push   $0x2
801064cd:	e8 2e fc ff ff       	call   80106100 <argint>
801064d2:	83 c4 10             	add    $0x10,%esp
801064d5:	85 c0                	test   %eax,%eax
801064d7:	78 37                	js     80106510 <sys_read+0x60>
801064d9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801064dc:	83 ec 04             	sub    $0x4,%esp
801064df:	ff 75 f0             	pushl  -0x10(%ebp)
801064e2:	50                   	push   %eax
801064e3:	6a 01                	push   $0x1
801064e5:	e8 66 fc ff ff       	call   80106150 <argptr>
801064ea:	83 c4 10             	add    $0x10,%esp
801064ed:	85 c0                	test   %eax,%eax
801064ef:	78 1f                	js     80106510 <sys_read+0x60>
  return fileread(f, p, n);
801064f1:	83 ec 04             	sub    $0x4,%esp
801064f4:	ff 75 f0             	pushl  -0x10(%ebp)
801064f7:	ff 75 f4             	pushl  -0xc(%ebp)
801064fa:	ff 75 ec             	pushl  -0x14(%ebp)
801064fd:	e8 5e aa ff ff       	call   80100f60 <fileread>
80106502:	83 c4 10             	add    $0x10,%esp
}
80106505:	c9                   	leave  
80106506:	c3                   	ret    
80106507:	89 f6                	mov    %esi,%esi
80106509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80106510:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106515:	c9                   	leave  
80106516:	c3                   	ret    
80106517:	89 f6                	mov    %esi,%esi
80106519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106520 <sys_write>:
{
80106520:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106521:	31 c0                	xor    %eax,%eax
{
80106523:	89 e5                	mov    %esp,%ebp
80106525:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106528:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010652b:	e8 c0 fe ff ff       	call   801063f0 <argfd.constprop.0>
80106530:	85 c0                	test   %eax,%eax
80106532:	78 4c                	js     80106580 <sys_write+0x60>
80106534:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106537:	83 ec 08             	sub    $0x8,%esp
8010653a:	50                   	push   %eax
8010653b:	6a 02                	push   $0x2
8010653d:	e8 be fb ff ff       	call   80106100 <argint>
80106542:	83 c4 10             	add    $0x10,%esp
80106545:	85 c0                	test   %eax,%eax
80106547:	78 37                	js     80106580 <sys_write+0x60>
80106549:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010654c:	83 ec 04             	sub    $0x4,%esp
8010654f:	ff 75 f0             	pushl  -0x10(%ebp)
80106552:	50                   	push   %eax
80106553:	6a 01                	push   $0x1
80106555:	e8 f6 fb ff ff       	call   80106150 <argptr>
8010655a:	83 c4 10             	add    $0x10,%esp
8010655d:	85 c0                	test   %eax,%eax
8010655f:	78 1f                	js     80106580 <sys_write+0x60>
  return filewrite(f, p, n);
80106561:	83 ec 04             	sub    $0x4,%esp
80106564:	ff 75 f0             	pushl  -0x10(%ebp)
80106567:	ff 75 f4             	pushl  -0xc(%ebp)
8010656a:	ff 75 ec             	pushl  -0x14(%ebp)
8010656d:	e8 7e aa ff ff       	call   80100ff0 <filewrite>
80106572:	83 c4 10             	add    $0x10,%esp
}
80106575:	c9                   	leave  
80106576:	c3                   	ret    
80106577:	89 f6                	mov    %esi,%esi
80106579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80106580:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106585:	c9                   	leave  
80106586:	c3                   	ret    
80106587:	89 f6                	mov    %esi,%esi
80106589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106590 <sys_close>:
{
80106590:	55                   	push   %ebp
80106591:	89 e5                	mov    %esp,%ebp
80106593:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80106596:	8d 55 f4             	lea    -0xc(%ebp),%edx
80106599:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010659c:	e8 4f fe ff ff       	call   801063f0 <argfd.constprop.0>
801065a1:	85 c0                	test   %eax,%eax
801065a3:	78 2b                	js     801065d0 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
801065a5:	e8 c6 dd ff ff       	call   80104370 <myproc>
801065aa:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
801065ad:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
801065b0:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
801065b7:	00 
  fileclose(f);
801065b8:	ff 75 f4             	pushl  -0xc(%ebp)
801065bb:	e8 80 a8 ff ff       	call   80100e40 <fileclose>
  return 0;
801065c0:	83 c4 10             	add    $0x10,%esp
801065c3:	31 c0                	xor    %eax,%eax
}
801065c5:	c9                   	leave  
801065c6:	c3                   	ret    
801065c7:	89 f6                	mov    %esi,%esi
801065c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801065d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801065d5:	c9                   	leave  
801065d6:	c3                   	ret    
801065d7:	89 f6                	mov    %esi,%esi
801065d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801065e0 <sys_fstat>:
{
801065e0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801065e1:	31 c0                	xor    %eax,%eax
{
801065e3:	89 e5                	mov    %esp,%ebp
801065e5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801065e8:	8d 55 f0             	lea    -0x10(%ebp),%edx
801065eb:	e8 00 fe ff ff       	call   801063f0 <argfd.constprop.0>
801065f0:	85 c0                	test   %eax,%eax
801065f2:	78 2c                	js     80106620 <sys_fstat+0x40>
801065f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801065f7:	83 ec 04             	sub    $0x4,%esp
801065fa:	6a 14                	push   $0x14
801065fc:	50                   	push   %eax
801065fd:	6a 01                	push   $0x1
801065ff:	e8 4c fb ff ff       	call   80106150 <argptr>
80106604:	83 c4 10             	add    $0x10,%esp
80106607:	85 c0                	test   %eax,%eax
80106609:	78 15                	js     80106620 <sys_fstat+0x40>
  return filestat(f, st);
8010660b:	83 ec 08             	sub    $0x8,%esp
8010660e:	ff 75 f4             	pushl  -0xc(%ebp)
80106611:	ff 75 f0             	pushl  -0x10(%ebp)
80106614:	e8 f7 a8 ff ff       	call   80100f10 <filestat>
80106619:	83 c4 10             	add    $0x10,%esp
}
8010661c:	c9                   	leave  
8010661d:	c3                   	ret    
8010661e:	66 90                	xchg   %ax,%ax
    return -1;
80106620:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106625:	c9                   	leave  
80106626:	c3                   	ret    
80106627:	89 f6                	mov    %esi,%esi
80106629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106630 <sys_link>:
{
80106630:	55                   	push   %ebp
80106631:	89 e5                	mov    %esp,%ebp
80106633:	57                   	push   %edi
80106634:	56                   	push   %esi
80106635:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80106636:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80106639:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010663c:	50                   	push   %eax
8010663d:	6a 00                	push   $0x0
8010663f:	e8 6c fb ff ff       	call   801061b0 <argstr>
80106644:	83 c4 10             	add    $0x10,%esp
80106647:	85 c0                	test   %eax,%eax
80106649:	0f 88 fb 00 00 00    	js     8010674a <sys_link+0x11a>
8010664f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80106652:	83 ec 08             	sub    $0x8,%esp
80106655:	50                   	push   %eax
80106656:	6a 01                	push   $0x1
80106658:	e8 53 fb ff ff       	call   801061b0 <argstr>
8010665d:	83 c4 10             	add    $0x10,%esp
80106660:	85 c0                	test   %eax,%eax
80106662:	0f 88 e2 00 00 00    	js     8010674a <sys_link+0x11a>
  begin_op();
80106668:	e8 c3 ca ff ff       	call   80103130 <begin_op>
  if((ip = namei(old)) == 0){
8010666d:	83 ec 0c             	sub    $0xc,%esp
80106670:	ff 75 d4             	pushl  -0x2c(%ebp)
80106673:	e8 f8 bd ff ff       	call   80102470 <namei>
80106678:	83 c4 10             	add    $0x10,%esp
8010667b:	85 c0                	test   %eax,%eax
8010667d:	89 c3                	mov    %eax,%ebx
8010667f:	0f 84 ea 00 00 00    	je     8010676f <sys_link+0x13f>
  ilock(ip);
80106685:	83 ec 0c             	sub    $0xc,%esp
80106688:	50                   	push   %eax
80106689:	e8 42 b3 ff ff       	call   801019d0 <ilock>
  if(ip->type == T_DIR){
8010668e:	83 c4 10             	add    $0x10,%esp
80106691:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106696:	0f 84 bb 00 00 00    	je     80106757 <sys_link+0x127>
  ip->nlink++;
8010669c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
801066a1:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
801066a4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801066a7:	53                   	push   %ebx
801066a8:	e8 73 b2 ff ff       	call   80101920 <iupdate>
  iunlock(ip);
801066ad:	89 1c 24             	mov    %ebx,(%esp)
801066b0:	e8 fb b3 ff ff       	call   80101ab0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
801066b5:	58                   	pop    %eax
801066b6:	5a                   	pop    %edx
801066b7:	57                   	push   %edi
801066b8:	ff 75 d0             	pushl  -0x30(%ebp)
801066bb:	e8 d0 bd ff ff       	call   80102490 <nameiparent>
801066c0:	83 c4 10             	add    $0x10,%esp
801066c3:	85 c0                	test   %eax,%eax
801066c5:	89 c6                	mov    %eax,%esi
801066c7:	74 5b                	je     80106724 <sys_link+0xf4>
  ilock(dp);
801066c9:	83 ec 0c             	sub    $0xc,%esp
801066cc:	50                   	push   %eax
801066cd:	e8 fe b2 ff ff       	call   801019d0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801066d2:	83 c4 10             	add    $0x10,%esp
801066d5:	8b 03                	mov    (%ebx),%eax
801066d7:	39 06                	cmp    %eax,(%esi)
801066d9:	75 3d                	jne    80106718 <sys_link+0xe8>
801066db:	83 ec 04             	sub    $0x4,%esp
801066de:	ff 73 04             	pushl  0x4(%ebx)
801066e1:	57                   	push   %edi
801066e2:	56                   	push   %esi
801066e3:	e8 c8 bc ff ff       	call   801023b0 <dirlink>
801066e8:	83 c4 10             	add    $0x10,%esp
801066eb:	85 c0                	test   %eax,%eax
801066ed:	78 29                	js     80106718 <sys_link+0xe8>
  iunlockput(dp);
801066ef:	83 ec 0c             	sub    $0xc,%esp
801066f2:	56                   	push   %esi
801066f3:	e8 a8 b7 ff ff       	call   80101ea0 <iunlockput>
  iput(ip);
801066f8:	89 1c 24             	mov    %ebx,(%esp)
801066fb:	e8 00 b4 ff ff       	call   80101b00 <iput>
  end_op();
80106700:	e8 9b ca ff ff       	call   801031a0 <end_op>
  return 0;
80106705:	83 c4 10             	add    $0x10,%esp
80106708:	31 c0                	xor    %eax,%eax
}
8010670a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010670d:	5b                   	pop    %ebx
8010670e:	5e                   	pop    %esi
8010670f:	5f                   	pop    %edi
80106710:	5d                   	pop    %ebp
80106711:	c3                   	ret    
80106712:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80106718:	83 ec 0c             	sub    $0xc,%esp
8010671b:	56                   	push   %esi
8010671c:	e8 7f b7 ff ff       	call   80101ea0 <iunlockput>
    goto bad;
80106721:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80106724:	83 ec 0c             	sub    $0xc,%esp
80106727:	53                   	push   %ebx
80106728:	e8 a3 b2 ff ff       	call   801019d0 <ilock>
  ip->nlink--;
8010672d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80106732:	89 1c 24             	mov    %ebx,(%esp)
80106735:	e8 e6 b1 ff ff       	call   80101920 <iupdate>
  iunlockput(ip);
8010673a:	89 1c 24             	mov    %ebx,(%esp)
8010673d:	e8 5e b7 ff ff       	call   80101ea0 <iunlockput>
  end_op();
80106742:	e8 59 ca ff ff       	call   801031a0 <end_op>
  return -1;
80106747:	83 c4 10             	add    $0x10,%esp
}
8010674a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010674d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106752:	5b                   	pop    %ebx
80106753:	5e                   	pop    %esi
80106754:	5f                   	pop    %edi
80106755:	5d                   	pop    %ebp
80106756:	c3                   	ret    
    iunlockput(ip);
80106757:	83 ec 0c             	sub    $0xc,%esp
8010675a:	53                   	push   %ebx
8010675b:	e8 40 b7 ff ff       	call   80101ea0 <iunlockput>
    end_op();
80106760:	e8 3b ca ff ff       	call   801031a0 <end_op>
    return -1;
80106765:	83 c4 10             	add    $0x10,%esp
80106768:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010676d:	eb 9b                	jmp    8010670a <sys_link+0xda>
    end_op();
8010676f:	e8 2c ca ff ff       	call   801031a0 <end_op>
    return -1;
80106774:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106779:	eb 8f                	jmp    8010670a <sys_link+0xda>
8010677b:	90                   	nop
8010677c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106780 <sys_unlink>:
{
80106780:	55                   	push   %ebp
80106781:	89 e5                	mov    %esp,%ebp
80106783:	57                   	push   %edi
80106784:	56                   	push   %esi
80106785:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80106786:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80106789:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
8010678c:	50                   	push   %eax
8010678d:	6a 00                	push   $0x0
8010678f:	e8 1c fa ff ff       	call   801061b0 <argstr>
80106794:	83 c4 10             	add    $0x10,%esp
80106797:	85 c0                	test   %eax,%eax
80106799:	0f 88 77 01 00 00    	js     80106916 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
8010679f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
801067a2:	e8 89 c9 ff ff       	call   80103130 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801067a7:	83 ec 08             	sub    $0x8,%esp
801067aa:	53                   	push   %ebx
801067ab:	ff 75 c0             	pushl  -0x40(%ebp)
801067ae:	e8 dd bc ff ff       	call   80102490 <nameiparent>
801067b3:	83 c4 10             	add    $0x10,%esp
801067b6:	85 c0                	test   %eax,%eax
801067b8:	89 c6                	mov    %eax,%esi
801067ba:	0f 84 60 01 00 00    	je     80106920 <sys_unlink+0x1a0>
  ilock(dp);
801067c0:	83 ec 0c             	sub    $0xc,%esp
801067c3:	50                   	push   %eax
801067c4:	e8 07 b2 ff ff       	call   801019d0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801067c9:	58                   	pop    %eax
801067ca:	5a                   	pop    %edx
801067cb:	68 e7 91 10 80       	push   $0x801091e7
801067d0:	53                   	push   %ebx
801067d1:	e8 4a b9 ff ff       	call   80102120 <namecmp>
801067d6:	83 c4 10             	add    $0x10,%esp
801067d9:	85 c0                	test   %eax,%eax
801067db:	0f 84 03 01 00 00    	je     801068e4 <sys_unlink+0x164>
801067e1:	83 ec 08             	sub    $0x8,%esp
801067e4:	68 17 94 10 80       	push   $0x80109417
801067e9:	53                   	push   %ebx
801067ea:	e8 31 b9 ff ff       	call   80102120 <namecmp>
801067ef:	83 c4 10             	add    $0x10,%esp
801067f2:	85 c0                	test   %eax,%eax
801067f4:	0f 84 ea 00 00 00    	je     801068e4 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
801067fa:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801067fd:	83 ec 04             	sub    $0x4,%esp
80106800:	50                   	push   %eax
80106801:	53                   	push   %ebx
80106802:	56                   	push   %esi
80106803:	e8 38 b9 ff ff       	call   80102140 <dirlookup>
80106808:	83 c4 10             	add    $0x10,%esp
8010680b:	85 c0                	test   %eax,%eax
8010680d:	89 c3                	mov    %eax,%ebx
8010680f:	0f 84 cf 00 00 00    	je     801068e4 <sys_unlink+0x164>
  ilock(ip);
80106815:	83 ec 0c             	sub    $0xc,%esp
80106818:	50                   	push   %eax
80106819:	e8 b2 b1 ff ff       	call   801019d0 <ilock>
  if(ip->nlink < 1)
8010681e:	83 c4 10             	add    $0x10,%esp
80106821:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80106826:	0f 8e 10 01 00 00    	jle    8010693c <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010682c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106831:	74 6d                	je     801068a0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80106833:	8d 45 d8             	lea    -0x28(%ebp),%eax
80106836:	83 ec 04             	sub    $0x4,%esp
80106839:	6a 10                	push   $0x10
8010683b:	6a 00                	push   $0x0
8010683d:	50                   	push   %eax
8010683e:	e8 bd f5 ff ff       	call   80105e00 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80106843:	8d 45 d8             	lea    -0x28(%ebp),%eax
80106846:	6a 10                	push   $0x10
80106848:	ff 75 c4             	pushl  -0x3c(%ebp)
8010684b:	50                   	push   %eax
8010684c:	56                   	push   %esi
8010684d:	e8 9e b7 ff ff       	call   80101ff0 <writei>
80106852:	83 c4 20             	add    $0x20,%esp
80106855:	83 f8 10             	cmp    $0x10,%eax
80106858:	0f 85 eb 00 00 00    	jne    80106949 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
8010685e:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106863:	0f 84 97 00 00 00    	je     80106900 <sys_unlink+0x180>
  iunlockput(dp);
80106869:	83 ec 0c             	sub    $0xc,%esp
8010686c:	56                   	push   %esi
8010686d:	e8 2e b6 ff ff       	call   80101ea0 <iunlockput>
  ip->nlink--;
80106872:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80106877:	89 1c 24             	mov    %ebx,(%esp)
8010687a:	e8 a1 b0 ff ff       	call   80101920 <iupdate>
  iunlockput(ip);
8010687f:	89 1c 24             	mov    %ebx,(%esp)
80106882:	e8 19 b6 ff ff       	call   80101ea0 <iunlockput>
  end_op();
80106887:	e8 14 c9 ff ff       	call   801031a0 <end_op>
  return 0;
8010688c:	83 c4 10             	add    $0x10,%esp
8010688f:	31 c0                	xor    %eax,%eax
}
80106891:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106894:	5b                   	pop    %ebx
80106895:	5e                   	pop    %esi
80106896:	5f                   	pop    %edi
80106897:	5d                   	pop    %ebp
80106898:	c3                   	ret    
80106899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801068a0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801068a4:	76 8d                	jbe    80106833 <sys_unlink+0xb3>
801068a6:	bf 20 00 00 00       	mov    $0x20,%edi
801068ab:	eb 0f                	jmp    801068bc <sys_unlink+0x13c>
801068ad:	8d 76 00             	lea    0x0(%esi),%esi
801068b0:	83 c7 10             	add    $0x10,%edi
801068b3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801068b6:	0f 83 77 ff ff ff    	jae    80106833 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801068bc:	8d 45 d8             	lea    -0x28(%ebp),%eax
801068bf:	6a 10                	push   $0x10
801068c1:	57                   	push   %edi
801068c2:	50                   	push   %eax
801068c3:	53                   	push   %ebx
801068c4:	e8 27 b6 ff ff       	call   80101ef0 <readi>
801068c9:	83 c4 10             	add    $0x10,%esp
801068cc:	83 f8 10             	cmp    $0x10,%eax
801068cf:	75 5e                	jne    8010692f <sys_unlink+0x1af>
    if(de.inum != 0)
801068d1:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801068d6:	74 d8                	je     801068b0 <sys_unlink+0x130>
    iunlockput(ip);
801068d8:	83 ec 0c             	sub    $0xc,%esp
801068db:	53                   	push   %ebx
801068dc:	e8 bf b5 ff ff       	call   80101ea0 <iunlockput>
    goto bad;
801068e1:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
801068e4:	83 ec 0c             	sub    $0xc,%esp
801068e7:	56                   	push   %esi
801068e8:	e8 b3 b5 ff ff       	call   80101ea0 <iunlockput>
  end_op();
801068ed:	e8 ae c8 ff ff       	call   801031a0 <end_op>
  return -1;
801068f2:	83 c4 10             	add    $0x10,%esp
801068f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801068fa:	eb 95                	jmp    80106891 <sys_unlink+0x111>
801068fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80106900:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80106905:	83 ec 0c             	sub    $0xc,%esp
80106908:	56                   	push   %esi
80106909:	e8 12 b0 ff ff       	call   80101920 <iupdate>
8010690e:	83 c4 10             	add    $0x10,%esp
80106911:	e9 53 ff ff ff       	jmp    80106869 <sys_unlink+0xe9>
    return -1;
80106916:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010691b:	e9 71 ff ff ff       	jmp    80106891 <sys_unlink+0x111>
    end_op();
80106920:	e8 7b c8 ff ff       	call   801031a0 <end_op>
    return -1;
80106925:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010692a:	e9 62 ff ff ff       	jmp    80106891 <sys_unlink+0x111>
      panic("isdirempty: readi");
8010692f:	83 ec 0c             	sub    $0xc,%esp
80106932:	68 3c 94 10 80       	push   $0x8010943c
80106937:	e8 54 9a ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
8010693c:	83 ec 0c             	sub    $0xc,%esp
8010693f:	68 2a 94 10 80       	push   $0x8010942a
80106944:	e8 47 9a ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80106949:	83 ec 0c             	sub    $0xc,%esp
8010694c:	68 4e 94 10 80       	push   $0x8010944e
80106951:	e8 3a 9a ff ff       	call   80100390 <panic>
80106956:	8d 76 00             	lea    0x0(%esi),%esi
80106959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106960 <sys_open>:

int
sys_open(void)
{
80106960:	55                   	push   %ebp
80106961:	89 e5                	mov    %esp,%ebp
80106963:	57                   	push   %edi
80106964:	56                   	push   %esi
80106965:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106966:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80106969:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010696c:	50                   	push   %eax
8010696d:	6a 00                	push   $0x0
8010696f:	e8 3c f8 ff ff       	call   801061b0 <argstr>
80106974:	83 c4 10             	add    $0x10,%esp
80106977:	85 c0                	test   %eax,%eax
80106979:	0f 88 1d 01 00 00    	js     80106a9c <sys_open+0x13c>
8010697f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106982:	83 ec 08             	sub    $0x8,%esp
80106985:	50                   	push   %eax
80106986:	6a 01                	push   $0x1
80106988:	e8 73 f7 ff ff       	call   80106100 <argint>
8010698d:	83 c4 10             	add    $0x10,%esp
80106990:	85 c0                	test   %eax,%eax
80106992:	0f 88 04 01 00 00    	js     80106a9c <sys_open+0x13c>
    return -1;

  begin_op();
80106998:	e8 93 c7 ff ff       	call   80103130 <begin_op>

  if(omode & O_CREATE){
8010699d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801069a1:	0f 85 a9 00 00 00    	jne    80106a50 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801069a7:	83 ec 0c             	sub    $0xc,%esp
801069aa:	ff 75 e0             	pushl  -0x20(%ebp)
801069ad:	e8 be ba ff ff       	call   80102470 <namei>
801069b2:	83 c4 10             	add    $0x10,%esp
801069b5:	85 c0                	test   %eax,%eax
801069b7:	89 c6                	mov    %eax,%esi
801069b9:	0f 84 b2 00 00 00    	je     80106a71 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
801069bf:	83 ec 0c             	sub    $0xc,%esp
801069c2:	50                   	push   %eax
801069c3:	e8 08 b0 ff ff       	call   801019d0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801069c8:	83 c4 10             	add    $0x10,%esp
801069cb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801069d0:	0f 84 aa 00 00 00    	je     80106a80 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801069d6:	e8 a5 a3 ff ff       	call   80100d80 <filealloc>
801069db:	85 c0                	test   %eax,%eax
801069dd:	89 c7                	mov    %eax,%edi
801069df:	0f 84 a6 00 00 00    	je     80106a8b <sys_open+0x12b>
  struct proc *curproc = myproc();
801069e5:	e8 86 d9 ff ff       	call   80104370 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801069ea:	31 db                	xor    %ebx,%ebx
801069ec:	eb 0e                	jmp    801069fc <sys_open+0x9c>
801069ee:	66 90                	xchg   %ax,%ax
801069f0:	83 c3 01             	add    $0x1,%ebx
801069f3:	83 fb 10             	cmp    $0x10,%ebx
801069f6:	0f 84 ac 00 00 00    	je     80106aa8 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
801069fc:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80106a00:	85 d2                	test   %edx,%edx
80106a02:	75 ec                	jne    801069f0 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80106a04:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80106a07:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80106a0b:	56                   	push   %esi
80106a0c:	e8 9f b0 ff ff       	call   80101ab0 <iunlock>
  end_op();
80106a11:	e8 8a c7 ff ff       	call   801031a0 <end_op>

  f->type = FD_INODE;
80106a16:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80106a1c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106a1f:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80106a22:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80106a25:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80106a2c:	89 d0                	mov    %edx,%eax
80106a2e:	f7 d0                	not    %eax
80106a30:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106a33:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80106a36:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106a39:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80106a3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a40:	89 d8                	mov    %ebx,%eax
80106a42:	5b                   	pop    %ebx
80106a43:	5e                   	pop    %esi
80106a44:	5f                   	pop    %edi
80106a45:	5d                   	pop    %ebp
80106a46:	c3                   	ret    
80106a47:	89 f6                	mov    %esi,%esi
80106a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80106a50:	83 ec 0c             	sub    $0xc,%esp
80106a53:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106a56:	31 c9                	xor    %ecx,%ecx
80106a58:	6a 00                	push   $0x0
80106a5a:	ba 02 00 00 00       	mov    $0x2,%edx
80106a5f:	e8 ec f7 ff ff       	call   80106250 <create>
    if(ip == 0){
80106a64:	83 c4 10             	add    $0x10,%esp
80106a67:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80106a69:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80106a6b:	0f 85 65 ff ff ff    	jne    801069d6 <sys_open+0x76>
      end_op();
80106a71:	e8 2a c7 ff ff       	call   801031a0 <end_op>
      return -1;
80106a76:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106a7b:	eb c0                	jmp    80106a3d <sys_open+0xdd>
80106a7d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80106a80:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106a83:	85 c9                	test   %ecx,%ecx
80106a85:	0f 84 4b ff ff ff    	je     801069d6 <sys_open+0x76>
    iunlockput(ip);
80106a8b:	83 ec 0c             	sub    $0xc,%esp
80106a8e:	56                   	push   %esi
80106a8f:	e8 0c b4 ff ff       	call   80101ea0 <iunlockput>
    end_op();
80106a94:	e8 07 c7 ff ff       	call   801031a0 <end_op>
    return -1;
80106a99:	83 c4 10             	add    $0x10,%esp
80106a9c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106aa1:	eb 9a                	jmp    80106a3d <sys_open+0xdd>
80106aa3:	90                   	nop
80106aa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80106aa8:	83 ec 0c             	sub    $0xc,%esp
80106aab:	57                   	push   %edi
80106aac:	e8 8f a3 ff ff       	call   80100e40 <fileclose>
80106ab1:	83 c4 10             	add    $0x10,%esp
80106ab4:	eb d5                	jmp    80106a8b <sys_open+0x12b>
80106ab6:	8d 76 00             	lea    0x0(%esi),%esi
80106ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ac0 <sys_mkdir>:

int
sys_mkdir(void)
{
80106ac0:	55                   	push   %ebp
80106ac1:	89 e5                	mov    %esp,%ebp
80106ac3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80106ac6:	e8 65 c6 ff ff       	call   80103130 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80106acb:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106ace:	83 ec 08             	sub    $0x8,%esp
80106ad1:	50                   	push   %eax
80106ad2:	6a 00                	push   $0x0
80106ad4:	e8 d7 f6 ff ff       	call   801061b0 <argstr>
80106ad9:	83 c4 10             	add    $0x10,%esp
80106adc:	85 c0                	test   %eax,%eax
80106ade:	78 30                	js     80106b10 <sys_mkdir+0x50>
80106ae0:	83 ec 0c             	sub    $0xc,%esp
80106ae3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ae6:	31 c9                	xor    %ecx,%ecx
80106ae8:	6a 00                	push   $0x0
80106aea:	ba 01 00 00 00       	mov    $0x1,%edx
80106aef:	e8 5c f7 ff ff       	call   80106250 <create>
80106af4:	83 c4 10             	add    $0x10,%esp
80106af7:	85 c0                	test   %eax,%eax
80106af9:	74 15                	je     80106b10 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80106afb:	83 ec 0c             	sub    $0xc,%esp
80106afe:	50                   	push   %eax
80106aff:	e8 9c b3 ff ff       	call   80101ea0 <iunlockput>
  end_op();
80106b04:	e8 97 c6 ff ff       	call   801031a0 <end_op>
  return 0;
80106b09:	83 c4 10             	add    $0x10,%esp
80106b0c:	31 c0                	xor    %eax,%eax
}
80106b0e:	c9                   	leave  
80106b0f:	c3                   	ret    
    end_op();
80106b10:	e8 8b c6 ff ff       	call   801031a0 <end_op>
    return -1;
80106b15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106b1a:	c9                   	leave  
80106b1b:	c3                   	ret    
80106b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106b20 <sys_mknod>:

int
sys_mknod(void)
{
80106b20:	55                   	push   %ebp
80106b21:	89 e5                	mov    %esp,%ebp
80106b23:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80106b26:	e8 05 c6 ff ff       	call   80103130 <begin_op>
  if((argstr(0, &path)) < 0 ||
80106b2b:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106b2e:	83 ec 08             	sub    $0x8,%esp
80106b31:	50                   	push   %eax
80106b32:	6a 00                	push   $0x0
80106b34:	e8 77 f6 ff ff       	call   801061b0 <argstr>
80106b39:	83 c4 10             	add    $0x10,%esp
80106b3c:	85 c0                	test   %eax,%eax
80106b3e:	78 60                	js     80106ba0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80106b40:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106b43:	83 ec 08             	sub    $0x8,%esp
80106b46:	50                   	push   %eax
80106b47:	6a 01                	push   $0x1
80106b49:	e8 b2 f5 ff ff       	call   80106100 <argint>
  if((argstr(0, &path)) < 0 ||
80106b4e:	83 c4 10             	add    $0x10,%esp
80106b51:	85 c0                	test   %eax,%eax
80106b53:	78 4b                	js     80106ba0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80106b55:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106b58:	83 ec 08             	sub    $0x8,%esp
80106b5b:	50                   	push   %eax
80106b5c:	6a 02                	push   $0x2
80106b5e:	e8 9d f5 ff ff       	call   80106100 <argint>
     argint(1, &major) < 0 ||
80106b63:	83 c4 10             	add    $0x10,%esp
80106b66:	85 c0                	test   %eax,%eax
80106b68:	78 36                	js     80106ba0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80106b6a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
80106b6e:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80106b71:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80106b75:	ba 03 00 00 00       	mov    $0x3,%edx
80106b7a:	50                   	push   %eax
80106b7b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106b7e:	e8 cd f6 ff ff       	call   80106250 <create>
80106b83:	83 c4 10             	add    $0x10,%esp
80106b86:	85 c0                	test   %eax,%eax
80106b88:	74 16                	je     80106ba0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80106b8a:	83 ec 0c             	sub    $0xc,%esp
80106b8d:	50                   	push   %eax
80106b8e:	e8 0d b3 ff ff       	call   80101ea0 <iunlockput>
  end_op();
80106b93:	e8 08 c6 ff ff       	call   801031a0 <end_op>
  return 0;
80106b98:	83 c4 10             	add    $0x10,%esp
80106b9b:	31 c0                	xor    %eax,%eax
}
80106b9d:	c9                   	leave  
80106b9e:	c3                   	ret    
80106b9f:	90                   	nop
    end_op();
80106ba0:	e8 fb c5 ff ff       	call   801031a0 <end_op>
    return -1;
80106ba5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106baa:	c9                   	leave  
80106bab:	c3                   	ret    
80106bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106bb0 <sys_chdir>:

int
sys_chdir(void)
{
80106bb0:	55                   	push   %ebp
80106bb1:	89 e5                	mov    %esp,%ebp
80106bb3:	56                   	push   %esi
80106bb4:	53                   	push   %ebx
80106bb5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80106bb8:	e8 b3 d7 ff ff       	call   80104370 <myproc>
80106bbd:	89 c6                	mov    %eax,%esi
  
  begin_op();
80106bbf:	e8 6c c5 ff ff       	call   80103130 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106bc4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106bc7:	83 ec 08             	sub    $0x8,%esp
80106bca:	50                   	push   %eax
80106bcb:	6a 00                	push   $0x0
80106bcd:	e8 de f5 ff ff       	call   801061b0 <argstr>
80106bd2:	83 c4 10             	add    $0x10,%esp
80106bd5:	85 c0                	test   %eax,%eax
80106bd7:	78 77                	js     80106c50 <sys_chdir+0xa0>
80106bd9:	83 ec 0c             	sub    $0xc,%esp
80106bdc:	ff 75 f4             	pushl  -0xc(%ebp)
80106bdf:	e8 8c b8 ff ff       	call   80102470 <namei>
80106be4:	83 c4 10             	add    $0x10,%esp
80106be7:	85 c0                	test   %eax,%eax
80106be9:	89 c3                	mov    %eax,%ebx
80106beb:	74 63                	je     80106c50 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80106bed:	83 ec 0c             	sub    $0xc,%esp
80106bf0:	50                   	push   %eax
80106bf1:	e8 da ad ff ff       	call   801019d0 <ilock>
  if(ip->type != T_DIR){
80106bf6:	83 c4 10             	add    $0x10,%esp
80106bf9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106bfe:	75 30                	jne    80106c30 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80106c00:	83 ec 0c             	sub    $0xc,%esp
80106c03:	53                   	push   %ebx
80106c04:	e8 a7 ae ff ff       	call   80101ab0 <iunlock>
  iput(curproc->cwd);
80106c09:	58                   	pop    %eax
80106c0a:	ff 76 68             	pushl  0x68(%esi)
80106c0d:	e8 ee ae ff ff       	call   80101b00 <iput>
  end_op();
80106c12:	e8 89 c5 ff ff       	call   801031a0 <end_op>
  curproc->cwd = ip;
80106c17:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80106c1a:	83 c4 10             	add    $0x10,%esp
80106c1d:	31 c0                	xor    %eax,%eax
}
80106c1f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106c22:	5b                   	pop    %ebx
80106c23:	5e                   	pop    %esi
80106c24:	5d                   	pop    %ebp
80106c25:	c3                   	ret    
80106c26:	8d 76 00             	lea    0x0(%esi),%esi
80106c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80106c30:	83 ec 0c             	sub    $0xc,%esp
80106c33:	53                   	push   %ebx
80106c34:	e8 67 b2 ff ff       	call   80101ea0 <iunlockput>
    end_op();
80106c39:	e8 62 c5 ff ff       	call   801031a0 <end_op>
    return -1;
80106c3e:	83 c4 10             	add    $0x10,%esp
80106c41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106c46:	eb d7                	jmp    80106c1f <sys_chdir+0x6f>
80106c48:	90                   	nop
80106c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80106c50:	e8 4b c5 ff ff       	call   801031a0 <end_op>
    return -1;
80106c55:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106c5a:	eb c3                	jmp    80106c1f <sys_chdir+0x6f>
80106c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106c60 <sys_exec>:

int
sys_exec(void)
{
80106c60:	55                   	push   %ebp
80106c61:	89 e5                	mov    %esp,%ebp
80106c63:	57                   	push   %edi
80106c64:	56                   	push   %esi
80106c65:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106c66:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80106c6c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106c72:	50                   	push   %eax
80106c73:	6a 00                	push   $0x0
80106c75:	e8 36 f5 ff ff       	call   801061b0 <argstr>
80106c7a:	83 c4 10             	add    $0x10,%esp
80106c7d:	85 c0                	test   %eax,%eax
80106c7f:	0f 88 87 00 00 00    	js     80106d0c <sys_exec+0xac>
80106c85:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80106c8b:	83 ec 08             	sub    $0x8,%esp
80106c8e:	50                   	push   %eax
80106c8f:	6a 01                	push   $0x1
80106c91:	e8 6a f4 ff ff       	call   80106100 <argint>
80106c96:	83 c4 10             	add    $0x10,%esp
80106c99:	85 c0                	test   %eax,%eax
80106c9b:	78 6f                	js     80106d0c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80106c9d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106ca3:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80106ca6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80106ca8:	68 80 00 00 00       	push   $0x80
80106cad:	6a 00                	push   $0x0
80106caf:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80106cb5:	50                   	push   %eax
80106cb6:	e8 45 f1 ff ff       	call   80105e00 <memset>
80106cbb:	83 c4 10             	add    $0x10,%esp
80106cbe:	eb 2c                	jmp    80106cec <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80106cc0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80106cc6:	85 c0                	test   %eax,%eax
80106cc8:	74 56                	je     80106d20 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106cca:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80106cd0:	83 ec 08             	sub    $0x8,%esp
80106cd3:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80106cd6:	52                   	push   %edx
80106cd7:	50                   	push   %eax
80106cd8:	e8 b3 f3 ff ff       	call   80106090 <fetchstr>
80106cdd:	83 c4 10             	add    $0x10,%esp
80106ce0:	85 c0                	test   %eax,%eax
80106ce2:	78 28                	js     80106d0c <sys_exec+0xac>
  for(i=0;; i++){
80106ce4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80106ce7:	83 fb 20             	cmp    $0x20,%ebx
80106cea:	74 20                	je     80106d0c <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106cec:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106cf2:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80106cf9:	83 ec 08             	sub    $0x8,%esp
80106cfc:	57                   	push   %edi
80106cfd:	01 f0                	add    %esi,%eax
80106cff:	50                   	push   %eax
80106d00:	e8 4b f3 ff ff       	call   80106050 <fetchint>
80106d05:	83 c4 10             	add    $0x10,%esp
80106d08:	85 c0                	test   %eax,%eax
80106d0a:	79 b4                	jns    80106cc0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
80106d0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80106d0f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106d14:	5b                   	pop    %ebx
80106d15:	5e                   	pop    %esi
80106d16:	5f                   	pop    %edi
80106d17:	5d                   	pop    %ebp
80106d18:	c3                   	ret    
80106d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80106d20:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106d26:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80106d29:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80106d30:	00 00 00 00 
  return exec(path, argv);
80106d34:	50                   	push   %eax
80106d35:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80106d3b:	e8 d0 9c ff ff       	call   80100a10 <exec>
80106d40:	83 c4 10             	add    $0x10,%esp
}
80106d43:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d46:	5b                   	pop    %ebx
80106d47:	5e                   	pop    %esi
80106d48:	5f                   	pop    %edi
80106d49:	5d                   	pop    %ebp
80106d4a:	c3                   	ret    
80106d4b:	90                   	nop
80106d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106d50 <sys_pipe>:

int
sys_pipe(void)
{
80106d50:	55                   	push   %ebp
80106d51:	89 e5                	mov    %esp,%ebp
80106d53:	57                   	push   %edi
80106d54:	56                   	push   %esi
80106d55:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106d56:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80106d59:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106d5c:	6a 08                	push   $0x8
80106d5e:	50                   	push   %eax
80106d5f:	6a 00                	push   $0x0
80106d61:	e8 ea f3 ff ff       	call   80106150 <argptr>
80106d66:	83 c4 10             	add    $0x10,%esp
80106d69:	85 c0                	test   %eax,%eax
80106d6b:	0f 88 ae 00 00 00    	js     80106e1f <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80106d71:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106d74:	83 ec 08             	sub    $0x8,%esp
80106d77:	50                   	push   %eax
80106d78:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106d7b:	50                   	push   %eax
80106d7c:	e8 4f ca ff ff       	call   801037d0 <pipealloc>
80106d81:	83 c4 10             	add    $0x10,%esp
80106d84:	85 c0                	test   %eax,%eax
80106d86:	0f 88 93 00 00 00    	js     80106e1f <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106d8c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80106d8f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80106d91:	e8 da d5 ff ff       	call   80104370 <myproc>
80106d96:	eb 10                	jmp    80106da8 <sys_pipe+0x58>
80106d98:	90                   	nop
80106d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106da0:	83 c3 01             	add    $0x1,%ebx
80106da3:	83 fb 10             	cmp    $0x10,%ebx
80106da6:	74 60                	je     80106e08 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80106da8:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80106dac:	85 f6                	test   %esi,%esi
80106dae:	75 f0                	jne    80106da0 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80106db0:	8d 73 08             	lea    0x8(%ebx),%esi
80106db3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106db7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80106dba:	e8 b1 d5 ff ff       	call   80104370 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106dbf:	31 d2                	xor    %edx,%edx
80106dc1:	eb 0d                	jmp    80106dd0 <sys_pipe+0x80>
80106dc3:	90                   	nop
80106dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106dc8:	83 c2 01             	add    $0x1,%edx
80106dcb:	83 fa 10             	cmp    $0x10,%edx
80106dce:	74 28                	je     80106df8 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
80106dd0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80106dd4:	85 c9                	test   %ecx,%ecx
80106dd6:	75 f0                	jne    80106dc8 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
80106dd8:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80106ddc:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106ddf:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106de1:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106de4:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80106de7:	31 c0                	xor    %eax,%eax
}
80106de9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106dec:	5b                   	pop    %ebx
80106ded:	5e                   	pop    %esi
80106dee:	5f                   	pop    %edi
80106def:	5d                   	pop    %ebp
80106df0:	c3                   	ret    
80106df1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80106df8:	e8 73 d5 ff ff       	call   80104370 <myproc>
80106dfd:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80106e04:	00 
80106e05:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80106e08:	83 ec 0c             	sub    $0xc,%esp
80106e0b:	ff 75 e0             	pushl  -0x20(%ebp)
80106e0e:	e8 2d a0 ff ff       	call   80100e40 <fileclose>
    fileclose(wf);
80106e13:	58                   	pop    %eax
80106e14:	ff 75 e4             	pushl  -0x1c(%ebp)
80106e17:	e8 24 a0 ff ff       	call   80100e40 <fileclose>
    return -1;
80106e1c:	83 c4 10             	add    $0x10,%esp
80106e1f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106e24:	eb c3                	jmp    80106de9 <sys_pipe+0x99>
80106e26:	66 90                	xchg   %ax,%ax
80106e28:	66 90                	xchg   %ax,%ax
80106e2a:	66 90                	xchg   %ax,%ax
80106e2c:	66 90                	xchg   %ax,%ax
80106e2e:	66 90                	xchg   %ax,%ax

80106e30 <sys_fork>:
#include "proc.h"
#include "xem.h"

int
sys_fork(void)
{
80106e30:	55                   	push   %ebp
80106e31:	89 e5                	mov    %esp,%ebp
  return fork();
}
80106e33:	5d                   	pop    %ebp
  return fork();
80106e34:	e9 57 d7 ff ff       	jmp    80104590 <fork>
80106e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106e40 <sys_exit>:

int
sys_exit(void)
{
80106e40:	55                   	push   %ebp
80106e41:	89 e5                	mov    %esp,%ebp
80106e43:	83 ec 08             	sub    $0x8,%esp
  exit();
80106e46:	e8 f5 dc ff ff       	call   80104b40 <exit>
  return 0;  // not reached
}
80106e4b:	31 c0                	xor    %eax,%eax
80106e4d:	c9                   	leave  
80106e4e:	c3                   	ret    
80106e4f:	90                   	nop

80106e50 <sys_wait>:

int
sys_wait(void)
{
80106e50:	55                   	push   %ebp
80106e51:	89 e5                	mov    %esp,%ebp
  return wait();
}
80106e53:	5d                   	pop    %ebp
  return wait();
80106e54:	e9 c7 e0 ff ff       	jmp    80104f20 <wait>
80106e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106e60 <sys_kill>:

int
sys_kill(void)
{
80106e60:	55                   	push   %ebp
80106e61:	89 e5                	mov    %esp,%ebp
80106e63:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106e66:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106e69:	50                   	push   %eax
80106e6a:	6a 00                	push   $0x0
80106e6c:	e8 8f f2 ff ff       	call   80106100 <argint>
80106e71:	83 c4 10             	add    $0x10,%esp
80106e74:	85 c0                	test   %eax,%eax
80106e76:	78 18                	js     80106e90 <sys_kill+0x30>
    return -1;
  return kill(pid);
80106e78:	83 ec 0c             	sub    $0xc,%esp
80106e7b:	ff 75 f4             	pushl  -0xc(%ebp)
80106e7e:	e8 1d e3 ff ff       	call   801051a0 <kill>
80106e83:	83 c4 10             	add    $0x10,%esp
}
80106e86:	c9                   	leave  
80106e87:	c3                   	ret    
80106e88:	90                   	nop
80106e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106e90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106e95:	c9                   	leave  
80106e96:	c3                   	ret    
80106e97:	89 f6                	mov    %esi,%esi
80106e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ea0 <sys_getpid>:

int
sys_getpid(void)
{
80106ea0:	55                   	push   %ebp
80106ea1:	89 e5                	mov    %esp,%ebp
80106ea3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106ea6:	e8 c5 d4 ff ff       	call   80104370 <myproc>
80106eab:	8b 40 10             	mov    0x10(%eax),%eax
}
80106eae:	c9                   	leave  
80106eaf:	c3                   	ret    

80106eb0 <sys_sbrk>:

int
sys_sbrk(void)
{
80106eb0:	55                   	push   %ebp
80106eb1:	89 e5                	mov    %esp,%ebp
80106eb3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106eb4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106eb7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80106eba:	50                   	push   %eax
80106ebb:	6a 00                	push   $0x0
80106ebd:	e8 3e f2 ff ff       	call   80106100 <argint>
80106ec2:	83 c4 10             	add    $0x10,%esp
80106ec5:	85 c0                	test   %eax,%eax
80106ec7:	78 27                	js     80106ef0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106ec9:	e8 a2 d4 ff ff       	call   80104370 <myproc>
  if(growproc(n) < 0)
80106ece:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80106ed1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106ed3:	ff 75 f4             	pushl  -0xc(%ebp)
80106ed6:	e8 35 d6 ff ff       	call   80104510 <growproc>
80106edb:	83 c4 10             	add    $0x10,%esp
80106ede:	85 c0                	test   %eax,%eax
80106ee0:	78 0e                	js     80106ef0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106ee2:	89 d8                	mov    %ebx,%eax
80106ee4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106ee7:	c9                   	leave  
80106ee8:	c3                   	ret    
80106ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106ef0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106ef5:	eb eb                	jmp    80106ee2 <sys_sbrk+0x32>
80106ef7:	89 f6                	mov    %esi,%esi
80106ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f00 <sys_sleep>:

int
sys_sleep(void)
{
80106f00:	55                   	push   %ebp
80106f01:	89 e5                	mov    %esp,%ebp
80106f03:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106f04:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106f07:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80106f0a:	50                   	push   %eax
80106f0b:	6a 00                	push   $0x0
80106f0d:	e8 ee f1 ff ff       	call   80106100 <argint>
80106f12:	83 c4 10             	add    $0x10,%esp
80106f15:	85 c0                	test   %eax,%eax
80106f17:	0f 88 8a 00 00 00    	js     80106fa7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80106f1d:	83 ec 0c             	sub    $0xc,%esp
80106f20:	68 c0 ba 11 80       	push   $0x8011bac0
80106f25:	e8 c6 ed ff ff       	call   80105cf0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106f2a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106f2d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80106f30:	8b 1d 00 c3 11 80    	mov    0x8011c300,%ebx
  while(ticks - ticks0 < n){
80106f36:	85 d2                	test   %edx,%edx
80106f38:	75 27                	jne    80106f61 <sys_sleep+0x61>
80106f3a:	eb 54                	jmp    80106f90 <sys_sleep+0x90>
80106f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106f40:	83 ec 08             	sub    $0x8,%esp
80106f43:	68 c0 ba 11 80       	push   $0x8011bac0
80106f48:	68 00 c3 11 80       	push   $0x8011c300
80106f4d:	e8 0e df ff ff       	call   80104e60 <sleep>
  while(ticks - ticks0 < n){
80106f52:	a1 00 c3 11 80       	mov    0x8011c300,%eax
80106f57:	83 c4 10             	add    $0x10,%esp
80106f5a:	29 d8                	sub    %ebx,%eax
80106f5c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80106f5f:	73 2f                	jae    80106f90 <sys_sleep+0x90>
    if(myproc()->killed){
80106f61:	e8 0a d4 ff ff       	call   80104370 <myproc>
80106f66:	8b 40 24             	mov    0x24(%eax),%eax
80106f69:	85 c0                	test   %eax,%eax
80106f6b:	74 d3                	je     80106f40 <sys_sleep+0x40>
      release(&tickslock);
80106f6d:	83 ec 0c             	sub    $0xc,%esp
80106f70:	68 c0 ba 11 80       	push   $0x8011bac0
80106f75:	e8 36 ee ff ff       	call   80105db0 <release>
      return -1;
80106f7a:	83 c4 10             	add    $0x10,%esp
80106f7d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80106f82:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106f85:	c9                   	leave  
80106f86:	c3                   	ret    
80106f87:	89 f6                	mov    %esi,%esi
80106f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80106f90:	83 ec 0c             	sub    $0xc,%esp
80106f93:	68 c0 ba 11 80       	push   $0x8011bac0
80106f98:	e8 13 ee ff ff       	call   80105db0 <release>
  return 0;
80106f9d:	83 c4 10             	add    $0x10,%esp
80106fa0:	31 c0                	xor    %eax,%eax
}
80106fa2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106fa5:	c9                   	leave  
80106fa6:	c3                   	ret    
    return -1;
80106fa7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106fac:	eb f4                	jmp    80106fa2 <sys_sleep+0xa2>
80106fae:	66 90                	xchg   %ax,%ax

80106fb0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106fb0:	55                   	push   %ebp
80106fb1:	89 e5                	mov    %esp,%ebp
80106fb3:	53                   	push   %ebx
80106fb4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80106fb7:	68 c0 ba 11 80       	push   $0x8011bac0
80106fbc:	e8 2f ed ff ff       	call   80105cf0 <acquire>
  xticks = ticks;
80106fc1:	8b 1d 00 c3 11 80    	mov    0x8011c300,%ebx
  release(&tickslock);
80106fc7:	c7 04 24 c0 ba 11 80 	movl   $0x8011bac0,(%esp)
80106fce:	e8 dd ed ff ff       	call   80105db0 <release>
  return xticks;
}
80106fd3:	89 d8                	mov    %ebx,%eax
80106fd5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106fd8:	c9                   	leave  
80106fd9:	c3                   	ret    
80106fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106fe0 <sys_getlev>:


int
sys_getlev(void)
{
80106fe0:	55                   	push   %ebp
80106fe1:	89 e5                	mov    %esp,%ebp
	return getlev();
}
80106fe3:	5d                   	pop    %ebp
	return getlev();
80106fe4:	e9 37 d2 ff ff       	jmp    80104220 <getlev>
80106fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106ff0 <sys_yield>:

int
sys_yield(void)
{
80106ff0:	55                   	push   %ebp
80106ff1:	89 e5                	mov    %esp,%ebp
	return yield();
}
80106ff3:	5d                   	pop    %ebp
	return yield();
80106ff4:	e9 d7 d9 ff ff       	jmp    801049d0 <yield>
80106ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107000 <sys_set_cpu_share>:

int
sys_set_cpu_share(void)
{
80107000:	55                   	push   %ebp
80107001:	89 e5                	mov    %esp,%ebp
80107003:	83 ec 20             	sub    $0x20,%esp
	int cpu_share;
	if (argint(0, &cpu_share) < 0)
80107006:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107009:	50                   	push   %eax
8010700a:	6a 00                	push   $0x0
8010700c:	e8 ef f0 ff ff       	call   80106100 <argint>
80107011:	83 c4 10             	add    $0x10,%esp
80107014:	85 c0                	test   %eax,%eax
80107016:	78 18                	js     80107030 <sys_set_cpu_share+0x30>
		return -1;
	return set_cpu_share(cpu_share);
80107018:	83 ec 0c             	sub    $0xc,%esp
8010701b:	ff 75 f4             	pushl  -0xc(%ebp)
8010701e:	e8 2d d2 ff ff       	call   80104250 <set_cpu_share>
80107023:	83 c4 10             	add    $0x10,%esp
}
80107026:	c9                   	leave  
80107027:	c3                   	ret    
80107028:	90                   	nop
80107029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return -1;
80107030:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107035:	c9                   	leave  
80107036:	c3                   	ret    
80107037:	89 f6                	mov    %esi,%esi
80107039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107040 <sys_thread_create>:

int
sys_thread_create(void){
80107040:	55                   	push   %ebp
80107041:	89 e5                	mov    %esp,%ebp
80107043:	83 ec 20             	sub    $0x20,%esp
	int first_arg, second_arg, third_arg;

	if(argint(0, &first_arg) <0) return -1;
80107046:	8d 45 ec             	lea    -0x14(%ebp),%eax
80107049:	50                   	push   %eax
8010704a:	6a 00                	push   $0x0
8010704c:	e8 af f0 ff ff       	call   80106100 <argint>
80107051:	83 c4 10             	add    $0x10,%esp
80107054:	85 c0                	test   %eax,%eax
80107056:	78 48                	js     801070a0 <sys_thread_create+0x60>
	if(argint(1, &second_arg) <0) return -1;
80107058:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010705b:	83 ec 08             	sub    $0x8,%esp
8010705e:	50                   	push   %eax
8010705f:	6a 01                	push   $0x1
80107061:	e8 9a f0 ff ff       	call   80106100 <argint>
80107066:	83 c4 10             	add    $0x10,%esp
80107069:	85 c0                	test   %eax,%eax
8010706b:	78 33                	js     801070a0 <sys_thread_create+0x60>
	if(argint(2, &third_arg) <0) return -1;
8010706d:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107070:	83 ec 08             	sub    $0x8,%esp
80107073:	50                   	push   %eax
80107074:	6a 02                	push   $0x2
80107076:	e8 85 f0 ff ff       	call   80106100 <argint>
8010707b:	83 c4 10             	add    $0x10,%esp
8010707e:	85 c0                	test   %eax,%eax
80107080:	78 1e                	js     801070a0 <sys_thread_create+0x60>

	return thread_create((thread_t *)first_arg, (void*(*)(void*))second_arg, (void*)third_arg);
80107082:	83 ec 04             	sub    $0x4,%esp
80107085:	ff 75 f4             	pushl  -0xc(%ebp)
80107088:	ff 75 f0             	pushl  -0x10(%ebp)
8010708b:	ff 75 ec             	pushl  -0x14(%ebp)
8010708e:	e8 bd e2 ff ff       	call   80105350 <thread_create>
80107093:	83 c4 10             	add    $0x10,%esp
}
80107096:	c9                   	leave  
80107097:	c3                   	ret    
80107098:	90                   	nop
80107099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	if(argint(0, &first_arg) <0) return -1;
801070a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801070a5:	c9                   	leave  
801070a6:	c3                   	ret    
801070a7:	89 f6                	mov    %esi,%esi
801070a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801070b0 <sys_thread_exit>:

int
sys_thread_exit(void){
801070b0:	55                   	push   %ebp
801070b1:	89 e5                	mov    %esp,%ebp
801070b3:	83 ec 20             	sub    $0x20,%esp
	int arg;
	if(argint(0, &arg) <0) return -1;
801070b6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801070b9:	50                   	push   %eax
801070ba:	6a 00                	push   $0x0
801070bc:	e8 3f f0 ff ff       	call   80106100 <argint>
801070c1:	83 c4 10             	add    $0x10,%esp
801070c4:	85 c0                	test   %eax,%eax
801070c6:	78 18                	js     801070e0 <sys_thread_exit+0x30>
	thread_exit((void*)arg);
801070c8:	83 ec 0c             	sub    $0xc,%esp
801070cb:	ff 75 f4             	pushl  -0xc(%ebp)
801070ce:	e8 ed e4 ff ff       	call   801055c0 <thread_exit>
	return 0;
801070d3:	83 c4 10             	add    $0x10,%esp
801070d6:	31 c0                	xor    %eax,%eax
}
801070d8:	c9                   	leave  
801070d9:	c3                   	ret    
801070da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	if(argint(0, &arg) <0) return -1;
801070e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801070e5:	c9                   	leave  
801070e6:	c3                   	ret    
801070e7:	89 f6                	mov    %esi,%esi
801070e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801070f0 <sys_thread_join>:

int sys_thread_join(void){
801070f0:	55                   	push   %ebp
801070f1:	89 e5                	mov    %esp,%ebp
801070f3:	83 ec 20             	sub    $0x20,%esp
	int first_arg, second_arg;

	if(argint(0, &first_arg) < 0) return -1;
801070f6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801070f9:	50                   	push   %eax
801070fa:	6a 00                	push   $0x0
801070fc:	e8 ff ef ff ff       	call   80106100 <argint>
80107101:	83 c4 10             	add    $0x10,%esp
80107104:	85 c0                	test   %eax,%eax
80107106:	78 28                	js     80107130 <sys_thread_join+0x40>
	if(argint(1, &second_arg) < 0) return -1;
80107108:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010710b:	83 ec 08             	sub    $0x8,%esp
8010710e:	50                   	push   %eax
8010710f:	6a 01                	push   $0x1
80107111:	e8 ea ef ff ff       	call   80106100 <argint>
80107116:	83 c4 10             	add    $0x10,%esp
80107119:	85 c0                	test   %eax,%eax
8010711b:	78 13                	js     80107130 <sys_thread_join+0x40>
	return thread_join((thread_t)first_arg, (void**)second_arg);
8010711d:	83 ec 08             	sub    $0x8,%esp
80107120:	ff 75 f4             	pushl  -0xc(%ebp)
80107123:	ff 75 f0             	pushl  -0x10(%ebp)
80107126:	e8 85 e5 ff ff       	call   801056b0 <thread_join>
8010712b:	83 c4 10             	add    $0x10,%esp
}
8010712e:	c9                   	leave  
8010712f:	c3                   	ret    
	if(argint(0, &first_arg) < 0) return -1;
80107130:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107135:	c9                   	leave  
80107136:	c3                   	ret    
80107137:	89 f6                	mov    %esi,%esi
80107139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107140 <sys_xem_init>:

int sys_xem_init(void){
80107140:	55                   	push   %ebp
80107141:	89 e5                	mov    %esp,%ebp
80107143:	81 ec 24 01 00 00    	sub    $0x124,%esp
	xem_t arg;
	return xem_init(&arg);
80107149:	8d 85 e8 fe ff ff    	lea    -0x118(%ebp),%eax
8010714f:	50                   	push   %eax
80107150:	e8 9b e7 ff ff       	call   801058f0 <xem_init>
}
80107155:	c9                   	leave  
80107156:	c3                   	ret    
80107157:	89 f6                	mov    %esi,%esi
80107159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107160 <sys_xem_wait>:

int sys_xem_wait(void){
80107160:	55                   	push   %ebp
80107161:	89 e5                	mov    %esp,%ebp
80107163:	81 ec 24 01 00 00    	sub    $0x124,%esp
	xem_t arg;
	return xem_wait(&arg);
80107169:	8d 85 e8 fe ff ff    	lea    -0x118(%ebp),%eax
8010716f:	50                   	push   %eax
80107170:	e8 fb e7 ff ff       	call   80105970 <xem_wait>
}
80107175:	c9                   	leave  
80107176:	c3                   	ret    
80107177:	89 f6                	mov    %esi,%esi
80107179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107180 <sys_xem_unlock>:

int sys_xem_unlock(void){
80107180:	55                   	push   %ebp
80107181:	89 e5                	mov    %esp,%ebp
80107183:	81 ec 24 01 00 00    	sub    $0x124,%esp
	xem_t arg;
	return xem_unlock(&arg);
80107189:	8d 85 e8 fe ff ff    	lea    -0x118(%ebp),%eax
8010718f:	50                   	push   %eax
80107190:	e8 6b e8 ff ff       	call   80105a00 <xem_unlock>
}
80107195:	c9                   	leave  
80107196:	c3                   	ret    
80107197:	89 f6                	mov    %esi,%esi
80107199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801071a0 <sys_pread>:

int sys_pread(void)
{
801071a0:	55                   	push   %ebp
801071a1:	89 e5                	mov    %esp,%ebp
801071a3:	83 ec 20             	sub    $0x20,%esp
	struct file *f =0;
	int n;
	char *p;
	int off;

	if( argint(2, &n) < 0 || argint(3, &off) < 0 || argptr(1, &p, n) < 0)
801071a6:	8d 45 ec             	lea    -0x14(%ebp),%eax
801071a9:	50                   	push   %eax
801071aa:	6a 02                	push   $0x2
801071ac:	e8 4f ef ff ff       	call   80106100 <argint>
801071b1:	83 c4 10             	add    $0x10,%esp
801071b4:	85 c0                	test   %eax,%eax
801071b6:	78 48                	js     80107200 <sys_pread+0x60>
801071b8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801071bb:	83 ec 08             	sub    $0x8,%esp
801071be:	50                   	push   %eax
801071bf:	6a 03                	push   $0x3
801071c1:	e8 3a ef ff ff       	call   80106100 <argint>
801071c6:	83 c4 10             	add    $0x10,%esp
801071c9:	85 c0                	test   %eax,%eax
801071cb:	78 33                	js     80107200 <sys_pread+0x60>
801071cd:	8d 45 f0             	lea    -0x10(%ebp),%eax
801071d0:	83 ec 04             	sub    $0x4,%esp
801071d3:	ff 75 ec             	pushl  -0x14(%ebp)
801071d6:	50                   	push   %eax
801071d7:	6a 01                	push   $0x1
801071d9:	e8 72 ef ff ff       	call   80106150 <argptr>
801071de:	83 c4 10             	add    $0x10,%esp
801071e1:	85 c0                	test   %eax,%eax
801071e3:	78 1b                	js     80107200 <sys_pread+0x60>
		return -1;
	return pfileread(f, p, n, off);
801071e5:	ff 75 f4             	pushl  -0xc(%ebp)
801071e8:	ff 75 ec             	pushl  -0x14(%ebp)
801071eb:	ff 75 f0             	pushl  -0x10(%ebp)
801071ee:	6a 00                	push   $0x0
801071f0:	e8 1b 9f ff ff       	call   80101110 <pfileread>
801071f5:	83 c4 10             	add    $0x10,%esp
}
801071f8:	c9                   	leave  
801071f9:	c3                   	ret    
801071fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		return -1;
80107200:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107205:	c9                   	leave  
80107206:	c3                   	ret    
80107207:	89 f6                	mov    %esi,%esi
80107209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107210 <sys_pwrite>:

int sys_pwrite(void)
{
80107210:	55                   	push   %ebp
80107211:	89 e5                	mov    %esp,%ebp
80107213:	83 ec 20             	sub    $0x20,%esp
	struct file* f=0;
	int n, off;
	char *p;

	if( argint(2, &n) < 0 || argint(3, &off) < 0 || argptr(1, &p, n) < 0)
80107216:	8d 45 ec             	lea    -0x14(%ebp),%eax
80107219:	50                   	push   %eax
8010721a:	6a 02                	push   $0x2
8010721c:	e8 df ee ff ff       	call   80106100 <argint>
80107221:	83 c4 10             	add    $0x10,%esp
80107224:	85 c0                	test   %eax,%eax
80107226:	78 48                	js     80107270 <sys_pwrite+0x60>
80107228:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010722b:	83 ec 08             	sub    $0x8,%esp
8010722e:	50                   	push   %eax
8010722f:	6a 03                	push   $0x3
80107231:	e8 ca ee ff ff       	call   80106100 <argint>
80107236:	83 c4 10             	add    $0x10,%esp
80107239:	85 c0                	test   %eax,%eax
8010723b:	78 33                	js     80107270 <sys_pwrite+0x60>
8010723d:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107240:	83 ec 04             	sub    $0x4,%esp
80107243:	ff 75 ec             	pushl  -0x14(%ebp)
80107246:	50                   	push   %eax
80107247:	6a 01                	push   $0x1
80107249:	e8 02 ef ff ff       	call   80106150 <argptr>
8010724e:	83 c4 10             	add    $0x10,%esp
80107251:	85 c0                	test   %eax,%eax
80107253:	78 1b                	js     80107270 <sys_pwrite+0x60>
		return -1;

	return pfilewrite(f,p,n,off);
80107255:	ff 75 f0             	pushl  -0x10(%ebp)
80107258:	ff 75 ec             	pushl  -0x14(%ebp)
8010725b:	ff 75 f4             	pushl  -0xc(%ebp)
8010725e:	6a 00                	push   $0x0
80107260:	e8 3b 9f ff ff       	call   801011a0 <pfilewrite>
80107265:	83 c4 10             	add    $0x10,%esp
}
80107268:	c9                   	leave  
80107269:	c3                   	ret    
8010726a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		return -1;
80107270:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107275:	c9                   	leave  
80107276:	c3                   	ret    

80107277 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80107277:	1e                   	push   %ds
  pushl %es
80107278:	06                   	push   %es
  pushl %fs
80107279:	0f a0                	push   %fs
  pushl %gs
8010727b:	0f a8                	push   %gs
  pushal
8010727d:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
8010727e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80107282:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80107284:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80107286:	54                   	push   %esp
  call trap
80107287:	e8 c4 00 00 00       	call   80107350 <trap>
  addl $4, %esp
8010728c:	83 c4 04             	add    $0x4,%esp

8010728f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
8010728f:	61                   	popa   
  popl %gs
80107290:	0f a9                	pop    %gs
  popl %fs
80107292:	0f a1                	pop    %fs
  popl %es
80107294:	07                   	pop    %es
  popl %ds
80107295:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80107296:	83 c4 08             	add    $0x8,%esp
  iret
80107299:	cf                   	iret   
8010729a:	66 90                	xchg   %ax,%ax
8010729c:	66 90                	xchg   %ax,%ax
8010729e:	66 90                	xchg   %ax,%ax

801072a0 <tvinit>:
extern const uint TIME_QUANTUM[];		// in proc.c: array of time quantum
extern uint boost_tick;							// in proc.c: logical tick counter for priority boost

void
tvinit(void)
{
801072a0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
801072a1:	31 c0                	xor    %eax,%eax
{
801072a3:	89 e5                	mov    %esp,%ebp
801072a5:	83 ec 08             	sub    $0x8,%esp
801072a8:	90                   	nop
801072a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801072b0:	8b 14 85 0c c0 10 80 	mov    -0x7fef3ff4(,%eax,4),%edx
801072b7:	c7 04 c5 02 bb 11 80 	movl   $0x8e000008,-0x7fee44fe(,%eax,8)
801072be:	08 00 00 8e 
801072c2:	66 89 14 c5 00 bb 11 	mov    %dx,-0x7fee4500(,%eax,8)
801072c9:	80 
801072ca:	c1 ea 10             	shr    $0x10,%edx
801072cd:	66 89 14 c5 06 bb 11 	mov    %dx,-0x7fee44fa(,%eax,8)
801072d4:	80 
  for(i = 0; i < 256; i++)
801072d5:	83 c0 01             	add    $0x1,%eax
801072d8:	3d 00 01 00 00       	cmp    $0x100,%eax
801072dd:	75 d1                	jne    801072b0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801072df:	a1 0c c1 10 80       	mov    0x8010c10c,%eax

  initlock(&tickslock, "time");
801072e4:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801072e7:	c7 05 02 bd 11 80 08 	movl   $0xef000008,0x8011bd02
801072ee:	00 00 ef 
  initlock(&tickslock, "time");
801072f1:	68 5d 94 10 80       	push   $0x8010945d
801072f6:	68 c0 ba 11 80       	push   $0x8011bac0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801072fb:	66 a3 00 bd 11 80    	mov    %ax,0x8011bd00
80107301:	c1 e8 10             	shr    $0x10,%eax
80107304:	66 a3 06 bd 11 80    	mov    %ax,0x8011bd06
  initlock(&tickslock, "time");
8010730a:	e8 a1 e8 ff ff       	call   80105bb0 <initlock>
}
8010730f:	83 c4 10             	add    $0x10,%esp
80107312:	c9                   	leave  
80107313:	c3                   	ret    
80107314:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010731a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107320 <idtinit>:

void
idtinit(void)
{
80107320:	55                   	push   %ebp
  pd[0] = size-1;
80107321:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80107326:	89 e5                	mov    %esp,%ebp
80107328:	83 ec 10             	sub    $0x10,%esp
8010732b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010732f:	b8 00 bb 11 80       	mov    $0x8011bb00,%eax
80107334:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80107338:	c1 e8 10             	shr    $0x10,%eax
8010733b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010733f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80107342:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80107345:	c9                   	leave  
80107346:	c3                   	ret    
80107347:	89 f6                	mov    %esi,%esi
80107349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107350 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80107350:	55                   	push   %ebp
80107351:	89 e5                	mov    %esp,%ebp
80107353:	57                   	push   %edi
80107354:	56                   	push   %esi
80107355:	53                   	push   %ebx
80107356:	83 ec 1c             	sub    $0x1c,%esp
80107359:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
8010735c:	8b 47 30             	mov    0x30(%edi),%eax
8010735f:	83 f8 40             	cmp    $0x40,%eax
80107362:	0f 84 f0 00 00 00    	je     80107458 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80107368:	83 e8 20             	sub    $0x20,%eax
8010736b:	83 f8 1f             	cmp    $0x1f,%eax
8010736e:	77 10                	ja     80107380 <trap+0x30>
80107370:	ff 24 85 04 95 10 80 	jmp    *-0x7fef6afc(,%eax,4)
80107377:	89 f6                	mov    %esi,%esi
80107379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){ //trap
80107380:	e8 eb cf ff ff       	call   80104370 <myproc>
80107385:	85 c0                	test   %eax,%eax
80107387:	8b 5f 38             	mov    0x38(%edi),%ebx
8010738a:	0f 84 ca 02 00 00    	je     8010765a <trap+0x30a>
80107390:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80107394:	0f 84 c0 02 00 00    	je     8010765a <trap+0x30a>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010739a:	0f 20 d1             	mov    %cr2,%ecx
8010739d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801073a0:	e8 5b ce ff ff       	call   80104200 <cpuid>
801073a5:	89 45 dc             	mov    %eax,-0x24(%ebp)
801073a8:	8b 47 34             	mov    0x34(%edi),%eax
801073ab:	8b 77 30             	mov    0x30(%edi),%esi
801073ae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
801073b1:	e8 ba cf ff ff       	call   80104370 <myproc>
801073b6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801073b9:	e8 b2 cf ff ff       	call   80104370 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801073be:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801073c1:	8b 55 dc             	mov    -0x24(%ebp),%edx
801073c4:	51                   	push   %ecx
801073c5:	53                   	push   %ebx
801073c6:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
801073c7:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801073ca:	ff 75 e4             	pushl  -0x1c(%ebp)
801073cd:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
801073ce:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801073d1:	52                   	push   %edx
801073d2:	ff 70 10             	pushl  0x10(%eax)
801073d5:	68 c0 94 10 80       	push   $0x801094c0
801073da:	e8 81 92 ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
801073df:	83 c4 20             	add    $0x20,%esp
801073e2:	e8 89 cf ff ff       	call   80104370 <myproc>
801073e7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801073ee:	e8 7d cf ff ff       	call   80104370 <myproc>
801073f3:	85 c0                	test   %eax,%eax
801073f5:	74 1d                	je     80107414 <trap+0xc4>
801073f7:	e8 74 cf ff ff       	call   80104370 <myproc>
801073fc:	8b 70 24             	mov    0x24(%eax),%esi
801073ff:	85 f6                	test   %esi,%esi
80107401:	74 11                	je     80107414 <trap+0xc4>
80107403:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80107407:	83 e0 03             	and    $0x3,%eax
8010740a:	66 83 f8 03          	cmp    $0x3,%ax
8010740e:	0f 84 bc 01 00 00    	je     801075d0 <trap+0x280>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80107414:	e8 57 cf ff ff       	call   80104370 <myproc>
80107419:	85 c0                	test   %eax,%eax
8010741b:	74 0b                	je     80107428 <trap+0xd8>
8010741d:	e8 4e cf ff ff       	call   80104370 <myproc>
80107422:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80107426:	74 68                	je     80107490 <trap+0x140>
			} 
		}
	}

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107428:	e8 43 cf ff ff       	call   80104370 <myproc>
8010742d:	85 c0                	test   %eax,%eax
8010742f:	74 19                	je     8010744a <trap+0xfa>
80107431:	e8 3a cf ff ff       	call   80104370 <myproc>
80107436:	8b 40 24             	mov    0x24(%eax),%eax
80107439:	85 c0                	test   %eax,%eax
8010743b:	74 0d                	je     8010744a <trap+0xfa>
8010743d:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80107441:	83 e0 03             	and    $0x3,%eax
80107444:	66 83 f8 03          	cmp    $0x3,%ax
80107448:	74 37                	je     80107481 <trap+0x131>
    exit();
}
8010744a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010744d:	5b                   	pop    %ebx
8010744e:	5e                   	pop    %esi
8010744f:	5f                   	pop    %edi
80107450:	5d                   	pop    %ebp
80107451:	c3                   	ret    
80107452:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
80107458:	e8 13 cf ff ff       	call   80104370 <myproc>
8010745d:	8b 40 24             	mov    0x24(%eax),%eax
80107460:	85 c0                	test   %eax,%eax
80107462:	0f 85 58 01 00 00    	jne    801075c0 <trap+0x270>
    myproc()->tf = tf;
80107468:	e8 03 cf ff ff       	call   80104370 <myproc>
8010746d:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80107470:	e8 7b ed ff ff       	call   801061f0 <syscall>
    if(myproc()->killed)
80107475:	e8 f6 ce ff ff       	call   80104370 <myproc>
8010747a:	8b 78 24             	mov    0x24(%eax),%edi
8010747d:	85 ff                	test   %edi,%edi
8010747f:	74 c9                	je     8010744a <trap+0xfa>
}
80107481:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107484:	5b                   	pop    %ebx
80107485:	5e                   	pop    %esi
80107486:	5f                   	pop    %edi
80107487:	5d                   	pop    %ebp
      exit();
80107488:	e9 b3 d6 ff ff       	jmp    80104b40 <exit>
8010748d:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80107490:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80107494:	75 92                	jne    80107428 <trap+0xd8>
		if(!myproc()->is_stride)
80107496:	e8 d5 ce ff ff       	call   80104370 <myproc>
8010749b:	8b 98 98 01 00 00    	mov    0x198(%eax),%ebx
801074a1:	85 db                	test   %ebx,%ebx
801074a3:	75 07                	jne    801074ac <trap+0x15c>
			boost_tick++;
801074a5:	83 05 c0 c5 10 80 01 	addl   $0x1,0x8010c5c0
		myproc()->tick_cnt++;
801074ac:	e8 bf ce ff ff       	call   80104370 <myproc>
801074b1:	83 80 94 01 00 00 01 	addl   $0x1,0x194(%eax)
		if (!myproc()->is_stride && boost_tick >= BOOST_LIMIT) {
801074b8:	e8 b3 ce ff ff       	call   80104370 <myproc>
801074bd:	8b 88 98 01 00 00    	mov    0x198(%eax),%ecx
801074c3:	85 c9                	test   %ecx,%ecx
801074c5:	75 10                	jne    801074d7 <trap+0x187>
801074c7:	81 3d c0 c5 10 80 c7 	cmpl   $0xc7,0x8010c5c0
801074ce:	00 00 00 
801074d1:	0f 87 79 01 00 00    	ja     80107650 <trap+0x300>
		if (myproc()->is_stride) {
801074d7:	e8 94 ce ff ff       	call   80104370 <myproc>
801074dc:	8b 90 98 01 00 00    	mov    0x198(%eax),%edx
801074e2:	85 d2                	test   %edx,%edx
801074e4:	0f 84 2e 01 00 00    	je     80107618 <trap+0x2c8>
			myproc()->pass_value += myproc()->stride;
801074ea:	e8 81 ce ff ff       	call   80104370 <myproc>
801074ef:	8b 98 9c 01 00 00    	mov    0x19c(%eax),%ebx
801074f5:	e8 76 ce ff ff       	call   80104370 <myproc>
801074fa:	01 98 a0 01 00 00    	add    %ebx,0x1a0(%eax)
			tick_yield();
80107500:	e8 6b d8 ff ff       	call   80104d70 <tick_yield>
80107505:	e9 1e ff ff ff       	jmp    80107428 <trap+0xd8>
8010750a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80107510:	e8 eb cc ff ff       	call   80104200 <cpuid>
80107515:	85 c0                	test   %eax,%eax
80107517:	0f 84 c3 00 00 00    	je     801075e0 <trap+0x290>
    lapiceoi();
8010751d:	e8 be b7 ff ff       	call   80102ce0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107522:	e8 49 ce ff ff       	call   80104370 <myproc>
80107527:	85 c0                	test   %eax,%eax
80107529:	0f 85 c8 fe ff ff    	jne    801073f7 <trap+0xa7>
8010752f:	e9 e0 fe ff ff       	jmp    80107414 <trap+0xc4>
80107534:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80107538:	e8 63 b6 ff ff       	call   80102ba0 <kbdintr>
    lapiceoi();
8010753d:	e8 9e b7 ff ff       	call   80102ce0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107542:	e8 29 ce ff ff       	call   80104370 <myproc>
80107547:	85 c0                	test   %eax,%eax
80107549:	0f 85 a8 fe ff ff    	jne    801073f7 <trap+0xa7>
8010754f:	e9 c0 fe ff ff       	jmp    80107414 <trap+0xc4>
80107554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80107558:	e8 a3 02 00 00       	call   80107800 <uartintr>
    lapiceoi();
8010755d:	e8 7e b7 ff ff       	call   80102ce0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107562:	e8 09 ce ff ff       	call   80104370 <myproc>
80107567:	85 c0                	test   %eax,%eax
80107569:	0f 85 88 fe ff ff    	jne    801073f7 <trap+0xa7>
8010756f:	e9 a0 fe ff ff       	jmp    80107414 <trap+0xc4>
80107574:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80107578:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
8010757c:	8b 77 38             	mov    0x38(%edi),%esi
8010757f:	e8 7c cc ff ff       	call   80104200 <cpuid>
80107584:	56                   	push   %esi
80107585:	53                   	push   %ebx
80107586:	50                   	push   %eax
80107587:	68 68 94 10 80       	push   $0x80109468
8010758c:	e8 cf 90 ff ff       	call   80100660 <cprintf>
    lapiceoi();
80107591:	e8 4a b7 ff ff       	call   80102ce0 <lapiceoi>
    break;
80107596:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107599:	e8 d2 cd ff ff       	call   80104370 <myproc>
8010759e:	85 c0                	test   %eax,%eax
801075a0:	0f 85 51 fe ff ff    	jne    801073f7 <trap+0xa7>
801075a6:	e9 69 fe ff ff       	jmp    80107414 <trap+0xc4>
801075ab:	90                   	nop
801075ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
801075b0:	e8 5b b0 ff ff       	call   80102610 <ideintr>
801075b5:	e9 63 ff ff ff       	jmp    8010751d <trap+0x1cd>
801075ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
801075c0:	e8 7b d5 ff ff       	call   80104b40 <exit>
801075c5:	e9 9e fe ff ff       	jmp    80107468 <trap+0x118>
801075ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
801075d0:	e8 6b d5 ff ff       	call   80104b40 <exit>
801075d5:	e9 3a fe ff ff       	jmp    80107414 <trap+0xc4>
801075da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
801075e0:	83 ec 0c             	sub    $0xc,%esp
801075e3:	68 c0 ba 11 80       	push   $0x8011bac0
801075e8:	e8 03 e7 ff ff       	call   80105cf0 <acquire>
      wakeup(&ticks);
801075ed:	c7 04 24 00 c3 11 80 	movl   $0x8011c300,(%esp)
      ticks++;
801075f4:	83 05 00 c3 11 80 01 	addl   $0x1,0x8011c300
      wakeup(&ticks);
801075fb:	e8 70 db ff ff       	call   80105170 <wakeup>
      release(&tickslock);
80107600:	c7 04 24 c0 ba 11 80 	movl   $0x8011bac0,(%esp)
80107607:	e8 a4 e7 ff ff       	call   80105db0 <release>
8010760c:	83 c4 10             	add    $0x10,%esp
8010760f:	e9 09 ff ff ff       	jmp    8010751d <trap+0x1cd>
80107614:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
			mlfq_pass_inc();
80107618:	e8 33 c8 ff ff       	call   80103e50 <mlfq_pass_inc>
			if (myproc()->tick_cnt % TIME_QUANTUM[myproc()->lev] == 0) {
8010761d:	e8 4e cd ff ff       	call   80104370 <myproc>
80107622:	8b 98 94 01 00 00    	mov    0x194(%eax),%ebx
80107628:	e8 43 cd ff ff       	call   80104370 <myproc>
8010762d:	8b 88 90 01 00 00    	mov    0x190(%eax),%ecx
80107633:	31 d2                	xor    %edx,%edx
80107635:	89 d8                	mov    %ebx,%eax
80107637:	f7 34 8d 14 93 10 80 	divl   -0x7fef6cec(,%ecx,4)
8010763e:	85 d2                	test   %edx,%edx
80107640:	0f 85 e2 fd ff ff    	jne    80107428 <trap+0xd8>
				tick_yield();
80107646:	e8 25 d7 ff ff       	call   80104d70 <tick_yield>
8010764b:	e9 d8 fd ff ff       	jmp    80107428 <trap+0xd8>
			priority_boost();
80107650:	e8 8b c8 ff ff       	call   80103ee0 <priority_boost>
80107655:	e9 7d fe ff ff       	jmp    801074d7 <trap+0x187>
8010765a:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
8010765d:	e8 9e cb ff ff       	call   80104200 <cpuid>
80107662:	83 ec 0c             	sub    $0xc,%esp
80107665:	56                   	push   %esi
80107666:	53                   	push   %ebx
80107667:	50                   	push   %eax
80107668:	ff 77 30             	pushl  0x30(%edi)
8010766b:	68 8c 94 10 80       	push   $0x8010948c
80107670:	e8 eb 8f ff ff       	call   80100660 <cprintf>
      panic("trap");
80107675:	83 c4 14             	add    $0x14,%esp
80107678:	68 62 94 10 80       	push   $0x80109462
8010767d:	e8 0e 8d ff ff       	call   80100390 <panic>
80107682:	66 90                	xchg   %ax,%ax
80107684:	66 90                	xchg   %ax,%ax
80107686:	66 90                	xchg   %ax,%ax
80107688:	66 90                	xchg   %ax,%ax
8010768a:	66 90                	xchg   %ax,%ax
8010768c:	66 90                	xchg   %ax,%ax
8010768e:	66 90                	xchg   %ax,%ax

80107690 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80107690:	a1 c8 c5 10 80       	mov    0x8010c5c8,%eax
{
80107695:	55                   	push   %ebp
80107696:	89 e5                	mov    %esp,%ebp
  if(!uart)
80107698:	85 c0                	test   %eax,%eax
8010769a:	74 1c                	je     801076b8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010769c:	ba fd 03 00 00       	mov    $0x3fd,%edx
801076a1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801076a2:	a8 01                	test   $0x1,%al
801076a4:	74 12                	je     801076b8 <uartgetc+0x28>
801076a6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801076ab:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801076ac:	0f b6 c0             	movzbl %al,%eax
}
801076af:	5d                   	pop    %ebp
801076b0:	c3                   	ret    
801076b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801076b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801076bd:	5d                   	pop    %ebp
801076be:	c3                   	ret    
801076bf:	90                   	nop

801076c0 <uartputc.part.0>:
uartputc(int c)
801076c0:	55                   	push   %ebp
801076c1:	89 e5                	mov    %esp,%ebp
801076c3:	57                   	push   %edi
801076c4:	56                   	push   %esi
801076c5:	53                   	push   %ebx
801076c6:	89 c7                	mov    %eax,%edi
801076c8:	bb 80 00 00 00       	mov    $0x80,%ebx
801076cd:	be fd 03 00 00       	mov    $0x3fd,%esi
801076d2:	83 ec 0c             	sub    $0xc,%esp
801076d5:	eb 1b                	jmp    801076f2 <uartputc.part.0+0x32>
801076d7:	89 f6                	mov    %esi,%esi
801076d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
801076e0:	83 ec 0c             	sub    $0xc,%esp
801076e3:	6a 0a                	push   $0xa
801076e5:	e8 16 b6 ff ff       	call   80102d00 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801076ea:	83 c4 10             	add    $0x10,%esp
801076ed:	83 eb 01             	sub    $0x1,%ebx
801076f0:	74 07                	je     801076f9 <uartputc.part.0+0x39>
801076f2:	89 f2                	mov    %esi,%edx
801076f4:	ec                   	in     (%dx),%al
801076f5:	a8 20                	test   $0x20,%al
801076f7:	74 e7                	je     801076e0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801076f9:	ba f8 03 00 00       	mov    $0x3f8,%edx
801076fe:	89 f8                	mov    %edi,%eax
80107700:	ee                   	out    %al,(%dx)
}
80107701:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107704:	5b                   	pop    %ebx
80107705:	5e                   	pop    %esi
80107706:	5f                   	pop    %edi
80107707:	5d                   	pop    %ebp
80107708:	c3                   	ret    
80107709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107710 <uartinit>:
{
80107710:	55                   	push   %ebp
80107711:	31 c9                	xor    %ecx,%ecx
80107713:	89 c8                	mov    %ecx,%eax
80107715:	89 e5                	mov    %esp,%ebp
80107717:	57                   	push   %edi
80107718:	56                   	push   %esi
80107719:	53                   	push   %ebx
8010771a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010771f:	89 da                	mov    %ebx,%edx
80107721:	83 ec 0c             	sub    $0xc,%esp
80107724:	ee                   	out    %al,(%dx)
80107725:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010772a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010772f:	89 fa                	mov    %edi,%edx
80107731:	ee                   	out    %al,(%dx)
80107732:	b8 0c 00 00 00       	mov    $0xc,%eax
80107737:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010773c:	ee                   	out    %al,(%dx)
8010773d:	be f9 03 00 00       	mov    $0x3f9,%esi
80107742:	89 c8                	mov    %ecx,%eax
80107744:	89 f2                	mov    %esi,%edx
80107746:	ee                   	out    %al,(%dx)
80107747:	b8 03 00 00 00       	mov    $0x3,%eax
8010774c:	89 fa                	mov    %edi,%edx
8010774e:	ee                   	out    %al,(%dx)
8010774f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80107754:	89 c8                	mov    %ecx,%eax
80107756:	ee                   	out    %al,(%dx)
80107757:	b8 01 00 00 00       	mov    $0x1,%eax
8010775c:	89 f2                	mov    %esi,%edx
8010775e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010775f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80107764:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80107765:	3c ff                	cmp    $0xff,%al
80107767:	74 5a                	je     801077c3 <uartinit+0xb3>
  uart = 1;
80107769:	c7 05 c8 c5 10 80 01 	movl   $0x1,0x8010c5c8
80107770:	00 00 00 
80107773:	89 da                	mov    %ebx,%edx
80107775:	ec                   	in     (%dx),%al
80107776:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010777b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
8010777c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
8010777f:	bb 84 95 10 80       	mov    $0x80109584,%ebx
  ioapicenable(IRQ_COM1, 0);
80107784:	6a 00                	push   $0x0
80107786:	6a 04                	push   $0x4
80107788:	e8 d3 b0 ff ff       	call   80102860 <ioapicenable>
8010778d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80107790:	b8 78 00 00 00       	mov    $0x78,%eax
80107795:	eb 13                	jmp    801077aa <uartinit+0x9a>
80107797:	89 f6                	mov    %esi,%esi
80107799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801077a0:	83 c3 01             	add    $0x1,%ebx
801077a3:	0f be 03             	movsbl (%ebx),%eax
801077a6:	84 c0                	test   %al,%al
801077a8:	74 19                	je     801077c3 <uartinit+0xb3>
  if(!uart)
801077aa:	8b 15 c8 c5 10 80    	mov    0x8010c5c8,%edx
801077b0:	85 d2                	test   %edx,%edx
801077b2:	74 ec                	je     801077a0 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
801077b4:	83 c3 01             	add    $0x1,%ebx
801077b7:	e8 04 ff ff ff       	call   801076c0 <uartputc.part.0>
801077bc:	0f be 03             	movsbl (%ebx),%eax
801077bf:	84 c0                	test   %al,%al
801077c1:	75 e7                	jne    801077aa <uartinit+0x9a>
}
801077c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077c6:	5b                   	pop    %ebx
801077c7:	5e                   	pop    %esi
801077c8:	5f                   	pop    %edi
801077c9:	5d                   	pop    %ebp
801077ca:	c3                   	ret    
801077cb:	90                   	nop
801077cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801077d0 <uartputc>:
  if(!uart)
801077d0:	8b 15 c8 c5 10 80    	mov    0x8010c5c8,%edx
{
801077d6:	55                   	push   %ebp
801077d7:	89 e5                	mov    %esp,%ebp
  if(!uart)
801077d9:	85 d2                	test   %edx,%edx
{
801077db:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
801077de:	74 10                	je     801077f0 <uartputc+0x20>
}
801077e0:	5d                   	pop    %ebp
801077e1:	e9 da fe ff ff       	jmp    801076c0 <uartputc.part.0>
801077e6:	8d 76 00             	lea    0x0(%esi),%esi
801077e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801077f0:	5d                   	pop    %ebp
801077f1:	c3                   	ret    
801077f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801077f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107800 <uartintr>:

void
uartintr(void)
{
80107800:	55                   	push   %ebp
80107801:	89 e5                	mov    %esp,%ebp
80107803:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80107806:	68 90 76 10 80       	push   $0x80107690
8010780b:	e8 00 90 ff ff       	call   80100810 <consoleintr>
}
80107810:	83 c4 10             	add    $0x10,%esp
80107813:	c9                   	leave  
80107814:	c3                   	ret    

80107815 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80107815:	6a 00                	push   $0x0
  pushl $0
80107817:	6a 00                	push   $0x0
  jmp alltraps
80107819:	e9 59 fa ff ff       	jmp    80107277 <alltraps>

8010781e <vector1>:
.globl vector1
vector1:
  pushl $0
8010781e:	6a 00                	push   $0x0
  pushl $1
80107820:	6a 01                	push   $0x1
  jmp alltraps
80107822:	e9 50 fa ff ff       	jmp    80107277 <alltraps>

80107827 <vector2>:
.globl vector2
vector2:
  pushl $0
80107827:	6a 00                	push   $0x0
  pushl $2
80107829:	6a 02                	push   $0x2
  jmp alltraps
8010782b:	e9 47 fa ff ff       	jmp    80107277 <alltraps>

80107830 <vector3>:
.globl vector3
vector3:
  pushl $0
80107830:	6a 00                	push   $0x0
  pushl $3
80107832:	6a 03                	push   $0x3
  jmp alltraps
80107834:	e9 3e fa ff ff       	jmp    80107277 <alltraps>

80107839 <vector4>:
.globl vector4
vector4:
  pushl $0
80107839:	6a 00                	push   $0x0
  pushl $4
8010783b:	6a 04                	push   $0x4
  jmp alltraps
8010783d:	e9 35 fa ff ff       	jmp    80107277 <alltraps>

80107842 <vector5>:
.globl vector5
vector5:
  pushl $0
80107842:	6a 00                	push   $0x0
  pushl $5
80107844:	6a 05                	push   $0x5
  jmp alltraps
80107846:	e9 2c fa ff ff       	jmp    80107277 <alltraps>

8010784b <vector6>:
.globl vector6
vector6:
  pushl $0
8010784b:	6a 00                	push   $0x0
  pushl $6
8010784d:	6a 06                	push   $0x6
  jmp alltraps
8010784f:	e9 23 fa ff ff       	jmp    80107277 <alltraps>

80107854 <vector7>:
.globl vector7
vector7:
  pushl $0
80107854:	6a 00                	push   $0x0
  pushl $7
80107856:	6a 07                	push   $0x7
  jmp alltraps
80107858:	e9 1a fa ff ff       	jmp    80107277 <alltraps>

8010785d <vector8>:
.globl vector8
vector8:
  pushl $8
8010785d:	6a 08                	push   $0x8
  jmp alltraps
8010785f:	e9 13 fa ff ff       	jmp    80107277 <alltraps>

80107864 <vector9>:
.globl vector9
vector9:
  pushl $0
80107864:	6a 00                	push   $0x0
  pushl $9
80107866:	6a 09                	push   $0x9
  jmp alltraps
80107868:	e9 0a fa ff ff       	jmp    80107277 <alltraps>

8010786d <vector10>:
.globl vector10
vector10:
  pushl $10
8010786d:	6a 0a                	push   $0xa
  jmp alltraps
8010786f:	e9 03 fa ff ff       	jmp    80107277 <alltraps>

80107874 <vector11>:
.globl vector11
vector11:
  pushl $11
80107874:	6a 0b                	push   $0xb
  jmp alltraps
80107876:	e9 fc f9 ff ff       	jmp    80107277 <alltraps>

8010787b <vector12>:
.globl vector12
vector12:
  pushl $12
8010787b:	6a 0c                	push   $0xc
  jmp alltraps
8010787d:	e9 f5 f9 ff ff       	jmp    80107277 <alltraps>

80107882 <vector13>:
.globl vector13
vector13:
  pushl $13
80107882:	6a 0d                	push   $0xd
  jmp alltraps
80107884:	e9 ee f9 ff ff       	jmp    80107277 <alltraps>

80107889 <vector14>:
.globl vector14
vector14:
  pushl $14
80107889:	6a 0e                	push   $0xe
  jmp alltraps
8010788b:	e9 e7 f9 ff ff       	jmp    80107277 <alltraps>

80107890 <vector15>:
.globl vector15
vector15:
  pushl $0
80107890:	6a 00                	push   $0x0
  pushl $15
80107892:	6a 0f                	push   $0xf
  jmp alltraps
80107894:	e9 de f9 ff ff       	jmp    80107277 <alltraps>

80107899 <vector16>:
.globl vector16
vector16:
  pushl $0
80107899:	6a 00                	push   $0x0
  pushl $16
8010789b:	6a 10                	push   $0x10
  jmp alltraps
8010789d:	e9 d5 f9 ff ff       	jmp    80107277 <alltraps>

801078a2 <vector17>:
.globl vector17
vector17:
  pushl $17
801078a2:	6a 11                	push   $0x11
  jmp alltraps
801078a4:	e9 ce f9 ff ff       	jmp    80107277 <alltraps>

801078a9 <vector18>:
.globl vector18
vector18:
  pushl $0
801078a9:	6a 00                	push   $0x0
  pushl $18
801078ab:	6a 12                	push   $0x12
  jmp alltraps
801078ad:	e9 c5 f9 ff ff       	jmp    80107277 <alltraps>

801078b2 <vector19>:
.globl vector19
vector19:
  pushl $0
801078b2:	6a 00                	push   $0x0
  pushl $19
801078b4:	6a 13                	push   $0x13
  jmp alltraps
801078b6:	e9 bc f9 ff ff       	jmp    80107277 <alltraps>

801078bb <vector20>:
.globl vector20
vector20:
  pushl $0
801078bb:	6a 00                	push   $0x0
  pushl $20
801078bd:	6a 14                	push   $0x14
  jmp alltraps
801078bf:	e9 b3 f9 ff ff       	jmp    80107277 <alltraps>

801078c4 <vector21>:
.globl vector21
vector21:
  pushl $0
801078c4:	6a 00                	push   $0x0
  pushl $21
801078c6:	6a 15                	push   $0x15
  jmp alltraps
801078c8:	e9 aa f9 ff ff       	jmp    80107277 <alltraps>

801078cd <vector22>:
.globl vector22
vector22:
  pushl $0
801078cd:	6a 00                	push   $0x0
  pushl $22
801078cf:	6a 16                	push   $0x16
  jmp alltraps
801078d1:	e9 a1 f9 ff ff       	jmp    80107277 <alltraps>

801078d6 <vector23>:
.globl vector23
vector23:
  pushl $0
801078d6:	6a 00                	push   $0x0
  pushl $23
801078d8:	6a 17                	push   $0x17
  jmp alltraps
801078da:	e9 98 f9 ff ff       	jmp    80107277 <alltraps>

801078df <vector24>:
.globl vector24
vector24:
  pushl $0
801078df:	6a 00                	push   $0x0
  pushl $24
801078e1:	6a 18                	push   $0x18
  jmp alltraps
801078e3:	e9 8f f9 ff ff       	jmp    80107277 <alltraps>

801078e8 <vector25>:
.globl vector25
vector25:
  pushl $0
801078e8:	6a 00                	push   $0x0
  pushl $25
801078ea:	6a 19                	push   $0x19
  jmp alltraps
801078ec:	e9 86 f9 ff ff       	jmp    80107277 <alltraps>

801078f1 <vector26>:
.globl vector26
vector26:
  pushl $0
801078f1:	6a 00                	push   $0x0
  pushl $26
801078f3:	6a 1a                	push   $0x1a
  jmp alltraps
801078f5:	e9 7d f9 ff ff       	jmp    80107277 <alltraps>

801078fa <vector27>:
.globl vector27
vector27:
  pushl $0
801078fa:	6a 00                	push   $0x0
  pushl $27
801078fc:	6a 1b                	push   $0x1b
  jmp alltraps
801078fe:	e9 74 f9 ff ff       	jmp    80107277 <alltraps>

80107903 <vector28>:
.globl vector28
vector28:
  pushl $0
80107903:	6a 00                	push   $0x0
  pushl $28
80107905:	6a 1c                	push   $0x1c
  jmp alltraps
80107907:	e9 6b f9 ff ff       	jmp    80107277 <alltraps>

8010790c <vector29>:
.globl vector29
vector29:
  pushl $0
8010790c:	6a 00                	push   $0x0
  pushl $29
8010790e:	6a 1d                	push   $0x1d
  jmp alltraps
80107910:	e9 62 f9 ff ff       	jmp    80107277 <alltraps>

80107915 <vector30>:
.globl vector30
vector30:
  pushl $0
80107915:	6a 00                	push   $0x0
  pushl $30
80107917:	6a 1e                	push   $0x1e
  jmp alltraps
80107919:	e9 59 f9 ff ff       	jmp    80107277 <alltraps>

8010791e <vector31>:
.globl vector31
vector31:
  pushl $0
8010791e:	6a 00                	push   $0x0
  pushl $31
80107920:	6a 1f                	push   $0x1f
  jmp alltraps
80107922:	e9 50 f9 ff ff       	jmp    80107277 <alltraps>

80107927 <vector32>:
.globl vector32
vector32:
  pushl $0
80107927:	6a 00                	push   $0x0
  pushl $32
80107929:	6a 20                	push   $0x20
  jmp alltraps
8010792b:	e9 47 f9 ff ff       	jmp    80107277 <alltraps>

80107930 <vector33>:
.globl vector33
vector33:
  pushl $0
80107930:	6a 00                	push   $0x0
  pushl $33
80107932:	6a 21                	push   $0x21
  jmp alltraps
80107934:	e9 3e f9 ff ff       	jmp    80107277 <alltraps>

80107939 <vector34>:
.globl vector34
vector34:
  pushl $0
80107939:	6a 00                	push   $0x0
  pushl $34
8010793b:	6a 22                	push   $0x22
  jmp alltraps
8010793d:	e9 35 f9 ff ff       	jmp    80107277 <alltraps>

80107942 <vector35>:
.globl vector35
vector35:
  pushl $0
80107942:	6a 00                	push   $0x0
  pushl $35
80107944:	6a 23                	push   $0x23
  jmp alltraps
80107946:	e9 2c f9 ff ff       	jmp    80107277 <alltraps>

8010794b <vector36>:
.globl vector36
vector36:
  pushl $0
8010794b:	6a 00                	push   $0x0
  pushl $36
8010794d:	6a 24                	push   $0x24
  jmp alltraps
8010794f:	e9 23 f9 ff ff       	jmp    80107277 <alltraps>

80107954 <vector37>:
.globl vector37
vector37:
  pushl $0
80107954:	6a 00                	push   $0x0
  pushl $37
80107956:	6a 25                	push   $0x25
  jmp alltraps
80107958:	e9 1a f9 ff ff       	jmp    80107277 <alltraps>

8010795d <vector38>:
.globl vector38
vector38:
  pushl $0
8010795d:	6a 00                	push   $0x0
  pushl $38
8010795f:	6a 26                	push   $0x26
  jmp alltraps
80107961:	e9 11 f9 ff ff       	jmp    80107277 <alltraps>

80107966 <vector39>:
.globl vector39
vector39:
  pushl $0
80107966:	6a 00                	push   $0x0
  pushl $39
80107968:	6a 27                	push   $0x27
  jmp alltraps
8010796a:	e9 08 f9 ff ff       	jmp    80107277 <alltraps>

8010796f <vector40>:
.globl vector40
vector40:
  pushl $0
8010796f:	6a 00                	push   $0x0
  pushl $40
80107971:	6a 28                	push   $0x28
  jmp alltraps
80107973:	e9 ff f8 ff ff       	jmp    80107277 <alltraps>

80107978 <vector41>:
.globl vector41
vector41:
  pushl $0
80107978:	6a 00                	push   $0x0
  pushl $41
8010797a:	6a 29                	push   $0x29
  jmp alltraps
8010797c:	e9 f6 f8 ff ff       	jmp    80107277 <alltraps>

80107981 <vector42>:
.globl vector42
vector42:
  pushl $0
80107981:	6a 00                	push   $0x0
  pushl $42
80107983:	6a 2a                	push   $0x2a
  jmp alltraps
80107985:	e9 ed f8 ff ff       	jmp    80107277 <alltraps>

8010798a <vector43>:
.globl vector43
vector43:
  pushl $0
8010798a:	6a 00                	push   $0x0
  pushl $43
8010798c:	6a 2b                	push   $0x2b
  jmp alltraps
8010798e:	e9 e4 f8 ff ff       	jmp    80107277 <alltraps>

80107993 <vector44>:
.globl vector44
vector44:
  pushl $0
80107993:	6a 00                	push   $0x0
  pushl $44
80107995:	6a 2c                	push   $0x2c
  jmp alltraps
80107997:	e9 db f8 ff ff       	jmp    80107277 <alltraps>

8010799c <vector45>:
.globl vector45
vector45:
  pushl $0
8010799c:	6a 00                	push   $0x0
  pushl $45
8010799e:	6a 2d                	push   $0x2d
  jmp alltraps
801079a0:	e9 d2 f8 ff ff       	jmp    80107277 <alltraps>

801079a5 <vector46>:
.globl vector46
vector46:
  pushl $0
801079a5:	6a 00                	push   $0x0
  pushl $46
801079a7:	6a 2e                	push   $0x2e
  jmp alltraps
801079a9:	e9 c9 f8 ff ff       	jmp    80107277 <alltraps>

801079ae <vector47>:
.globl vector47
vector47:
  pushl $0
801079ae:	6a 00                	push   $0x0
  pushl $47
801079b0:	6a 2f                	push   $0x2f
  jmp alltraps
801079b2:	e9 c0 f8 ff ff       	jmp    80107277 <alltraps>

801079b7 <vector48>:
.globl vector48
vector48:
  pushl $0
801079b7:	6a 00                	push   $0x0
  pushl $48
801079b9:	6a 30                	push   $0x30
  jmp alltraps
801079bb:	e9 b7 f8 ff ff       	jmp    80107277 <alltraps>

801079c0 <vector49>:
.globl vector49
vector49:
  pushl $0
801079c0:	6a 00                	push   $0x0
  pushl $49
801079c2:	6a 31                	push   $0x31
  jmp alltraps
801079c4:	e9 ae f8 ff ff       	jmp    80107277 <alltraps>

801079c9 <vector50>:
.globl vector50
vector50:
  pushl $0
801079c9:	6a 00                	push   $0x0
  pushl $50
801079cb:	6a 32                	push   $0x32
  jmp alltraps
801079cd:	e9 a5 f8 ff ff       	jmp    80107277 <alltraps>

801079d2 <vector51>:
.globl vector51
vector51:
  pushl $0
801079d2:	6a 00                	push   $0x0
  pushl $51
801079d4:	6a 33                	push   $0x33
  jmp alltraps
801079d6:	e9 9c f8 ff ff       	jmp    80107277 <alltraps>

801079db <vector52>:
.globl vector52
vector52:
  pushl $0
801079db:	6a 00                	push   $0x0
  pushl $52
801079dd:	6a 34                	push   $0x34
  jmp alltraps
801079df:	e9 93 f8 ff ff       	jmp    80107277 <alltraps>

801079e4 <vector53>:
.globl vector53
vector53:
  pushl $0
801079e4:	6a 00                	push   $0x0
  pushl $53
801079e6:	6a 35                	push   $0x35
  jmp alltraps
801079e8:	e9 8a f8 ff ff       	jmp    80107277 <alltraps>

801079ed <vector54>:
.globl vector54
vector54:
  pushl $0
801079ed:	6a 00                	push   $0x0
  pushl $54
801079ef:	6a 36                	push   $0x36
  jmp alltraps
801079f1:	e9 81 f8 ff ff       	jmp    80107277 <alltraps>

801079f6 <vector55>:
.globl vector55
vector55:
  pushl $0
801079f6:	6a 00                	push   $0x0
  pushl $55
801079f8:	6a 37                	push   $0x37
  jmp alltraps
801079fa:	e9 78 f8 ff ff       	jmp    80107277 <alltraps>

801079ff <vector56>:
.globl vector56
vector56:
  pushl $0
801079ff:	6a 00                	push   $0x0
  pushl $56
80107a01:	6a 38                	push   $0x38
  jmp alltraps
80107a03:	e9 6f f8 ff ff       	jmp    80107277 <alltraps>

80107a08 <vector57>:
.globl vector57
vector57:
  pushl $0
80107a08:	6a 00                	push   $0x0
  pushl $57
80107a0a:	6a 39                	push   $0x39
  jmp alltraps
80107a0c:	e9 66 f8 ff ff       	jmp    80107277 <alltraps>

80107a11 <vector58>:
.globl vector58
vector58:
  pushl $0
80107a11:	6a 00                	push   $0x0
  pushl $58
80107a13:	6a 3a                	push   $0x3a
  jmp alltraps
80107a15:	e9 5d f8 ff ff       	jmp    80107277 <alltraps>

80107a1a <vector59>:
.globl vector59
vector59:
  pushl $0
80107a1a:	6a 00                	push   $0x0
  pushl $59
80107a1c:	6a 3b                	push   $0x3b
  jmp alltraps
80107a1e:	e9 54 f8 ff ff       	jmp    80107277 <alltraps>

80107a23 <vector60>:
.globl vector60
vector60:
  pushl $0
80107a23:	6a 00                	push   $0x0
  pushl $60
80107a25:	6a 3c                	push   $0x3c
  jmp alltraps
80107a27:	e9 4b f8 ff ff       	jmp    80107277 <alltraps>

80107a2c <vector61>:
.globl vector61
vector61:
  pushl $0
80107a2c:	6a 00                	push   $0x0
  pushl $61
80107a2e:	6a 3d                	push   $0x3d
  jmp alltraps
80107a30:	e9 42 f8 ff ff       	jmp    80107277 <alltraps>

80107a35 <vector62>:
.globl vector62
vector62:
  pushl $0
80107a35:	6a 00                	push   $0x0
  pushl $62
80107a37:	6a 3e                	push   $0x3e
  jmp alltraps
80107a39:	e9 39 f8 ff ff       	jmp    80107277 <alltraps>

80107a3e <vector63>:
.globl vector63
vector63:
  pushl $0
80107a3e:	6a 00                	push   $0x0
  pushl $63
80107a40:	6a 3f                	push   $0x3f
  jmp alltraps
80107a42:	e9 30 f8 ff ff       	jmp    80107277 <alltraps>

80107a47 <vector64>:
.globl vector64
vector64:
  pushl $0
80107a47:	6a 00                	push   $0x0
  pushl $64
80107a49:	6a 40                	push   $0x40
  jmp alltraps
80107a4b:	e9 27 f8 ff ff       	jmp    80107277 <alltraps>

80107a50 <vector65>:
.globl vector65
vector65:
  pushl $0
80107a50:	6a 00                	push   $0x0
  pushl $65
80107a52:	6a 41                	push   $0x41
  jmp alltraps
80107a54:	e9 1e f8 ff ff       	jmp    80107277 <alltraps>

80107a59 <vector66>:
.globl vector66
vector66:
  pushl $0
80107a59:	6a 00                	push   $0x0
  pushl $66
80107a5b:	6a 42                	push   $0x42
  jmp alltraps
80107a5d:	e9 15 f8 ff ff       	jmp    80107277 <alltraps>

80107a62 <vector67>:
.globl vector67
vector67:
  pushl $0
80107a62:	6a 00                	push   $0x0
  pushl $67
80107a64:	6a 43                	push   $0x43
  jmp alltraps
80107a66:	e9 0c f8 ff ff       	jmp    80107277 <alltraps>

80107a6b <vector68>:
.globl vector68
vector68:
  pushl $0
80107a6b:	6a 00                	push   $0x0
  pushl $68
80107a6d:	6a 44                	push   $0x44
  jmp alltraps
80107a6f:	e9 03 f8 ff ff       	jmp    80107277 <alltraps>

80107a74 <vector69>:
.globl vector69
vector69:
  pushl $0
80107a74:	6a 00                	push   $0x0
  pushl $69
80107a76:	6a 45                	push   $0x45
  jmp alltraps
80107a78:	e9 fa f7 ff ff       	jmp    80107277 <alltraps>

80107a7d <vector70>:
.globl vector70
vector70:
  pushl $0
80107a7d:	6a 00                	push   $0x0
  pushl $70
80107a7f:	6a 46                	push   $0x46
  jmp alltraps
80107a81:	e9 f1 f7 ff ff       	jmp    80107277 <alltraps>

80107a86 <vector71>:
.globl vector71
vector71:
  pushl $0
80107a86:	6a 00                	push   $0x0
  pushl $71
80107a88:	6a 47                	push   $0x47
  jmp alltraps
80107a8a:	e9 e8 f7 ff ff       	jmp    80107277 <alltraps>

80107a8f <vector72>:
.globl vector72
vector72:
  pushl $0
80107a8f:	6a 00                	push   $0x0
  pushl $72
80107a91:	6a 48                	push   $0x48
  jmp alltraps
80107a93:	e9 df f7 ff ff       	jmp    80107277 <alltraps>

80107a98 <vector73>:
.globl vector73
vector73:
  pushl $0
80107a98:	6a 00                	push   $0x0
  pushl $73
80107a9a:	6a 49                	push   $0x49
  jmp alltraps
80107a9c:	e9 d6 f7 ff ff       	jmp    80107277 <alltraps>

80107aa1 <vector74>:
.globl vector74
vector74:
  pushl $0
80107aa1:	6a 00                	push   $0x0
  pushl $74
80107aa3:	6a 4a                	push   $0x4a
  jmp alltraps
80107aa5:	e9 cd f7 ff ff       	jmp    80107277 <alltraps>

80107aaa <vector75>:
.globl vector75
vector75:
  pushl $0
80107aaa:	6a 00                	push   $0x0
  pushl $75
80107aac:	6a 4b                	push   $0x4b
  jmp alltraps
80107aae:	e9 c4 f7 ff ff       	jmp    80107277 <alltraps>

80107ab3 <vector76>:
.globl vector76
vector76:
  pushl $0
80107ab3:	6a 00                	push   $0x0
  pushl $76
80107ab5:	6a 4c                	push   $0x4c
  jmp alltraps
80107ab7:	e9 bb f7 ff ff       	jmp    80107277 <alltraps>

80107abc <vector77>:
.globl vector77
vector77:
  pushl $0
80107abc:	6a 00                	push   $0x0
  pushl $77
80107abe:	6a 4d                	push   $0x4d
  jmp alltraps
80107ac0:	e9 b2 f7 ff ff       	jmp    80107277 <alltraps>

80107ac5 <vector78>:
.globl vector78
vector78:
  pushl $0
80107ac5:	6a 00                	push   $0x0
  pushl $78
80107ac7:	6a 4e                	push   $0x4e
  jmp alltraps
80107ac9:	e9 a9 f7 ff ff       	jmp    80107277 <alltraps>

80107ace <vector79>:
.globl vector79
vector79:
  pushl $0
80107ace:	6a 00                	push   $0x0
  pushl $79
80107ad0:	6a 4f                	push   $0x4f
  jmp alltraps
80107ad2:	e9 a0 f7 ff ff       	jmp    80107277 <alltraps>

80107ad7 <vector80>:
.globl vector80
vector80:
  pushl $0
80107ad7:	6a 00                	push   $0x0
  pushl $80
80107ad9:	6a 50                	push   $0x50
  jmp alltraps
80107adb:	e9 97 f7 ff ff       	jmp    80107277 <alltraps>

80107ae0 <vector81>:
.globl vector81
vector81:
  pushl $0
80107ae0:	6a 00                	push   $0x0
  pushl $81
80107ae2:	6a 51                	push   $0x51
  jmp alltraps
80107ae4:	e9 8e f7 ff ff       	jmp    80107277 <alltraps>

80107ae9 <vector82>:
.globl vector82
vector82:
  pushl $0
80107ae9:	6a 00                	push   $0x0
  pushl $82
80107aeb:	6a 52                	push   $0x52
  jmp alltraps
80107aed:	e9 85 f7 ff ff       	jmp    80107277 <alltraps>

80107af2 <vector83>:
.globl vector83
vector83:
  pushl $0
80107af2:	6a 00                	push   $0x0
  pushl $83
80107af4:	6a 53                	push   $0x53
  jmp alltraps
80107af6:	e9 7c f7 ff ff       	jmp    80107277 <alltraps>

80107afb <vector84>:
.globl vector84
vector84:
  pushl $0
80107afb:	6a 00                	push   $0x0
  pushl $84
80107afd:	6a 54                	push   $0x54
  jmp alltraps
80107aff:	e9 73 f7 ff ff       	jmp    80107277 <alltraps>

80107b04 <vector85>:
.globl vector85
vector85:
  pushl $0
80107b04:	6a 00                	push   $0x0
  pushl $85
80107b06:	6a 55                	push   $0x55
  jmp alltraps
80107b08:	e9 6a f7 ff ff       	jmp    80107277 <alltraps>

80107b0d <vector86>:
.globl vector86
vector86:
  pushl $0
80107b0d:	6a 00                	push   $0x0
  pushl $86
80107b0f:	6a 56                	push   $0x56
  jmp alltraps
80107b11:	e9 61 f7 ff ff       	jmp    80107277 <alltraps>

80107b16 <vector87>:
.globl vector87
vector87:
  pushl $0
80107b16:	6a 00                	push   $0x0
  pushl $87
80107b18:	6a 57                	push   $0x57
  jmp alltraps
80107b1a:	e9 58 f7 ff ff       	jmp    80107277 <alltraps>

80107b1f <vector88>:
.globl vector88
vector88:
  pushl $0
80107b1f:	6a 00                	push   $0x0
  pushl $88
80107b21:	6a 58                	push   $0x58
  jmp alltraps
80107b23:	e9 4f f7 ff ff       	jmp    80107277 <alltraps>

80107b28 <vector89>:
.globl vector89
vector89:
  pushl $0
80107b28:	6a 00                	push   $0x0
  pushl $89
80107b2a:	6a 59                	push   $0x59
  jmp alltraps
80107b2c:	e9 46 f7 ff ff       	jmp    80107277 <alltraps>

80107b31 <vector90>:
.globl vector90
vector90:
  pushl $0
80107b31:	6a 00                	push   $0x0
  pushl $90
80107b33:	6a 5a                	push   $0x5a
  jmp alltraps
80107b35:	e9 3d f7 ff ff       	jmp    80107277 <alltraps>

80107b3a <vector91>:
.globl vector91
vector91:
  pushl $0
80107b3a:	6a 00                	push   $0x0
  pushl $91
80107b3c:	6a 5b                	push   $0x5b
  jmp alltraps
80107b3e:	e9 34 f7 ff ff       	jmp    80107277 <alltraps>

80107b43 <vector92>:
.globl vector92
vector92:
  pushl $0
80107b43:	6a 00                	push   $0x0
  pushl $92
80107b45:	6a 5c                	push   $0x5c
  jmp alltraps
80107b47:	e9 2b f7 ff ff       	jmp    80107277 <alltraps>

80107b4c <vector93>:
.globl vector93
vector93:
  pushl $0
80107b4c:	6a 00                	push   $0x0
  pushl $93
80107b4e:	6a 5d                	push   $0x5d
  jmp alltraps
80107b50:	e9 22 f7 ff ff       	jmp    80107277 <alltraps>

80107b55 <vector94>:
.globl vector94
vector94:
  pushl $0
80107b55:	6a 00                	push   $0x0
  pushl $94
80107b57:	6a 5e                	push   $0x5e
  jmp alltraps
80107b59:	e9 19 f7 ff ff       	jmp    80107277 <alltraps>

80107b5e <vector95>:
.globl vector95
vector95:
  pushl $0
80107b5e:	6a 00                	push   $0x0
  pushl $95
80107b60:	6a 5f                	push   $0x5f
  jmp alltraps
80107b62:	e9 10 f7 ff ff       	jmp    80107277 <alltraps>

80107b67 <vector96>:
.globl vector96
vector96:
  pushl $0
80107b67:	6a 00                	push   $0x0
  pushl $96
80107b69:	6a 60                	push   $0x60
  jmp alltraps
80107b6b:	e9 07 f7 ff ff       	jmp    80107277 <alltraps>

80107b70 <vector97>:
.globl vector97
vector97:
  pushl $0
80107b70:	6a 00                	push   $0x0
  pushl $97
80107b72:	6a 61                	push   $0x61
  jmp alltraps
80107b74:	e9 fe f6 ff ff       	jmp    80107277 <alltraps>

80107b79 <vector98>:
.globl vector98
vector98:
  pushl $0
80107b79:	6a 00                	push   $0x0
  pushl $98
80107b7b:	6a 62                	push   $0x62
  jmp alltraps
80107b7d:	e9 f5 f6 ff ff       	jmp    80107277 <alltraps>

80107b82 <vector99>:
.globl vector99
vector99:
  pushl $0
80107b82:	6a 00                	push   $0x0
  pushl $99
80107b84:	6a 63                	push   $0x63
  jmp alltraps
80107b86:	e9 ec f6 ff ff       	jmp    80107277 <alltraps>

80107b8b <vector100>:
.globl vector100
vector100:
  pushl $0
80107b8b:	6a 00                	push   $0x0
  pushl $100
80107b8d:	6a 64                	push   $0x64
  jmp alltraps
80107b8f:	e9 e3 f6 ff ff       	jmp    80107277 <alltraps>

80107b94 <vector101>:
.globl vector101
vector101:
  pushl $0
80107b94:	6a 00                	push   $0x0
  pushl $101
80107b96:	6a 65                	push   $0x65
  jmp alltraps
80107b98:	e9 da f6 ff ff       	jmp    80107277 <alltraps>

80107b9d <vector102>:
.globl vector102
vector102:
  pushl $0
80107b9d:	6a 00                	push   $0x0
  pushl $102
80107b9f:	6a 66                	push   $0x66
  jmp alltraps
80107ba1:	e9 d1 f6 ff ff       	jmp    80107277 <alltraps>

80107ba6 <vector103>:
.globl vector103
vector103:
  pushl $0
80107ba6:	6a 00                	push   $0x0
  pushl $103
80107ba8:	6a 67                	push   $0x67
  jmp alltraps
80107baa:	e9 c8 f6 ff ff       	jmp    80107277 <alltraps>

80107baf <vector104>:
.globl vector104
vector104:
  pushl $0
80107baf:	6a 00                	push   $0x0
  pushl $104
80107bb1:	6a 68                	push   $0x68
  jmp alltraps
80107bb3:	e9 bf f6 ff ff       	jmp    80107277 <alltraps>

80107bb8 <vector105>:
.globl vector105
vector105:
  pushl $0
80107bb8:	6a 00                	push   $0x0
  pushl $105
80107bba:	6a 69                	push   $0x69
  jmp alltraps
80107bbc:	e9 b6 f6 ff ff       	jmp    80107277 <alltraps>

80107bc1 <vector106>:
.globl vector106
vector106:
  pushl $0
80107bc1:	6a 00                	push   $0x0
  pushl $106
80107bc3:	6a 6a                	push   $0x6a
  jmp alltraps
80107bc5:	e9 ad f6 ff ff       	jmp    80107277 <alltraps>

80107bca <vector107>:
.globl vector107
vector107:
  pushl $0
80107bca:	6a 00                	push   $0x0
  pushl $107
80107bcc:	6a 6b                	push   $0x6b
  jmp alltraps
80107bce:	e9 a4 f6 ff ff       	jmp    80107277 <alltraps>

80107bd3 <vector108>:
.globl vector108
vector108:
  pushl $0
80107bd3:	6a 00                	push   $0x0
  pushl $108
80107bd5:	6a 6c                	push   $0x6c
  jmp alltraps
80107bd7:	e9 9b f6 ff ff       	jmp    80107277 <alltraps>

80107bdc <vector109>:
.globl vector109
vector109:
  pushl $0
80107bdc:	6a 00                	push   $0x0
  pushl $109
80107bde:	6a 6d                	push   $0x6d
  jmp alltraps
80107be0:	e9 92 f6 ff ff       	jmp    80107277 <alltraps>

80107be5 <vector110>:
.globl vector110
vector110:
  pushl $0
80107be5:	6a 00                	push   $0x0
  pushl $110
80107be7:	6a 6e                	push   $0x6e
  jmp alltraps
80107be9:	e9 89 f6 ff ff       	jmp    80107277 <alltraps>

80107bee <vector111>:
.globl vector111
vector111:
  pushl $0
80107bee:	6a 00                	push   $0x0
  pushl $111
80107bf0:	6a 6f                	push   $0x6f
  jmp alltraps
80107bf2:	e9 80 f6 ff ff       	jmp    80107277 <alltraps>

80107bf7 <vector112>:
.globl vector112
vector112:
  pushl $0
80107bf7:	6a 00                	push   $0x0
  pushl $112
80107bf9:	6a 70                	push   $0x70
  jmp alltraps
80107bfb:	e9 77 f6 ff ff       	jmp    80107277 <alltraps>

80107c00 <vector113>:
.globl vector113
vector113:
  pushl $0
80107c00:	6a 00                	push   $0x0
  pushl $113
80107c02:	6a 71                	push   $0x71
  jmp alltraps
80107c04:	e9 6e f6 ff ff       	jmp    80107277 <alltraps>

80107c09 <vector114>:
.globl vector114
vector114:
  pushl $0
80107c09:	6a 00                	push   $0x0
  pushl $114
80107c0b:	6a 72                	push   $0x72
  jmp alltraps
80107c0d:	e9 65 f6 ff ff       	jmp    80107277 <alltraps>

80107c12 <vector115>:
.globl vector115
vector115:
  pushl $0
80107c12:	6a 00                	push   $0x0
  pushl $115
80107c14:	6a 73                	push   $0x73
  jmp alltraps
80107c16:	e9 5c f6 ff ff       	jmp    80107277 <alltraps>

80107c1b <vector116>:
.globl vector116
vector116:
  pushl $0
80107c1b:	6a 00                	push   $0x0
  pushl $116
80107c1d:	6a 74                	push   $0x74
  jmp alltraps
80107c1f:	e9 53 f6 ff ff       	jmp    80107277 <alltraps>

80107c24 <vector117>:
.globl vector117
vector117:
  pushl $0
80107c24:	6a 00                	push   $0x0
  pushl $117
80107c26:	6a 75                	push   $0x75
  jmp alltraps
80107c28:	e9 4a f6 ff ff       	jmp    80107277 <alltraps>

80107c2d <vector118>:
.globl vector118
vector118:
  pushl $0
80107c2d:	6a 00                	push   $0x0
  pushl $118
80107c2f:	6a 76                	push   $0x76
  jmp alltraps
80107c31:	e9 41 f6 ff ff       	jmp    80107277 <alltraps>

80107c36 <vector119>:
.globl vector119
vector119:
  pushl $0
80107c36:	6a 00                	push   $0x0
  pushl $119
80107c38:	6a 77                	push   $0x77
  jmp alltraps
80107c3a:	e9 38 f6 ff ff       	jmp    80107277 <alltraps>

80107c3f <vector120>:
.globl vector120
vector120:
  pushl $0
80107c3f:	6a 00                	push   $0x0
  pushl $120
80107c41:	6a 78                	push   $0x78
  jmp alltraps
80107c43:	e9 2f f6 ff ff       	jmp    80107277 <alltraps>

80107c48 <vector121>:
.globl vector121
vector121:
  pushl $0
80107c48:	6a 00                	push   $0x0
  pushl $121
80107c4a:	6a 79                	push   $0x79
  jmp alltraps
80107c4c:	e9 26 f6 ff ff       	jmp    80107277 <alltraps>

80107c51 <vector122>:
.globl vector122
vector122:
  pushl $0
80107c51:	6a 00                	push   $0x0
  pushl $122
80107c53:	6a 7a                	push   $0x7a
  jmp alltraps
80107c55:	e9 1d f6 ff ff       	jmp    80107277 <alltraps>

80107c5a <vector123>:
.globl vector123
vector123:
  pushl $0
80107c5a:	6a 00                	push   $0x0
  pushl $123
80107c5c:	6a 7b                	push   $0x7b
  jmp alltraps
80107c5e:	e9 14 f6 ff ff       	jmp    80107277 <alltraps>

80107c63 <vector124>:
.globl vector124
vector124:
  pushl $0
80107c63:	6a 00                	push   $0x0
  pushl $124
80107c65:	6a 7c                	push   $0x7c
  jmp alltraps
80107c67:	e9 0b f6 ff ff       	jmp    80107277 <alltraps>

80107c6c <vector125>:
.globl vector125
vector125:
  pushl $0
80107c6c:	6a 00                	push   $0x0
  pushl $125
80107c6e:	6a 7d                	push   $0x7d
  jmp alltraps
80107c70:	e9 02 f6 ff ff       	jmp    80107277 <alltraps>

80107c75 <vector126>:
.globl vector126
vector126:
  pushl $0
80107c75:	6a 00                	push   $0x0
  pushl $126
80107c77:	6a 7e                	push   $0x7e
  jmp alltraps
80107c79:	e9 f9 f5 ff ff       	jmp    80107277 <alltraps>

80107c7e <vector127>:
.globl vector127
vector127:
  pushl $0
80107c7e:	6a 00                	push   $0x0
  pushl $127
80107c80:	6a 7f                	push   $0x7f
  jmp alltraps
80107c82:	e9 f0 f5 ff ff       	jmp    80107277 <alltraps>

80107c87 <vector128>:
.globl vector128
vector128:
  pushl $0
80107c87:	6a 00                	push   $0x0
  pushl $128
80107c89:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80107c8e:	e9 e4 f5 ff ff       	jmp    80107277 <alltraps>

80107c93 <vector129>:
.globl vector129
vector129:
  pushl $0
80107c93:	6a 00                	push   $0x0
  pushl $129
80107c95:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80107c9a:	e9 d8 f5 ff ff       	jmp    80107277 <alltraps>

80107c9f <vector130>:
.globl vector130
vector130:
  pushl $0
80107c9f:	6a 00                	push   $0x0
  pushl $130
80107ca1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80107ca6:	e9 cc f5 ff ff       	jmp    80107277 <alltraps>

80107cab <vector131>:
.globl vector131
vector131:
  pushl $0
80107cab:	6a 00                	push   $0x0
  pushl $131
80107cad:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80107cb2:	e9 c0 f5 ff ff       	jmp    80107277 <alltraps>

80107cb7 <vector132>:
.globl vector132
vector132:
  pushl $0
80107cb7:	6a 00                	push   $0x0
  pushl $132
80107cb9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80107cbe:	e9 b4 f5 ff ff       	jmp    80107277 <alltraps>

80107cc3 <vector133>:
.globl vector133
vector133:
  pushl $0
80107cc3:	6a 00                	push   $0x0
  pushl $133
80107cc5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80107cca:	e9 a8 f5 ff ff       	jmp    80107277 <alltraps>

80107ccf <vector134>:
.globl vector134
vector134:
  pushl $0
80107ccf:	6a 00                	push   $0x0
  pushl $134
80107cd1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107cd6:	e9 9c f5 ff ff       	jmp    80107277 <alltraps>

80107cdb <vector135>:
.globl vector135
vector135:
  pushl $0
80107cdb:	6a 00                	push   $0x0
  pushl $135
80107cdd:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107ce2:	e9 90 f5 ff ff       	jmp    80107277 <alltraps>

80107ce7 <vector136>:
.globl vector136
vector136:
  pushl $0
80107ce7:	6a 00                	push   $0x0
  pushl $136
80107ce9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80107cee:	e9 84 f5 ff ff       	jmp    80107277 <alltraps>

80107cf3 <vector137>:
.globl vector137
vector137:
  pushl $0
80107cf3:	6a 00                	push   $0x0
  pushl $137
80107cf5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80107cfa:	e9 78 f5 ff ff       	jmp    80107277 <alltraps>

80107cff <vector138>:
.globl vector138
vector138:
  pushl $0
80107cff:	6a 00                	push   $0x0
  pushl $138
80107d01:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107d06:	e9 6c f5 ff ff       	jmp    80107277 <alltraps>

80107d0b <vector139>:
.globl vector139
vector139:
  pushl $0
80107d0b:	6a 00                	push   $0x0
  pushl $139
80107d0d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80107d12:	e9 60 f5 ff ff       	jmp    80107277 <alltraps>

80107d17 <vector140>:
.globl vector140
vector140:
  pushl $0
80107d17:	6a 00                	push   $0x0
  pushl $140
80107d19:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80107d1e:	e9 54 f5 ff ff       	jmp    80107277 <alltraps>

80107d23 <vector141>:
.globl vector141
vector141:
  pushl $0
80107d23:	6a 00                	push   $0x0
  pushl $141
80107d25:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80107d2a:	e9 48 f5 ff ff       	jmp    80107277 <alltraps>

80107d2f <vector142>:
.globl vector142
vector142:
  pushl $0
80107d2f:	6a 00                	push   $0x0
  pushl $142
80107d31:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80107d36:	e9 3c f5 ff ff       	jmp    80107277 <alltraps>

80107d3b <vector143>:
.globl vector143
vector143:
  pushl $0
80107d3b:	6a 00                	push   $0x0
  pushl $143
80107d3d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80107d42:	e9 30 f5 ff ff       	jmp    80107277 <alltraps>

80107d47 <vector144>:
.globl vector144
vector144:
  pushl $0
80107d47:	6a 00                	push   $0x0
  pushl $144
80107d49:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80107d4e:	e9 24 f5 ff ff       	jmp    80107277 <alltraps>

80107d53 <vector145>:
.globl vector145
vector145:
  pushl $0
80107d53:	6a 00                	push   $0x0
  pushl $145
80107d55:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80107d5a:	e9 18 f5 ff ff       	jmp    80107277 <alltraps>

80107d5f <vector146>:
.globl vector146
vector146:
  pushl $0
80107d5f:	6a 00                	push   $0x0
  pushl $146
80107d61:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107d66:	e9 0c f5 ff ff       	jmp    80107277 <alltraps>

80107d6b <vector147>:
.globl vector147
vector147:
  pushl $0
80107d6b:	6a 00                	push   $0x0
  pushl $147
80107d6d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107d72:	e9 00 f5 ff ff       	jmp    80107277 <alltraps>

80107d77 <vector148>:
.globl vector148
vector148:
  pushl $0
80107d77:	6a 00                	push   $0x0
  pushl $148
80107d79:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80107d7e:	e9 f4 f4 ff ff       	jmp    80107277 <alltraps>

80107d83 <vector149>:
.globl vector149
vector149:
  pushl $0
80107d83:	6a 00                	push   $0x0
  pushl $149
80107d85:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80107d8a:	e9 e8 f4 ff ff       	jmp    80107277 <alltraps>

80107d8f <vector150>:
.globl vector150
vector150:
  pushl $0
80107d8f:	6a 00                	push   $0x0
  pushl $150
80107d91:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107d96:	e9 dc f4 ff ff       	jmp    80107277 <alltraps>

80107d9b <vector151>:
.globl vector151
vector151:
  pushl $0
80107d9b:	6a 00                	push   $0x0
  pushl $151
80107d9d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80107da2:	e9 d0 f4 ff ff       	jmp    80107277 <alltraps>

80107da7 <vector152>:
.globl vector152
vector152:
  pushl $0
80107da7:	6a 00                	push   $0x0
  pushl $152
80107da9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80107dae:	e9 c4 f4 ff ff       	jmp    80107277 <alltraps>

80107db3 <vector153>:
.globl vector153
vector153:
  pushl $0
80107db3:	6a 00                	push   $0x0
  pushl $153
80107db5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80107dba:	e9 b8 f4 ff ff       	jmp    80107277 <alltraps>

80107dbf <vector154>:
.globl vector154
vector154:
  pushl $0
80107dbf:	6a 00                	push   $0x0
  pushl $154
80107dc1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80107dc6:	e9 ac f4 ff ff       	jmp    80107277 <alltraps>

80107dcb <vector155>:
.globl vector155
vector155:
  pushl $0
80107dcb:	6a 00                	push   $0x0
  pushl $155
80107dcd:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107dd2:	e9 a0 f4 ff ff       	jmp    80107277 <alltraps>

80107dd7 <vector156>:
.globl vector156
vector156:
  pushl $0
80107dd7:	6a 00                	push   $0x0
  pushl $156
80107dd9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80107dde:	e9 94 f4 ff ff       	jmp    80107277 <alltraps>

80107de3 <vector157>:
.globl vector157
vector157:
  pushl $0
80107de3:	6a 00                	push   $0x0
  pushl $157
80107de5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80107dea:	e9 88 f4 ff ff       	jmp    80107277 <alltraps>

80107def <vector158>:
.globl vector158
vector158:
  pushl $0
80107def:	6a 00                	push   $0x0
  pushl $158
80107df1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107df6:	e9 7c f4 ff ff       	jmp    80107277 <alltraps>

80107dfb <vector159>:
.globl vector159
vector159:
  pushl $0
80107dfb:	6a 00                	push   $0x0
  pushl $159
80107dfd:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80107e02:	e9 70 f4 ff ff       	jmp    80107277 <alltraps>

80107e07 <vector160>:
.globl vector160
vector160:
  pushl $0
80107e07:	6a 00                	push   $0x0
  pushl $160
80107e09:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80107e0e:	e9 64 f4 ff ff       	jmp    80107277 <alltraps>

80107e13 <vector161>:
.globl vector161
vector161:
  pushl $0
80107e13:	6a 00                	push   $0x0
  pushl $161
80107e15:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80107e1a:	e9 58 f4 ff ff       	jmp    80107277 <alltraps>

80107e1f <vector162>:
.globl vector162
vector162:
  pushl $0
80107e1f:	6a 00                	push   $0x0
  pushl $162
80107e21:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80107e26:	e9 4c f4 ff ff       	jmp    80107277 <alltraps>

80107e2b <vector163>:
.globl vector163
vector163:
  pushl $0
80107e2b:	6a 00                	push   $0x0
  pushl $163
80107e2d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80107e32:	e9 40 f4 ff ff       	jmp    80107277 <alltraps>

80107e37 <vector164>:
.globl vector164
vector164:
  pushl $0
80107e37:	6a 00                	push   $0x0
  pushl $164
80107e39:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80107e3e:	e9 34 f4 ff ff       	jmp    80107277 <alltraps>

80107e43 <vector165>:
.globl vector165
vector165:
  pushl $0
80107e43:	6a 00                	push   $0x0
  pushl $165
80107e45:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80107e4a:	e9 28 f4 ff ff       	jmp    80107277 <alltraps>

80107e4f <vector166>:
.globl vector166
vector166:
  pushl $0
80107e4f:	6a 00                	push   $0x0
  pushl $166
80107e51:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107e56:	e9 1c f4 ff ff       	jmp    80107277 <alltraps>

80107e5b <vector167>:
.globl vector167
vector167:
  pushl $0
80107e5b:	6a 00                	push   $0x0
  pushl $167
80107e5d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107e62:	e9 10 f4 ff ff       	jmp    80107277 <alltraps>

80107e67 <vector168>:
.globl vector168
vector168:
  pushl $0
80107e67:	6a 00                	push   $0x0
  pushl $168
80107e69:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80107e6e:	e9 04 f4 ff ff       	jmp    80107277 <alltraps>

80107e73 <vector169>:
.globl vector169
vector169:
  pushl $0
80107e73:	6a 00                	push   $0x0
  pushl $169
80107e75:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80107e7a:	e9 f8 f3 ff ff       	jmp    80107277 <alltraps>

80107e7f <vector170>:
.globl vector170
vector170:
  pushl $0
80107e7f:	6a 00                	push   $0x0
  pushl $170
80107e81:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107e86:	e9 ec f3 ff ff       	jmp    80107277 <alltraps>

80107e8b <vector171>:
.globl vector171
vector171:
  pushl $0
80107e8b:	6a 00                	push   $0x0
  pushl $171
80107e8d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107e92:	e9 e0 f3 ff ff       	jmp    80107277 <alltraps>

80107e97 <vector172>:
.globl vector172
vector172:
  pushl $0
80107e97:	6a 00                	push   $0x0
  pushl $172
80107e99:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80107e9e:	e9 d4 f3 ff ff       	jmp    80107277 <alltraps>

80107ea3 <vector173>:
.globl vector173
vector173:
  pushl $0
80107ea3:	6a 00                	push   $0x0
  pushl $173
80107ea5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80107eaa:	e9 c8 f3 ff ff       	jmp    80107277 <alltraps>

80107eaf <vector174>:
.globl vector174
vector174:
  pushl $0
80107eaf:	6a 00                	push   $0x0
  pushl $174
80107eb1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107eb6:	e9 bc f3 ff ff       	jmp    80107277 <alltraps>

80107ebb <vector175>:
.globl vector175
vector175:
  pushl $0
80107ebb:	6a 00                	push   $0x0
  pushl $175
80107ebd:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107ec2:	e9 b0 f3 ff ff       	jmp    80107277 <alltraps>

80107ec7 <vector176>:
.globl vector176
vector176:
  pushl $0
80107ec7:	6a 00                	push   $0x0
  pushl $176
80107ec9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80107ece:	e9 a4 f3 ff ff       	jmp    80107277 <alltraps>

80107ed3 <vector177>:
.globl vector177
vector177:
  pushl $0
80107ed3:	6a 00                	push   $0x0
  pushl $177
80107ed5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80107eda:	e9 98 f3 ff ff       	jmp    80107277 <alltraps>

80107edf <vector178>:
.globl vector178
vector178:
  pushl $0
80107edf:	6a 00                	push   $0x0
  pushl $178
80107ee1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107ee6:	e9 8c f3 ff ff       	jmp    80107277 <alltraps>

80107eeb <vector179>:
.globl vector179
vector179:
  pushl $0
80107eeb:	6a 00                	push   $0x0
  pushl $179
80107eed:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107ef2:	e9 80 f3 ff ff       	jmp    80107277 <alltraps>

80107ef7 <vector180>:
.globl vector180
vector180:
  pushl $0
80107ef7:	6a 00                	push   $0x0
  pushl $180
80107ef9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80107efe:	e9 74 f3 ff ff       	jmp    80107277 <alltraps>

80107f03 <vector181>:
.globl vector181
vector181:
  pushl $0
80107f03:	6a 00                	push   $0x0
  pushl $181
80107f05:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80107f0a:	e9 68 f3 ff ff       	jmp    80107277 <alltraps>

80107f0f <vector182>:
.globl vector182
vector182:
  pushl $0
80107f0f:	6a 00                	push   $0x0
  pushl $182
80107f11:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107f16:	e9 5c f3 ff ff       	jmp    80107277 <alltraps>

80107f1b <vector183>:
.globl vector183
vector183:
  pushl $0
80107f1b:	6a 00                	push   $0x0
  pushl $183
80107f1d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107f22:	e9 50 f3 ff ff       	jmp    80107277 <alltraps>

80107f27 <vector184>:
.globl vector184
vector184:
  pushl $0
80107f27:	6a 00                	push   $0x0
  pushl $184
80107f29:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80107f2e:	e9 44 f3 ff ff       	jmp    80107277 <alltraps>

80107f33 <vector185>:
.globl vector185
vector185:
  pushl $0
80107f33:	6a 00                	push   $0x0
  pushl $185
80107f35:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80107f3a:	e9 38 f3 ff ff       	jmp    80107277 <alltraps>

80107f3f <vector186>:
.globl vector186
vector186:
  pushl $0
80107f3f:	6a 00                	push   $0x0
  pushl $186
80107f41:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107f46:	e9 2c f3 ff ff       	jmp    80107277 <alltraps>

80107f4b <vector187>:
.globl vector187
vector187:
  pushl $0
80107f4b:	6a 00                	push   $0x0
  pushl $187
80107f4d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107f52:	e9 20 f3 ff ff       	jmp    80107277 <alltraps>

80107f57 <vector188>:
.globl vector188
vector188:
  pushl $0
80107f57:	6a 00                	push   $0x0
  pushl $188
80107f59:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80107f5e:	e9 14 f3 ff ff       	jmp    80107277 <alltraps>

80107f63 <vector189>:
.globl vector189
vector189:
  pushl $0
80107f63:	6a 00                	push   $0x0
  pushl $189
80107f65:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80107f6a:	e9 08 f3 ff ff       	jmp    80107277 <alltraps>

80107f6f <vector190>:
.globl vector190
vector190:
  pushl $0
80107f6f:	6a 00                	push   $0x0
  pushl $190
80107f71:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107f76:	e9 fc f2 ff ff       	jmp    80107277 <alltraps>

80107f7b <vector191>:
.globl vector191
vector191:
  pushl $0
80107f7b:	6a 00                	push   $0x0
  pushl $191
80107f7d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107f82:	e9 f0 f2 ff ff       	jmp    80107277 <alltraps>

80107f87 <vector192>:
.globl vector192
vector192:
  pushl $0
80107f87:	6a 00                	push   $0x0
  pushl $192
80107f89:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80107f8e:	e9 e4 f2 ff ff       	jmp    80107277 <alltraps>

80107f93 <vector193>:
.globl vector193
vector193:
  pushl $0
80107f93:	6a 00                	push   $0x0
  pushl $193
80107f95:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80107f9a:	e9 d8 f2 ff ff       	jmp    80107277 <alltraps>

80107f9f <vector194>:
.globl vector194
vector194:
  pushl $0
80107f9f:	6a 00                	push   $0x0
  pushl $194
80107fa1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107fa6:	e9 cc f2 ff ff       	jmp    80107277 <alltraps>

80107fab <vector195>:
.globl vector195
vector195:
  pushl $0
80107fab:	6a 00                	push   $0x0
  pushl $195
80107fad:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107fb2:	e9 c0 f2 ff ff       	jmp    80107277 <alltraps>

80107fb7 <vector196>:
.globl vector196
vector196:
  pushl $0
80107fb7:	6a 00                	push   $0x0
  pushl $196
80107fb9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80107fbe:	e9 b4 f2 ff ff       	jmp    80107277 <alltraps>

80107fc3 <vector197>:
.globl vector197
vector197:
  pushl $0
80107fc3:	6a 00                	push   $0x0
  pushl $197
80107fc5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80107fca:	e9 a8 f2 ff ff       	jmp    80107277 <alltraps>

80107fcf <vector198>:
.globl vector198
vector198:
  pushl $0
80107fcf:	6a 00                	push   $0x0
  pushl $198
80107fd1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107fd6:	e9 9c f2 ff ff       	jmp    80107277 <alltraps>

80107fdb <vector199>:
.globl vector199
vector199:
  pushl $0
80107fdb:	6a 00                	push   $0x0
  pushl $199
80107fdd:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107fe2:	e9 90 f2 ff ff       	jmp    80107277 <alltraps>

80107fe7 <vector200>:
.globl vector200
vector200:
  pushl $0
80107fe7:	6a 00                	push   $0x0
  pushl $200
80107fe9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80107fee:	e9 84 f2 ff ff       	jmp    80107277 <alltraps>

80107ff3 <vector201>:
.globl vector201
vector201:
  pushl $0
80107ff3:	6a 00                	push   $0x0
  pushl $201
80107ff5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80107ffa:	e9 78 f2 ff ff       	jmp    80107277 <alltraps>

80107fff <vector202>:
.globl vector202
vector202:
  pushl $0
80107fff:	6a 00                	push   $0x0
  pushl $202
80108001:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80108006:	e9 6c f2 ff ff       	jmp    80107277 <alltraps>

8010800b <vector203>:
.globl vector203
vector203:
  pushl $0
8010800b:	6a 00                	push   $0x0
  pushl $203
8010800d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80108012:	e9 60 f2 ff ff       	jmp    80107277 <alltraps>

80108017 <vector204>:
.globl vector204
vector204:
  pushl $0
80108017:	6a 00                	push   $0x0
  pushl $204
80108019:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010801e:	e9 54 f2 ff ff       	jmp    80107277 <alltraps>

80108023 <vector205>:
.globl vector205
vector205:
  pushl $0
80108023:	6a 00                	push   $0x0
  pushl $205
80108025:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010802a:	e9 48 f2 ff ff       	jmp    80107277 <alltraps>

8010802f <vector206>:
.globl vector206
vector206:
  pushl $0
8010802f:	6a 00                	push   $0x0
  pushl $206
80108031:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80108036:	e9 3c f2 ff ff       	jmp    80107277 <alltraps>

8010803b <vector207>:
.globl vector207
vector207:
  pushl $0
8010803b:	6a 00                	push   $0x0
  pushl $207
8010803d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80108042:	e9 30 f2 ff ff       	jmp    80107277 <alltraps>

80108047 <vector208>:
.globl vector208
vector208:
  pushl $0
80108047:	6a 00                	push   $0x0
  pushl $208
80108049:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010804e:	e9 24 f2 ff ff       	jmp    80107277 <alltraps>

80108053 <vector209>:
.globl vector209
vector209:
  pushl $0
80108053:	6a 00                	push   $0x0
  pushl $209
80108055:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010805a:	e9 18 f2 ff ff       	jmp    80107277 <alltraps>

8010805f <vector210>:
.globl vector210
vector210:
  pushl $0
8010805f:	6a 00                	push   $0x0
  pushl $210
80108061:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80108066:	e9 0c f2 ff ff       	jmp    80107277 <alltraps>

8010806b <vector211>:
.globl vector211
vector211:
  pushl $0
8010806b:	6a 00                	push   $0x0
  pushl $211
8010806d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80108072:	e9 00 f2 ff ff       	jmp    80107277 <alltraps>

80108077 <vector212>:
.globl vector212
vector212:
  pushl $0
80108077:	6a 00                	push   $0x0
  pushl $212
80108079:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010807e:	e9 f4 f1 ff ff       	jmp    80107277 <alltraps>

80108083 <vector213>:
.globl vector213
vector213:
  pushl $0
80108083:	6a 00                	push   $0x0
  pushl $213
80108085:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010808a:	e9 e8 f1 ff ff       	jmp    80107277 <alltraps>

8010808f <vector214>:
.globl vector214
vector214:
  pushl $0
8010808f:	6a 00                	push   $0x0
  pushl $214
80108091:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80108096:	e9 dc f1 ff ff       	jmp    80107277 <alltraps>

8010809b <vector215>:
.globl vector215
vector215:
  pushl $0
8010809b:	6a 00                	push   $0x0
  pushl $215
8010809d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801080a2:	e9 d0 f1 ff ff       	jmp    80107277 <alltraps>

801080a7 <vector216>:
.globl vector216
vector216:
  pushl $0
801080a7:	6a 00                	push   $0x0
  pushl $216
801080a9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801080ae:	e9 c4 f1 ff ff       	jmp    80107277 <alltraps>

801080b3 <vector217>:
.globl vector217
vector217:
  pushl $0
801080b3:	6a 00                	push   $0x0
  pushl $217
801080b5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801080ba:	e9 b8 f1 ff ff       	jmp    80107277 <alltraps>

801080bf <vector218>:
.globl vector218
vector218:
  pushl $0
801080bf:	6a 00                	push   $0x0
  pushl $218
801080c1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801080c6:	e9 ac f1 ff ff       	jmp    80107277 <alltraps>

801080cb <vector219>:
.globl vector219
vector219:
  pushl $0
801080cb:	6a 00                	push   $0x0
  pushl $219
801080cd:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801080d2:	e9 a0 f1 ff ff       	jmp    80107277 <alltraps>

801080d7 <vector220>:
.globl vector220
vector220:
  pushl $0
801080d7:	6a 00                	push   $0x0
  pushl $220
801080d9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801080de:	e9 94 f1 ff ff       	jmp    80107277 <alltraps>

801080e3 <vector221>:
.globl vector221
vector221:
  pushl $0
801080e3:	6a 00                	push   $0x0
  pushl $221
801080e5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801080ea:	e9 88 f1 ff ff       	jmp    80107277 <alltraps>

801080ef <vector222>:
.globl vector222
vector222:
  pushl $0
801080ef:	6a 00                	push   $0x0
  pushl $222
801080f1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801080f6:	e9 7c f1 ff ff       	jmp    80107277 <alltraps>

801080fb <vector223>:
.globl vector223
vector223:
  pushl $0
801080fb:	6a 00                	push   $0x0
  pushl $223
801080fd:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80108102:	e9 70 f1 ff ff       	jmp    80107277 <alltraps>

80108107 <vector224>:
.globl vector224
vector224:
  pushl $0
80108107:	6a 00                	push   $0x0
  pushl $224
80108109:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010810e:	e9 64 f1 ff ff       	jmp    80107277 <alltraps>

80108113 <vector225>:
.globl vector225
vector225:
  pushl $0
80108113:	6a 00                	push   $0x0
  pushl $225
80108115:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010811a:	e9 58 f1 ff ff       	jmp    80107277 <alltraps>

8010811f <vector226>:
.globl vector226
vector226:
  pushl $0
8010811f:	6a 00                	push   $0x0
  pushl $226
80108121:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80108126:	e9 4c f1 ff ff       	jmp    80107277 <alltraps>

8010812b <vector227>:
.globl vector227
vector227:
  pushl $0
8010812b:	6a 00                	push   $0x0
  pushl $227
8010812d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80108132:	e9 40 f1 ff ff       	jmp    80107277 <alltraps>

80108137 <vector228>:
.globl vector228
vector228:
  pushl $0
80108137:	6a 00                	push   $0x0
  pushl $228
80108139:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010813e:	e9 34 f1 ff ff       	jmp    80107277 <alltraps>

80108143 <vector229>:
.globl vector229
vector229:
  pushl $0
80108143:	6a 00                	push   $0x0
  pushl $229
80108145:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010814a:	e9 28 f1 ff ff       	jmp    80107277 <alltraps>

8010814f <vector230>:
.globl vector230
vector230:
  pushl $0
8010814f:	6a 00                	push   $0x0
  pushl $230
80108151:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80108156:	e9 1c f1 ff ff       	jmp    80107277 <alltraps>

8010815b <vector231>:
.globl vector231
vector231:
  pushl $0
8010815b:	6a 00                	push   $0x0
  pushl $231
8010815d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80108162:	e9 10 f1 ff ff       	jmp    80107277 <alltraps>

80108167 <vector232>:
.globl vector232
vector232:
  pushl $0
80108167:	6a 00                	push   $0x0
  pushl $232
80108169:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010816e:	e9 04 f1 ff ff       	jmp    80107277 <alltraps>

80108173 <vector233>:
.globl vector233
vector233:
  pushl $0
80108173:	6a 00                	push   $0x0
  pushl $233
80108175:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010817a:	e9 f8 f0 ff ff       	jmp    80107277 <alltraps>

8010817f <vector234>:
.globl vector234
vector234:
  pushl $0
8010817f:	6a 00                	push   $0x0
  pushl $234
80108181:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80108186:	e9 ec f0 ff ff       	jmp    80107277 <alltraps>

8010818b <vector235>:
.globl vector235
vector235:
  pushl $0
8010818b:	6a 00                	push   $0x0
  pushl $235
8010818d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80108192:	e9 e0 f0 ff ff       	jmp    80107277 <alltraps>

80108197 <vector236>:
.globl vector236
vector236:
  pushl $0
80108197:	6a 00                	push   $0x0
  pushl $236
80108199:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010819e:	e9 d4 f0 ff ff       	jmp    80107277 <alltraps>

801081a3 <vector237>:
.globl vector237
vector237:
  pushl $0
801081a3:	6a 00                	push   $0x0
  pushl $237
801081a5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801081aa:	e9 c8 f0 ff ff       	jmp    80107277 <alltraps>

801081af <vector238>:
.globl vector238
vector238:
  pushl $0
801081af:	6a 00                	push   $0x0
  pushl $238
801081b1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801081b6:	e9 bc f0 ff ff       	jmp    80107277 <alltraps>

801081bb <vector239>:
.globl vector239
vector239:
  pushl $0
801081bb:	6a 00                	push   $0x0
  pushl $239
801081bd:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801081c2:	e9 b0 f0 ff ff       	jmp    80107277 <alltraps>

801081c7 <vector240>:
.globl vector240
vector240:
  pushl $0
801081c7:	6a 00                	push   $0x0
  pushl $240
801081c9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801081ce:	e9 a4 f0 ff ff       	jmp    80107277 <alltraps>

801081d3 <vector241>:
.globl vector241
vector241:
  pushl $0
801081d3:	6a 00                	push   $0x0
  pushl $241
801081d5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801081da:	e9 98 f0 ff ff       	jmp    80107277 <alltraps>

801081df <vector242>:
.globl vector242
vector242:
  pushl $0
801081df:	6a 00                	push   $0x0
  pushl $242
801081e1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801081e6:	e9 8c f0 ff ff       	jmp    80107277 <alltraps>

801081eb <vector243>:
.globl vector243
vector243:
  pushl $0
801081eb:	6a 00                	push   $0x0
  pushl $243
801081ed:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801081f2:	e9 80 f0 ff ff       	jmp    80107277 <alltraps>

801081f7 <vector244>:
.globl vector244
vector244:
  pushl $0
801081f7:	6a 00                	push   $0x0
  pushl $244
801081f9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801081fe:	e9 74 f0 ff ff       	jmp    80107277 <alltraps>

80108203 <vector245>:
.globl vector245
vector245:
  pushl $0
80108203:	6a 00                	push   $0x0
  pushl $245
80108205:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010820a:	e9 68 f0 ff ff       	jmp    80107277 <alltraps>

8010820f <vector246>:
.globl vector246
vector246:
  pushl $0
8010820f:	6a 00                	push   $0x0
  pushl $246
80108211:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80108216:	e9 5c f0 ff ff       	jmp    80107277 <alltraps>

8010821b <vector247>:
.globl vector247
vector247:
  pushl $0
8010821b:	6a 00                	push   $0x0
  pushl $247
8010821d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80108222:	e9 50 f0 ff ff       	jmp    80107277 <alltraps>

80108227 <vector248>:
.globl vector248
vector248:
  pushl $0
80108227:	6a 00                	push   $0x0
  pushl $248
80108229:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010822e:	e9 44 f0 ff ff       	jmp    80107277 <alltraps>

80108233 <vector249>:
.globl vector249
vector249:
  pushl $0
80108233:	6a 00                	push   $0x0
  pushl $249
80108235:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010823a:	e9 38 f0 ff ff       	jmp    80107277 <alltraps>

8010823f <vector250>:
.globl vector250
vector250:
  pushl $0
8010823f:	6a 00                	push   $0x0
  pushl $250
80108241:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80108246:	e9 2c f0 ff ff       	jmp    80107277 <alltraps>

8010824b <vector251>:
.globl vector251
vector251:
  pushl $0
8010824b:	6a 00                	push   $0x0
  pushl $251
8010824d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80108252:	e9 20 f0 ff ff       	jmp    80107277 <alltraps>

80108257 <vector252>:
.globl vector252
vector252:
  pushl $0
80108257:	6a 00                	push   $0x0
  pushl $252
80108259:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010825e:	e9 14 f0 ff ff       	jmp    80107277 <alltraps>

80108263 <vector253>:
.globl vector253
vector253:
  pushl $0
80108263:	6a 00                	push   $0x0
  pushl $253
80108265:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010826a:	e9 08 f0 ff ff       	jmp    80107277 <alltraps>

8010826f <vector254>:
.globl vector254
vector254:
  pushl $0
8010826f:	6a 00                	push   $0x0
  pushl $254
80108271:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80108276:	e9 fc ef ff ff       	jmp    80107277 <alltraps>

8010827b <vector255>:
.globl vector255
vector255:
  pushl $0
8010827b:	6a 00                	push   $0x0
  pushl $255
8010827d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80108282:	e9 f0 ef ff ff       	jmp    80107277 <alltraps>
80108287:	66 90                	xchg   %ax,%ax
80108289:	66 90                	xchg   %ax,%ax
8010828b:	66 90                	xchg   %ax,%ax
8010828d:	66 90                	xchg   %ax,%ax
8010828f:	90                   	nop

80108290 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80108290:	55                   	push   %ebp
80108291:	89 e5                	mov    %esp,%ebp
80108293:	57                   	push   %edi
80108294:	56                   	push   %esi
80108295:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80108296:	89 d3                	mov    %edx,%ebx
{
80108298:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
8010829a:	c1 eb 16             	shr    $0x16,%ebx
8010829d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
801082a0:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
801082a3:	8b 06                	mov    (%esi),%eax
801082a5:	a8 01                	test   $0x1,%al
801082a7:	74 27                	je     801082d0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801082a9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801082ae:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801082b4:	c1 ef 0a             	shr    $0xa,%edi
}
801082b7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
801082ba:	89 fa                	mov    %edi,%edx
801082bc:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801082c2:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
801082c5:	5b                   	pop    %ebx
801082c6:	5e                   	pop    %esi
801082c7:	5f                   	pop    %edi
801082c8:	5d                   	pop    %ebp
801082c9:	c3                   	ret    
801082ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801082d0:	85 c9                	test   %ecx,%ecx
801082d2:	74 2c                	je     80108300 <walkpgdir+0x70>
801082d4:	e8 77 a7 ff ff       	call   80102a50 <kalloc>
801082d9:	85 c0                	test   %eax,%eax
801082db:	89 c3                	mov    %eax,%ebx
801082dd:	74 21                	je     80108300 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
801082df:	83 ec 04             	sub    $0x4,%esp
801082e2:	68 00 10 00 00       	push   $0x1000
801082e7:	6a 00                	push   $0x0
801082e9:	50                   	push   %eax
801082ea:	e8 11 db ff ff       	call   80105e00 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801082ef:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801082f5:	83 c4 10             	add    $0x10,%esp
801082f8:	83 c8 07             	or     $0x7,%eax
801082fb:	89 06                	mov    %eax,(%esi)
801082fd:	eb b5                	jmp    801082b4 <walkpgdir+0x24>
801082ff:	90                   	nop
}
80108300:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80108303:	31 c0                	xor    %eax,%eax
}
80108305:	5b                   	pop    %ebx
80108306:	5e                   	pop    %esi
80108307:	5f                   	pop    %edi
80108308:	5d                   	pop    %ebp
80108309:	c3                   	ret    
8010830a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108310 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80108310:	55                   	push   %ebp
80108311:	89 e5                	mov    %esp,%ebp
80108313:	57                   	push   %edi
80108314:	56                   	push   %esi
80108315:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80108316:	89 d3                	mov    %edx,%ebx
80108318:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010831e:	83 ec 1c             	sub    $0x1c,%esp
80108321:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80108324:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80108328:	8b 7d 08             	mov    0x8(%ebp),%edi
8010832b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108330:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80108333:	8b 45 0c             	mov    0xc(%ebp),%eax
80108336:	29 df                	sub    %ebx,%edi
80108338:	83 c8 01             	or     $0x1,%eax
8010833b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010833e:	eb 15                	jmp    80108355 <mappages+0x45>
    if(*pte & PTE_P)
80108340:	f6 00 01             	testb  $0x1,(%eax)
80108343:	75 45                	jne    8010838a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80108345:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80108348:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
8010834b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010834d:	74 31                	je     80108380 <mappages+0x70>
      break;
    a += PGSIZE;
8010834f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80108355:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108358:	b9 01 00 00 00       	mov    $0x1,%ecx
8010835d:	89 da                	mov    %ebx,%edx
8010835f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80108362:	e8 29 ff ff ff       	call   80108290 <walkpgdir>
80108367:	85 c0                	test   %eax,%eax
80108369:	75 d5                	jne    80108340 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010836b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010836e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80108373:	5b                   	pop    %ebx
80108374:	5e                   	pop    %esi
80108375:	5f                   	pop    %edi
80108376:	5d                   	pop    %ebp
80108377:	c3                   	ret    
80108378:	90                   	nop
80108379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108380:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80108383:	31 c0                	xor    %eax,%eax
}
80108385:	5b                   	pop    %ebx
80108386:	5e                   	pop    %esi
80108387:	5f                   	pop    %edi
80108388:	5d                   	pop    %ebp
80108389:	c3                   	ret    
      panic("remap");
8010838a:	83 ec 0c             	sub    $0xc,%esp
8010838d:	68 8c 95 10 80       	push   $0x8010958c
80108392:	e8 f9 7f ff ff       	call   80100390 <panic>
80108397:	89 f6                	mov    %esi,%esi
80108399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801083a0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801083a0:	55                   	push   %ebp
801083a1:	89 e5                	mov    %esp,%ebp
801083a3:	57                   	push   %edi
801083a4:	56                   	push   %esi
801083a5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801083a6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801083ac:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
801083ae:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801083b4:	83 ec 1c             	sub    $0x1c,%esp
801083b7:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801083ba:	39 d3                	cmp    %edx,%ebx
801083bc:	73 66                	jae    80108424 <deallocuvm.part.0+0x84>
801083be:	89 d6                	mov    %edx,%esi
801083c0:	eb 3d                	jmp    801083ff <deallocuvm.part.0+0x5f>
801083c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
801083c8:	8b 10                	mov    (%eax),%edx
801083ca:	f6 c2 01             	test   $0x1,%dl
801083cd:	74 26                	je     801083f5 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801083cf:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801083d5:	74 58                	je     8010842f <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
801083d7:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
801083da:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801083e0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
801083e3:	52                   	push   %edx
801083e4:	e8 b7 a4 ff ff       	call   801028a0 <kfree>
      *pte = 0;
801083e9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801083ec:	83 c4 10             	add    $0x10,%esp
801083ef:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
801083f5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801083fb:	39 f3                	cmp    %esi,%ebx
801083fd:	73 25                	jae    80108424 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
801083ff:	31 c9                	xor    %ecx,%ecx
80108401:	89 da                	mov    %ebx,%edx
80108403:	89 f8                	mov    %edi,%eax
80108405:	e8 86 fe ff ff       	call   80108290 <walkpgdir>
    if(!pte)
8010840a:	85 c0                	test   %eax,%eax
8010840c:	75 ba                	jne    801083c8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010840e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80108414:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
8010841a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80108420:	39 f3                	cmp    %esi,%ebx
80108422:	72 db                	jb     801083ff <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
80108424:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108427:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010842a:	5b                   	pop    %ebx
8010842b:	5e                   	pop    %esi
8010842c:	5f                   	pop    %edi
8010842d:	5d                   	pop    %ebp
8010842e:	c3                   	ret    
        panic("kfree");
8010842f:	83 ec 0c             	sub    $0xc,%esp
80108432:	68 26 8e 10 80       	push   $0x80108e26
80108437:	e8 54 7f ff ff       	call   80100390 <panic>
8010843c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80108440 <seginit>:
{
80108440:	55                   	push   %ebp
80108441:	89 e5                	mov    %esp,%ebp
80108443:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80108446:	e8 b5 bd ff ff       	call   80104200 <cpuid>
8010844b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80108451:	ba 2f 00 00 00       	mov    $0x2f,%edx
80108456:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010845a:	c7 80 18 48 11 80 ff 	movl   $0xffff,-0x7feeb7e8(%eax)
80108461:	ff 00 00 
80108464:	c7 80 1c 48 11 80 00 	movl   $0xcf9a00,-0x7feeb7e4(%eax)
8010846b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010846e:	c7 80 20 48 11 80 ff 	movl   $0xffff,-0x7feeb7e0(%eax)
80108475:	ff 00 00 
80108478:	c7 80 24 48 11 80 00 	movl   $0xcf9200,-0x7feeb7dc(%eax)
8010847f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80108482:	c7 80 28 48 11 80 ff 	movl   $0xffff,-0x7feeb7d8(%eax)
80108489:	ff 00 00 
8010848c:	c7 80 2c 48 11 80 00 	movl   $0xcffa00,-0x7feeb7d4(%eax)
80108493:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80108496:	c7 80 30 48 11 80 ff 	movl   $0xffff,-0x7feeb7d0(%eax)
8010849d:	ff 00 00 
801084a0:	c7 80 34 48 11 80 00 	movl   $0xcff200,-0x7feeb7cc(%eax)
801084a7:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
801084aa:	05 10 48 11 80       	add    $0x80114810,%eax
  pd[1] = (uint)p;
801084af:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801084b3:	c1 e8 10             	shr    $0x10,%eax
801084b6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801084ba:	8d 45 f2             	lea    -0xe(%ebp),%eax
801084bd:	0f 01 10             	lgdtl  (%eax)
}
801084c0:	c9                   	leave  
801084c1:	c3                   	ret    
801084c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801084c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801084d0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801084d0:	a1 04 c3 11 80       	mov    0x8011c304,%eax
{
801084d5:	55                   	push   %ebp
801084d6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801084d8:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801084dd:	0f 22 d8             	mov    %eax,%cr3
}
801084e0:	5d                   	pop    %ebp
801084e1:	c3                   	ret    
801084e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801084e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801084f0 <switchuvm>:
{
801084f0:	55                   	push   %ebp
801084f1:	89 e5                	mov    %esp,%ebp
801084f3:	57                   	push   %edi
801084f4:	56                   	push   %esi
801084f5:	53                   	push   %ebx
801084f6:	83 ec 1c             	sub    $0x1c,%esp
801084f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
801084fc:	85 db                	test   %ebx,%ebx
801084fe:	0f 84 cb 00 00 00    	je     801085cf <switchuvm+0xdf>
  if(p->kstack == 0)
80108504:	8b 43 08             	mov    0x8(%ebx),%eax
80108507:	85 c0                	test   %eax,%eax
80108509:	0f 84 da 00 00 00    	je     801085e9 <switchuvm+0xf9>
  if(p->pgdir == 0)
8010850f:	8b 43 04             	mov    0x4(%ebx),%eax
80108512:	85 c0                	test   %eax,%eax
80108514:	0f 84 c2 00 00 00    	je     801085dc <switchuvm+0xec>
  pushcli();
8010851a:	e8 01 d7 ff ff       	call   80105c20 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010851f:	e8 5c bc ff ff       	call   80104180 <mycpu>
80108524:	89 c6                	mov    %eax,%esi
80108526:	e8 55 bc ff ff       	call   80104180 <mycpu>
8010852b:	89 c7                	mov    %eax,%edi
8010852d:	e8 4e bc ff ff       	call   80104180 <mycpu>
80108532:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108535:	83 c7 08             	add    $0x8,%edi
80108538:	e8 43 bc ff ff       	call   80104180 <mycpu>
8010853d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80108540:	83 c0 08             	add    $0x8,%eax
80108543:	ba 67 00 00 00       	mov    $0x67,%edx
80108548:	c1 e8 18             	shr    $0x18,%eax
8010854b:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80108552:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80108559:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010855f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80108564:	83 c1 08             	add    $0x8,%ecx
80108567:	c1 e9 10             	shr    $0x10,%ecx
8010856a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80108570:	b9 99 40 00 00       	mov    $0x4099,%ecx
80108575:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010857c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80108581:	e8 fa bb ff ff       	call   80104180 <mycpu>
80108586:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010858d:	e8 ee bb ff ff       	call   80104180 <mycpu>
80108592:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80108596:	8b 73 08             	mov    0x8(%ebx),%esi
80108599:	e8 e2 bb ff ff       	call   80104180 <mycpu>
8010859e:	81 c6 00 10 00 00    	add    $0x1000,%esi
801085a4:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801085a7:	e8 d4 bb ff ff       	call   80104180 <mycpu>
801085ac:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801085b0:	b8 28 00 00 00       	mov    $0x28,%eax
801085b5:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
801085b8:	8b 43 04             	mov    0x4(%ebx),%eax
801085bb:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801085c0:	0f 22 d8             	mov    %eax,%cr3
}
801085c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801085c6:	5b                   	pop    %ebx
801085c7:	5e                   	pop    %esi
801085c8:	5f                   	pop    %edi
801085c9:	5d                   	pop    %ebp
  popcli();
801085ca:	e9 91 d6 ff ff       	jmp    80105c60 <popcli>
    panic("switchuvm: no process");
801085cf:	83 ec 0c             	sub    $0xc,%esp
801085d2:	68 92 95 10 80       	push   $0x80109592
801085d7:	e8 b4 7d ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
801085dc:	83 ec 0c             	sub    $0xc,%esp
801085df:	68 bd 95 10 80       	push   $0x801095bd
801085e4:	e8 a7 7d ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
801085e9:	83 ec 0c             	sub    $0xc,%esp
801085ec:	68 a8 95 10 80       	push   $0x801095a8
801085f1:	e8 9a 7d ff ff       	call   80100390 <panic>
801085f6:	8d 76 00             	lea    0x0(%esi),%esi
801085f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108600 <inituvm>:
{
80108600:	55                   	push   %ebp
80108601:	89 e5                	mov    %esp,%ebp
80108603:	57                   	push   %edi
80108604:	56                   	push   %esi
80108605:	53                   	push   %ebx
80108606:	83 ec 1c             	sub    $0x1c,%esp
80108609:	8b 75 10             	mov    0x10(%ebp),%esi
8010860c:	8b 45 08             	mov    0x8(%ebp),%eax
8010860f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80108612:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80108618:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
8010861b:	77 49                	ja     80108666 <inituvm+0x66>
  mem = kalloc();
8010861d:	e8 2e a4 ff ff       	call   80102a50 <kalloc>
  memset(mem, 0, PGSIZE);
80108622:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80108625:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80108627:	68 00 10 00 00       	push   $0x1000
8010862c:	6a 00                	push   $0x0
8010862e:	50                   	push   %eax
8010862f:	e8 cc d7 ff ff       	call   80105e00 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80108634:	58                   	pop    %eax
80108635:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010863b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80108640:	5a                   	pop    %edx
80108641:	6a 06                	push   $0x6
80108643:	50                   	push   %eax
80108644:	31 d2                	xor    %edx,%edx
80108646:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108649:	e8 c2 fc ff ff       	call   80108310 <mappages>
  memmove(mem, init, sz);
8010864e:	89 75 10             	mov    %esi,0x10(%ebp)
80108651:	89 7d 0c             	mov    %edi,0xc(%ebp)
80108654:	83 c4 10             	add    $0x10,%esp
80108657:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010865a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010865d:	5b                   	pop    %ebx
8010865e:	5e                   	pop    %esi
8010865f:	5f                   	pop    %edi
80108660:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80108661:	e9 4a d8 ff ff       	jmp    80105eb0 <memmove>
    panic("inituvm: more than a page");
80108666:	83 ec 0c             	sub    $0xc,%esp
80108669:	68 d1 95 10 80       	push   $0x801095d1
8010866e:	e8 1d 7d ff ff       	call   80100390 <panic>
80108673:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80108679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108680 <loaduvm>:
{
80108680:	55                   	push   %ebp
80108681:	89 e5                	mov    %esp,%ebp
80108683:	57                   	push   %edi
80108684:	56                   	push   %esi
80108685:	53                   	push   %ebx
80108686:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80108689:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80108690:	0f 85 91 00 00 00    	jne    80108727 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80108696:	8b 75 18             	mov    0x18(%ebp),%esi
80108699:	31 db                	xor    %ebx,%ebx
8010869b:	85 f6                	test   %esi,%esi
8010869d:	75 1a                	jne    801086b9 <loaduvm+0x39>
8010869f:	eb 6f                	jmp    80108710 <loaduvm+0x90>
801086a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801086a8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801086ae:	81 ee 00 10 00 00    	sub    $0x1000,%esi
801086b4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
801086b7:	76 57                	jbe    80108710 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801086b9:	8b 55 0c             	mov    0xc(%ebp),%edx
801086bc:	8b 45 08             	mov    0x8(%ebp),%eax
801086bf:	31 c9                	xor    %ecx,%ecx
801086c1:	01 da                	add    %ebx,%edx
801086c3:	e8 c8 fb ff ff       	call   80108290 <walkpgdir>
801086c8:	85 c0                	test   %eax,%eax
801086ca:	74 4e                	je     8010871a <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
801086cc:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
801086ce:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
801086d1:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
801086d6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801086db:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801086e1:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801086e4:	01 d9                	add    %ebx,%ecx
801086e6:	05 00 00 00 80       	add    $0x80000000,%eax
801086eb:	57                   	push   %edi
801086ec:	51                   	push   %ecx
801086ed:	50                   	push   %eax
801086ee:	ff 75 10             	pushl  0x10(%ebp)
801086f1:	e8 fa 97 ff ff       	call   80101ef0 <readi>
801086f6:	83 c4 10             	add    $0x10,%esp
801086f9:	39 f8                	cmp    %edi,%eax
801086fb:	74 ab                	je     801086a8 <loaduvm+0x28>
}
801086fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80108700:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80108705:	5b                   	pop    %ebx
80108706:	5e                   	pop    %esi
80108707:	5f                   	pop    %edi
80108708:	5d                   	pop    %ebp
80108709:	c3                   	ret    
8010870a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80108710:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80108713:	31 c0                	xor    %eax,%eax
}
80108715:	5b                   	pop    %ebx
80108716:	5e                   	pop    %esi
80108717:	5f                   	pop    %edi
80108718:	5d                   	pop    %ebp
80108719:	c3                   	ret    
      panic("loaduvm: address should exist");
8010871a:	83 ec 0c             	sub    $0xc,%esp
8010871d:	68 eb 95 10 80       	push   $0x801095eb
80108722:	e8 69 7c ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80108727:	83 ec 0c             	sub    $0xc,%esp
8010872a:	68 8c 96 10 80       	push   $0x8010968c
8010872f:	e8 5c 7c ff ff       	call   80100390 <panic>
80108734:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010873a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80108740 <allocuvm>:
{
80108740:	55                   	push   %ebp
80108741:	89 e5                	mov    %esp,%ebp
80108743:	57                   	push   %edi
80108744:	56                   	push   %esi
80108745:	53                   	push   %ebx
80108746:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80108749:	8b 7d 10             	mov    0x10(%ebp),%edi
8010874c:	85 ff                	test   %edi,%edi
8010874e:	0f 88 8e 00 00 00    	js     801087e2 <allocuvm+0xa2>
  if(newsz < oldsz)
80108754:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80108757:	0f 82 93 00 00 00    	jb     801087f0 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
8010875d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108760:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80108766:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010876c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010876f:	0f 86 7e 00 00 00    	jbe    801087f3 <allocuvm+0xb3>
80108775:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80108778:	8b 7d 08             	mov    0x8(%ebp),%edi
8010877b:	eb 42                	jmp    801087bf <allocuvm+0x7f>
8010877d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80108780:	83 ec 04             	sub    $0x4,%esp
80108783:	68 00 10 00 00       	push   $0x1000
80108788:	6a 00                	push   $0x0
8010878a:	50                   	push   %eax
8010878b:	e8 70 d6 ff ff       	call   80105e00 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80108790:	58                   	pop    %eax
80108791:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80108797:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010879c:	5a                   	pop    %edx
8010879d:	6a 06                	push   $0x6
8010879f:	50                   	push   %eax
801087a0:	89 da                	mov    %ebx,%edx
801087a2:	89 f8                	mov    %edi,%eax
801087a4:	e8 67 fb ff ff       	call   80108310 <mappages>
801087a9:	83 c4 10             	add    $0x10,%esp
801087ac:	85 c0                	test   %eax,%eax
801087ae:	78 50                	js     80108800 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
801087b0:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801087b6:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801087b9:	0f 86 81 00 00 00    	jbe    80108840 <allocuvm+0x100>
    mem = kalloc();
801087bf:	e8 8c a2 ff ff       	call   80102a50 <kalloc>
    if(mem == 0){
801087c4:	85 c0                	test   %eax,%eax
    mem = kalloc();
801087c6:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801087c8:	75 b6                	jne    80108780 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
801087ca:	83 ec 0c             	sub    $0xc,%esp
801087cd:	68 09 96 10 80       	push   $0x80109609
801087d2:	e8 89 7e ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
801087d7:	83 c4 10             	add    $0x10,%esp
801087da:	8b 45 0c             	mov    0xc(%ebp),%eax
801087dd:	39 45 10             	cmp    %eax,0x10(%ebp)
801087e0:	77 6e                	ja     80108850 <allocuvm+0x110>
}
801087e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801087e5:	31 ff                	xor    %edi,%edi
}
801087e7:	89 f8                	mov    %edi,%eax
801087e9:	5b                   	pop    %ebx
801087ea:	5e                   	pop    %esi
801087eb:	5f                   	pop    %edi
801087ec:	5d                   	pop    %ebp
801087ed:	c3                   	ret    
801087ee:	66 90                	xchg   %ax,%ax
    return oldsz;
801087f0:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
801087f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801087f6:	89 f8                	mov    %edi,%eax
801087f8:	5b                   	pop    %ebx
801087f9:	5e                   	pop    %esi
801087fa:	5f                   	pop    %edi
801087fb:	5d                   	pop    %ebp
801087fc:	c3                   	ret    
801087fd:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80108800:	83 ec 0c             	sub    $0xc,%esp
80108803:	68 21 96 10 80       	push   $0x80109621
80108808:	e8 53 7e ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
8010880d:	83 c4 10             	add    $0x10,%esp
80108810:	8b 45 0c             	mov    0xc(%ebp),%eax
80108813:	39 45 10             	cmp    %eax,0x10(%ebp)
80108816:	76 0d                	jbe    80108825 <allocuvm+0xe5>
80108818:	89 c1                	mov    %eax,%ecx
8010881a:	8b 55 10             	mov    0x10(%ebp),%edx
8010881d:	8b 45 08             	mov    0x8(%ebp),%eax
80108820:	e8 7b fb ff ff       	call   801083a0 <deallocuvm.part.0>
      kfree(mem);
80108825:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80108828:	31 ff                	xor    %edi,%edi
      kfree(mem);
8010882a:	56                   	push   %esi
8010882b:	e8 70 a0 ff ff       	call   801028a0 <kfree>
      return 0;
80108830:	83 c4 10             	add    $0x10,%esp
}
80108833:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108836:	89 f8                	mov    %edi,%eax
80108838:	5b                   	pop    %ebx
80108839:	5e                   	pop    %esi
8010883a:	5f                   	pop    %edi
8010883b:	5d                   	pop    %ebp
8010883c:	c3                   	ret    
8010883d:	8d 76 00             	lea    0x0(%esi),%esi
80108840:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80108843:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108846:	5b                   	pop    %ebx
80108847:	89 f8                	mov    %edi,%eax
80108849:	5e                   	pop    %esi
8010884a:	5f                   	pop    %edi
8010884b:	5d                   	pop    %ebp
8010884c:	c3                   	ret    
8010884d:	8d 76 00             	lea    0x0(%esi),%esi
80108850:	89 c1                	mov    %eax,%ecx
80108852:	8b 55 10             	mov    0x10(%ebp),%edx
80108855:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80108858:	31 ff                	xor    %edi,%edi
8010885a:	e8 41 fb ff ff       	call   801083a0 <deallocuvm.part.0>
8010885f:	eb 92                	jmp    801087f3 <allocuvm+0xb3>
80108861:	eb 0d                	jmp    80108870 <deallocuvm>
80108863:	90                   	nop
80108864:	90                   	nop
80108865:	90                   	nop
80108866:	90                   	nop
80108867:	90                   	nop
80108868:	90                   	nop
80108869:	90                   	nop
8010886a:	90                   	nop
8010886b:	90                   	nop
8010886c:	90                   	nop
8010886d:	90                   	nop
8010886e:	90                   	nop
8010886f:	90                   	nop

80108870 <deallocuvm>:
{
80108870:	55                   	push   %ebp
80108871:	89 e5                	mov    %esp,%ebp
80108873:	8b 55 0c             	mov    0xc(%ebp),%edx
80108876:	8b 4d 10             	mov    0x10(%ebp),%ecx
80108879:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010887c:	39 d1                	cmp    %edx,%ecx
8010887e:	73 10                	jae    80108890 <deallocuvm+0x20>
}
80108880:	5d                   	pop    %ebp
80108881:	e9 1a fb ff ff       	jmp    801083a0 <deallocuvm.part.0>
80108886:	8d 76 00             	lea    0x0(%esi),%esi
80108889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80108890:	89 d0                	mov    %edx,%eax
80108892:	5d                   	pop    %ebp
80108893:	c3                   	ret    
80108894:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010889a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801088a0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801088a0:	55                   	push   %ebp
801088a1:	89 e5                	mov    %esp,%ebp
801088a3:	57                   	push   %edi
801088a4:	56                   	push   %esi
801088a5:	53                   	push   %ebx
801088a6:	83 ec 0c             	sub    $0xc,%esp
801088a9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801088ac:	85 f6                	test   %esi,%esi
801088ae:	74 59                	je     80108909 <freevm+0x69>
801088b0:	31 c9                	xor    %ecx,%ecx
801088b2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801088b7:	89 f0                	mov    %esi,%eax
801088b9:	e8 e2 fa ff ff       	call   801083a0 <deallocuvm.part.0>
801088be:	89 f3                	mov    %esi,%ebx
801088c0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801088c6:	eb 0f                	jmp    801088d7 <freevm+0x37>
801088c8:	90                   	nop
801088c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801088d0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801088d3:	39 fb                	cmp    %edi,%ebx
801088d5:	74 23                	je     801088fa <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801088d7:	8b 03                	mov    (%ebx),%eax
801088d9:	a8 01                	test   $0x1,%al
801088db:	74 f3                	je     801088d0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801088dd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
801088e2:	83 ec 0c             	sub    $0xc,%esp
801088e5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
801088e8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801088ed:	50                   	push   %eax
801088ee:	e8 ad 9f ff ff       	call   801028a0 <kfree>
801088f3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801088f6:	39 fb                	cmp    %edi,%ebx
801088f8:	75 dd                	jne    801088d7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
801088fa:	89 75 08             	mov    %esi,0x8(%ebp)
}
801088fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108900:	5b                   	pop    %ebx
80108901:	5e                   	pop    %esi
80108902:	5f                   	pop    %edi
80108903:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80108904:	e9 97 9f ff ff       	jmp    801028a0 <kfree>
    panic("freevm: no pgdir");
80108909:	83 ec 0c             	sub    $0xc,%esp
8010890c:	68 3d 96 10 80       	push   $0x8010963d
80108911:	e8 7a 7a ff ff       	call   80100390 <panic>
80108916:	8d 76 00             	lea    0x0(%esi),%esi
80108919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108920 <setupkvm>:
{
80108920:	55                   	push   %ebp
80108921:	89 e5                	mov    %esp,%ebp
80108923:	56                   	push   %esi
80108924:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80108925:	e8 26 a1 ff ff       	call   80102a50 <kalloc>
8010892a:	85 c0                	test   %eax,%eax
8010892c:	89 c6                	mov    %eax,%esi
8010892e:	74 42                	je     80108972 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80108930:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108933:	bb 20 c4 10 80       	mov    $0x8010c420,%ebx
  memset(pgdir, 0, PGSIZE);
80108938:	68 00 10 00 00       	push   $0x1000
8010893d:	6a 00                	push   $0x0
8010893f:	50                   	push   %eax
80108940:	e8 bb d4 ff ff       	call   80105e00 <memset>
80108945:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80108948:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010894b:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010894e:	83 ec 08             	sub    $0x8,%esp
80108951:	8b 13                	mov    (%ebx),%edx
80108953:	ff 73 0c             	pushl  0xc(%ebx)
80108956:	50                   	push   %eax
80108957:	29 c1                	sub    %eax,%ecx
80108959:	89 f0                	mov    %esi,%eax
8010895b:	e8 b0 f9 ff ff       	call   80108310 <mappages>
80108960:	83 c4 10             	add    $0x10,%esp
80108963:	85 c0                	test   %eax,%eax
80108965:	78 19                	js     80108980 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108967:	83 c3 10             	add    $0x10,%ebx
8010896a:	81 fb 60 c4 10 80    	cmp    $0x8010c460,%ebx
80108970:	75 d6                	jne    80108948 <setupkvm+0x28>
}
80108972:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108975:	89 f0                	mov    %esi,%eax
80108977:	5b                   	pop    %ebx
80108978:	5e                   	pop    %esi
80108979:	5d                   	pop    %ebp
8010897a:	c3                   	ret    
8010897b:	90                   	nop
8010897c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80108980:	83 ec 0c             	sub    $0xc,%esp
80108983:	56                   	push   %esi
      return 0;
80108984:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80108986:	e8 15 ff ff ff       	call   801088a0 <freevm>
      return 0;
8010898b:	83 c4 10             	add    $0x10,%esp
}
8010898e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108991:	89 f0                	mov    %esi,%eax
80108993:	5b                   	pop    %ebx
80108994:	5e                   	pop    %esi
80108995:	5d                   	pop    %ebp
80108996:	c3                   	ret    
80108997:	89 f6                	mov    %esi,%esi
80108999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801089a0 <kvmalloc>:
{
801089a0:	55                   	push   %ebp
801089a1:	89 e5                	mov    %esp,%ebp
801089a3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801089a6:	e8 75 ff ff ff       	call   80108920 <setupkvm>
801089ab:	a3 04 c3 11 80       	mov    %eax,0x8011c304
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801089b0:	05 00 00 00 80       	add    $0x80000000,%eax
801089b5:	0f 22 d8             	mov    %eax,%cr3
}
801089b8:	c9                   	leave  
801089b9:	c3                   	ret    
801089ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801089c0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801089c0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801089c1:	31 c9                	xor    %ecx,%ecx
{
801089c3:	89 e5                	mov    %esp,%ebp
801089c5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
801089c8:	8b 55 0c             	mov    0xc(%ebp),%edx
801089cb:	8b 45 08             	mov    0x8(%ebp),%eax
801089ce:	e8 bd f8 ff ff       	call   80108290 <walkpgdir>
  if(pte == 0)
801089d3:	85 c0                	test   %eax,%eax
801089d5:	74 05                	je     801089dc <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
801089d7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801089da:	c9                   	leave  
801089db:	c3                   	ret    
    panic("clearpteu");
801089dc:	83 ec 0c             	sub    $0xc,%esp
801089df:	68 4e 96 10 80       	push   $0x8010964e
801089e4:	e8 a7 79 ff ff       	call   80100390 <panic>
801089e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801089f0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801089f0:	55                   	push   %ebp
801089f1:	89 e5                	mov    %esp,%ebp
801089f3:	57                   	push   %edi
801089f4:	56                   	push   %esi
801089f5:	53                   	push   %ebx
801089f6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801089f9:	e8 22 ff ff ff       	call   80108920 <setupkvm>
801089fe:	85 c0                	test   %eax,%eax
80108a00:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108a03:	0f 84 9f 00 00 00    	je     80108aa8 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108a09:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80108a0c:	85 c9                	test   %ecx,%ecx
80108a0e:	0f 84 94 00 00 00    	je     80108aa8 <copyuvm+0xb8>
80108a14:	31 ff                	xor    %edi,%edi
80108a16:	eb 4a                	jmp    80108a62 <copyuvm+0x72>
80108a18:	90                   	nop
80108a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80108a20:	83 ec 04             	sub    $0x4,%esp
80108a23:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80108a29:	68 00 10 00 00       	push   $0x1000
80108a2e:	53                   	push   %ebx
80108a2f:	50                   	push   %eax
80108a30:	e8 7b d4 ff ff       	call   80105eb0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80108a35:	58                   	pop    %eax
80108a36:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80108a3c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80108a41:	5a                   	pop    %edx
80108a42:	ff 75 e4             	pushl  -0x1c(%ebp)
80108a45:	50                   	push   %eax
80108a46:	89 fa                	mov    %edi,%edx
80108a48:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108a4b:	e8 c0 f8 ff ff       	call   80108310 <mappages>
80108a50:	83 c4 10             	add    $0x10,%esp
80108a53:	85 c0                	test   %eax,%eax
80108a55:	78 61                	js     80108ab8 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80108a57:	81 c7 00 10 00 00    	add    $0x1000,%edi
80108a5d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80108a60:	76 46                	jbe    80108aa8 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80108a62:	8b 45 08             	mov    0x8(%ebp),%eax
80108a65:	31 c9                	xor    %ecx,%ecx
80108a67:	89 fa                	mov    %edi,%edx
80108a69:	e8 22 f8 ff ff       	call   80108290 <walkpgdir>
80108a6e:	85 c0                	test   %eax,%eax
80108a70:	74 61                	je     80108ad3 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80108a72:	8b 00                	mov    (%eax),%eax
80108a74:	a8 01                	test   $0x1,%al
80108a76:	74 4e                	je     80108ac6 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80108a78:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
80108a7a:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
80108a7f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80108a85:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80108a88:	e8 c3 9f ff ff       	call   80102a50 <kalloc>
80108a8d:	85 c0                	test   %eax,%eax
80108a8f:	89 c6                	mov    %eax,%esi
80108a91:	75 8d                	jne    80108a20 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80108a93:	83 ec 0c             	sub    $0xc,%esp
80108a96:	ff 75 e0             	pushl  -0x20(%ebp)
80108a99:	e8 02 fe ff ff       	call   801088a0 <freevm>
  return 0;
80108a9e:	83 c4 10             	add    $0x10,%esp
80108aa1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80108aa8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108aab:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108aae:	5b                   	pop    %ebx
80108aaf:	5e                   	pop    %esi
80108ab0:	5f                   	pop    %edi
80108ab1:	5d                   	pop    %ebp
80108ab2:	c3                   	ret    
80108ab3:	90                   	nop
80108ab4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80108ab8:	83 ec 0c             	sub    $0xc,%esp
80108abb:	56                   	push   %esi
80108abc:	e8 df 9d ff ff       	call   801028a0 <kfree>
      goto bad;
80108ac1:	83 c4 10             	add    $0x10,%esp
80108ac4:	eb cd                	jmp    80108a93 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80108ac6:	83 ec 0c             	sub    $0xc,%esp
80108ac9:	68 72 96 10 80       	push   $0x80109672
80108ace:	e8 bd 78 ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80108ad3:	83 ec 0c             	sub    $0xc,%esp
80108ad6:	68 58 96 10 80       	push   $0x80109658
80108adb:	e8 b0 78 ff ff       	call   80100390 <panic>

80108ae0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108ae0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108ae1:	31 c9                	xor    %ecx,%ecx
{
80108ae3:	89 e5                	mov    %esp,%ebp
80108ae5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80108ae8:	8b 55 0c             	mov    0xc(%ebp),%edx
80108aeb:	8b 45 08             	mov    0x8(%ebp),%eax
80108aee:	e8 9d f7 ff ff       	call   80108290 <walkpgdir>
  if((*pte & PTE_P) == 0)
80108af3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80108af5:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80108af6:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80108af8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80108afd:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80108b00:	05 00 00 00 80       	add    $0x80000000,%eax
80108b05:	83 fa 05             	cmp    $0x5,%edx
80108b08:	ba 00 00 00 00       	mov    $0x0,%edx
80108b0d:	0f 45 c2             	cmovne %edx,%eax
}
80108b10:	c3                   	ret    
80108b11:	eb 0d                	jmp    80108b20 <copyout>
80108b13:	90                   	nop
80108b14:	90                   	nop
80108b15:	90                   	nop
80108b16:	90                   	nop
80108b17:	90                   	nop
80108b18:	90                   	nop
80108b19:	90                   	nop
80108b1a:	90                   	nop
80108b1b:	90                   	nop
80108b1c:	90                   	nop
80108b1d:	90                   	nop
80108b1e:	90                   	nop
80108b1f:	90                   	nop

80108b20 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108b20:	55                   	push   %ebp
80108b21:	89 e5                	mov    %esp,%ebp
80108b23:	57                   	push   %edi
80108b24:	56                   	push   %esi
80108b25:	53                   	push   %ebx
80108b26:	83 ec 1c             	sub    $0x1c,%esp
80108b29:	8b 5d 14             	mov    0x14(%ebp),%ebx
80108b2c:	8b 55 0c             	mov    0xc(%ebp),%edx
80108b2f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80108b32:	85 db                	test   %ebx,%ebx
80108b34:	75 40                	jne    80108b76 <copyout+0x56>
80108b36:	eb 70                	jmp    80108ba8 <copyout+0x88>
80108b38:	90                   	nop
80108b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80108b40:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80108b43:	89 f1                	mov    %esi,%ecx
80108b45:	29 d1                	sub    %edx,%ecx
80108b47:	81 c1 00 10 00 00    	add    $0x1000,%ecx
80108b4d:	39 d9                	cmp    %ebx,%ecx
80108b4f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80108b52:	29 f2                	sub    %esi,%edx
80108b54:	83 ec 04             	sub    $0x4,%esp
80108b57:	01 d0                	add    %edx,%eax
80108b59:	51                   	push   %ecx
80108b5a:	57                   	push   %edi
80108b5b:	50                   	push   %eax
80108b5c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80108b5f:	e8 4c d3 ff ff       	call   80105eb0 <memmove>
    len -= n;
    buf += n;
80108b64:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80108b67:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
80108b6a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80108b70:	01 cf                	add    %ecx,%edi
  while(len > 0){
80108b72:	29 cb                	sub    %ecx,%ebx
80108b74:	74 32                	je     80108ba8 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80108b76:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80108b78:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
80108b7b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80108b7e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80108b84:	56                   	push   %esi
80108b85:	ff 75 08             	pushl  0x8(%ebp)
80108b88:	e8 53 ff ff ff       	call   80108ae0 <uva2ka>
    if(pa0 == 0)
80108b8d:	83 c4 10             	add    $0x10,%esp
80108b90:	85 c0                	test   %eax,%eax
80108b92:	75 ac                	jne    80108b40 <copyout+0x20>
  }
  return 0;
}
80108b94:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80108b97:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80108b9c:	5b                   	pop    %ebx
80108b9d:	5e                   	pop    %esi
80108b9e:	5f                   	pop    %edi
80108b9f:	5d                   	pop    %ebp
80108ba0:	c3                   	ret    
80108ba1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108ba8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80108bab:	31 c0                	xor    %eax,%eax
}
80108bad:	5b                   	pop    %ebx
80108bae:	5e                   	pop    %esi
80108baf:	5f                   	pop    %edi
80108bb0:	5d                   	pop    %ebp
80108bb1:	c3                   	ret    
