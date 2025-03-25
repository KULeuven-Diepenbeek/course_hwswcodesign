---
title: '5.4 Project'
weight: 54
pre: "<i class='fas fa-pen'></i> "
---

The project within this course will have you designing an HW/SW codesign that encodes sensor data to a QOI encoded image. The resulting design would look something like shown below.

![Example image](/img/50/project.png)

## Goals

This project is to be achieved in two steps: 

1. a software-only version, and 
0. a HW/SW codesign.

This first version (SW-only) will set the reference. Additionally, this will help you in understanding the encoding scheme. The result of the first version will be a working implementation. This will allow you to *run the numbers* (latency, resource usage, throughput, ...).

When the first version is done, optimisations are chosen and you'll set of to make the HW/SW codesign. You can use which ever technique you think is best for obtaining your optimisations.

{{% multiHcolumn %}}
{{% column %}}
Here are a number of resources that might come in handy:
{{% /column %}}
{{% column %}}
* Link to the [QOI specification](https://qoiformat.org/qoi-specification.pdf)
* Example image in: ['sensor-data-format'](https://github.com/KULeuven-Diepenbeek/course_hwswcodesign/blob/master/src/project/data/example_image.dat), [png](https://github.com/KULeuven-Diepenbeek/course_hwswcodesign/blob/master/src/project/data/example_image.png), and in [qoi](https://github.com/KULeuven-Diepenbeek/course_hwswcodesign/blob/master/src/project/data/example_image.qoi)
{{% /column %}}
{{% /multiHcolumn %}}

## Deadlines AY2024-2025

* <u>March 25th:</u> work on software 
* <u>April 1st:</u> **no course**
* <u>April 22nd:</u> deadline for software version + start HW/SW codesign
* <u>April 30th:</u> work on HW/SW codesign
* <u>May 6th:</u> work on HW/SW codesign
* <u>May 13th:</u> **Presentations**

## Template

```C
#include <stdio.h>
#include <stdint.h>

#define C_WIDTH 8
#define C_HEIGHT 8


void initialise(uint8_t r[C_WIDTH][C_HEIGHT], uint8_t g[C_WIDTH][C_HEIGHT], uint8_t b[C_WIDTH][C_HEIGHT], uint8_t a[C_WIDTH][C_HEIGHT]) {
    uint8_t w, h;

    for(h=0;h<C_HEIGHT/2;h++) {
        for(w=0;w<C_WIDTH/2;w++) {
            r[h][w] = 255; g[h][w] = 0; b[h][w] = 0; a[h][w] = 255;
        }
        for(w=C_WIDTH/2;w<C_WIDTH;w++) {
            r[h][w] = 0; g[h][w] = 255; b[h][w] = 0; a[h][w] = 255;
        }
    }
    for(h=C_HEIGHT/2;h<C_HEIGHT;h++) {
        for(w=0;w<C_WIDTH/2;w++) {
            r[h][w] = 0; g[h][w] = 0; b[h][w] = 255; a[h][w] = 255;
        }
        for(w=C_WIDTH/2;w<C_WIDTH;w++) {
            r[h][w] = 127; g[h][w] = 127; b[h][w] = 127; a[h][w] = 255;
        }
    }
}

int main(void) {

    uint8_t r[C_HEIGHT][C_WIDTH];
    uint8_t g[C_HEIGHT][C_WIDTH];
    uint8_t b[C_HEIGHT][C_WIDTH];
    uint8_t a[C_HEIGHT][C_WIDTH];

    uint8_t r_prev = 0;
    uint8_t g_prev = 0;
    uint8_t b_prev = 0;
    uint8_t a_prev = 255;

    uint8_t dr, dg, db;


    int8_t rle = -1;
    uint32_t running_array[64];
    uint8_t rv;
    uint8_t index;
    uint32_t value;

    /* Sanity check */
    if((C_WIDTH % 2) || (C_HEIGHT % 2)) {
        printf("ERROR: W or H not even");
        return 1;
    }

    /* Initialisation */
    initialise(r, g, b, a);
    for(uint8_t i=0;i<64;i++) {
        running_array[i] = 0;
    }

    /* Loop over pixels */
    for(uint8_t h=0;h<C_HEIGHT;h++) {
        for(uint8_t w=0;w<C_WIDTH;w++) {

            /* Do something useful here */
            
        }
    }

    return 0;
}

```