/*****************************************************************************
*   @FILE p1_1001125790.s
*   This programme acts as simple calculator in assembly language.
*   Created by Ram Shrestha on 11/7/15.
*******************************************************************************/
.global main
.func main

main:
    BL _printf                         	@ Branch _printf procedure with return
    MOV R5, R0                          @ moves return value from R0 to R5
    BL _scanf           		@ branch to _scanf procedure with return
    MOV R6, R0                          @ move return value from R0 to R6
    BL _printf				@ branch to _printf procedure with return
    MOV R7, R0                          @ move return value from R0 to R7
    MOV R1, R5                          @ move R5 to R1
    MOV R3, R6                          @ move R6 to R3
    MOV R2, R7                          @ move R7 to R2
    BL _Compare                         @ branch to _Compare procedure with return
    MOV R1, R0                          @ move R0 to R1
    BL _reg_dump
    LDR R0, =Printf_Output              @ R0 contains formatted string address
    BL printf                           @ call printf
    B main                              @ call main (to form a loop)
    
_printf:
    MOV R4, LR                          @ store LR since printf call overwrites
    SUB SP, SP, #4                       @ make room for stack
    LDR R0, =printf_Prompt             @ RO contains formatted string address
    BL printf                           @ call printf
    LDR R0, =Input_Value                @ R0 contains formatted string address
    MOV R1, SP                          @ move SP to R1 to store entry of stack
    BL scanf                            @ call scanf
    LDR R0, [SP]                        @ load value at SP into R0
    ADD SP, SP, #4                      @ remove value from stack
    MOV PC, R4                          @ return
    
_scanf:
    MOV R4, LR                          @ store LR since printf call overwrites
    SUB SP, SP, #4                      @ make room for stack
    LDR R0, =scanf_Prompt		@ R0 contains formatted string address
    BL printf                           @ call printf
    LDR R0, =Input_Operator             @ R0 contains formatted string address
    MOV R1, SP                          @ move SP to R1 to store entry of stack
    BL scanf                            @ call scanf
    LDR R0, [SP]                        @ load value at SP into R0
    ADD SP, SP, #4                      @ remove value from stack
    MOV PC, R4                          @ return
    
_Compare:
    CMP R3, # '-'                       @ compare with the constant character '-'
    BEQ _Difference                     @ branch to equal handler
    CMP R3, # '+'                       @ compare with the constant character '+'
    BEQ _Sum                            @ branch to equal handler
    CMP R3, # '*'                       @ compare with the constant character '*'
    BEQ _Product                        @ branch to equal handler
    CMP R3, # 'M'                       @ compare with the constant character 'M'
    BEQ _Max                            @ branch to equal handler
   
_Difference:
    SUB R0, R1, R2                      @ subtract R2 from R1 and store the value in R0
    MOV PC, LR                          @ return

_Sum:
    ADD R0, R1, R2                      @ add R1 and R2 and store the value in R0
    MOV PC, LR                          @ return
    
_Product:                           
    MUL R0, R1, R2                      @ multiply R1 and R2 and store the value in R0
    MOV PC, LR                          @ return

_Max:
    CMP R1, R2                          @ compare R1 and R2 
    MOVGT R0, R1                        @ Move Greater Than
    MOVLT R0, R2                        @ Move Less Than
    MOV PC, LR                          @ return
    
