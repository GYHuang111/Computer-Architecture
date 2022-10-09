.data 
num1: .word 1,2,3
numSize1: .word 3
first1: .word 1
num2: .word 6,2,7,3
numSize2: .word 4
first2: .word 4
num3: .word 5,6,7,8,9
numSize3: .word 5
first3: .word 2
nextline: .string "\n"
space: .string " "
.text
main:
    la a1,num1            #get num1 address
    la a2,numSize1        #get numSize1 address
    la a3,first1          #get first1 address
    lw a2,0(a2)           #a2 = numSize1 = 3
    lw a3,0(a3)           #a3 = first1 = 1
    li a4,0               #int i = 0
    li a5,0               #int count = 0
    li a6,3               #input set =3
    jal ra,decode.L1      #goto decode.L1
    la a1,num2            #get num2 address
    la a2,numSize2        #get numSize2 address
    la a3,first2          #get first2 address
    lw a2,0(a2)           #a2 = numSize2 = 4
    lw a3,0(a3)           #a3 = first2 = 4
    jal ra,decode.L1      #goto decode.L1
    la a1,num3            #get num3 address
    la a2,numSize3        #get numSize3 address
    la a3,first3          #get first3 address
    lw a2,0(a2)           #a2 = numSize3 = 5
    lw a3,0(a3)           #a3 = first3 = 2
decode.L1:
    add t0,a3,x0         
    sw t0,0(a4)           #result[0] = first
decode.L2:                #loop
    beq a4,a2,index_zero  #if i=numSize then goto index_zero   
    slli t0,a4,2          #a4*4
    add t2,t0,a1          #get num1[i]
    lw t1,0(t2)           #get num1[i] 
    lw t2,0(t0)           #get result[i]
    xor t1,t1,t2          #result[i] ^ num[i]
    addi t2,t0,4          #a4*4,k = i + 1
    sw t1,0(t2)           #result[k] = result[i] ^ num[i]
    addi a4,a4,1          #i++  
    j decode.L2           #goto decode.L2
index_zero:
    addi a4,x0,0          #i=0
print: 
    slli t0,a4,2          #a4*4
    lw a0,0(t0)           #get result[i]
    li a7,1               #systemcall print
    ecall                 #execute
    addi a4,a4,1          #i++
    la a0,space           #print " "
    li a7,4
    ecall
    ble a4,a2,print       #if i<numSize then goto print
    la a0,nextline        #nextline
    li a7,4
    ecall
    addi a5,a5,1          #count++
    beq a5,a6,exit        #excute all dataset
    li a4,0               #int i = 0
    jr ra
exit:
    li a7,10
    ecall
