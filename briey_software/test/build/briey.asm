
build/briey.elf:     file format elf32-littleriscv


Disassembly of section .vector:

80000000 <crtStart>:
.global crtStart
.global main
.global irqCallback

crtStart:
  j crtInit
80000000:	0b40006f          	j	800000b4 <crtInit>
  nop
80000004:	00000013          	nop
  nop
80000008:	00000013          	nop
  nop
8000000c:	00000013          	nop
  nop
80000010:	00000013          	nop
  nop
80000014:	00000013          	nop
  nop
80000018:	00000013          	nop
  nop
8000001c:	00000013          	nop

80000020 <trap_entry>:

.global  trap_entry
trap_entry:
  sw x1,  - 1*4(sp)
80000020:	fe112e23          	sw	ra,-4(sp)
  sw x5,  - 2*4(sp)
80000024:	fe512c23          	sw	t0,-8(sp)
  sw x6,  - 3*4(sp)
80000028:	fe612a23          	sw	t1,-12(sp)
  sw x7,  - 4*4(sp)
8000002c:	fe712823          	sw	t2,-16(sp)
  sw x10, - 5*4(sp)
80000030:	fea12623          	sw	a0,-20(sp)
  sw x11, - 6*4(sp)
80000034:	feb12423          	sw	a1,-24(sp)
  sw x12, - 7*4(sp)
80000038:	fec12223          	sw	a2,-28(sp)
  sw x13, - 8*4(sp)
8000003c:	fed12023          	sw	a3,-32(sp)
  sw x14, - 9*4(sp)
80000040:	fce12e23          	sw	a4,-36(sp)
  sw x15, -10*4(sp)
80000044:	fcf12c23          	sw	a5,-40(sp)
  sw x16, -11*4(sp)
80000048:	fd012a23          	sw	a6,-44(sp)
  sw x17, -12*4(sp)
8000004c:	fd112823          	sw	a7,-48(sp)
  sw x28, -13*4(sp)
80000050:	fdc12623          	sw	t3,-52(sp)
  sw x29, -14*4(sp)
80000054:	fdd12423          	sw	t4,-56(sp)
  sw x30, -15*4(sp)
80000058:	fde12223          	sw	t5,-60(sp)
  sw x31, -16*4(sp)
8000005c:	fdf12023          	sw	t6,-64(sp)
  addi sp,sp,-16*4
80000060:	fc010113          	addi	sp,sp,-64
  call irqCallback
80000064:	c0000097          	auipc	ra,0xc0000
80000068:	66c080e7          	jalr	1644(ra) # 400006d0 <irqCallback>
  lw x1 , 15*4(sp)
8000006c:	03c12083          	lw	ra,60(sp)
  lw x5,  14*4(sp)
80000070:	03812283          	lw	t0,56(sp)
  lw x6,  13*4(sp)
80000074:	03412303          	lw	t1,52(sp)
  lw x7,  12*4(sp)
80000078:	03012383          	lw	t2,48(sp)
  lw x10, 11*4(sp)
8000007c:	02c12503          	lw	a0,44(sp)
  lw x11, 10*4(sp)
80000080:	02812583          	lw	a1,40(sp)
  lw x12,  9*4(sp)
80000084:	02412603          	lw	a2,36(sp)
  lw x13,  8*4(sp)
80000088:	02012683          	lw	a3,32(sp)
  lw x14,  7*4(sp)
8000008c:	01c12703          	lw	a4,28(sp)
  lw x15,  6*4(sp)
80000090:	01812783          	lw	a5,24(sp)
  lw x16,  5*4(sp)
80000094:	01412803          	lw	a6,20(sp)
  lw x17,  4*4(sp)
80000098:	01012883          	lw	a7,16(sp)
  lw x28,  3*4(sp)
8000009c:	00c12e03          	lw	t3,12(sp)
  lw x29,  2*4(sp)
800000a0:	00812e83          	lw	t4,8(sp)
  lw x30,  1*4(sp)
800000a4:	00412f03          	lw	t5,4(sp)
  lw x31,  0*4(sp)
800000a8:	00012f83          	lw	t6,0(sp)
  addi sp,sp,16*4
800000ac:	04010113          	addi	sp,sp,64
  mret
800000b0:	30200073          	mret

800000b4 <crtInit>:


crtInit:
  .option push
  .option norelax
  la gp, __global_pointer$
800000b4:	c0001197          	auipc	gp,0xc0001
800000b8:	f7c18193          	addi	gp,gp,-132 # 40001030 <__global_pointer$>
  .option pop
  la sp, _stack_start
800000bc:	00001117          	auipc	sp,0x1
800000c0:	88410113          	addi	sp,sp,-1916 # 80000940 <_stack_start>

800000c4 <bss_init>:

bss_init:
  la a0, _bss_start
800000c4:	c0000517          	auipc	a0,0xc0000
800000c8:	76c50513          	addi	a0,a0,1900 # 40000830 <data>
  la a1, _bss_end
800000cc:	80818593          	addi	a1,gp,-2040 # 40000838 <_bss_end>

800000d0 <bss_loop>:
bss_loop:
  beq a0,a1,bss_done
800000d0:	00b50863          	beq	a0,a1,800000e0 <bss_done>
  sw zero,0(a0)
800000d4:	00052023          	sw	zero,0(a0)
  add a0,a0,4
800000d8:	00450513          	addi	a0,a0,4
  j bss_loop
