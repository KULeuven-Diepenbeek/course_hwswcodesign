---
title: '2.3 - Using TCNT'
weight: 23
pre: "<i class='fas fa-book'></i> "
---

{{% multiHcolumn %}}
{{% column %}}
As an example for using the timer counter, it is going to be used to measure the time of a matrix multiplication. The matrices are fixed in size and all have a 2x2 dimension.<br/><br/> This image refreshes your memory on matrix multiplication (in case you need it).
{{% /column %}}
{{% column %}}
{{% figure src="/img/20/matrix_mult.png" title=" " %}}
{{% /column %}}
{{% /multiHcolumn %}}

### Regular multiplication

The first problem that arises is the normal **multiplication**. Given the fact that the RISC-V still has RV32i configuration, this means that there is **no multiplier** present. Luckily this operation can also be implemented in software. Let us tend to this first.

{{% multiHcolumn %}}
{{% column %}}
{{< include_file "/src/20/23_swmult.S" "S" >}}
{{% /column %}}
{{% column %}}
This assembly code implements the multiplication in software: **z=x*y**.<br/> Before starting the number crunching a check is done to verify that the first factor is non-zero. In case the first function argument is 0x0, a 0x0 is returned. The value of **a0** serves both as an argument and return value here.
{{% notice tip %}}
Remember that function arguments are typically handed over through the **a0-a7** registers.<br/>The return value typically goes through **a0** and **x1** contains the return address. 
{{% /notice %}}
Next, the temporary registers are initialised to x-1 and y. In case the subtraction, simply copy over y to **a0** and return.<br/>
Finally, keep adding y to **t1** and decrementing **t0** for as long as **to** is not equal to zero.
{{% /column %}}
{{% /multiHcolumn %}}

{{% multiHcolumn %}}
{{% column %}}
The assembly code to perform multiplication can be added in the **start.S** file. The **sw_mult()** function can be called from C-code. To indicate to the linker that this function is callable from outside this file, the following line needs to be added (in the beginnen of **start.S**)
```S
.global sw_mult
```
{{% /column %}}
{{% column %}}
To be usable in the C-code, the **sw_mult()** function needs to be declared. The keyword **extern** that is added, indicates that this function will be found at link time.
```C
extern unsigned int sw_mult(unsigned int x, unsigned int y);
```
{{% /column %}}
{{% /multiHcolumn %}}

### Matrix multiplication

{{% multiHcolumn %}}
{{% column %}}
With regular multiplication sorted, focus can be moved to the matrix multiplication. The easiest way to work with matrices is to define a new type in C: **matrix_t**. This type has 4 elements which are all unsigned int.

With this new type, implementing the matrix multiplication function becomes fairly easy. This example takes two arguments: matrix x and matrix y. A new matrix is defined and each of its four elements is calculated as it should, using the **sw_mult()** function that is implemented in assembly.

<!-- Different types for notices are: info (yellow), tip (green), warning (red), note (blue)-->
{{% notice warning %}}
Compiling this on your laptop will (probably) work. <br/>**Cross-compiling this for bare-metal give you compile errors!!**
{{% /notice %}}
{{% /column %}}
{{% column %}}
```C
struct matrix_t{
	unsigned int a00;
	unsigned int a10;
	unsigned int a01;
	unsigned int a11;
};

struct matrix_t matrix_mult(struct matrix_t x, struct matrix_t y) {
	struct matrix_t z;
	z.a00 = sw_mult(x.a00, y.a00) + sw_mult(x.a10, y.a01);
	z.a10 = sw_mult(x.a00, y.a10) + sw_mult(x.a10, y.a11);
	z.a01 = sw_mult(x.a01, y.a00) + sw_mult(x.a11, y.a01);
	z.a11 = sw_mult(x.a01, y.a10) + sw_mult(x.a11, y.a11);
	return z;
}
```
{{% /column %}}
{{% /multiHcolumn %}}

> /opt/riscv/lib/gcc/riscv32-unknown-elf/14.2.0/../../../../riscv32-unknown-elf/bin/ld: /opt/riscv/lib/gcc/riscv32-unknown-elf/14.2.0/../../../../riscv32-unknown-elf/lib/libc.a(libc_a-memcpy.o): can't link double-float modules with soft-float modules<br/>
>/opt/riscv/lib/gcc/riscv32-unknown-elf/14.2.0/../../../../riscv32-unknown-elf/bin/ld: failed to merge target specific data of file /opt/riscv/lib/gcc/riscv32-unknown-elf/14.2.0/../../../../riscv32-unknown-elf/lib/libc.a(libc_a-memcpy.o) <br/>
>collect2: error: ld returned 1 exit status<br/>
>make: *** [Makefile:54: firmware.elf] Error 1<br/>

From the compiler outcome it can be learned that the linker has an issue: it cannot find the memcpy() function. This is exactly the reason why native compiling on a machine works and cross-compiling for bare-metal doesn't. In a bare-metal environment, there are **no libraries**. So there is also no memcpy() function.

*"Why is this function required?"*, I hear you ask.

For those with good memories and/or a bunch of C-experience (or are quick to {{% google %}}), you might know that C functions work with **pass-by-value** for the arguments. The function receives a copy of the argument’s value, meaning changes made to the parameter within the function do not affect the original variable. This implies that a **copy** is made of both matrices **x** and **y**. Also the return value suffers from this. The object that is made, only lives on the **stack**. When it is returned, the object on the stack is copied field-by-field to the struct that is declared in the main function. For these copy-operations, the memcpy() function is required.

Luckily engineers are trained to fix problems:

```C
void matrix_mult(struct matrix_t * z, struct matrix_t * x, struct matrix_t * y) {
	z->a00 = sw_mult(x->a00, y->a00) + sw_mult(x->a10, y->a01);
	z->a10 = sw_mult(x->a00, y->a10) + sw_mult(x->a10, y->a11);
	z->a01 = sw_mult(x->a01, y->a00) + sw_mult(x->a11, y->a01);
	z->a11 = sw_mult(x->a01, y->a10) + sw_mult(x->a11, y->a11);
}
```

By writing the matrix_mult() function in a slightly different form, the need for memcpy() can be avoided.

### Measuring clock cycles

{{% multiHcolumn %}}
{{% column %}}
```C
	struct matrix_t m, n, o;
	
	m.a00 = 1; n.a00 = 5;
	m.a10 = 2; n.a10 = 6;
	m.a01 = 3; n.a01 = 7;
	m.a11 = 4; n.a11 = 8;

	TCNT_clear();
	TCNT_start();
	matrix_mult(&o, &m, &n);
	TCNT_stop();
	tcnt = TCNT_VAL;
	print_dec(tcnt);

```
{{% /column %}}
{{% column %}}
It is at this point, the timer/counter will be used again. Before the matrix multiplication is done, the timer/counter is cleared and started. Right after the multiplication, it is stopped. Finally, the value of the counter is fetched and printed.

<!-- Different types for notices are: info (yellow), tip (green), warning (red), note (blue)-->
{{% notice note %}}
How do you interpret this value?
{{% /notice %}}
{{% /column %}}
{{% /multiHcolumn %}}