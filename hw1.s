.global main
.func main

main:
  BL _prompt                  @branch to prompt procedure with return
  BL _scanf                   @branch to _scanf procedure with return
  MOV R6, R0                  @move return value R0 to argument register R1
  BL _getchar                 @branch to _getchar procedure with return
  BL _scanf                   @branch to scanf_procedure with return
  MOV R8, R0                  @move return value R0 to argument register R2
  
  BL printf_operator          @branch to _prompt procedure with return
  MOV R3, R0                  @move return value R0 to argument register R2
  
  MOV R1, R6                  @move value to argument register R1  
  MOV R2, R8                  @move value to argument register R2    
  
  BL _compare                 @branch to _compare with return              
  MOV R1, R0                  @move return value R0 to argument register R1      
  BL printf_statement            @branch to printf_result with return
  B main                      @branch to main procedure for loop

  
@_scanf procedure is procedure which takes user input and store at R0
_scanf:                        
  PUSH {LR }                  @store LR since scanf call overwrites          
  SUB SP, SP, #4              @makes room at stack
  LDR R0, =scanf_statement    @R0 contains address of scanf_statement
  MOV R1, SP                  @move SP to R1 to store entry on stack
  BL scanf                    @call scanf procedure
  LDR R0, [SP]                @load value into R0 from SP
  ADD SP, SP, #4              @restore the stack pointer
  POP {PC}                    @return
  
@printf_result procedure prints string at printf_statement 
_printf:
  MOV R4, LR                  @store LR since printf call overwrites
  LDR R0, =printf_statement   @R0 contains address of printf_statement  
  MOV R1, R1                  @R1 contains printf argument
  BL printf                   @call printf procedure
  MOV PC, R4                  @return

@_SUM procedure Adds registers R1 and R2, returning result in register R0
_SUM:
  ADD R0, R1, R2              @Adds registers R1 and R2, returning result in register R0
  MOV PC, LR                  @return
  
@_DIFFERENCE procedure Subtracts register R2 from R1, returning result in register R0
_DIFFERENCE:
  SUB R0, R1, R2              @Subtracts register R2 from R1, returning result in register R0
  MOV PC, LR                  @return  
 
@_PRODUCT procedure Multiplies registers R1 and R2, returning the result in register R0.
_PRODUCT:
  MUL R0, R1, R2              @Multiplies registers R1 and R2, returning the result in register R0.      
  MOV PC, LR                  @return    
  
@_MAX procedure Compares registers R1 and R2, returning the maximum of the two values in R0 
_MAX:  
  CMP R1, R2                  @Compares registers R1 and R2,      
  MOVGT R0, R1                @move greater than          
  MOVLT R0, R2                @move less than        
  MOV PC, LR                  @return        
 
@_getchar procedure 
_getchar:
  MOV R7, #3                  @write syscall, 3                      
  MOV R0, #0                  @input stream from monitor, 0          
  MOV R2, #1                  @read a single character            
  LDR R1, =operation_type     @store the character in data memory          
  SWI 0                       @execute the system call        
  LDR R0, [R1]                @move the character to the return register R0        
  AND R0, #0xFF               @mask out all but the lowest 8 bits      
  MOV PC, LR                  @return          

@_prompt procedure prompts with user with print statement to input character for operation   
_prompt:
  MOV R7, #4                  @write syscall, 4                
  MOV R0, #1                  @output stream to monitor, 1
  MOV R2, #100                @length of print string      
  LDR R1, =prompt_str         @string at label prompt_str          
  SWI 0                       @execute syscall        
  MOV PC, LR                  @return                        
    
@_compare procedure compares the user input character and perfroms the operation    
_compare:
  CMP R3, #'+'                    @compare the user input with '+'   
  BEQ _ADD                        @branch to equal handler, add_operation      
  CMP R3, #'-'                    @compare the user input with '-'        
  BEQ _DIFFERENCE                 @branch to equal handler, subtraction_operation      
  CMP R3, #'*'                    @compare the user input with '*'           
  BEQ _PRODUCT                    @branch to equal handler, multiplication_operation       
  CMP R3, #'M'                    @compare the user input with 'M'      
  BEQ _MAX                        @branch to equal handler, compare_max 
  BNE main                        @brach to not equal handler, main procedure
  MOV PC, R4                      @return 
_reg_dump:
  PUSH {LR}                       @ backup registers
  PUSH {R0}                       @ backup registers
  PUSH {R1}                       @ backup registers
  PUSH {R2}                       @ backup registers
  PUSH {R3}                       @ backup registers
  
  
  PUSH {R8}                       @ push registers for printing
  PUSH {R7}                       @ push registers for printing
  PUSH {R6}                       @ push registers for printing
  PUSH {R5}                       @ push registers for printing
  PUSH {R4}                       @ push registers for printing
  PUSH {R3}                       @ push registers for printing
  PUSH {R2}                       @ push registers for printing
  PUSH {R1}                       @ push registers for printing
  PUSH {R0}                       @ push registers for printing
	
	
	  LDR R0,=debug_str            @ prepare register print
	  MOV R1, #0                   @ prepare R0 print
	  POP {R2}                     @ prepare R0 print
	  MOV R3, R2                   @ prepare R0 print
	  BL printf                    @ print R0 value prior to reg_dump call
	  
	  LDR R0,=debug_str            @ prepare register print
	  MOV R1, #1                   @ prepare R1 print
	  POP {R2}                     @ prepare R1 print
	  MOV R3, R2                   @ prepare R1 print
	  BL printf                    @ print R1 value prior to reg_dump call
	  
	  LDR R0,=debug_str            @ prepare register print
	  MOV R1, #2                   @ prepare R2 print
	  POP {R2}                     @ prepare R2 print
	  MOV R3, R2                   @ prepare R2 print
  	BL printf                    @ print R2 value prior to reg_dump call
	  
	  LDR R0,=debug_str            @ prepare register print
	  MOV R1, #3                   @ prepare R3 print
	  POP {R2}                     @ prepare R3 print
	  MOV R3, R2                   @ prepare R3 print
	  BL printf                    @ print R3 value prior to reg_dump call
	  
	  LDR R0,=debug_str            @ prepare register print
	  MOV R1, #4                   @ prepare R4 print
	  POP {R2}                     @ prepare R4 print
	  MOV R3, R2                   @ prepare R4 print
	  BL printf                    @ print R4 value prior to reg_dump call
	  
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
	  
.data
debug_str:              .asciz "R%-2d   0x%08X  %011d \n"
operation_type:         .asciz    " "
scanf_statement:        .asciz    "%d"
prompt_str:             .ascii    "Please insert a number and press Enter:"
printf_statement:       .asciz    "The final result is: %d\n"
printf_operator:        .asciz    "Insert the type of operation '+' for addition, '-' for subtraction, '*' for multiplication, 'M' for Maximum:"
