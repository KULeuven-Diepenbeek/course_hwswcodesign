---
title: '51 Digital image'
weight: 51
draft: false
---

Images are everywhere. When looking at digital images (as in: not for printing) every pixel of the image has pixelvalue. Typically, the light that is generated in a pixel is composed of <span style="color: red">red</span> light, <span style="color: green">green</span> light, and <span style="color: blue">blue</span> light, hence **RGB**. To make photos or movies, some device needs to *capture* the light. This is done in an image sensor. For the sake of completeness, it is mentioned that there two main types of sensors: CCD and CMOS.

{{% multiHcolumn %}}
{{% column %}}

These sensors have receptors that *record* the light. The output of the sensor consists of values how much R, G, and B light is measured. This results in RGB values for each pixel. The **more pixels** that are available, the **better the quality** of the image is. In the figure, the left side has a 12 by 9 resolution and the right has a 24 by 18 resolution.


If we do some quick math, we come to the following. 

* let's assume each R, G, and B value is represented in a **single byte**
* every pixel, hence, is 3x1 byte = **3 bytes**
* the **left** resolution has 12x9 = 108 pixels
* the **right** resolution has 24x18= 432 pixels
* the left image thus has 108 pixels x 3byte/pixel = **324 bytes**
* the right image thus has 108 pixels x 3byte/pixel = **1296 bytes**

It is not hard to see that the larger the resolution, the more bytes are required to store the images.

{{% /column %}}

{{% column %}}
![pixelated circle](/img/500/circle.png)
{{% /column %}}
{{% /multiHcolumn %}}

### Color depth

In the example above, it was assumed that every pixel is stored in 3 bytes, one for each color. This boils down to 24 bits per pixel (bpp). This is known as **True color** and, as of 2018, this is used by most phone displays and computers. With true color, 2<sup>24</sup> colors can be displayed, or **16'777'216 colors**.

### The alpha channel

In computer graphics, it is sometimes desireable to have a *transparent* background. Since the late 1970's there is the concept of **an alpha channel**. This is a value that indicates how opaque a pixel is: entirely transparent (0) or entirely opaque (1). This alpha value is also stored with the R, G, and B values of the pixel. Up until now, a single pixel used 24 bits. With the addition of an 8-bit alpha channel, the total number of bits per pixels is 32. **Cool**, a power of 2 :smiley:


## Resolutions

The images above serve to illustrate the concept of pixels and resolutions. Of course there are predefined resolutions. Some of the most well known resoltions (width x height) are listed here:

{{% multiHcolumn %}}
{{% column %}}

* **SD**, also known as **480p**, has a dimension of <u>640x480</u>
* **HD**, also known as **720p**, has a dimension of <u>1280x720</u>
* **Full HD**, also known as **1080p**, has a dimension of <u>1920x1080</u>
* **Quad HD**, also known as **2K**, has a dimension of <u>2560x1440</u>
* **Ultra HD**, also known as **4K**, has a dimension of <u>4096x2160</u>
* **Full Ultra HD**, also known as **8K**, has a dimension of <u>7680x4320</u>

{{% /column %}}

{{% column %}}
![Resolutoins](/img/500/resolutions.png)
{{% /column %}}
{{% /multiHcolumn %}}

This table calculates how many bytes are required to store an image of a certain resolution, given that every pixel is represented by 4 bytes. Take a look at that Full Ultra HD file: 132'710'400 bytes. **That is 132 MB!!**