800000dc:	ff5ff06f          	j	800000d0 <bss_loop>

800000e0 <bss_done>:
bss_done:

ctors_init:
  la a0, _ctors_start
800000e0:	c0000517          	auipc	a0,0xc0000
800000e4:	74c50513          	addi	a0,a0,1868 # 4000082c <_ctors_end>
  addi sp,sp,-4
800000e8:	ffc10113          	addi	sp,sp,-4

800000ec <ctors_loop>:
ctors_loop:
  la a1, _ctors_end
800000ec:	c0000597          	auipc	a1,0xc0000
800000f0:	74058593          	addi	a1,a1,1856 # 4000082c <_ctors_end>
  beq a0,a1,ctors_done
800000f4:	00b50e63          	beq	a0,a1,80000110 <ctors_done>
  lw a3,0(a0)
800000f8:	00052683          	lw	a3,0(a0)
  add a0,a0,4
800000fc:	00450513          	addi	a0,a0,4
  sw a0,0(sp)
80000100:	00a12023          	sw	a0,0(sp)
  jalr  a3
80000104:	000680e7          	jalr	a3
  lw a0,0(sp)
80000108:	00012503          	lw	a0,0(sp)
  j ctors_loop
8000010c:	fe1ff06f          	j	800000ec <ctors_loop>

80000110 <ctors_done>:
ctors_done:
  addi sp,sp,4
80000110:	00410113          	addi	sp,sp,4


  li a0, 0x880     //880 enable timer + external interrupts
80000114:	00001537          	lui	a0,0x1
80000118:	88050513          	addi	a0,a0,-1920 # 880 <_stack_size+0x80>
  csrw mie,a0
8000011c:	30451073          	csrw	mie,a0
  li a0, 0x1808     //1808 enable interrupts
80000120:	00002537          	lui	a0,0x2
80000124:	80850513          	addi	a0,a0,-2040 # 1808 <_stack_size+0x1008>
  csrw mstatus,a0
80000128:	30051073          	csrw	mstatus,a0

  call main
8000012c:	c0000097          	auipc	ra,0xc0000
80000130:	338080e7          	jalr	824(ra) # 40000464 <main>

80000134 <infinitLoop>:
infinitLoop:
  j infinitLoop
80000134:	0000006f          	j	80000134 <infinitLoop>

Disassembly of section .memory:

40000000 <timer_init>:
  volatile uint32_t CLEARS_TICKS;
  volatile uint32_t LIMIT;
  volatile uint32_t VALUE;
} Timer_Reg;

static void timer_init(Timer_Reg *reg){
40000000:	fe010113          	addi	sp,sp,-32
40000004:	00812e23          	sw	s0,28(sp)
40000008:	02010413          	addi	s0,sp,32
4000000c:	fea42623          	sw	a0,-20(s0)
	reg->CLEARS_TICKS  = 0;
40000010:	fec42783          	lw	a5,-20(s0)
40000014:	0007a023          	sw	zero,0(a5)
	reg->VALUE = 0;
40000018:	fec42783          	lw	a5,-20(s0)
4000001c:	0007a423          	sw	zero,8(a5)
}
40000020:	00000013          	nop
40000024:	01c12403          	lw	s0,28(sp)
40000028:	02010113          	addi	sp,sp,32
4000002c:	00008067          	ret

40000030 <prescaler_init>:
typedef struct
{
  volatile uint32_t LIMIT;
} Prescaler_Reg;

static void prescaler_init(Prescaler_Reg* reg){
40000030:	fe010113          	addi	sp,sp,-32
40000034:	00812e23          	sw	s0,28(sp)
40000038:	02010413          	addi	s0,sp,32
4000003c:	fea42623          	sw	a0,-20(s0)

}
40000040:	00000013          	nop
40000044:	01c12403          	lw	s0,28(sp)
40000048:	02010113          	addi	sp,sp,32
4000004c:	00008067          	ret

40000050 <interruptCtrl_init>:
{
  volatile uint32_t PENDINGS;
  volatile uint32_t MASKS;
} InterruptCtrl_Reg;

static void interruptCtrl_init(InterruptCtrl_Reg* reg){
40000050:	fe010113          	addi	sp,sp,-32
40000054:	00812e23          	sw	s0,28(sp)
40000058:	02010413          	addi	s0,sp,32
4000005c:	fea42623          	sw	a0,-20(s0)
	reg->MASKS = 0;
40000060:	fec42783          	lw	a5,-20(s0)
40000064:	0007a223          	sw	zero,4(a5)
	reg->PENDINGS = 0xFFFFFFFF;
40000068:	fec42783          	lw	a5,-20(s0)
4000006c:	fff00713          	li	a4,-1
40000070:	00e7a023          	sw	a4,0(a5)
}
40000074:	00000013          	nop
40000078:	01c12403          	lw	s0,28(sp)
4000007c:	02010113          	addi	sp,sp,32
40000080:	00008067          	ret

40000084 <uart_writeAvailability>:
	enum UartParity parity;
	enum UartStop stop;
	uint32_t clockDivider;
} Uart_Config;

