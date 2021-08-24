.data 
message:      .asciiz "|  "
message0:     .asciiz "Enter The Point: "
message0.5:   .asciiz "Enter The Number of Values: "
message1:     .asciiz "Sum of (x - "
message1.5:   .asciiz ")*f: "
message2:     .asciiz "Enter the Value of 'x': "
message3:     .asciiz "Enter the Value of 'f': "
message4:     .asciiz "  |  Sum of 'f': "
message5:     .asciiz "  |  1st Moment Prerequisite (or) mu''(In Integer format): "
message5.5:   .asciiz "  |  1st Moment Prerequisite (or) mu''(In Mixed Fraction): "
message6:     .asciiz "  |  2nd Moment Prerequisite (or) mu''(In Integer format): "
message6.5:   .asciiz "  |  2nd Moment Prerequisite (or) mu''(In Mixed Fraction): "
message7:     .asciiz "  |  3rd Moment Prerequisite (or) mu''(In Integer format): "
message7.5:   .asciiz "  |  3rd Moment Prerequisite (or) mu''(In Mixed Fraction): "
message8:     .asciiz "  |  4th Moment Prerequisite (or) mu''(In Integer format): "
message8.5:   .asciiz "  |  4th Moment Prerequisite (or) mu''(In Mixed Fraction): "
message9:     .asciiz "  |"
messageslash: .asciiz "/"
messagespace: .asciiz " "
.text
#value1
li $v0, 4
la $a0, message0 #Enter The Point
syscall
#read the user input
li $v0, 5 
syscall
#store the input
move $t8,$v0

#no.of values
li $v0, 4
la $a0, message0.5#Enter The Number of Values
syscall
#read the no.of values input
li $v0, 5
syscall
move $k1,$v0
move $t0,$0
li $t2,0
li $t9,0
li $s6,0
li $s5,0
li $s7,0
li $k0,0
startloop:
beq $t0,$k1,end
li $v0,4
la $a0,message2#Enter the Value of 'x'
syscall
li $v0,5
syscall
sub $v0,$v0,$t8 #x-5 stored in v0
move $t1,$v0 #x-5 moved to t1 
li $v0,4
la $a0,message3#Enter the Value of 'f'
syscall
li $v0,5
syscall
move $t5,$v0 #f is stored in t5
mul $t3,$t1,$t5 # (x-5)*f stored in t3
add $t2,$t3,$t2 # E (x-5)*f stored in t2
add $t9,$t5,$t9 # E f in t9
addi $s2,$t1,0
mul $s2,$s2,$t1 # store (x-5)*(x-5) in s2
mul $s2,$s2,$t5 # store (x-5)*(x-5)*f in s2
add $s6,$s6,$s2

mul $s3,$s2,$t1 # (x-5)^3*f
add $s5,$s5,$s3

mul $s1,$s3,$t1 # (x-5)^4*f
add $s7,$s7,$s1

addi $t0,$t0,1
j startloop
end:
li $v0,4
la $a0,message#|
syscall
li $v0,4
la $a0,message1#Sum of (x - 
syscall
li $v0,1
add $a0,$zero,$t8 #the point
syscall
li $v0,4
la $a0,message1.5#)*f
syscall
li $v0,1
move $a0,$t2 #E(x-p)*f
syscall
li $v0,4
la $a0,message4#|  Sum of 'f'
syscall
li $v0,1
move $a0,$t9 #E f
syscall


div $t2,$t9
mflo $s0
mfhi $t6
beq $t6,$k0,yes1
li $v0,4
la $a0,message5.5#1st Moment Prerequisite (or) mu''(In Mixed Fraction)
syscall
li $v0,1
add $a0,$zero,$s0 #quo
syscall
li $v0,4
la $a0,messagespace
syscall
li $v0,1
add $a0,$zero,$t6 #rem
syscall
li $v0,4
la $a0,messageslash
syscall
li $v0,1
add $a0,$zero,$t9 #div
syscall
j end1
yes1:
li $v0,4
la $a0,message5#1st Moment Prerequisite (or) mu''(In Integer format)
syscall
li $v0,1
add $a0,$zero,$s0 #quo
syscall
end1:

div $s6,$t9 #E((x-5)^2)*f/Ef
mflo $s6
mfhi $t7
beq $t7,$k0,yes2
li $v0,4
la $a0,message6.5#2nd Moment Prerequisite (or) mu''(In Mixed Fraction)
syscall
li $v0,1
add $a0,$zero,$s6 #quo
syscall
li $v0,4
la $a0,messagespace
syscall
li $v0,1
add $a0,$zero,$t7 #rem
syscall
li $v0,4
la $a0,messageslash
syscall
li $v0,1
add $a0,$zero,$t9 #div
syscall
j end2
yes2:
li $v0,4
la $a0,message6#2nd Moment Prerequisite (or) mu''(In Integer format)
syscall
li $v0,1
add $a0,$zero,$s6
syscall
end2:

div $s5,$t9 #E((x-5)^3)*f/Ef
mflo $s5 
mfhi $t6
beq $t6,$k0,yes3
li $v0,4
la $a0,message7.5#3rd Moment Prerequisite (or) mu''(In Mixed Fraction)
syscall
li $v0,1
add $a0,$zero,$s5 #quo 
syscall
li $v0,4
la $a0,messagespace
syscall
li $v0,1
add $a0,$zero,$t6 #rem
syscall
li $v0,4
la $a0,messageslash
syscall
li $v0,1
add $a0,$zero,$t9 #div
syscall
j end3
yes3:
li $v0,4
la $a0,message7#3rd Moment Prerequisite (or) mu''(In Integer format)
syscall
li $v0,1
add $a0,$zero,$s5
syscall
end3:

div $s7,$t9 #E((x-5)^4)*f/Ef
mflo $s7
mfhi $t7
beq $t7,$k0,yes4
li $v0,4
la $a0,message8.5#4th Moment Prerequisite (or) mu''(In Mixed Fraction)
syscall
li $v0,1
add $a0,$zero,$s7 #quo
syscall
li $v0,4
la $a0,messagespace
syscall
li $v0,1
add $a0,$zero,$t7 #rem
syscall
li $v0,4
la $a0,messageslash
syscall
li $v0,1
add $a0,$zero,$t9 #div
syscall
j end4
yes4:
li $v0,4
la $a0,message8#4th Moment Prerequisite (or) mu''(In Integer format)
syscall
li $v0,1
add $a0,$zero,$s7
syscall
li $v0,4
la $a0,message9#|
syscall
end4:

