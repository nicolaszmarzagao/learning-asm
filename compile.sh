#!/bin/bash

echo "running nasm..."
nasm -f elf64 $1.asm -o ./build/$1.o
if [ $? -ne 0 ]; then
    echo "NASM failed"
    exit 1
fi

echo "running linker..."
ld ./build/$1.o -o ./build/$1
if [ $? -ne 0 ]; then
    echo "Linking failed"
    exit 1
fi

echo "running program:"
echo "---"
./build/$1
echo "---"