static uint32_t uart_writeAvailability(Uart_Reg *reg){
40000084:	fe010113          	addi	sp,sp,-32
40000088:	00812e23          	sw	s0,28(sp)
4000008c:	02010413          	addi	s0,sp,32
40000090:	fea42623          	sw	a0,-20(s0)
	return (reg->STATUS >> 16) & 0xFF;
40000094:	fec42783          	lw	a5,-20(s0)
40000098:	0047a783          	lw	a5,4(a5)
4000009c:	0107d793          	srli	a5,a5,0x10
400000a0:	0ff7f793          	zext.b	a5,a5
}
400000a4:	00078513          	mv	a0,a5
400000a8:	01c12403          	lw	s0,28(sp)
400000ac:	02010113          	addi	sp,sp,32
400000b0:	00008067          	ret

400000b4 <uart_readOccupancy>:
static uint32_t uart_readOccupancy(Uart_Reg *reg){
400000b4:	fe010113          	addi	sp,sp,-32
400000b8:	00812e23          	sw	s0,28(sp)
400000bc:	02010413          	addi	s0,sp,32
400000c0:	fea42623          	sw	a0,-20(s0)
	return reg->STATUS >> 24;
400000c4:	fec42783          	lw	a5,-20(s0)
400000c8:	0047a783          	lw	a5,4(a5)
400000cc:	0187d793          	srli	a5,a5,0x18
}
400000d0:	00078513          	mv	a0,a5
400000d4:	01c12403          	lw	s0,28(sp)
400000d8:	02010113          	addi	sp,sp,32
400000dc:	00008067          	ret

400000e0 <uart_write>:

static void uart_write(Uart_Reg *reg, uint32_t data){
400000e0:	fe010113          	addi	sp,sp,-32
400000e4:	00112e23          	sw	ra,28(sp)
400000e8:	00812c23          	sw	s0,24(sp)
400000ec:	02010413          	addi	s0,sp,32
400000f0:	fea42623          	sw	a0,-20(s0)
400000f4:	feb42423          	sw	a1,-24(s0)
	while(uart_writeAvailability(reg) == 0);
400000f8:	00000013          	nop
400000fc:	fec42503          	lw	a0,-20(s0)
40000100:	f85ff0ef          	jal	ra,40000084 <uart_writeAvailability>
40000104:	00050793          	mv	a5,a0
40000108:	fe078ae3          	beqz	a5,400000fc <uart_write+0x1c>
	reg->DATA = data;
4000010c:	fec42783          	lw	a5,-20(s0)
40000110:	fe842703          	lw	a4,-24(s0)
40000114:	00e7a023          	sw	a4,0(a5)
}
40000118:	00000013          	nop
4000011c:	01c12083          	lw	ra,28(sp)
40000120:	01812403          	lw	s0,24(sp)
40000124:	02010113          	addi	sp,sp,32
40000128:	00008067          	ret

4000012c <uart_applyConfig>:

static void uart_applyConfig(Uart_Reg *reg, Uart_Config *config){
4000012c:	fe010113          	addi	sp,sp,-32
40000130:	00812e23          	sw	s0,28(sp)
40000134:	02010413          	addi	s0,sp,32
40000138:	fea42623          	sw	a0,-20(s0)
4000013c:	feb42423          	sw	a1,-24(s0)
	reg->CLOCK_DIVIDER = config->clockDivider;
40000140:	fe842783          	lw	a5,-24(s0)
40000144:	00c7a703          	lw	a4,12(a5)
40000148:	fec42783          	lw	a5,-20(s0)
4000014c:	00e7a423          	sw	a4,8(a5)
	reg->FRAME_CONFIG = ((config->dataLength-1) << 0) | (config->parity << 8) | (config->stop << 16);
40000150:	fe842783          	lw	a5,-24(s0)
40000154:	0007a783          	lw	a5,0(a5)
40000158:	fff78713          	addi	a4,a5,-1
4000015c:	fe842783          	lw	a5,-24(s0)
40000160:	0047a783          	lw	a5,4(a5)
40000164:	00879793          	slli	a5,a5,0x8
40000168:	00f76733          	or	a4,a4,a5
4000016c:	fe842783          	lw	a5,-24(s0)
40000170:	0087a783          	lw	a5,8(a5)
40000174:	01079793          	slli	a5,a5,0x10
40000178:	00f76733          	or	a4,a4,a5
4000017c:	fec42783          	lw	a5,-20(s0)
40000180:	00e7a623          	sw	a4,12(a5)
}
40000184:	00000013          	nop
40000188:	01c12403          	lw	s0,28(sp)
4000018c:	02010113          	addi	sp,sp,32
40000190:	00008067          	ret

40000194 <vga_isBusy>:
  volatile uint32_t  FRAME_BASE;
  volatile uint32_t  DUMMY0[13];
  volatile Vga_Timing TIMING;
} Vga_Reg;

static uint32_t vga_isBusy(Vga_Reg *reg){
40000194:	fe010113          	addi	sp,sp,-32
40000198:	00812e23          	sw	s0,28(sp)
4000019c:	02010413          	addi	s0,sp,32
400001a0:	fea42623          	sw	a0,-20(s0)
	return (reg->STATUS & 2) != 0;
400001a4:	fec42783          	lw	a5,-20(s0)
400001a8:	0007a783          	lw	a5,0(a5)
400001ac:	0027f793          	andi	a5,a5,2
400001b0:	00f037b3          	snez	a5,a5
400001b4:	0ff7f793          	zext.b	a5,a5
}
400001b8:	00078513          	mv	a0,a5
400001bc:	01c12403          	lw	s0,28(sp)
400001c0:	02010113          	addi	sp,sp,32
400001c4:	00008067          	ret

400001c8 <vga_run>:

