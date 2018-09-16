.data
Star: .asciiz"* "
Line: .asciiz"\n"
player: .asciiz"P "
enemy: .asciiz"E "
wall: .asciiz"# # # # # "
wall2: .asciiz"# "
wall3: .asciiz"# # # # # # # # # # #"
.text

li $t4,,90
li $t5,85
li $t6,95
li $a3,3
Begain:
li $t0,20
li $t1,12
li $t3,0
MapConstruction:
beq $t3,168,PrintWall
beq $t3,45,PrintWall3
beq $t3,$t4,PrintPlayer
beq $t3,$t5,PrintEnemy
beq $t3,$t6,PrintEnemy
la $a0,Star
li $v0,4
syscall
addi $t0,$t0,-1
addi $t3,$t3,1
Continue:
bnez  $t0,MapConstruction


PrintLine:
li $t0,20
la $a0,Line
li $v0,4
syscall
addi $t1,$t1,-1
bnez  $t1,MapConstruction

j PlayerMovement

PrintPlayer:
la $a0,player
li $v0,4
syscall
addi $t0,$t0,-1
addi $t3,$t3,1
j MapConstruction

PrintEnemy:
la $a0,enemy
li $v0,4
syscall
addi $t0,$t0,-1
addi $t3,$t3,1
j MapConstruction

PrintWall:
la $a0,wall
li $v0,4
syscall
addi $t0,$t0,-5
addi $t3,$t3,5
j Continue

PrintWall3:
la $a0,wall3
li $v0,4
syscall
addi $t0,$t0,-10
addi $t3,$t3,10
j Continue

PrintWall2:
la $a0,wall2
li $v0,4
syscall
addi $t0,$t0,-1
addi $t3,$t3,1
j MapConstruction

PlayerMovement:
li $v0,12
syscall
beq $a3,3,FirstStep
addi $a1,$t4,1
beq $a1,$t5,PlayerLeft
beq $a1,$t6,PlayerLeft
addi $a1,$t4,-1
beq $a1,$t5,PlayerRight
beq $a1,$t6,PlayerRight
beq $a3,1,PlayerUp
beq $a3,2,PlayerDown
j PlayerDown

FirstStep:
sub $a1,$t4,240
mul $a1,$a1,-1
beq $a1,$t4,PlayerUp
ble $a1,$t4,PlayerDown
bge $a1,$t4,PlayerUp
j end

PlayerRight:
addi $t4,$t4,1
j end

PlayerLeft:
addi $t4,$t4,-1
j end

PlayerDown:
li $a3,2
addi $t4,$t4,20
bge $t4,166,checkwall2
j end

PlayerUp:
li $a3,1
addi $t4,$t4,-20
bge $t4,45,checkwall
j end

playerwallup:
addi $t4,$t4,20
j PlayerDown

playerwalldown:
addi $t4,$t4,-20
j PlayerRight

checkwall:
ble $t4,55,playerwallup
j end

checkwall2:
ble $t4,172,playerwalldown
j end

end:
beq $t4,19,gameover
beq $t4,39,gameover
beq $t4,59,gameover
beq $t4,79,gameover
beq $t4,99,gameover
beq $t4,119,gameover
beq $t4,139,gameover
beq $t4,159,gameover
beq $t4,179,gameover
beq $t4,199,gameover
beq $t4,219,gameover
beq $t4,239,gameover
ble $t4,0,gameover
bge $t4,240,gameover



EnemyMovement1:
addi $a1,$t5,10
ble $t4,$a1,MoveRight1
sub $a1,$t4,$t5
beqz $a1,gameover
div $a2,$a1,20
mfhi $a2
beqz $a2,MoveVertical
ble $t4,$t5,MoveRight1
bgt $a1,10,MoveRight1
blt $a1,-10,MoveLeft1
j Begain
MoveRight1:
addi $t5,$t5,1
j EnemyMovement2

MoveLeft1:
addi $t5,$t5,-1
j EnemyMovement2

MoveVertical:
bgtz $a1,MoveDown1
bltz $a1,MoveUp1
j EnemyMovement2

MoveDown1:
addi $t5,$t5,20
j EnemyMovement2

MoveUp1:
addi $t5,$t5,-1
j EnemyMovement2

EnemyMovement2:
addi $t7,$t6,2
beq $t7,$t4,MoveRight2
ble $t4,$a1,MoveLeft2
sub $a1,$t4,$t5
beqz $a1,gameover
div $a2,$a1,20
mfhi $a2
beqz $a2,MoveVertical2
ble $t4,$t5,MoveRight2
bgt $a1,10,MoveLeft2
blt $a1,-10,MoveLeft2
j Begain

j Begain
MoveRight2:
addi $t6,$t6,1
j Begain

MoveLeft2:
addi $t6,$t6,-1
j Begain

MoveVertical2:
bgtz $a1,MoveDown2
bltz $a1,MoveUp2
j Begain

MoveDown2:
addi $t6,$t6,20
bge $t6,166,checkwall4
j Begain

checkwall4:
ble $t6,172,Enemy2walldown
j Begain

Enemy2walldown:
addi $t6,$t6,-20
j MoveRight2

MoveUp2:
addi $t6,$t6,-1
j Begain

gameover:
li $v0,10
syscall