_reg_dump:
    PUSH {LR}           @ backup registers
    PUSH {R0}           @ backup registers
    PUSH {R1}           @ backup registers
    PUSH {R2}           @ backup registers
    PUSH {R3}           @ backup registers
    
    PUSH {R14}          @ push registers for printing
    PUSH {R13}          @ push registers for printing
    PUSH {R12}          @ push registers for printing
    PUSH {R11}          @ push registers for printing
    PUSH {R10}          @ push registers for printing
    PUSH {R9}           @ push registers for printing
    PUSH {R8}           @ push registers for printing
    PUSH {R7}           @ push registers for printing
    PUSH {R6}           @ push registers for printing
    PUSH {R5}           @ push registers for printing
    PUSH {R4}           @ push registers for printing
    PUSH {R3}           @ push registers for printing
    PUSH {R2}           @ push registers for printing
    PUSH {R1}           @ push registers for printing
    PUSH {R0}           @ push registers for printing
	
    LDR R0,=debug_str   @ prepare register print
    MOV R1, #0          @ prepare R0 print
    POP {R2}            @ prepare R0 print
    MOV R3, R2          @ prepare R0 print
    BL printf           @ print R0 value prior to reg_dump call

    LDR R0,=debug_str   @ prepare register print
    MOV R1, #1          @ prepare R1 print
    POP {R2}            @ prepare R1 print
    MOV R3, R2          @ prepare R1 print
    BL printf           @ print R1 value prior to reg_dump call

    LDR R0,=debug_str   @ prepare register print
    MOV R1, #2          @ prepare R2 print
    POP {R2}            @ prepare R2 print
    MOV R3, R2          @ prepare R2 print
    BL printf           @ print R2 value prior to reg_dump call
 
    LDR R0,=debug_str   @ prepare register print
    MOV R1, #3          @ prepare R3 print
    POP {R2}            @ prepare R3 print
    MOV R3, R2          @ prepare R3 print
    BL printf           @ print R3 value prior to reg_dump call

    LDR R0,=debug_str   @ prepare register print
    MOV R1, #4          @ prepare R4 print
    POP {R2}            @ prepare R4 print
    MOV R3, R2          @ prepare R4 print
    BL printf           @ print R4 value prior to reg_dump call

    LDR R0,=debug_str   @ prepare register print
    MOV R1, #5          @ prepare R5 print
    POP {R2}            @ prepare R5 print
    MOV R3, R2          @ prepare R5 print
    BL printf           @ print R5 value prior to reg_dump call

    LDR R0,=debug_str   @ prepare register print
    MOV R1, #6          @ prepare R6 print
    POP {R2}            @ prepare R6 print
    MOV R3, R2          @ prepare R6 print
    BL printf           @ print R6 value prior to reg_dump call
 
    LDR R0,=debug_str   @ prepare register print
    MOV R1, #7          @ prepare R7 print
    POP {R2}            @ prepare R7 print
    MOV R3, R2          @ prepare R7 print
    BL printf           @ print R7 value prior to reg_dump call

    LDR R0,=debug_str   @ prepare register print
    MOV R1, #8          @ prepare R8 print
    POP {R2}            @ prepare R8 print
    MOV R3, R2          @ prepare R8 print
    BL printf           @ print R8 value prior to reg_dump call

    LDR R0,=debug_str   @ prepare register print
    MOV R1, #9          @ prepare R9 print
    POP {R2}            @ prepare R9 print
    MOV R3, R2          @ prepare R9 print
    BL printf           @ print R9 value prior to reg_dump call
    
    LDR R0,=debug_str   @ prepare register print
    MOV R1, #10          @ prepare R10 print
    POP {R2}            @ prepare R10 print
    MOV R3, R2          @ prepare R10 print
    BL printf           @ print R10 value prior to reg_dump call
    
    LDR R0,=debug_str   @ prepare register print
    MOV R1, #11         @ prepare R11 print
    POP {R2}            @ prepare R11 print
    MOV R3, R2          @ prepare R11 print
    BL printf           @ print R11 value prior to reg_dump call
    
    LDR R0,=debug_str   @ prepare register print
    MOV R1, #12         @ prepare R12 print
    POP {R2}            @ prepare R12 print
    MOV R3, R2          @ prepare R12 print
    BL printf           @ print R12 value prior to reg_dump call

    LDR R0,=debug_str   @ prepare register print
    MOV R1, #13         @ prepare R13 print
    POP {R2}            @ prepare R13 print
    MOV R3, R2          @ prepare R13 print
    BL printf           @ print R13 value prior to reg_dump call

    LDR R0,=debug_str   @ prepare register print
    MOV R1, #14         @ prepare R14 print
    POP {R2}            @ prepare R14 print
    MOV R3, R2          @ prepare R14 print
    BL printf           @ print R14 value prior to reg_dump call
    
    POP {R3}            @ restore register
    POP {R2}            @ restore register
    POP {R1}            @ restore register
    POP {R0}            @ restore regsiter
    POP {PC}            @ return
 
.data
debug_str:			.asciz 	    "R%-2d   0x%08X  %011d \n"
printf_Prompt: 		.asciz "Please enter an integer: "
Input_Value: 			.asciz "%d"
scanf_Prompt		.asciz "Please enter one of the operation code from (+,-,*,M): "
Input_Operator: 		.asciz "%s"
Printf_Output: 			.asciz "The output based on the entered operation code is : %d\n"
    