static void vga_run(Vga_Reg *reg){
400001c8:	fe010113          	addi	sp,sp,-32
400001cc:	00812e23          	sw	s0,28(sp)
400001d0:	02010413          	addi	s0,sp,32
400001d4:	fea42623          	sw	a0,-20(s0)
	reg->STATUS  = 1;
400001d8:	fec42783          	lw	a5,-20(s0)
400001dc:	00100713          	li	a4,1
400001e0:	00e7a023          	sw	a4,0(a5)
}
400001e4:	00000013          	nop
400001e8:	01c12403          	lw	s0,28(sp)
400001ec:	02010113          	addi	sp,sp,32
400001f0:	00008067          	ret

400001f4 <vga_stop>:

static void vga_stop(Vga_Reg *reg){
400001f4:	fe010113          	addi	sp,sp,-32
400001f8:	00112e23          	sw	ra,28(sp)
400001fc:	00812c23          	sw	s0,24(sp)
40000200:	02010413          	addi	s0,sp,32
40000204:	fea42623          	sw	a0,-20(s0)
	reg->STATUS  = 0;
40000208:	fec42783          	lw	a5,-20(s0)
4000020c:	0007a023          	sw	zero,0(a5)
	while(vga_isBusy(reg));
40000210:	00000013          	nop
40000214:	fec42503          	lw	a0,-20(s0)
40000218:	f7dff0ef          	jal	ra,40000194 <vga_isBusy>
4000021c:	00050793          	mv	a5,a0
40000220:	fe079ae3          	bnez	a5,40000214 <vga_stop+0x20>
}
40000224:	00000013          	nop
40000228:	00000013          	nop
4000022c:	01c12083          	lw	ra,28(sp)
40000230:	01812403          	lw	s0,24(sp)
40000234:	02010113          	addi	sp,sp,32
40000238:	00008067          	ret

4000023c <prince_write>:
#include <stdlib.h>
#include <briey.h>
//function----
//------------------------PRINCE-------------------
void prince_write(uint32_t iData, uint32_t iAddress)
{
4000023c:	fe010113          	addi	sp,sp,-32
40000240:	00812e23          	sw	s0,28(sp)
40000244:	02010413          	addi	s0,sp,32
40000248:	fea42623          	sw	a0,-20(s0)
4000024c:	feb42423          	sw	a1,-24(s0)
	PRINCE_BASE->ADDRESS		= iAddress;
40000250:	f00027b7          	lui	a5,0xf0002
40000254:	fe842703          	lw	a4,-24(s0)
40000258:	00e7a423          	sw	a4,8(a5) # f0002008 <_stack_start+0x700016c8>
	PRINCE_BASE->WRITE_ENABLE 	= 1;
4000025c:	f00027b7          	lui	a5,0xf0002
40000260:	00100713          	li	a4,1
40000264:	00e7a223          	sw	a4,4(a5) # f0002004 <_stack_start+0x700016c4>
	PRINCE_BASE->IDATA			= iData;
40000268:	f00027b7          	lui	a5,0xf0002
4000026c:	fec42703          	lw	a4,-20(s0)
40000270:	00e7a623          	sw	a4,12(a5) # f000200c <_stack_start+0x700016cc>
	PRINCE_BASE->CHIP_SELECT	= 1;
40000274:	f00027b7          	lui	a5,0xf0002
40000278:	00100713          	li	a4,1
4000027c:	00e7a023          	sw	a4,0(a5) # f0002000 <_stack_start+0x700016c0>
	PRINCE_BASE->CHIP_SELECT	= 0;
40000280:	f00027b7          	lui	a5,0xf0002
40000284:	0007a023          	sw	zero,0(a5) # f0002000 <_stack_start+0x700016c0>
}
40000288:	00000013          	nop
4000028c:	01c12403          	lw	s0,28(sp)
40000290:	02010113          	addi	sp,sp,32
40000294:	00008067          	ret

40000298 <prince_read>:
uint32_t prince_read(uint32_t iAddress)
{
40000298:	fd010113          	addi	sp,sp,-48
4000029c:	02812623          	sw	s0,44(sp)
400002a0:	03010413          	addi	s0,sp,48
400002a4:	fca42e23          	sw	a0,-36(s0)
	PRINCE_BASE->ADDRESS		= iAddress;
400002a8:	f00027b7          	lui	a5,0xf0002
400002ac:	fdc42703          	lw	a4,-36(s0)
400002b0:	00e7a423          	sw	a4,8(a5) # f0002008 <_stack_start+0x700016c8>
	PRINCE_BASE->WRITE_ENABLE	= 0;
400002b4:	f00027b7          	lui	a5,0xf0002
400002b8:	0007a223          	sw	zero,4(a5) # f0002004 <_stack_start+0x700016c4>
	PRINCE_BASE->CHIP_SELECT	= 1;
400002bc:	f00027b7          	lui	a5,0xf0002
400002c0:	00100713          	li	a4,1
400002c4:	00e7a023          	sw	a4,0(a5) # f0002000 <_stack_start+0x700016c0>
	uint32_t res 				= PRINCE_BASE->ODATA;
400002c8:	f00027b7          	lui	a5,0xf0002
400002cc:	0107a783          	lw	a5,16(a5) # f0002010 <_stack_start+0x700016d0>
400002d0:	fef42623          	sw	a5,-20(s0)
	PRINCE_BASE->CHIP_SELECT	= 0;
400002d4:	f00027b7          	lui	a5,0xf0002
400002d8:	0007a023          	sw	zero,0(a5) # f0002000 <_stack_start+0x700016c0>
	return res;
400002dc:	fec42783          	lw	a5,-20(s0)
}
400002e0:	00078513          	mv	a0,a5
400002e4:	02c12403          	lw	s0,44(sp)
400002e8:	03010113          	addi	sp,sp,48
400002ec:	00008067          	ret

