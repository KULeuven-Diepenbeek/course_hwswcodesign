#!/bin/bash


extractImages.sh HWSWCD-images_100.drawio.pdf picorv32 toolflow1 toolflow2 testbench apb_peripheral apb counter apbcounter

for i in picorv32 toolflow1 toolflow2 testbench
do
    convert $i.pdf $i.png
    mv $i.png ../100
done


extractImages.sh HWSWCD-images_200.drawio.pdf pcpi_mul pcpi_hd

for i in pcpi_mul pcpi_hd
do
    convert $i.pdf $i.png
    rm $i.pdf
    mv $i.png ../200
done


extractImages.sh HWSWCD-images_300.drawio.pdf apb_peripheral apb counter apbcounter memmap

for i in apb_peripheral apb counter apbcounter memmap
do
    convert $i.pdf $i.png
    rm $i.pdf
    mv $i.png ../300
done

extractImages.sh HWSWCD-images_400.drawio.pdf flow interrupt sections sections_interrupt

for i in flow interrupt sections sections_interrupt
do
    convert $i.pdf $i.png
    rm $i.pdf
    mv $i.png ../400
done

extractImages.sh HWSWCD-images_500.drawio.pdf hash

for i in hash
do
    convert $i.pdf $i.png
    rm $i.pdf
    mv $i.png ../500
done


# extractImages.sh HWSWCD-images_x00.drawio.pdf xoodoo xoodoo_state sponge cyclist

# for i in xoodoo xoodoo_state sponge cyclist
# do
#     convert $i.pdf $i.png
#     rm $i.pdf
#     mv $i.png ../400
# done