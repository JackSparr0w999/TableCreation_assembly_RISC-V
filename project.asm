.globl main

.data
table: .space 20
info: .asciz "Columns number: " #saved in s0
info2: .asciz "Rows number: "  #saved in s1
spazio3: .word 0		            #the string is saved in memory
info3: .asciz "Cells name: "



.text
main:
#asking for colums, they will be saved in s0    
la a0, info
li a7, 4
ecall

li a7, 5
ecall # by default the integer entered by the user is saved in a0
mv s0, a0

#asking for rows, they will be saved in s1
la a0, info2
li a7, 4
ecall

li a7, 5
ecall
mv s1, a0

#asking for cells name
la a0, info3
li a7, 4
ecall

li a7, 8
la a0, table
li a1, 20
ecall

mv s6, a0 # i need it to understand the length of the row "-----"

li t0, '\n'

####### i have to remove "/n", saved by default in the input in order to prevent the string from wrapping
mv s6, a0
li s7, 0 # character counter
###li t0, '\n'
# starting from the base address and continue to scroll through the bytes of the string until I find "/n"

loop0:
lb s3, 0(s6) #first string character in s3
beq s3, t0, exit
addi s7, s7, 1
addi s6, s6, 1 #increasing address
j loop0

exit:
#in s7 i have the final length of the characters

######## it's 2 am and I'm tired of translating

mv t2, a0 #in t2 ho partenza indirizzo titolo
li t4, 0
# occhio li t0, '\n'

#elimino '\n' per evitare che vada a capo
continuo:
add t2, a0, t4 # è sbagliato fare add t2, t2, t4 perchè è come fare 26900+0 poi 26900+1 poi 26901+2 poi 26903+3 (mi perdo i pezzi)
lb t1, 0(t2)
beq t1, t0, delete #in t0 ho '\n' salvato prima di ####
addi t4, t4, 1
j continuo

delete:
#ho in t1 '\n'
li t3, '\0'
sb t3, 0(t2) #meglio mettere una somma di indrizzi = indirizzo + t5


#creazione tabella
# scrivo | prima di tutto 
#in base alle x colonne scrivo x volte Title poi x volte Title
# ciclo? stampo Title| , Title|, Title|,... quante sono le colonne

li a0, '|'
li a7, 11
ecall

#contatore
li s2, 0

loop:
la a0, table #stampo titolo la a0, table
li a7, 4
ecall

li a0, '|'
li a7, 11
ecall

addi s2, s2, 1
beq s2, s0, next
j loop

next:
#vado a capo
li a7, 11
li a0, '\n'
ecall

#stampo riga di separazione 
li s3, 0
li s5, 5
mul s4, s7, s5 # per ogni colonna stampo 5 "-" , dipende più dalla lunghwzza del titolo piu che dalle colonne
#in s7 ho lunghezza titolo: titolo= ciao stampo caratteri titolo (+1) x colonne 
addi s7, s7, 1

#devo raggiungere
mul s8, s7, s0 # s8=numero di - da stampare caratteri +1 x colonne

next2:
li a7, 11
li a0, '-'
ecall

addi s3, s3, 1 #stampo una volta, due, tre, ...

beq s3, s8, next3
j next2


#adesso stampo le righe
next3:
li s9, 0
li s10, 0

li a7, 11
li a0, '\n'
ecall

li a0, '|'
li a7, 11
ecall

stampo_righe:
la a0, table
li a7, 4
ecall

li a0, '|'
li a7, 11
ecall

addi s9, s9, 1

beq s9, s0, stampo_righe2
j stampo_righe

stampo_righe2:

li a7, 11
li a0, '\n'
ecall

addi s10, s10, 1 #prima riga fatta, ...

beq s10, s1, exit2
li a0, '|'
li a7, 11
ecall

li s9, 0

j stampo_righe


exit2:
li a7, 10
ecall