400002f0 <prince_cipher>:

void prince_cipher(uint32_t mode, uint32_t *key, uint32_t *block, uint32_t *res)
{
400002f0:	fe010113          	addi	sp,sp,-32
400002f4:	00112e23          	sw	ra,28(sp)
400002f8:	00812c23          	sw	s0,24(sp)
400002fc:	00912a23          	sw	s1,20(sp)
40000300:	02010413          	addi	s0,sp,32
40000304:	fea42623          	sw	a0,-20(s0)
40000308:	feb42423          	sw	a1,-24(s0)
4000030c:	fec42223          	sw	a2,-28(s0)
40000310:	fed42023          	sw	a3,-32(s0)
		//KEY----

		prince_write(key[3],PRINCE_ADDR_KEY3);
40000314:	fe842783          	lw	a5,-24(s0)
40000318:	00c78793          	addi	a5,a5,12
4000031c:	0007a783          	lw	a5,0(a5)
40000320:	01300593          	li	a1,19
40000324:	00078513          	mv	a0,a5
40000328:	f15ff0ef          	jal	ra,4000023c <prince_write>
		prince_write(key[2],PRINCE_ADDR_KEY2);
4000032c:	fe842783          	lw	a5,-24(s0)
40000330:	00878793          	addi	a5,a5,8
40000334:	0007a783          	lw	a5,0(a5)
40000338:	01200593          	li	a1,18
4000033c:	00078513          	mv	a0,a5
40000340:	efdff0ef          	jal	ra,4000023c <prince_write>
		prince_write(key[1],PRINCE_ADDR_KEY1);
40000344:	fe842783          	lw	a5,-24(s0)
40000348:	00478793          	addi	a5,a5,4
4000034c:	0007a783          	lw	a5,0(a5)
40000350:	01100593          	li	a1,17
40000354:	00078513          	mv	a0,a5
40000358:	ee5ff0ef          	jal	ra,4000023c <prince_write>
		prince_write(key[0],PRINCE_ADDR_KEY0);
4000035c:	fe842783          	lw	a5,-24(s0)
40000360:	0007a783          	lw	a5,0(a5)
40000364:	01000593          	li	a1,16
40000368:	00078513          	mv	a0,a5
4000036c:	ed1ff0ef          	jal	ra,4000023c <prince_write>



		//EN-OR-DE---
		prince_write(mode,PRINCE_ADDR_CONFIG);
40000370:	00a00593          	li	a1,10
40000374:	fec42503          	lw	a0,-20(s0)
40000378:	ec5ff0ef          	jal	ra,4000023c <prince_write>

		//BLOCK----
		prince_write(block[1],PRINCE_ADDR_BLOCK1);
4000037c:	fe442783          	lw	a5,-28(s0)
40000380:	00478793          	addi	a5,a5,4
40000384:	0007a783          	lw	a5,0(a5)
40000388:	02100593          	li	a1,33
4000038c:	00078513          	mv	a0,a5
40000390:	eadff0ef          	jal	ra,4000023c <prince_write>
		prince_write(block[0],PRINCE_ADDR_BLOCK0);
40000394:	fe442783          	lw	a5,-28(s0)
40000398:	0007a783          	lw	a5,0(a5)
4000039c:	02000593          	li	a1,32
400003a0:	00078513          	mv	a0,a5
400003a4:	e99ff0ef          	jal	ra,4000023c <prince_write>


		//START----
		prince_write(0x1,PRINCE_ADDR_CTRL);
400003a8:	00800593          	li	a1,8
400003ac:	00100513          	li	a0,1
400003b0:	e8dff0ef          	jal	ra,4000023c <prince_write>

		//wait result----
		while(prince_read(PRINCE_ADDR_STATUS)==0);
400003b4:	00000013          	nop
400003b8:	00900513          	li	a0,9
400003bc:	eddff0ef          	jal	ra,40000298 <prince_read>
400003c0:	00050793          	mv	a5,a0
400003c4:	fe078ae3          	beqz	a5,400003b8 <prince_cipher+0xc8>
		res[1] = prince_read(PRINCE_ADDR_RESULT1);
400003c8:	fe042783          	lw	a5,-32(s0)
400003cc:	00478493          	addi	s1,a5,4
400003d0:	03100513          	li	a0,49
400003d4:	ec5ff0ef          	jal	ra,40000298 <prince_read>
400003d8:	00050793          	mv	a5,a0
400003dc:	00f4a023          	sw	a5,0(s1)
		res[0] = prince_read(PRINCE_ADDR_RESULT0);
400003e0:	03000513          	li	a0,48
400003e4:	eb5ff0ef          	jal	ra,40000298 <prince_read>
400003e8:	00050713          	mv	a4,a0
400003ec:	fe042783          	lw	a5,-32(s0)
400003f0:	00e7a023          	sw	a4,0(a5)
}
400003f4:	00000013          	nop
400003f8:	01c12083          	lw	ra,28(sp)
400003fc:	01812403          	lw	s0,24(sp)
40000400:	01412483          	lw	s1,20(sp)
40000404:	02010113          	addi	sp,sp,32
40000408:	00008067          	ret

