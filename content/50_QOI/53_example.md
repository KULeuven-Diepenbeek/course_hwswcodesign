---
title: '53 Example'
weight: 53
draft: false
---

Here, an example is shown to help you understand how QOI (encoding) works. The data from the 8-by-8 sensor looks like shown below.

![Example image](/img/500/example.png)

## Header

The header is stictly defined:

* The first for bytes are the letters 'q', 'o', 'i', and 'f'. These letters have to be UTF-8 encoded first, which results in **0x716F6966**.
* The width of the image is stored as a 32-bit value: **0x00000008**.
* The height of the image is stored as a 32-bit value: **0x00000008**.
* Depending on whether or not an alpha channel is present, the number of channels is either 3 (for RGB) or 4 (for RGBA). This is stored in a single byte: **0x03**.
* The colorspace is also represented in a single byte: **0x00** for sRGB with linear alpha and 0x01 for an image where all channels are linear.

This makes the encoding of the header equal to<span style="font-weight: bold; background-color: orange"> 0x716F696600000008000000080300 </span>. Now we continue with the second row.

{{% notice note %}}
Both the channels and the colorspace fields are puely informative.
{{% / notice %}}

## Chunks

At the start, we assume that the previous values of R, G, and B (called **R_d**, **G_d**, and **B_d**) are all 0x0. The previous value for alpha (**A_d**) is 0xFF. The running array (**RA**) of width 64 is initialised on 0x0's. The current longest runs of repeating pixels is also initialised on -1 (**RLE**).


{{% multiHcolumn %}}
{{% column %}}
The pixel at (0,0) has value **0xFF0000FF**
{{% /column %}}
{{% column %}}
**1)&nbsp;** It is not the same as the previous values R_d, G_d, B_d and A_d<br/>
**2)&nbsp;** It is not present in the RA.<br/>
&nbsp; &nbsp; &nbsp;Nonetheless, we add it. H(R,G,B,A) = 50, so RA[50] = 0xFF0000FF.<br/>
**3)&nbsp;** Difference with previous pixels<br/>
&nbsp; &nbsp; &nbsp;dr = 0xFF - 0x00 = 0xFF (= -1) &nbsp; => &nbsp; b01<br/>
&nbsp; &nbsp; &nbsp;dg = 0x00 - 0x00 = 0x00 (=  0) &nbsp; => &nbsp; b10<br/>
&nbsp; &nbsp; &nbsp;db = 0x00 - 0x00 = 0x00 (=  0) &nbsp; => &nbsp; b10<br/>
<br/>
This chunk is hence encoded as b01 b01 b10 b10 = b01011010 =<span style="font-weight: bold; background-color: yellow"> 0x5A </span>.<br/>
R_d becomes 0xFF, G_d becomes 0x00, B_d becomes 0x00, A_d remains 0xFF.
{{% /column %}}
{{% /multiHcolumn %}}



{{% multiHcolumn %}}
{{% column %}}
The pixel at (1,0) has value **0xFF0000FF**
{{% /column %}}
{{% column %}}
**1)&nbsp;** It is the same as the previous values R_d, G_d, B_d and A_d, so this is run-length encoding. **RLE=0**<br/>
{{% /column %}}
{{% /multiHcolumn %}}

{{% multiHcolumn %}}
{{% column %}}
The pixel at (2,0) has value **0xFF0000FF**
{{% /column %}}
{{% column %}}
**1)&nbsp;** It is the same as the previous values R_d, G_d, B_d and A_d, so this is run-length encoding. **RLE=1**<br/>
{{% /column %}}
{{% /multiHcolumn %}}

{{% multiHcolumn %}}
{{% column %}}
The pixel at (3,0) has value **0xFF0000FF**
{{% /column %}}
{{% column %}}
**1)&nbsp;** It is the same as the previous values R_d, G_d, B_d and A_d, so this is run-length encoding. **RLE=2**<br/>
{{% /column %}}
{{% /multiHcolumn %}}

