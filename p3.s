/********************************************************************************************
*   @FILE p3_1001125790.s                                                                   *
*   This programme populates the fixed size integer array of 20 elements and sort them in   *
*   acsending order.                                                                        *
*   Created by Ram Shrestha on 12/02/15.                                                    *
*********************************************************************************************/
.global main
.func main
   
main:
    BL _scanf
    MOV R7, R0
    MOV R0, #0              @ initialze index variable
    
    
writeloop:
    CMP R0, #20             @ check to see if we are done iterating
    BEQ writedone           @ exit loop if done
    LDR R1, =array_a        @ get address of array_a
    LSL R2, R0, #2          @ multiply index*4 to get array offset
    ADD R2, R1, R2          @ R2 now has the element address
    ADD R8, R7, R0          @ R8 = n+i
    STR R8, [R2]            @ write the address of a[i] to a[i]
    ADD R2, R2, #4
    ADD R8, R8, #1
    NEG R8, R8
    ADD R0, R0, #2          @ increment index
    STR R8, [R2]
    B   writeloop           @ branch to next loop iteration
writedone:
    MOV R0, #0              @ initialze index variable
    
readloop:
    CMP R0, #20             @ check to see if we are done iterating
    BEQ readdone            @ exit loop if done
    LDR R1, =array_a        @ get address of array_a
    LSL R2, R0, #2          @ multiply index*4 to get array offset
    ADD R2, R1, R2          @ R2 now has the element address
    LDR R1, [R2]            @ read the array at address  
    PUSH {R0}               @ backup register before printf
    PUSH {R1}               @ backup register before printf
    PUSH {R2}               @ backup register before printf
    MOV R2, R1              @ move array value to R2 for printf
    MOV R1, R0              @ move array index to R1 for printf
    BL  _printf             @ branch to print procedure with return
    POP {R2}                @ restore register
    POP {R1}                @ restore register
    POP {R0}                @ restore register
    ADD R0, R0, #1          @ increment index
    B   readloop            @ branch to next loop iteration
    
readdone:
    B _exit                 @ exit if done


_printf:
    PUSH {LR}               @ store the return address
    LDR R0, =printf_str     @ R0 contains formatted string address
    BL printf               @ call printf
    POP {PC}                @ restore the stack pointer and return

_scanf:
  PUSH {LR}                 @ store LR since scanf call overwrites
  SUB SP, SP, #4            @ make room on stack
  LDR R0, =scanf_str        @ R0 contains address of format string
  MOV R1, SP                @ move SP to R1 to store entry on stack
  BL scanf                  @ call scanf
  LDR R0, [SP]              @ load value at SP into R0
  ADD SP, SP, #4            @ restore the stack pointer
  POP {PC}                  @ return


_exit:  
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #21             @ print string length
    LDR R1, =exit_str       @ string at label exit_str:
    SWI 0                   @ execute syscall
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall

   
.data

.balign 4
array_a:              .skip       80
array_b:              .skip       80
printf_str:           .asciz      "array_a[%d] = %d     array_b = %d\n"
scanf_str:             .asciz      "Please enter an integer"
exit_str:             .ascii      "Terminating program.\n"