4000040c <print>:
void print(char *str){
4000040c:	fe010113          	addi	sp,sp,-32
40000410:	00112e23          	sw	ra,28(sp)
40000414:	00812c23          	sw	s0,24(sp)
40000418:	02010413          	addi	s0,sp,32
4000041c:	fea42623          	sw	a0,-20(s0)
	while(*str){
40000420:	0200006f          	j	40000440 <print+0x34>
		uart_write(UART,*(str++));
40000424:	fec42783          	lw	a5,-20(s0)
40000428:	00178713          	addi	a4,a5,1
4000042c:	fee42623          	sw	a4,-20(s0)
40000430:	0007c783          	lbu	a5,0(a5)
40000434:	00078593          	mv	a1,a5
40000438:	f0010537          	lui	a0,0xf0010
4000043c:	ca5ff0ef          	jal	ra,400000e0 <uart_write>
	while(*str){
40000440:	fec42783          	lw	a5,-20(s0)
40000444:	0007c783          	lbu	a5,0(a5)
40000448:	fc079ee3          	bnez	a5,40000424 <print+0x18>
	}
}
4000044c:	00000013          	nop
40000450:	00000013          	nop
40000454:	01c12083          	lw	ra,28(sp)
40000458:	01812403          	lw	s0,24(sp)
4000045c:	02010113          	addi	sp,sp,32
40000460:	00008067          	ret

40000464 <main>:

unsigned int data;
unsigned int address;
int main() {
40000464:	fc010113          	addi	sp,sp,-64
40000468:	02112e23          	sw	ra,60(sp)
4000046c:	02812c23          	sw	s0,56(sp)
40000470:	04010413          	addi	s0,sp,64
	Uart_Config uartConfig;
	uartConfig.dataLength = 8;
40000474:	00800793          	li	a5,8
40000478:	fef42023          	sw	a5,-32(s0)
	uartConfig.parity = NONE;
4000047c:	fe042223          	sw	zero,-28(s0)
	uartConfig.stop = ONE;
40000480:	fe042423          	sw	zero,-24(s0)
	uartConfig.clockDivider = (CORE_HZ / 8 / 115200) - 1;
40000484:	03500793          	li	a5,53
40000488:	fef42623          	sw	a5,-20(s0)
	uart_applyConfig(UART,&uartConfig);
4000048c:	fe040793          	addi	a5,s0,-32
40000490:	00078593          	mv	a1,a5
40000494:	f0010537          	lui	a0,0xf0010
40000498:	c95ff0ef          	jal	ra,4000012c <uart_applyConfig>

	print("====================================================\r\n");
4000049c:	400007b7          	lui	a5,0x40000
400004a0:	74c78513          	addi	a0,a5,1868 # 4000074c <vga_simRes_h160_v120+0x20>
400004a4:	f69ff0ef          	jal	ra,4000040c <print>
	print("==========Add Prince Peripheral to Briey-SoC========\r\n");
400004a8:	400007b7          	lui	a5,0x40000
400004ac:	78478513          	addi	a0,a5,1924 # 40000784 <vga_simRes_h160_v120+0x58>
400004b0:	f5dff0ef          	jal	ra,4000040c <print>
	print("==========K18 FETEL - EMBEDDED SYSTEM -=============\r\n");
400004b4:	400007b7          	lui	a5,0x40000
400004b8:	7bc78513          	addi	a0,a5,1980 # 400007bc <vga_simRes_h160_v120+0x90>
400004bc:	f51ff0ef          	jal	ra,4000040c <print>
	print("=============LE DUY LINH - 18200157-================\r\n");
400004c0:	400007b7          	lui	a5,0x40000
400004c4:	7f478513          	addi	a0,a5,2036 # 400007f4 <vga_simRes_h160_v120+0xc8>
400004c8:	f45ff0ef          	jal	ra,4000040c <print>
	print("====================================================\r\n");
400004cc:	400007b7          	lui	a5,0x40000
400004d0:	74c78513          	addi	a0,a5,1868 # 4000074c <vga_simRes_h160_v120+0x20>
400004d4:	f39ff0ef          	jal	ra,4000040c <print>
	//******************************************************************
	//******************************PRINCE******************************
	//******************************************************************
	uint32_t key[4] 		= {0x0, 0x0, 0x0, 0x0};
400004d8:	fc042823          	sw	zero,-48(s0)
400004dc:	fc042a23          	sw	zero,-44(s0)
400004e0:	fc042c23          	sw	zero,-40(s0)
400004e4:	fc042e23          	sw	zero,-36(s0)
	uint32_t block[2] 		= {0x0, 0x0};
400004e8:	fc042423          	sw	zero,-56(s0)
400004ec:	fc042623          	sw	zero,-52(s0)
	uint32_t real_res[2] 	= {0x0,0x0};
400004f0:	fc042023          	sw	zero,-64(s0)
400004f4:	fc042223          	sw	zero,-60(s0)
	//************************TEST 1 (ENCRYPT)**************************

	key[3]		= 0x00112233;
400004f8:	001127b7          	lui	a5,0x112
400004fc:	23378793          	addi	a5,a5,563 # 112233 <_stack_size+0x111a33>
40000500:	fcf42e23          	sw	a5,-36(s0)
	key[2]		= 0x44556677;
40000504:	445567b7          	lui	a5,0x44556
40000508:	67778793          	addi	a5,a5,1655 # 44556677 <__global_pointer$+0x4555647>
4000050c:	fcf42c23          	sw	a5,-40(s0)
	key[1]		= 0x8899aabb;
40000510:	8899b7b7          	lui	a5,0x8899b
40000514:	abb78793          	addi	a5,a5,-1349 # 8899aabb <_stack_start+0x899a17b>
40000518:	fcf42a23          	sw	a5,-44(s0)
	key[0]		= 0xccddeeff;
4000051c:	ccddf7b7          	lui	a5,0xccddf
40000520:	eff78793          	addi	a5,a5,-257 # ccddeeff <_stack_start+0x4cdde5bf>
40000524:	fcf42823          	sw	a5,-48(s0)

	block[1] 	= 0x01234567;
40000528:	012347b7          	lui	a5,0x1234
4000052c:	56778793          	addi	a5,a5,1383 # 1234567 <_stack_size+0x1233d67>
40000530:	fcf42623          	sw	a5,-52(s0)
	block[0] 	= 0x89abcdef;
40000534:	89abd7b7          	lui	a5,0x89abd
40000538:	def78793          	addi	a5,a5,-529 # 89abcdef <_stack_start+0x9abc4af>
4000053c:	fcf42423          	sw	a5,-56(s0)

	prince_cipher(PRINCE_OP_EN,key,block,real_res);
40000540:	fc040693          	addi	a3,s0,-64
40000544:	fc840713          	addi	a4,s0,-56
40000548:	fd040793          	addi	a5,s0,-48
4000054c:	00070613          	mv	a2,a4
40000550:	00078593          	mv	a1,a5
40000554:	00100513          	li	a0,1
40000558:	d99ff0ef          	jal	ra,400002f0 <prince_cipher>
	GPIO_A_BASE->OUTPUT = real_res[1];
4000055c:	f00007b7          	lui	a5,0xf0000
40000560:	fc442703          	lw	a4,-60(s0)
40000564:	00e7a223          	sw	a4,4(a5) # f0000004 <_stack_start+0x6ffff6c4>
	GPIO_A_BASE->OUTPUT = real_res[0];
40000568:	f00007b7          	lui	a5,0xf0000
4000056c:	fc042703          	lw	a4,-64(s0)
40000570:	00e7a223          	sw	a4,4(a5) # f0000004 <_stack_start+0x6ffff6c4>


	//************************TEST 2 (ENCRYPT)*************************
	key[3]		= 0x00000000;
40000574:	fc042e23          	sw	zero,-36(s0)
	key[2]		= 0x00000000;
40000578:	fc042c23          	sw	zero,-40(s0)
	key[1]		= 0x00000000;
4000057c:	fc042a23          	sw	zero,-44(s0)
	key[0]		= 0x00000000;
40000580:	fc042823          	sw	zero,-48(s0)

	block[1] 	= 0x00000000;
40000584:	fc042623          	sw	zero,-52(s0)
	block[0] 	= 0x00000000;
40000588:	fc042423          	sw	zero,-56(s0)

	prince_cipher(PRINCE_OP_EN,key,block,real_res);
4000058c:	fc040693          	addi	a3,s0,-64
40000590:	fc840713          	addi	a4,s0,-56
40000594:	fd040793          	addi	a5,s0,-48
40000598:	00070613          	mv	a2,a4
4000059c:	00078593          	mv	a1,a5
400005a0:	00100513          	li	a0,1
400005a4:	d4dff0ef          	jal	ra,400002f0 <prince_cipher>
	GPIO_A_BASE->OUTPUT = real_res[1];
400005a8:	f00007b7          	lui	a5,0xf0000
400005ac:	fc442703          	lw	a4,-60(s0)
400005b0:	00e7a223          	sw	a4,4(a5) # f0000004 <_stack_start+0x6ffff6c4>
	GPIO_A_BASE->OUTPUT = real_res[0];
400005b4:	f00007b7          	lui	a5,0xf0000
400005b8:	fc042703          	lw	a4,-64(s0)
400005bc:	00e7a223          	sw	a4,4(a5) # f0000004 <_stack_start+0x6ffff6c4>


	//************************TEST 3 (ENCRYPT)*************************

	key[3]		= 0xd8cdb780;
400005c0:	d8cdb7b7          	lui	a5,0xd8cdb
400005c4:	78078793          	addi	a5,a5,1920 # d8cdb780 <_stack_start+0x58cdae40>
400005c8:	fcf42e23          	sw	a5,-36(s0)
	key[2]		= 0x70b4c55a;
400005cc:	70b4c7b7          	lui	a5,0x70b4c
400005d0:	55a78793          	addi	a5,a5,1370 # 70b4c55a <__global_pointer$+0x30b4b52a>
400005d4:	fcf42c23          	sw	a5,-40(s0)
	key[1]		= 0x818665aa;
400005d8:	818667b7          	lui	a5,0x81866
400005dc:	5aa78793          	addi	a5,a5,1450 # 818665aa <_stack_start+0x1865c6a>
400005e0:	fcf42a23          	sw	a5,-44(s0)
	key[0]		= 0x0d02dfda;
400005e4:	0d02e7b7          	lui	a5,0xd02e
400005e8:	fda78793          	addi	a5,a5,-38 # d02dfda <_stack_size+0xd02d7da>
400005ec:	fcf42823          	sw	a5,-48(s0)

	block[1] = 0x69c4e0d8;
400005f0:	69c4e7b7          	lui	a5,0x69c4e
400005f4:	0d878793          	addi	a5,a5,216 # 69c4e0d8 <__global_pointer$+0x29c4d0a8>
400005f8:	fcf42623          	sw	a5,-52(s0)
	block[0] = 0x6a7b0430;
400005fc:	6a7b07b7          	lui	a5,0x6a7b0
40000600:	43078793          	addi	a5,a5,1072 # 6a7b0430 <__global_pointer$+0x2a7af400>
40000604:	fcf42423          	sw	a5,-56(s0)

	prince_cipher(PRINCE_OP_EN,key,block,real_res);
40000608:	fc040693          	addi	a3,s0,-64
4000060c:	fc840713          	addi	a4,s0,-56
40000610:	fd040793          	addi	a5,s0,-48
40000614:	00070613          	mv	a2,a4
40000618:	00078593          	mv	a1,a5
4000061c:	00100513          	li	a0,1
40000620:	cd1ff0ef          	jal	ra,400002f0 <prince_cipher>
	GPIO_A_BASE->OUTPUT = real_res[1];
40000624:	f00007b7          	lui	a5,0xf0000
40000628:	fc442703          	lw	a4,-60(s0)
4000062c:	00e7a223          	sw	a4,4(a5) # f0000004 <_stack_start+0x6ffff6c4>
	GPIO_A_BASE->OUTPUT = real_res[0];
40000630:	f00007b7          	lui	a5,0xf0000
40000634:	fc042703          	lw	a4,-64(s0)
40000638:	00e7a223          	sw	a4,4(a5) # f0000004 <_stack_start+0x6ffff6c4>

	//************************TEST 4 (DECRYPT)*************************
	key[3]		= 0xd8cdb780;
4000063c:	d8cdb7b7          	lui	a5,0xd8cdb
40000640:	78078793          	addi	a5,a5,1920 # d8cdb780 <_stack_start+0x58cdae40>
40000644:	fcf42e23          	sw	a5,-36(s0)
	key[2]		= 0x70b4c55a;
40000648:	70b4c7b7          	lui	a5,0x70b4c
4000064c:	55a78793          	addi	a5,a5,1370 # 70b4c55a <__global_pointer$+0x30b4b52a>
40000650:	fcf42c23          	sw	a5,-40(s0)
	key[1]		= 0x818665aa;
40000654:	818667b7          	lui	a5,0x81866
40000658:	5aa78793          	addi	a5,a5,1450 # 818665aa <_stack_start+0x1865c6a>
4000065c:	fcf42a23          	sw	a5,-44(s0)
	key[0]		= 0x0d02dfda;
40000660:	0d02e7b7          	lui	a5,0xd02e
40000664:	fda78793          	addi	a5,a5,-38 # d02dfda <_stack_size+0xd02d7da>
40000668:	fcf42823          	sw	a5,-48(s0)

	block[1] 	= 0x43c6b256;
4000066c:	43c6b7b7          	lui	a5,0x43c6b
40000670:	25678793          	addi	a5,a5,598 # 43c6b256 <__global_pointer$+0x3c6a226>
40000674:	fcf42623          	sw	a5,-52(s0)
	block[0] 	= 0xd79de7e8;
40000678:	d79de7b7          	lui	a5,0xd79de
4000067c:	7e878793          	addi	a5,a5,2024 # d79de7e8 <_stack_start+0x579ddea8>
40000680:	fcf42423          	sw	a5,-56(s0)

	prince_cipher(PRINCE_OP_DE,key,block,real_res);
40000684:	fc040693          	addi	a3,s0,-64
40000688:	fc840713          	addi	a4,s0,-56
4000068c:	fd040793          	addi	a5,s0,-48
40000690:	00070613          	mv	a2,a4
40000694:	00078593          	mv	a1,a5
40000698:	00000513          	li	a0,0
4000069c:	c55ff0ef          	jal	ra,400002f0 <prince_cipher>
	GPIO_A_BASE->OUTPUT = real_res[1];
400006a0:	f00007b7          	lui	a5,0xf0000
400006a4:	fc442703          	lw	a4,-60(s0)
400006a8:	00e7a223          	sw	a4,4(a5) # f0000004 <_stack_start+0x6ffff6c4>
	GPIO_A_BASE->OUTPUT = real_res[0];
400006ac:	f00007b7          	lui	a5,0xf0000
400006b0:	fc042703          	lw	a4,-64(s0)
400006b4:	00e7a223          	sw	a4,4(a5) # f0000004 <_stack_start+0x6ffff6c4>
	return 0;	
400006b8:	00000793          	li	a5,0
}
400006bc:	00078513          	mv	a0,a5
400006c0:	03c12083          	lw	ra,60(sp)
400006c4:	03812403          	lw	s0,56(sp)
400006c8:	04010113          	addi	sp,sp,64
400006cc:	00008067          	ret

400006d0 <irqCallback>:
void irqCallback(){
400006d0:	ff010113          	addi	sp,sp,-16
400006d4:	00812623          	sw	s0,12(sp)
400006d8:	01010413          	addi	s0,sp,16

}
400006dc:	00000013          	nop
400006e0:	00c12403          	lw	s0,12(sp)
400006e4:	01010113          	addi	sp,sp,16
400006e8:	00008067          	ret