{{% multiHcolumn %}}
{{% column %}}
The pixel at (4,0) has value **0x00FF00FF**
{{% /column %}}
{{% column %}}
**1)&nbsp;** It is not the same as the previous values R_d, G_d, B_d and A_d. As there was a run length ongoing, this has to be recorded.<br/>
The chunks becomes: b11 b000010 = b11000010 =<span style="font-weight: bold; background-color: yellow"> 0xC2 </span>. RLE is reset to -1. <br/>
**2)&nbsp;** It is not present in the RA.<br/>
&nbsp; &nbsp; &nbsp;Nonetheless, we add it. H(R,G,B,A) = 45, so RA[48] = 0x00FF00FF.<br/>
**3)&nbsp;** Difference with previous pixels<br/>
&nbsp; &nbsp; &nbsp;dr = 0x00 - 0xFF = 0x01 (=  1) &nbsp; => &nbsp; b11<br/>
&nbsp; &nbsp; &nbsp;dg = 0xFF - 0x00 = 0xFF (= -1) &nbsp; => &nbsp; b01<br/>
&nbsp; &nbsp; &nbsp;db = 0x00 - 0x00 = 0x00 (=  0) &nbsp; => &nbsp; b10<br/>
<br/>
This chunk is hence encoded as b01 b11 b01 b10 = b01110110 =<span style="font-weight: bold; background-color: yellow"> 0x76 </span>.<br/>
R_d becomes 0xFF, G_d becomes 0x00, B_d becomes 0x00, A_d remains 0xFF.
{{% /column %}}
{{% /multiHcolumn %}}

{{% multiHcolumn %}}
{{% column %}}
The pixel (5,0), (6,0), and (7,0) are handled similarly to (1,0), (2,0), and (3,0).
{{% /column %}}
{{% column %}}
**1)&nbsp;** It is the same as the previous values R_d, G_d, B_d and A_d, so this is run-length encoding. **RLE=0, RLE=1, RLE=2**<br/>
{{% /column %}}
{{% /multiHcolumn %}}

This makes the encoding of the first row, currently, equal to <span style="font-weight: bold; background-color: orange"> 0x5AC276 </span>. Now we continue with the second row.
<hr/>
{{% multiHcolumn %}}
{{% column %}}
The pixel at (0,1) has value **0xFF0000FF**
{{% /column %}}
{{% column %}}
**1)&nbsp;** It is not the same as the previous values R_d, G_d, B_d and A_d. As there was a run length ongoing, this has to be recorded.<br/>
The chunks becomes: b11 b000010 = b11000010 =<span style="font-weight: bold; background-color: yellow"> 0xC2 </span>. RLE is reset to -1. <br/>
**2)&nbsp;** It **is** present in the RA. H(R,G,B,A) = 50, and RA[50] **==** 0xFF0000FF.<br/>
This chunk is hence encoded as b00 b110010 = b00110010 =<span style="font-weight: bold; background-color: yellow"> 0x32 </span>.<br/>
{{% /column %}}
{{% /multiHcolumn %}}

{{% multiHcolumn %}}
{{% column %}}
The pixels at (1,1), (2,1), and (3,1) are handled similar as before.
{{% /column %}}
{{% column %}}
&nbsp;
{{% /column %}}
{{% /multiHcolumn %}}

{{% multiHcolumn %}}
{{% column %}}
The pixel at (4,1) has value **0x00FF00FF**
{{% /column %}}
{{% column %}}
**1)&nbsp;** It is not the same as the previous values R_d, G_d, B_d and A_d. As there was a run length ongoing, this has to be recorded.<br/>
The chunks becomes: b11 b000010 = b11000010 =<span style="font-weight: bold; background-color: yellow"> 0xC2 </span>. RLE is reset to -1. <br/>
**2)&nbsp;** It **is** present in the RA. H(R,G,B,A) = 48, and RA[48] **==** 0x00FF00FF.<br/>
This chunk is hence encoded as b00 b110000 = b00110000 =<span style="font-weight: bold; background-color: yellow"> 0x30 </span>.<br/>
{{% /column %}}
{{% /multiHcolumn %}}

{{% multiHcolumn %}}
{{% column %}}
The pixels at (5,1), (6,1), and (7,1) are handled similar as before.
{{% /column %}}
{{% column %}}
&nbsp;
{{% /column %}}
{{% /multiHcolumn %}}

This makes the encoding of the second row, currently, equal to <span style="font-weight: bold; background-color: orange"> 0xC232C230 </span>.
<hr/>

