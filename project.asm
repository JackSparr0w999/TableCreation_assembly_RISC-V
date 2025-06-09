.globl main

.data
table: .space 20
info: .asciz "Numero colonne: " #salvate in a0
info2: .asciz "Numero righe: "  #salvate in a0
spazio3: .word 0		       #la stringa è salvata in memoria
info3: .asciz "Titoli: "



.text
main:
#blocco chiedo colonne ce le ho in s0    
la a0, info
li a7, 4
ecall

li a7, 5
ecall #ora il numero letto è in a0
mv s0, a0

#blocco chiedo righe ce le ho in s1
la a0, info2
li a7, 4
ecall

li a7, 5
ecall
mv s1, a0

#blocco chiedo titolo
la a0, info3
li a7, 4
ecall

li a7, 8
la a0, table
li a1, 20
ecall

mv s6, a0 # mi serve per capire lunghezza riga "-----"

li t0, '\n'

#######
mv s6, a0
li s7, 0 # copmtatore caratteri
###li t0, '\n'
# parto da indirizzo e base e continuo a scorrere i byte della string afinchè trovo /n

loop0:
lb s3, 0(s6) #primo carattere stringa in s2
beq s3, t0, exit
addi s7, s7, 1
addi s6, s6, 1 #incremento indirizzo
j loop0

exit:
#in s7 ho lunghezza caratteri

########

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




