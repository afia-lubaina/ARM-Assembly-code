		AREA lab, CODE
		ENTRY
		EXPORT prime

num1 DCD 2, 3, 7, 8, 12, 14, 37, 66  ; Array of numbers to check

prime
   LDR r0, =num1        ; Load address of num1 to r0
   LDR r1, =2           ; Initialize divisor (j) to 2 in r1
   LDR r5, =8            ; Load number of elements in num1 to r5 (k)
   LDR r6, =arr1        ; Load address of arr1 to r6

array_loop
   LDR r3, [r0]           ; Load current number (num[i]) to r3
   BL Divide              ; Call subroutine to check divisibility

   ADD r0, #4             ; Increment i (move to next number)
   SUBS r5, #1            ; Decrement k (number of elements remaining)
   BNE array_loop       ; Loop back if there are more elements

Divide  ; Subroutine to check divisibility
   SDIV r4, r3, r1       ; Calculate quotient (num[i] / j) and store in r4
   MUL r2, r4, r1       ; Calculate product (quotient * divisor) and store in r2
   CMP r2, r3           ; Compare product with dividend
   BEQ not_prime        ; Branch if dividend is divisible (not prime)

   CMP r1, r3           ; Check if divisor (j) is greater than dividend
   BLT next_divisor     ; Branch if divisor is less than dividend (go to next divisor)

not_prime  ; Label for non-prime number processing
   MOV r7, #1            ; Set value to indicate non-prime (1)
   STR r7, [r6]           ; Store non-prime flag in arr1

next_divisor  ; Label for moving to next divisor
   ADD r1, #1            ; Increment divisor (j)
   CMP r1, r3           ; Check if new divisor equals dividend
   BEQ loop_end          ; Branch to loop end if divisor is greater than dividend

loop_end ; Loop end
   BX LR                ; Return to calling function

		AREA labkk, DATA

arr1 DCD 0, 0, 0, 0, 0, 0, 0, 0  ; Initialize arr1 with zeros

		AREA my_main, CODE ; Define a new area for main
		EXPORT main

main
   BL prime      ; Call your prime checking function
   B .           ; Loop indefinitely (or add proper exit handling)
		END
		
	END