The third and fourth row in the image are handled identically to row 2.
This makes the encoding of these rows, currently, equal to <span style="font-weight: bold; background-color: orange"> 0xC232C2300xC232C230 </span>.
<hr/>

{{% multiHcolumn %}}
{{% column %}}
The pixel at (0,4) has value **0x0000FFFF**
{{% /column %}}
{{% column %}}
**1)&nbsp;** It is not the same as the previous values R_d, G_d, B_d and A_d As there was a run length ongoing, this has to be recorded.<br/>
The chunks becomes: b11 b000010 = b11000010 =<span style="font-weight: bold; background-color: yellow"> 0xC2 </span>. RLE is reset to -1. <br/>
**2)&nbsp;** It is not present in the RA.<br/>
&nbsp; &nbsp; &nbsp;Nonetheless, we add it. H(R,G,B,A) = 46, so RA[46] = 0x0000FFFF.<br/>
**3)&nbsp;** Difference with previous pixels<br/>
&nbsp; &nbsp; &nbsp;dr = 0x00 - 0x00 = 0x00 (=  0) &nbsp; => &nbsp; b10<br/>
&nbsp; &nbsp; &nbsp;dg = 0x00 - 0xFF = 0x01 (=  1) &nbsp; => &nbsp; b11<br/>
&nbsp; &nbsp; &nbsp;db = 0xFF - 0x00 = 0x00 (= -1) &nbsp; => &nbsp; b01<br/>
<br/>
This chunk is hence encoded as b01 b10 b11 b01 = b01101101 =<span style="font-weight: bold; background-color: yellow"> 0x6D </span>.
{{% /column %}}
{{% /multiHcolumn %}}

{{% multiHcolumn %}}
{{% column %}}
The pixels at (1,4), (2,4), and (3,4) are handled similar as before.
{{% /column %}}
{{% column %}}
&nbsp;
{{% /column %}}
{{% /multiHcolumn %}}

{{% multiHcolumn %}}
{{% column %}}
The pixel at (4,4) has value **0x7F7F7FFF**
{{% /column %}}
{{% column %}}
**1)&nbsp;** It is not the same as the previous values R_d, G_d, B_d and A_d As there was a run length ongoing, this has to be recorded.<br/>
The chunks becomes: b11 b000010 = b11000010 =<span style="font-weight: bold; background-color: yellow"> 0xC2 </span>. RLE is reset to -1. <br/>
**2)&nbsp;** It is not present in the RA.<br/>
&nbsp; &nbsp; &nbsp;Nonetheless, we add it. H(R,G,B,A) = 38, so RA[38] = 0x7F7F7FFF.<br/>
**3)&nbsp;** Difference with previous pixels<br/>
&nbsp; &nbsp; &nbsp;dr = 0x7F - 0x00 = 0x7F => &nbsp; *not defined*<br/>
&nbsp; &nbsp; &nbsp;dg = 0x7F - 0x00 = 0x7F => &nbsp; *not defined*<br/>
&nbsp; &nbsp; &nbsp;db = 0x7F - 0xFF = 0x80 => &nbsp; *not defined*<br/>
**4)&nbsp;** Difference with previous pixel's green<br/>
&nbsp; &nbsp; &nbsp;dg = 0x7F - 0x00 = 0x7F => &nbsp; *not defined*<br/>
&nbsp; &nbsp; &nbsp;...
**5)&nbsp;** RGB<br/>
&nbsp; &nbsp; &nbsp;A_d and a are equal => b11111110 x7F x7F x7F<br/>
This chunk is hence encoded as <span style="font-weight: bold; background-color: yellow"> 0xFE7F7F7F </span>.
{{% /column %}}
{{% /multiHcolumn %}}

{{% multiHcolumn %}}
{{% column %}}
The pixels at (5,4), (6,4), and (7,4) are handled similar as before.
{{% /column %}}
{{% column %}}
&nbsp;
{{% /column %}}
{{% /multiHcolumn %}}

This makes the encoding of the fifth row, currently, equal to <span style="font-weight: bold; background-color: orange"> 0xC26DC2FE7F7F7F </span>.
<hr/>


{{% multiHcolumn %}}
{{% column %}}
The pixel at (0,5) has value **0x0000FFFF**
{{% /column %}}
{{% column %}}
**1)&nbsp;** It is not the same as the previous values R_d, G_d, B_d and A_d As there was a run length ongoing, this has to be recorded.<br/>
The chunks becomes: b11 b000010 = b11000010 =<span style="font-weight: bold; background-color: yellow"> 0xC2 </span>. RLE is reset to -1. <br/>
**2)&nbsp;** It **is** present in the RA. H(R,G,B,A) = 46, and RA[46] **==** 0x0000FFFF.<br/>
This chunk is hence encoded as b00 b101110 = b00101110 =<span style="font-weight: bold; background-color: yellow"> 0x2E </span>.<br/>
{{% /column %}}
{{% /multiHcolumn %}}

{{% multiHcolumn %}}
{{% column %}}
The pixels at (1,5), (2,5), and (3,5) are handled similar as before.
{{% /column %}}
{{% column %}}
&nbsp;
{{% /column %}}
{{% /multiHcolumn %}}

{{% multiHcolumn %}}
{{% column %}}
The pixel at (4,5) has value **0x7F7F7FFF**
{{% /column %}}
{{% column %}}
**1)&nbsp;** It is not the same as the previous values R_d, G_d, B_d and A_d As there was a run length ongoing, this has to be recorded.<br/>
The chunks becomes: b11 b000010 = b11000010 =<span style="font-weight: bold; background-color: yellow"> 0xC2 </span>. RLE is reset to -1. <br/>
**2)&nbsp;** It **is** present in the RA. H(R,G,B,A) = 38, and RA[38] **==** 0x7F7F7FFF.<br/>
This chunk is hence encoded as b00 b100110 = b00100110 =<span style="font-weight: bold; background-color: yellow"> 0x26 </span>.<br/>
{{% /column %}}
{{% /multiHcolumn %}}

{{% multiHcolumn %}}
{{% column %}}
The pixels at (5,5), (6,5), and (7,5) are handled similar as before.
{{% /column %}}
{{% column %}}
&nbsp;
{{% /column %}}
{{% /multiHcolumn %}}

This makes the encoding of the fifth row, currently, equal to <span style="font-weight: bold; background-color: orange"> 0xC22EC226 </span>.
<hr/>

The final 2 rows are similarly processed as the previous one making the enconding equal to <span style="font-weight: bold; background-color: orange"> 0xC22EC226C22EC226 </span>.
<hr/>

{{% notice note %}}
<b>BEWARE!!</b><br/>
There is still something in the RLE!! This is however handled equally as above. This means another, final, <span style="font-weight: bold; background-color: orange">&nbsp;0xC2 </span>&nbsp;needs to be added.
{{% /notice %}}


## End marking

The end marker is a fixed 8-byte value: <span style="font-weight: bold; background-color: orange"> 0x0000000000000001 </span>.

# Results of the example

The result of the QOI encoding of the image above hence is:

<span style="font-weight: bold; background-color: orange">&nbsp;0x716F696600000008000000080300 0x5AC276 0xC232C230 0xC232C230 0xC232C230 0xC26DC2FE7F7F7F 0xC22EC226 0xC22EC226C22EC226 0xC2 0x0000000000000001&nbsp;</span>

<span style="font-weight: bold; background-color: orange">&nbsp;716F6966000000080000000803005AC276C232C230C232C230C232C230C26DC2FE7F7F7FC22EC226C22EC226C22EC226C20000000000000001&nbsp;</span>

This encoded result has a total size of **57 bytes**. If all the 64 pixels (8 by 8) would have to be stored in raw data, with an alpha channel, this would result in **256 bytes**. Without an alpha channel, this would result in **192 bytes** which is a reduction of **70%**!!

If we assume that 1 image is to be recorded every 40 ms, this would result in 25 images per second. This is approximately the framerate of video. If the sensor would make **one image every 40 ms**, it also has to be encoded on that speed. In the simulation, as shown below, the encoding of a single image roughly takes 190000 ns. If we *<u>extrapolate</u>* this result, we get: 190000 ns / 64 pixels = 2.97 µs per pixel, and thus a **480p** image would take 640\*480\*3 µs = 307200*3 µs = 912384 µs = **912.4 ms**.

![Image of simulation](/img/500/simulation.png)

**... and this is an extrapolation!!**

It is hard to give a fixed duration for the encoding of single image. An image of 307'200 consecutive white pixels will be done more quickly than 307'200 random pixels.

