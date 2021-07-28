.model small
.stack
.data
	start db 'P L A Y$'
	help db 'I N S T R U C T I O N S$'
	exit db 'E X I T$'
	val1 dw 0
	val2 dw 0
	val3 dw 0
	val4 dw 0
	
	val5 dw 0
	val6 dw 0
	val7 dw 0
	val8 dw 0
	
	startX dw 0
	startY dw 0
	
	endX dw 0
	endY dw 0
	
	color db ?
	
	mouseX dw ?
	mouseY dw ?
	
	scoreStr db "S C O R E : ", '$'
	
	score dw 1
	
	initialTime dw ?
	mins db ?
	secs db ?
	
	file db "myfile.txt", 0
	buffer db 5000 dup('$')
	
	inputMsg db "E N T E R  Y O U R  N A M E: ", 0Dh, 0Ah, '$'
	playerName db 50 dup('$')
	
	pauseMsg db "G  A  M  E   P A U S E D", '$'
	overMsg db "G  A  M  E   O V E R ! ! !", '$'
	resumeMsg db "R E S U M E", '$'
	returnMsg db "Press ESC to return	", '$'
	
	key db 0
	
	space db 32
	
	bgcolor db 0
	
	; DINO VARIABLES START - DO NOT TOUCH
	
	dinox dw 100 ;just change this value for changing positioning across mushroomX axis
	dinoy dw 180 ;just change this value for changing positioning across mushroomY axis
	
	dinox1 dw 100 ; this value should be the same as "dinox"
	dinoy1 dw 180 ; this value should be the same as "dinoy"
	
	dinostx dw 100 ; this value should be the same as "dinox"
	dinosty dw 180 ; this value should be the same as "dinoy"
	;leave all these vaiables alone dont touch them HANDS OFF
	taildinox dw 0
	taildinoy dw 0
	
	taildinox1 dw 0
	taildinoy1 dw 0
	
	flegx dw 0
	flegy dw 0
	
	flegx1 dw 0
	flegy1 dw 0
	
	slegx dw 0
	slegy dw 0
	
	slegx1 dw 0
	slegy1 dw 0
	
	eyex dw 0
	eyey dw 0
	
	eyex1 dw 0
	eyey1 dw 0
	
	armx dw 0
	army dw 0
	
	armx1 dw 0
	army1 dw 0
	
	coldino db 2 ;10=green;20=dark grey;30=weird white;40=red;50=green;60=;70=green;80=purple;90=light pink;100=light blue
	
	; DINO VARIABLES ENDS - NOW TOUCH
	
	; ufo variables start
	
	stx dw 600
	sty dw 110
	
	stx1 dw 600
	sty1 dw 110
	colufo db 10 ;10=green;20=dark grey;30=weird white;40=red;50=green;60=;70=green;80=purple;90=light pink;100=light blue
	
	ufostx dw 600
	ufosty dw 110
	
	; ufo vaiables end
	;mushroom
	mushroomX dw 600
	mushroomY dw 250
	
	mushroomX1 dw 600;150
	mushroomY1 dw 250;5
	mushroomX2 dw 0
	mushroomX3 dw 0
	
	xrein dw 600
	yrein dw 250
	
	lives db 3
	
	drawMushroom db 0
	drawUfo db 1
	
	dinopixelx db 1000 DUP(?)
	dinopixely db 1000 DUP(?)
	
	mushroompixelx db 1000 DUP(?)
	mushroompixely db 1000 DUP(?)
	
	ufopixelx db 1000 DUP(?)
	ufopixely db 1000 DUP(?)
	
	gameLevel db 1
	
		; heart variables
	
	heartx dw 300;200
	hearty dw 20;30
	
	heartx1 dw 300
	hearty1 dw 20
	
	
	varht1 dw 0
	
	heartxx dw 0
	heartyy dw 0
	
	heartxx1 dw 0
	heartyy1 dw 0
	
	
	varht2 dw 0
	
	heartColor db 4 
	
	startOfHeartsX dw ?
	
	; end of heart variables
	
	; cloud variables
	
	cloudx dw 100
	cloudy dw 20
	
	cloudx1 dw 100
	cloudy1 dw 20
	
	reincloudx dw 100
	reincloudy dw 20
	
	colcloud db 15
	
	; end of cloud variables
	
	rx dw 600
	ry dw 265
	
	rx1 dw 600
	ry1 dw 265
	
	rx2 dw 600
	ry2 dw 265
	
	rx3 dw 600
	
	cactx dw 200
	cacty dw 200
	
	cactx1 dw 200
	cacty1 dw 200
	
	scndcactx dw 0 ;260
	scndcacty dw 0;220
	
	scndcactx1 dw 0;260
	scndcacty1 dw 0;220
	
	thrdcactx dw 0;340
	thrdcacty dw 0;230
	
	thrdcactx1 dw 0;340
	thrdcacty1 dw 0;230
	
	col db 10
	
.code

main proc
	mov ax, @data
	mov ds, ax
	
	menu:
		call drawMenu
		
	;; mouse starts
	
	mov ax, 01h
	int 33h
	mouse:
		mov ax, 03h
		int 33h
		cmp bx, 1
		je check1
		jne mouse
		
		check1:
			mov mouseX, cx
			
			cmp mouseX, 200
			js mouse
			
			cmp mouseX, 400
			jg mouse
			
			mov mouseY, dx
			
			cmp mouseY, 80
			js mouse
			
			cmp mouseY, 270
			jg mouse
			
			cmp mouseY, 130
			js callPlay
			
			cmp mouseY, 150
			js mouse
			
			cmp mouseY, 200
			js callInstructionsDisplay
			
			cmp mouseY, 220
			js mouse
			
			cmp mouseY, 270
			js callExit
			
			jmp mouse
			
			callPlay:
				call playerNameInput
				call play
				jmp quit
				
			callInstructionsDisplay:
				call instructions
				jmp menu
				
			callExit:
				jmp quit
	
	quit:
		mov ah, 4ch
		int 21h
	
	mov ah, 04ch
	int 21h
		
main endp

;; clears the screen
cls proc
	mov al, 03
	mov ah, 0
	int 10h
	
	mov ah, 0
	mov al, 10h
	int 10h
	
	ret
cls endp

drawMenu proc
	mov ah, 13h
	mov al, 10h
	int 10h
	
	call cls
	
	mov bgcolor, 09h
	call fullScreenBackground
	;; play 
	
	mov bh, 0
	mov dh, 7 ;row
	mov dl, 34 ;column
	mov ah, 02h
	int 10h
	
	mov color, 0
	
	mov startX, 200
	mov endX, 400
	
	mov startY, 80
	mov endY, 130
	
	call drawShape
	
	push ax
	
	mov bh, 0
	mov dh, 7 ;row
	mov dl, 34 ;column
	mov ah, 02h
	int 10h
	
	
	mov ah, 09h
	mov dx, offset start
	int 21h
	
	pop ax
	
	;; instructions
	
	mov startX, 200
	mov endX, 400
	
	mov startY, 150
	mov endY, 200
	
	call drawShape
	
	mov bh,0
	mov dh,12 ;row
	mov dl,26 ;column
	mov ah,02h
	int 10h
	
	push ax
	
	mov ah,09h
	mov dx,offset help
	int 21h
	
	pop ax
	
	;; exit
	
	mov startX, 200
	mov endX, 400
	
	mov startY, 220
	mov endY, 270
	
	call drawShape
	
	mov bh,0
	mov dh,17 ;row
	mov dl,34 ;column
	mov ah,02h
	int 10h
	
	mov ah,09h
	mov dx,offset exit
	int 21h
	
	mov dinox, 100 ;40;just change this value for changing positioning across mushroomX axis
	mov dinoy, 230 ;just change this value for changing positioning across mushroomY axis
	
	mov dinox1, 100 ; this value should be the same as "dinox"
	mov dinoy1, 230 ; this value should be the same as "dinoy"
	
	mov dinostx, 100 ; this value should be the same as "dinox"
	mov dinosty, 230
	
	mov cloudx, 100
	mov cloudy, 40
	
	mov cloudx1, 100
	mov cloudy1, 40
	
	mov reincloudx, 100
	mov reincloudy, 40

	call mycloud
	
	mov cloudx, 510
	mov cloudy, 50

	mov cloudx1, 510
	mov cloudy1, 50
	
	mov reincloudx, 510
	mov reincloudy, 50

	call mycloud
	
	mov mushroomX, 610
	mov mushroomY, 320
	
	mov mushroomX1, 610;150
	mov mushroomY1, 320;5
	mov mushroomX2, 0
	mov mushroomX3, 0
	
	mov xrein, 610
	mov yrein, 320
	
	mov cx, 30
	
	mushLoop:
		push cx
		
		call mushroom
		sub xrein, 33
		
		pop cx
		loop mushLoop
		
	mov mushroomX, 610
	mov mushroomY, 0
	
	mov mushroomX1, 610;150
	mov mushroomY1, 0;5
	mov mushroomX2, 0
	mov mushroomX3, 0
	
	mov xrein, 610
	mov yrein, 0
	
	mov cx, 20
	
	mushLoop2:
		push cx
		
		call mushroom
		sub xrein, 33
		
		pop cx
		loop mushLoop2
		
	mov mushroomX, 10
	mov mushroomY, 0
	
	mov mushroomX1, 10;150
	mov mushroomY1, 0;5
	mov mushroomX2, 10
	mov mushroomX3, 0
	
	mov xrein, 10
	mov yrein, 0
	
	mov cx, 20
	
	mushLoop3:
		push cx
		
		call mushroom
		add yrein, 33
		
		pop cx
		loop mushLoop3
		
	mov mushroomX, 610
	mov mushroomY, 0
	
	mov mushroomX1, 610;150
	mov mushroomY1, 0;5
	mov mushroomX2, 0
	mov mushroomX3, 0
	
	mov xrein, 610
	mov yrein, 0
	
	mov cx, 20
	
	mushLoop4:
		push cx
		
		call mushroom
		add yrein, 33
		
		pop cx
		loop mushLoop4
		
	call mydino
	
	ret
drawMenu endp

;; changes background of whole screen
fullScreenbackground proc
	mov ah, 06h
	mov al, 0
	mov dh, 30
	mov dl, 100
	mov bh, bgcolor
	mov cl, 0
	mov ch, 0
	int 10h
	
	ret
		
fullScreenbackground endp

; takes in the name of the player
playerNameInput proc
	call cls
	
	mov bgcolor, 09h ; purple
	call fullScreenBackground
	
	mov bh, 0
	mov dh, 12 ; row
	mov dl, 20 ; column
	mov ah, 02h
	int 10h
	
	mov color, 0 ; black
	
	mov startX, 100
	mov endX, 530
		
	mov startY, 140
	mov endY, 210
		
	call drawShape
	
	mov bh, 0
	mov dh, 12 ; row
	mov dl, 15 ; column
	mov ah, 02h
	int 10h
	
	push ax
	
	mov ah, 09h
	mov dx, offset inputMsg
	int 21h
	
	pop ax
	
	mov bh, 0
	mov dh, 12 ; row
	mov dl, 45 ; column
	mov ah, 02h
	int 10h
	
	mov bx, offset playerName
	mov si, 0
	
	inputName:
		mov ah, 01h
		int 21h
		
		cmp al, 13
		je forw
		
		cmp al, 90
		ja next
		
		cmp al, 122
		jb next
		
		sub al, 32 ; changing lowercase to uppercase
		
		next:
			mov [bx + si], al
			inc si
			
			mov al, space
			
			mov [bx + si], al
			inc si
		
	jmp inputName
	
	forw:
		ret
playerNameInput endp

;; draws background for play screen
playBackground proc

	mov bgcolor, 12
	call fullScreenBackground
	
	; main screen
	
	cmp gameLevel, 1
	je redbg
	
	cmp gameLevel, 2
	je bluebg
	
	cmp gameLevel, 3
	je yellowbg
	
	cmp gameLevel, 3
	jg redbg
	
	redbg:
		mov bgcolor, 12
		jmp bg
		
	bluebg:
		mov bgcolor, 11
		jmp bg
		
	yellowbg:
		mov bgcolor, 14
		jmp bg
		
	bg:
		; mov ah, 06h
		; mov al, 0
		; mov dh, 23	; bottom
		; mov dl, 100	; right
		; mov bh, bgcolor
		; mov cl, 0	; left
		; mov ch, 10	; top
		; int 10h
		
		call fullScreenBackground
	
	; road
	
	mov bgcolor, 8
	
	mov ah, 06h
	mov al, 0
	mov dh, 30
	mov dl, 100
	mov bh, bgcolor
	mov cl, 0
	mov ch, 20
	int 10h
	
	ret
	
playBackground endp

;; draws a shape (startX -> endX, startY -> endY)
drawShape proc
	mov dx, startY
	mov cx, startX
	int 10h
 
	loop1:
		cmp dx, endY
		je quit1
	loop2:
		cmp cx, endX
		je quit2
		mov ah, 0ch
		mov al, color
		int 10h
		
		inc cx
	
	jmp loop2
	
	quit2:
		inc dx 
		mov cx, startX
	jmp loop1
	quit1:
		ret
		
drawShape endp

;; displays instructions
instructions proc

	call cls
	
	mov ah, 02h
	mov bh, 0
	mov dh, 2
	mov dl, 4
	int 10h
	
	mov dx, offset file
	mov al, 0
	mov ah, 3Dh
	int 21h
	
	mov bx, ax
	mov dx, offset buffer
	mov ah, 3Fh
	int 21h
	
	mov ah, 09h
	int 21h
	
	mov ah, 3Eh
	int 21h
	
	mov color, 15
	mov startX, 200
	mov endX, 500
		
	mov startY, 250
	mov endY, 310
		
	call drawShape
	
	mov color, 0
	mov startX, 220
	mov endX, 480
	
	mov startY, 260
	mov endY, 300
	
	call drawShape
	
	mov bh, 0
	mov dh, 19 ; row
	mov dl, 31 ; column
	mov ah, 02h
	int 10h
	
	push ax
	
	mov ah, 09h
	mov dx, offset returnMsg
	int 21h
	
	pop ax
	
	keyb2:
		mov ah, 0h
		int 16h
	
		mov key, al
		
		cmp key, 27
		jne keyb2
		
		ret
	
instructions endp

;; generates play screen
play proc
	mov dinox, 100 ;just change this value for changing positioning across mushroomX axis
	mov dinoy, 180 ;just change this value for changing positioning across mushroomY axis
	
	mov dinox1, 100 ; this value should be the same as "dinox"
	mov dinoy1, 180 ; this value should be the same as "dinoy"
	
	mov dinostx, 100 ; this value should be the same as "dinox"
	mov dinosty, 180 ; this value should be the same as "dinoy"
	
	mov mushroomX, 600
	mov mushroomY, 250
	
	mov mushroomX1, 600;150
	mov mushroomY1, 250;5
	mov mushroomX2, 0
	mov mushroomX3, 0
	
	mov xrein, 600
	mov yrein, 250
	
	mov rx, 600
	mov ry, 265
	
	mov rx1, 600
	mov ry1, 265
	
	mov rx2, 600
	mov ry2, 265
	
	mov rx3, 600
	
	L1:
		mov ah, 02ch
		int 21h
	
		call timeDelay
	
		cmp lives, 0
		je quit4
		
	mov ax,dinostx
	mov val1,ax
	mov ax,dinosty
	mov val2,ax
	mov ax,ufostx
	mov val3,ax
	mov ax,ufosty
	mov val4,ax
	
	mov ax,dinostx
	mov val5,ax
	mov ax,dinosty
	mov val6,ax
	mov ax,ufostx
	mov val7,ax
	mov ax,ufosty
	mov val8,ax
	
	add val1,100
	add val2,100
	add val3,100
	add val4,50
	
	sub val5,10
	sub val6,10
	sub val7,10
	sub val8,10
	mov ax,val5
	cmp ax,val7
	jle gore
	jmp outt1
	gore:
		mov ax,val1
		cmp ax,val3
		jge done
		jmp outt1
		
		chky:
			mov ax,val6
			cmp ax,val8
			jle gore1
			jmp outt1
			
			gore1:
				mov ax,val2
				cmp ax,val4
				jge done
				jmp outt1
				done:
					dec lives
				
	outt1:
		
		
		call drawPlayScreen
		call moveUfoLeft
		call updateScore
		call moveMushroomleft
	;	call moveRockLeft
		
		mov ah, 01
		int 16h
		
		jz onw ; jump if ZF = 1 / there is no key press
	
	repeat1:
		; Get keystroke
		mov ah,0
		int 16h
		; AH = BIOS scan code
		cmp ah,48h
		je up
		
		cmp ah,4Bh
		je left
		
		cmp ah,4Dh
		je right
		
		cmp ah,50h
		je down
		
		cmp ah, 1	; escape
		jne L1  ; loop until Esc is pressed
		
		jmp quit3
		
		right:
			call moveDinoRight
			jmp onw
			
		left:
			call moveDinoLeft
			jmp onw
			
		up:
			call moveDinoUp
			jmp onw
			
		down:
			call moveDinoDown
			jmp onw
			
		onw:
			jmp L1
			
	quit3:
		call gamePause
		ret
		
	quit4:
		call gameOver
		ret
	
play endp

timeDelay proc

	cmp gameLevel, 1
	je level1
	
	cmp gameLevel, 2
	je level2
	
	cmp gameLevel, 3
	je level3
	
	jmp level3
	
	level1:
		mov cx, 01H
		mov dx, 20H
		
		jmp delay
		
	level2:
		mov cx, 01h
		mov dx, 10h
		
		jmp delay
		
	level3:
		mov cx, 01h
		mov dx, 5h
		
		jmp delay
	
	delay:
		mov ah, 86h
		int 15h
	
	ret

timeDelay endp

gamePause proc
;	call cls
	
;	mov bgcolor, 09h ; purple
;	call fullScreenBackground
	mov bgcolor, 0
	mov ah, 06h
	mov al, 0
	mov dh, 30
	mov dl, 100
	mov bh, bgcolor
	mov cl, 0
	mov ch, 20
	int 10h
	
	mov bh, 0
	mov dh, 22 ; row
	mov dl, 25 ; column
	mov ah, 02h
	int 10h
	
	push ax
	
	mov ah, 09h
	mov dx, offset pauseMsg
	int 21h
	
	pop ax
	
	mov color, 0 ; black
	
	mov startX, 100
	mov endX, 330
		
	mov startY, 140
	mov endY, 210
		
	call drawShape
	
	mov startX, 350
	mov endX, 530
		
	mov startY, 140
	mov endY, 210
		
	call drawShape
	
	mov bh, 0
	mov dh, 12 ; row
	mov dl, 20 ; column
	mov ah, 02h
	int 10h
	
	push ax
	
	mov ah, 09h
	mov dx, offset resumeMsg
	int 21h
	
	pop ax
	
	mov bh, 0
	mov dh, 12 ; row
	mov dl, 51 ; column
	mov ah, 02h
	int 10h
	
	mov dx, offset exit
	mov ah, 09h
	int 21h
	
		mov ax, 01h
	int 33h
	mouse1:
		mov ax, 03h
		int 33h
		cmp bx, 1
		je check2
		jne mouse1
		
		check2:
			mov mouseX, cx
			
			cmp mouseX, 100
			js mouse1
			
			cmp mouseX, 530
			jg mouse1
			
			mov mouseY, dx
			
			cmp mouseY, 140
			js mouse1
			
			cmp mouseY, 210
			jg mouse1
			
			cmp mouseX, 330
			js callPlay2
			
			cmp mouseX, 350
			js mouse1
			
			cmp mouseX, 530
			js callExit2
			
			jmp mouse1
			
			callPlay2:
				call play
				
			callExit2:
				jmp quit4
	
	quit4:
		mov ah, 4ch
		int 21h
	
	ret
	
gamePause endp

gameOver proc
;	call cls
	
;	mov bgcolor, 09h ; purple
;	call fullScreenBackground
	mov bgcolor, 0
	mov ah, 06h
	mov al, 0
	mov dh, 30
	mov dl, 100
	mov bh, bgcolor
	mov cl, 0
	mov ch, 20
	int 10h
	
	mov bh, 0
	mov dh, 22 ; row
	mov dl, 25 ; column
	mov ah, 02h
	int 10h
	
	push ax
	
	mov ah, 09h
	mov dx, offset overMsg
	int 21h
	
	pop ax
	
	mov color, 0 ; black
	
	mov startX, 100
	mov endX, 330
		
	mov startY, 140
	mov endY, 210
		
	call drawShape
	
	mov startX, 350
	mov endX, 530
		
	mov startY, 140
	mov endY, 210
		
	call drawShape
	
	mov bh, 0
	mov dh, 12 ; row
	mov dl, 20 ; column
	mov ah, 02h
	int 10h
	
	push ax
	
	mov ah, 09h
	mov dx, offset scoreStr
	int 21h
	
	pop ax
	
	mov ax, score
	call displayAX
	
	mov bh, 0
	mov dh, 12 ; row
	mov dl, 51 ; column
	mov ah, 02h
	int 10h
	
	mov dx, offset exit
	mov ah, 09h
	int 21h
	
	mov ax, 01h
	int 33h
	
	mouse4:
		mov ax, 03h
		int 33h
		cmp bx, 1
		je check3
		jne mouse4
		
		check3:
			mov mouseX, cx
			
			cmp mouseX, 100
			js mouse4
			
			cmp mouseX, 530
			jg mouse4
			
			mov mouseY, dx
			
			cmp mouseY, 140
			js mouse4
			
			cmp mouseY, 210
			jg mouse4
			
			cmp mouseX, 330
			js mouse4
			
			cmp mouseX, 350
			js mouse4
			
			cmp mouseX, 530
			js callExit3
			
			jmp mouse4
				
			callExit3:
				jmp quit5
	
	quit5:
		mov ah, 4ch
		int 21h
	
	ret
	
gameOver endp

randomMushroom proc
	mov ax, score
	mov bl, 20
	div bl
	
	cmp al, 0
	jne return1
	
	mov drawMushroom, 1
	
	return1:
		ret
randomMushroom endp

resetMushroomVariables proc
	mov mushroomX, 600
	mov mushroomY, 250
	
	mov mushroomX1, 600;150
	mov mushroomY1, 250;5
	mov mushroomX2, 0
	mov mushroomX3, 0
	
	mov xrein, 600
	mov yrein, 250
	
	ret
resetMushroomVariables endp

updateScore proc
	inc score
	
	cmp score, 50
	je Level2
	
	cmp score, 100
	je Level3
	
	cmp score, 150
	je Level4
	
	jmp scoreRet
	
	Level2:
		mov gameLevel, 2
		jmp scoreRet
		
	Level3:
		mov gameLevel, 3
		jmp scoreRet
		
	Level4:
		mov gameLevel, 4
	
	scoreRet:
		ret
updateScore endp

moveRockLeft proc

	sub rx, 10
	ret

moveRockLeft endp

moveUfoLeft proc

	sub stx, 10

	sub stx1, 10

	sub ufostx, 10

	cmp ufostx,20
	jle yeapequal
	jmp noo1
	yeapequal:
	mov ufostx,600
	mov ufosty,110
	mov stx,600
	mov sty,110
	mov stx1,600
	mov sty1,110
	;mov sty, 150
	;mov sty1, 150
	;mov ufosty, 150
	noo1:

	ret

moveUfoLeft endp

moveDinoRight proc 
	add dinox, 15
	add dinox1, 15
	add dinostx, 15
	
	ret
moveDinoRight endp

moveDinoLeft proc 
	sub dinox, 15
	sub dinox1, 15
	sub dinostx, 15
	
	ret
moveDinoLeft endp

moveDinoUp proc 

	call music1
	;sub dinoy, 10
	;sub dinoy1, 10
	;sub dinosty, 10
	sub dinoy, 50
	sub dinoy1, 50
	
	add dinox,50
	add dinox1,50
	sub dinosty,50
	add dinostx,50
	
	call drawPlayScreen
	
	add dinoy, 50
	add dinoy1, 50
	add dinosty,50
	
	call drawPlayScreen
	;jmp repeat1
	
	ret
moveDinoUp endp

moveDinoDown proc 
	add dinoy, 10
	add dinoy1, 10
	add dinosty, 10
	
	ret
moveDinoDown endp

moveMushroomleft proc
	sub xrein,10
	
	cmp xrein,20
	jle yeapequal2
	jmp noo2
	yeapequal2:
	mov mushroomX,600
	mov mushroomY,250
	mov mushroomX1,600
	mov mushroomY1,250
	mov xrein,600
	mov yrein,250
	;mov sty, 150
	;mov sty1, 150
	;mov ufosty, 150
	noo2:
	
	

	ret
moveMushroomleft endp

; generates playing screen again
drawPlayScreen proc
	
	call cls
	
	mov ah, 0
	mov al, 10h
	int 10h
	
	call playBackground
	call displayPlayerName
	call displayScore
	call mydino
	call randomMushroom
	call displayHearts
	call displayClouds
	call displayRock
	call displayCactus
	
	mov color, 0
	
	mov startX, 0
	mov endX, 640
	
	mov startY, 280
	mov endY, 282
	
	call drawShape
	
	mov startX, 80
	mov endX, 100
	
	mov startY, 195
	mov endY, 200
	
	
	cmp drawUfo, 1
	jne forw
	
	call ufo
	
	forw:
		cmp drawMushroom, 1
		jne forw2
	
	call mushroom
	
	forw2:
		ret
drawPlayScreen endp

displayCactus proc
	; mov cactx, 350
	; mov cacty, 195
	
	; mov cactx1, 350
	; mov cacty1, 195
	
	; mov scndcactx, 0 ;260
	; mov scndcacty, 0;220
	
	; mov scndcactx1, 0;260
	; mov scndcacty1, 0;220
	
	; mov thrdcactx, 0;340
	; mov thrdcacty, 0;230
	
	; mov thrdcactx1, 0;340
	; mov thrdcacty1, 0;230
	
	mov color, 9
	
	mov startX, 500
	mov endX, 505
	
	mov startY, 240
	mov endY, 280
	
	call drawShape
	
	mov startX, 480
	mov endX, 520
	
	mov startY, 258
	mov endY, 260
	
	call drawShape
	
	mov startX, 480
	mov endX, 485
	
	mov startY, 230
	mov endY, 258
	
	call drawShape
	
	mov startX, 515
	mov endX, 520
	
	call drawShape
	
	ret

displayCactus endp

displayRock proc

	mov rx, 600
	mov ry, 265
	
	mov rx1, 600
	mov ry1, 265
	
	mov rx2, 600
	mov ry2, 265
	
	mov rx3, 600

	cmp rx, 20
	js return2
	
	call rock
	
	mov rx, 150
	mov ry, 265
	
	mov rx1, 150
	mov ry1, 265
	
	mov rx2, 150
	mov ry2, 265
	
	mov rx3, 150
	
	call rock
	
	mov rx, 350
	mov ry, 265
	
	mov rx1, 350
	mov ry1, 265
	
	mov rx2, 350
	mov ry2, 265
	
	mov rx3, 350
	
	call rock
	
	
	return2:
		ret

displayRock endp

; draws and displays player name
displayPlayerName proc
	mov ah, 02h
	mov bh, 0
	mov dh, 1
	mov dl, 85
	int 10h
	mov startX, 10
	mov endX, 210
	
	mov startY, 05
	mov endY, 40
	
	mov color, 0h
	
	call drawShape
	mov ah, 02h
	mov bh, 0
	mov dh, 1 ; row
	mov dl, 85 ; column
	int 10h
	
	mov dx, offset playerName
	mov ah, 09h
	int 21h
	
	ret	
displayPlayerName endp

;; draws and displays score
displayScore proc
	mov ah, 02h
	mov bh, 0
	mov dh, 1
	mov dl, 220
	int 10h
	mov startX, 460
	mov endX, 630
	
	mov startY, 05
	mov endY, 40
	
	mov color, 0h
	
	call drawShape
	mov ah, 02h
	mov bh, 0
	mov dh, 1
	mov dl, 220
	int 10h
	
	mov dx, offset scoreStr
	mov ah, 09h
	int 21h
	
	mov ax, score
	call displayAX
	
	ret
	
displayScore endp
;; dipslays contents of register ax 
displayAX proc     
   mov bx, 10  
   mov dx, 0000h   
   mov cx, 0000h   
loop1:  
   mov dx, 0000h    
   div bx      
   push dx        
   inc cx         
   cmp ax, 0        
   jne loop1          
    
loop2:  
   pop dx       
   add dx, 30h     
   mov ah, 02h     
   int 21h         
   loop loop2       
   ret            
displayAX  ENDP

; drawing clouds

displayClouds proc

	mov cloudx, 100
	mov cloudy, 40
	
	mov cloudx1, 100
	mov cloudy1, 40
	
	mov reincloudx, 100
	mov reincloudy, 40

	call mycloud
	
	mov cloudx, 310
	mov cloudy, 70
	
	mov cloudx1, 310
	mov cloudy1, 70
	
	mov reincloudx, 310
	mov reincloudy, 70

	call mycloud
	
	mov cloudx, 510
	mov cloudy, 50

	mov cloudx1, 510
	mov cloudy1, 50
	
	mov reincloudx, 510
	mov reincloudy, 50

	call mycloud
	
	ret

displayClouds endp

resetHeartVariables proc
	mov varht1, 0
	mov heartxx, 0
	mov heartyy, 0
	mov heartxx1, 0
	mov heartyy1, 0
	mov varht2, 0
	
	ret
resetHeartVariables endp

; draws hearts

displayHearts proc
	
	mov startOfHeartsX, 250 ; starting of hearts
	mov ax, startOfHeartsX
	
	; prints first heart

	mov heartx, ax
	mov hearty, 7
	mov heartx1, ax
	mov hearty1, 7
	
	call resetHeartVariables
	call heart
	
	cmp lives, 1
	je forward
	
	; prints second heart
	
	add startOfHeartsX, 60
	mov ax, startOfHeartsX

	mov heartx, ax
	mov hearty, 7
	mov heartx1, ax
	mov hearty1, 7
	
	call resetHeartVariables
	call heart
	
	cmp lives, 2
	je forward
	
	; prints third heard
	
	add startOfHeartsX, 60
	mov ax, startOfHeartsX

	mov heartx, ax
	mov hearty, 7
	mov heartx1, ax
	mov hearty1, 7
	
	call resetHeartVariables
	call heart
	
	forward:
		ret

displayHearts endp

;; resets dino-related variables
resetDinoVariables proc
	
	mov taildinox, 0
	mov taildinoy, 0
	
	mov taildinox1, 0
	mov taildinoy1, 0
	
	mov flegx, 0
	mov flegy, 0
	
	mov flegx1, 0
	mov flegy1, 0
	
	mov slegx, 0
	mov slegy, 0
	
	mov slegx1, 0
	mov slegy1, 0
	
	mov eyex, 0
	mov eyey, 0
	
	mov eyex1, 0
	mov eyey1, 0
	
	mov armx, 0
	mov army, 0
	
	mov armx1, 0
	mov army1, 0
	
	;mov sty, 150
	;mov sty1, 150
	;mov ufosty, 150
	ret
resetDinoVariables endp
resetUFOVariables proc
	mov stx, 600
	mov sty, 150
	
	mov stx1, 600
	mov sty1, 150
	mov colufo, 40 ;10=green;20=dark grey;30=weird white;40=red;50=green;60=;70=green;80=purple;90=light pink;100=light blue
	
	mov ufostx, 600
	mov ufosty, 150
	
	ret
resetUFOVariables endp
;; draws dino
mydino proc	
	call resetDinoVariables ; every time dino is drawn, these are reset
	mov si,offset dinopixelx
	mov di,offset dinopixely
	
	mov cx,dinostx
	mov dinox,cx
	mov dinox1,cx
	
	mov cx,dinosty
	mov dinoy,cx
	mov dinoy1,cx
	
	mov cx,4
	outdino1:
		mov bx,cx
		mov cx,dinox1
		mov dinox,cx
		
		inc dinoy
		mov cx,10
		dino1:
			push cx
			
			mov cx,dinox
			mov dx,dinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			
			inc dinox
			pop cx
		loop dino1
		mov cx,bx
	loop outdino1
	
	mov cx,dinox1
	mov dinox,cx
	
	sub dinox,2
	sub dinox1,2
	;inc dinoy
	mov cx,4
	outdino2:
		mov bx,cx
		mov cx,dinox1
		mov dinox,cx
		
		inc dinoy
		mov cx,16
		dino2:
			push cx
			mov cx,dinox
			mov dx,dinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			
			inc dinox
			pop cx
		loop dino2
		mov cx,bx
	loop outdino2
	
	mov cx,dinox1
	mov dinox,cx
	
	sub dinox,2
	sub dinox1,2
	;inc dinoy
	mov cx,4
	outdino3:
		mov bx,cx
		mov cx,dinox1
		mov dinox,cx
		
		inc dinoy
		mov cx,20
		dino3:
			push cx
			mov cx,dinox
			mov dx,dinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc dinox
			pop cx
		loop dino3
		mov cx,bx
	loop outdino3
	
	mov cx,dinox1
	mov dinox,cx
	
	sub dinox,2
	sub dinox1,2
	;inc dinoy
	mov cx,4
	outdino4:
		mov bx,cx
		mov cx,dinox1
		mov dinox,cx
		
		inc dinoy
		mov cx,24
		dino4:
			push cx
			mov cx,dinox
			mov dx,dinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc dinox
			pop cx
		loop dino4
		mov cx,bx
	loop outdino4
	
	
	mov cx,dinox1
	mov dinox,cx
	
	mov eyex,cx
	mov eyex1,cx
	
	mov cx,dinoy
	mov eyey,cx
	mov eyey1,cx
	
	;inc dinoy
	mov cx,10
	outdino5:
		mov bx,cx
		mov cx,dinox1
		mov dinox,cx
		
		inc dinoy
		mov cx,24
		dino5:
			push cx
			mov cx,dinox
			mov dx,dinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc dinox
			pop cx
		loop dino5
		mov cx,bx
	loop outdino5
	
	mov cx,4
	outdino6:
		mov bx,cx
		mov cx,dinox1
		mov dinox,cx
		
		inc dinoy
		mov cx,22
		dino6:
			push cx
			mov cx,dinox
			mov dx,dinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc dinox
			pop cx
		loop dino6
		mov cx,bx
	loop outdino6
	
	;lipssssssssssssssssssss
	mov cx,8
	outdino7:
		mov bx,cx
		mov cx,dinox1
		mov dinox,cx
		
		add dinox,10
		;inc dinoy
		mov cx,12
		dino7:
			push cx
			mov cx,dinox
			mov dx,dinoy
			mov al,5
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc dinox
			pop cx
		loop dino7
		mov cx,bx
	loop outdino7
	;***********************
	mov cx,4
	outdino8:
		mov bx,cx
		mov cx,dinox1
		mov dinox,cx
		
		inc dinoy
		mov cx,18
		dino8:
			push cx
			mov cx,dinox
			mov dx,dinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc dinox
			pop cx
		loop dino8
		mov cx,bx
	loop outdino8
	
	mov cx,4
	outdino9:
		mov bx,cx
		mov cx,dinox1
		mov dinox,cx
		
		inc dinoy
		mov cx,14
		dino9:
			push cx
			mov cx,dinox
			mov dx,dinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc dinox
			pop cx
		loop dino9
		mov cx,bx
	loop outdino9
	
	mov cx,4
	outdino10:
		mov bx,cx
		mov cx,dinox1
		mov dinox,cx
		;sub dinox,1
		;sub dinox1,1
		
		inc dinoy
		mov cx,14
		dino10:
			push cx
			mov cx,dinox
			mov dx,dinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc dinox
			pop cx
		loop dino10
		mov cx,bx
	loop outdino10
	
	mov cx,dinox1
	mov dinox,cx
	sub dinox,1
	sub dinox1,1
	mov cx,4
	outdino11:
		mov bx,cx
		mov cx,dinox1
		mov dinox,cx
	
		inc dinoy
		mov cx,15
		dino11:
			push cx
			mov cx,dinox
			mov dx,dinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc dinox
			pop cx
		loop dino11
		mov cx,bx
	loop outdino11
	
	mov cx,dinox1
	mov dinox,cx
	
	mov taildinox,cx  ;giving coordinates for tail
	mov taildinox1,cx
	
	mov cx,dinoy
	mov taildinoy,cx
	mov taildinoy1,cx
	
	sub dinox,2
	sub dinox1,2
	mov cx,4
	outdino12:
		mov bx,cx
		mov cx,dinox1
		mov dinox,cx
	
		inc dinoy
		mov cx,17
		dino12:
			push cx
			mov cx,dinox
			mov dx,dinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc dinox
			pop cx
		loop dino12
		mov cx,bx
	loop outdino12
	
	mov cx,dinox1
	mov dinox,cx
	sub dinox,2
	sub dinox1,2
	mov cx,4
	outdino13:
		mov bx,cx
		mov cx,dinox1
		mov dinox,cx
	
		inc dinoy
		mov cx,19
		dino13:
			push cx
			mov cx,dinox
			mov dx,dinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc dinox
			pop cx
		loop dino13
		mov cx,bx
	loop outdino13
	
	mov cx,dinox1
	mov dinox,cx
	mov armx,cx ;value for arm
	mov armx1,cx
	
	mov cx,dinoy
	
	mov army,cx
	mov army1,cx
	
	sub dinox,2
	sub dinox1,2
	mov cx,4
	outdino14:
		mov bx,cx
		mov cx,dinox1
		mov dinox,cx
	
		inc dinoy
		mov cx,21
		dino14:
			push cx
			mov cx,dinox
			mov dx,dinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc dinox
			pop cx
		loop dino14
		mov cx,bx
	loop outdino14
	
	mov cx,dinox1
	mov dinox,cx
	sub dinox,2
	sub dinox1,2
	mov cx,4
	outdino15:
		mov bx,cx
		mov cx,dinox1
		mov dinox,cx
	
		inc dinoy
		mov cx,23
		dino15:
			push cx
			mov cx,dinox
			mov dx,dinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc dinox
			pop cx
		loop dino15
		mov cx,bx
	loop outdino15
	
	mov cx,dinox1
	mov dinox,cx
	sub dinox,2
	sub dinox1,2
	mov cx,4
	outdino16:
		mov bx,cx
		mov cx,dinox1
		mov dinox,cx
	
		inc dinoy
		mov cx,25
		dino16:
			push cx
			mov cx,dinox
			mov dx,dinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc dinox
			pop cx
		loop dino16
		mov cx,bx
	loop outdino16
	
	mov cx,dinox1
	mov dinox,cx
	;sub dinox,2
	;sub dinox1,2
	mov cx,8
	outdino17:
		mov bx,cx
		mov cx,dinox1
		mov dinox,cx
	
		inc dinoy
		mov cx,23
		dino17:
			push cx
			mov cx,dinox
			mov dx,dinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc dinox
			pop cx
		loop dino17
		mov cx,bx
	loop outdino17
	
	mov cx,dinox1
	mov dinox,cx
	;sub dinox,2
	;sub dinox1,2
	mov cx,4
	outdino18:
		mov bx,cx
		mov cx,dinox1
		mov dinox,cx
	
		inc dinoy
		mov cx,21
		dino18:
			push cx
			mov cx,dinox
			mov dx,dinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc dinox
			pop cx
		loop dino18
		mov cx,bx
	loop outdino18
	
	mov cx,dinox1
	mov dinox,cx
	;sub dinox,2
	;sub dinox1,2
	mov cx,4
	outdino19:
		mov bx,cx
		mov cx,dinox1
		mov dinox,cx
	
		inc dinoy
		mov cx,19
		dino19:
			push cx
			mov cx,dinox
			mov dx,dinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc dinox
			pop cx
		loop dino19
		mov cx,bx
	loop outdino19
	
	mov cx,dinox1
	mov dinox,cx
	;sub dinox,2
	;sub dinox1,2
	mov cx,4
	outdino20:
		mov bx,cx
		mov cx,dinox1
		mov dinox,cx
	
		inc dinoy
		mov cx,17
		dino20:
			push cx
			mov cx,dinox
			mov dx,dinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc dinox
			pop cx
		loop dino20
		mov cx,bx
	loop outdino20
	
	mov cx,dinox1
	mov dinox,cx
	
	mov flegx,cx
	mov flegx1,cx
	
	mov cx,dinoy
	mov flegy,cx
	mov flegy1,cx
	
	;sub dinox,2
	;sub dinox1,2
	mov cx,4
	outdino21:
		mov bx,cx
		mov cx,dinox1
		mov dinox,cx
	
		inc dinoy
		mov cx,15
		dino21:
			push cx
			mov cx,dinox
			mov dx,dinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc dinox
			pop cx
		loop dino21
		mov cx,bx
	loop outdino21
	;****************leg***************
	mov cx,flegx1
	mov flegx,cx
	;sub dinox,2
	;sub dinox1,2
	mov cx,flegy
	mov slegy,cx
	mov slegy1,cx
	mov cx,8
	outdino22:
		mov bx,cx
		mov cx,flegx1
		mov flegx,cx
	
		inc flegy
		mov cx,7
		dino22:
			push cx
			mov cx,flegx
			mov dx,flegy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc flegx
			pop cx
		loop dino22
		mov cx,bx
	loop outdino22
	
	mov  cx,flegx
	mov slegx,cx
	mov slegx1,cx
	
	
	
	mov cx,flegx1
	mov flegx,cx
	;sub dinox,2
	;sub dinox1,2
	add flegx,1
	add flegx1,1
	
	mov cx,4
	outdino23:
		mov bx,cx
		mov cx,flegx1
		mov flegx,cx
	
		inc flegy
		mov cx,5
		dino23:
			push cx
			mov cx,flegx
			mov dx,flegy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc flegx
			pop cx
		loop dino23
		mov cx,bx
	loop outdino23
	
	mov cx,flegx1
	mov flegx,cx
	;sub dinox,2
	;sub dinox1,2
	add flegx,1
	add flegx1,1
	
	mov cx,4
	outdino24:
		mov bx,cx
		mov cx,flegx1
		mov flegx,cx
	
		inc flegy
		mov cx,3
		dino24:
			push cx
			mov cx,flegx
			mov dx,flegy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc flegx
			pop cx
		loop dino24
		mov cx,bx
	loop outdino24
	
	
	
	
	;******************second leg
	
	
	mov cx,slegx1
	mov slegx,cx
	;sub dinox,2
	;sub dinox1,2
	mov cx,8
	outdino25:
		mov bx,cx
		mov cx,slegx1
		mov slegx,cx
	
		inc slegy
		mov cx,7
		dino25:
			push cx
			mov cx,slegx
			mov dx,slegy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc slegx
			pop cx
		loop dino25
		mov cx,bx
	loop outdino25
	
	
	mov cx,slegx1
	mov slegx,cx
	;sub dinox,2
	;sub dinox1,2
	add slegx,1
	add slegx1,1
	
	mov cx,4
	outdino26:
		mov bx,cx
		mov cx,slegx1
		mov slegx,cx
	
		inc slegy
		mov cx,5
		dino26:
			push cx
			mov cx,slegx
			mov dx,slegy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc slegx
			pop cx
		loop dino26
		mov cx,bx
	loop outdino26
	
	mov cx,slegx1
	mov slegx,cx
	;sub dinox,2
	;sub dinox1,2
	add slegx,1
	add slegx1,1
	
	mov cx,4
	outdino27:
		mov bx,cx
		mov cx,slegx1
		mov slegx,cx
	
		inc slegy
		mov cx,3
		dino27:
			push cx
			mov cx,slegx
			mov dx,slegy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc slegx
			pop cx
		loop dino27
		mov cx,bx
	loop outdino27
	;**************************tail
	sub taildinox,25
	sub taildinox1,25
	
	mov cx,taildinox1
	mov taildinox,cx
	;sub dinox,2
	;sub dinox1,2
	add taildinox,1
	add taildinox1,1
	
	mov cx,6
	outdino28:
		mov bx,cx
		mov cx,taildinox1
		mov taildinox,cx
	
		inc taildinoy
		mov cx,3
		dino28:
			push cx
			mov cx,taildinox
			mov dx,taildinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc taildinox
			pop cx
		loop dino28
		mov cx,bx
	loop outdino28
	
	mov cx,taildinox1
	mov taildinox,cx
	;sub dinox,2
	;sub dinox1,2
	;add taildinox,1
	;add taildinox1,1
	
	mov cx,4
	outdino29:
		mov bx,cx
		mov cx,taildinox1
		mov taildinox,cx
	
		inc taildinoy
		mov cx,5
		dino29:
			push cx
			mov cx,taildinox
			mov dx,taildinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc taildinox
			pop cx
		loop dino29
		mov cx,bx
	loop outdino29
	
	mov cx,taildinox1
	mov taildinox,cx
	;sub dinox,2
	;sub dinox1,2
	;add taildinox,1
	;add taildinox1,1
	
	mov cx,4
	outdino30:
		mov bx,cx
		mov cx,taildinox1
		mov taildinox,cx
	
		inc taildinoy
		mov cx,7
		dino30:
			push cx
			mov cx,taildinox
			mov dx,taildinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc taildinox
			pop cx
		loop dino30
		mov cx,bx
	loop outdino30
	
	mov cx,taildinox1
	mov taildinox,cx
	;sub dinox,2
	;sub dinox1,2
	add taildinox,1
	add taildinox1,1
	
	mov cx,4
	outdino31:
		mov bx,cx
		mov cx,taildinox1
		mov taildinox,cx
	
		inc taildinoy
		mov cx,14
		dino31:
			push cx
			mov cx,taildinox
			mov dx,taildinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc taildinox
			pop cx
		loop dino31
		mov cx,bx
	loop outdino31
	
	
	mov cx,taildinox1
	mov taildinox,cx
	;sub dinox,2
	;sub dinox1,2
	add taildinox,1
	add taildinox1,1
	
	mov cx,4
	outdino32:
		mov bx,cx
		mov cx,taildinox1
		mov taildinox,cx
	
		inc taildinoy
		mov cx,14
		dino32:
			push cx
			mov cx,taildinox
			mov dx,taildinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc taildinox
			pop cx
		loop dino32
		mov cx,bx
	loop outdino32
	
	mov cx,taildinox1
	mov taildinox,cx
	;sub dinox,2
	;sub dinox1,2
	add taildinox,1
	add taildinox1,1
	
	mov cx,4
	outdino33:
		mov bx,cx
		mov cx,taildinox1
		mov taildinox,cx
	
		inc taildinoy
		mov cx,14
		dino33:
			push cx
			mov cx,taildinox
			mov dx,taildinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc taildinox
			pop cx
		loop dino33
		mov cx,bx
	loop outdino33
	
	mov cx,taildinox1
	mov taildinox,cx
	;sub dinox,2
	;sub dinox1,2
	add taildinox,1
	add taildinox1,1
	
	mov cx,4
	outdino34:
		mov bx,cx
		mov cx,taildinox1
		mov taildinox,cx
	
		inc taildinoy
		mov cx,14
		dino34:
			push cx
			mov cx,taildinox
			mov dx,taildinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc taildinox
			pop cx
		loop dino34
		mov cx,bx
	loop outdino34
	
	mov cx,taildinox1
	mov taildinox,cx
	;sub dinox,2
	;sub dinox1,2
	add taildinox,1
	add taildinox1,1
	
	mov cx,4
	outdino35:
		mov bx,cx
		mov cx,taildinox1
		mov taildinox,cx
	
		inc taildinoy
		mov cx,14
		dino35:
			push cx
			mov cx,taildinox
			mov dx,taildinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc taildinox
			pop cx
		loop dino35
		mov cx,bx
	loop outdino35
	
	mov cx,taildinox1
	mov taildinox,cx
	;sub dinox,2
	;sub dinox1,2
	add taildinox,1
	add taildinox1,1
	
	mov cx,4
	outdino36:
		mov bx,cx
		mov cx,taildinox1
		mov taildinox,cx
	
		inc taildinoy
		mov cx,14
		dino36:
			push cx
			mov cx,taildinox
			mov dx,taildinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc taildinox
			pop cx
		loop dino36
		mov cx,bx
	loop outdino36
	
	mov cx,taildinox1
	mov taildinox,cx
	;sub dinox,2
	;sub dinox1,2
	add taildinox,2
	add taildinox1,2
	
	mov cx,4
	outdino37:
		mov bx,cx
		mov cx,taildinox1
		mov taildinox,cx
	
		inc taildinoy
		mov cx,14
		dino37:
			push cx
			mov cx,taildinox
			mov dx,taildinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc taildinox
			pop cx
		loop dino37
		mov cx,bx
	loop outdino37
	
	
	mov cx,taildinox1
	mov taildinox,cx
	;sub dinox,2
	;sub dinox1,2
	add taildinox,2
	add taildinox1,2
	
	mov cx,4
	outdino38:
		mov bx,cx
		mov cx,taildinox1
		mov taildinox,cx
	
		inc taildinoy
		mov cx,14
		dino38:
			push cx
			mov cx,taildinox
			mov dx,taildinoy
			mov al,coldino
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc taildinox
			pop cx
		loop dino38
		mov cx,bx
	loop outdino38
	
	add eyex,6
	add eyex1,6
	
	sub eyey,2
	sub eyey1,2
	mov cx,eyex1
	mov eyex,cx
	;sub dinox,2
	;sub dinox1,2
	add eyex,2
	add eyex1,2
	
	mov cx,8
	outdino39:
		mov bx,cx
		mov cx,eyex1
		mov eyex,cx
	
		inc eyey
		mov cx,4
		dino39:
			push cx
			mov cx,eyex
			mov dx,eyey
			mov al,0
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc eyex
			pop cx
		loop dino39
		mov cx,bx
	loop outdino39
	
	add armx,10
	add armx1,10
	mov cx,armx1
	mov armx,cx
	;sub dinox,2
	;sub dinox1,2
	;add armx,2
	;add armx1,2
	
	mov cx,4
	outdino40:
		mov bx,cx
		mov cx,armx1
		mov armx,cx
	
		inc army
		mov cx,15
		dino40:
			push cx
			mov cx,armx
			mov dx,army
			mov al,0 ;keep this 0
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc armx
			pop cx
		loop dino40
		mov cx,bx
	loop outdino40
	
	
	mov cx,4
	outdino41:
		mov bx,cx
		mov cx,army1
		mov army,cx
	
		inc army
		mov cx,5
		dino41:
			push cx
			mov cx,armx
			mov dx,army
			mov al,0 ;keep this 0
			mov ah,0ch
			int 10h
			mov [si],cx
			mov [di],dx
			inc si
			inc di
			inc army
			pop cx
		loop dino41
		mov cx,bx
	loop outdino41
	
	mov cx,dinostx
	mov dinox,cx
	mov dinox1,cx
	
	mov cx,dinosty
	mov dinoy,cx
	mov dinoy1,cx
	
	
	
	ret
mydino endp
ufo proc
	mov si,offset ufopixelx
	mov di,offset ufopixely
	mov cx,6;10
	glass:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass
	
	mov cx,stx1
	mov stx,cx
	
	sub stx,2
	sub stx1,2
	inc sty
	mov cx,10;14
	glass1:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass1
	
	mov cx,stx1
	mov stx,cx
	
	sub stx,2
	sub stx1,2
	inc sty
	mov cx,14;18
	glass2:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass2
	
	mov cx,stx1
	mov stx,cx
	
	sub stx,1
	sub stx1,1
	inc sty
	mov cx,16;20
	glass3:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass3
	
	mov cx,stx1
	mov stx,cx
	
	sub stx,1
	sub stx1,1
	inc sty
	mov cx,18;22
	glass4:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass4
	
	mov cx,stx1
	mov stx,cx
	
	sub stx,1
	sub stx1,1
	inc sty
	mov cx,20;24
	glass5:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass5
	
	mov cx,stx1
	mov stx,cx
	inc sty
	mov cx,20;24
	glass6:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass6
	
	mov cx,stx1
	mov stx,cx
	inc sty
	mov cx,20;24
	glass7:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass7
	
	mov cx,stx1
	mov stx,cx
	inc sty
	mov cx,20;24
	glass8:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass8
	
	mov cx,stx1
	mov stx,cx
	inc sty
	mov cx,20;24
	glass9:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass9
	
	mov cx,stx1
	mov stx,cx
	inc sty
	mov cx,20;24
	glass10:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass10
	
	mov cx,stx1
	mov stx,cx
	inc sty
	mov cx,20;24
	glass11:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass11
	
	mov cx,stx1
	mov stx,cx
	inc sty
	mov cx,20;24
	glass12:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass12
	
	mov cx,stx1
	mov stx,cx
	inc sty
	mov cx,20;24
	glass13:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass13
	
	mov cx,stx1
	mov stx,cx
	inc sty
	mov cx,20;24
	glass14:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass14
	
	mov cx,stx1
	mov stx,cx
	inc sty
	mov cx,20;24
	glass15:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass15
	
	mov cx,stx1
	mov stx,cx
	
	mov colufo,20;60 ;10=green;20=dark grey;30=weird white;40=red;50=green;60=;70=green;80=purple;90=light pink;100=light blue
	sub stx,1
	sub stx1,1
	inc sty
	mov cx,22;26
	glass16:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass16
	
	mov cx,stx1
	mov stx,cx
	
	mov colufo,100;10=green;20=dark grey;30=weird white;40=red;50=green;60=;70=green;80=purple;90=light pink;100=light blue
	sub stx,1
	sub stx1,1
	inc sty
	mov cx,24;28
	glass17:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass17
	
	mov cx,stx1
	mov stx,cx
	
	mov colufo,20 ;60 ;10=green;20=dark grey;30=weird white;40=red;50=green;60=;70=green;80=purple;90=light pink;100=light blue
	sub stx,2
	sub stx1,2
	inc sty
	mov cx,28
	glass18:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass18
	
	mov cx,stx1
	mov stx,cx
	
	mov colufo,20;80 ;10=green;20=dark grey;30=weird white;40=red;50=green;60=;70=green;80=purple;90=light pink;100=light blue
	sub stx,2
	sub stx1,2
	inc sty
	mov cx,32
	glass19:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass19
	
	mov cx,stx1
	mov stx,cx
	
	;mov col,80
	sub stx,2
	sub stx1,2
	inc sty
	mov cx,36
	glass20:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass20
	
	mov cx,stx1
	mov stx,cx
	
	;mov col,80
	sub stx,2
	sub stx1,2
	inc sty
	mov cx,40
	glass21:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass21
	
	mov cx,stx1
	mov stx,cx
	
	mov colufo,30 ;10=green;20=dark grey;30=weird white;40=red;50=green;60=;70=green;80=purple;90=light pink;100=light blue
	inc sty
	mov cx,40
	glass22:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass22
	
	mov cx,stx1
	mov stx,cx
	
	mov colufo,30;90
	add stx,2
	add stx1,2
	inc sty
	mov cx,36
	glass23:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass23
	
	mov cx,stx1
	mov stx,cx
	
	mov colufo,30;90
	add stx,2
	add stx1,2
	inc sty
	mov cx,32
	glass24:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass24
	
	mov cx,stx1
	mov stx,cx
	
	;***************lights************
	mov colufo,14 ;10=green;20=dark grey;30=weird white;40=red;50=green;60=;70=green;80=purple;90=light pink;100=light blue
	add stx,4
	add stx1,4
	inc sty
	mov cx,5
	glass25:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass25
	
	mov colufo,14
	add stx,4
	add stx1,4
	;inc sty
	mov cx,5
	glass26:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass26
	
	mov colufo,14
	add stx,4
	add stx1,4
	;inc sty
	mov cx,5
	glass27:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass27
	
	mov cx,stx1
	mov stx,cx
	
	mov colufo,14
	add stx,2
	add stx1,2
	inc sty
	mov cx,3
	glass28:
		push cx
		mov cx,stx
		mov dx,sty
		mov al,colufo
		mov ah,0ch
		int 10h
		mov [si],cx
		mov [di],dx
		inc si
		inc di
		inc stx
		pop cx
	loop glass28
	
	mov cx, ufostx
	mov stx, cx
	mov stx1, cx
	
	mov cx,0
	
	mov cx, ufosty
	mov sty, cx
	mov sty1, cx
	
	mov colufo, 10
	
	;mov ufosty ,150
	;mov sty ,150
	;mov sty1 ,150
	
	ret
	
		
ufo endp
MUSHROOM PROC
;1st line
	mov cx,2
L1:
	push cx
	mov cx,26
L2:	
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L2
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L1	
;2nd line
mov cx,mushroomX1
	mov mushroomX,cx
	sub mushroomX,3
	sub mushroomX1,3
	
	mov cx,mushroomY
	mov mushroomY1,cx
;Blue pixel	
mov cx,2
L3:
	push cx
	mov cx,6
L4:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L4
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L3
;White pixel	
	add mushroomX1,6
	mov cx,mushroomX1
	mov mushroomX,cx
	
	mov cx,mushroomY1
	mov mushroomY,cx
mov cx,2
L11:
	push cx
	mov cx,4
L12:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L12
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L11
;....Green Part....	
	mov cx,mushroomY1
	mov mushroomY,cx
	
	mov cx,mushroomX1
	add mushroomX1,4
	mov cx,mushroomX1
	mov mushroomX,cx
mov cx,2
L5:  
	push cx
	mov cx,16
L6:
	push cx
	mov al,0Ah
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L6
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L5
;White pixel	
	add mushroomX1,12
	mov cx,mushroomX1
	mov mushroomX,cx
	
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L9:
	push cx
	mov cx,8
L10:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L10
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L9
;Blue Line
	mov cx,mushroomX1
	add mushroomX1,4
	mov cx,mushroomX1
	mov mushroomX,cx
	
	mov cx,mushroomY1
	mov mushroomY,cx
	
mov cx,2
L7:
	push cx
	mov cx,5
L8:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L8
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L7
;3rd line starting
	mov cx,mushroomY
	mov mushroomY1,cx
	
	sub mushroomX1,28
	sub mushroomX,28
	
	mov cx,mushroomX
	mov mushroomX3,cx
	
;Blue line
mov cx,2	
L13:
	push cx
	mov cx,6
L14:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L14
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L13
;White pixel
	mov cx,mushroomY1
	mov mushroomY,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
mov cx,2
L15:
	push cx
	mov cx,6
L16:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L16
	mov cx,mushroomX
	mov mushroomX1,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L15
;Green Part
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	
mov cx,2
L17:
	push cx
	mov cx,12
L18:
	push cx
	mov al,0Ah
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L18
	mov cx,mushroomX
	mov mushroomX2,cx
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L17
;White Pixels
	mov cx,mushroomY1
	mov mushroomY,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
mov cx,2
L19:
	push cx
	mov cx,6
L20:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L20
	mov cx,mushroomX
	mov mushroomX1,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L19
;Blue line
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
mov cx,2	
L21:
	push cx
	mov cx,5
L22:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L22
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L21
;4th line
mov cx,mushroomY
mov mushroomY1,cx
	sub mushroomX3,2
	mov cx,mushroomX3
	mov mushroomX,cx
	mov mushroomX1,cx
;Blue Line
mov cx,2
L23:
	push cx
	mov cx,5
L24:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L24
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L23
;Green pixel
	mov cx,mushroomX2
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L25:
	push cx
	mov cx,3
L26:
	push cx
	mov al,0Ah
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L26
	mov cx,mushroomX
	mov mushroomX1,cx
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L25
;White pixels
	mov cx,mushroomY1
	mov mushroomY,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
mov cx,2
L27:
	push cx
	mov cx,3
L28:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L28
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L27
;Green Pixels
	mov cx,mushroomX2
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L29:
	push cx
	mov cx,18
L30:
	push cx
	mov al,0Ah
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L30
	mov cx,mushroomX
	mov mushroomX1,cx
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L29
;White pixel
	mov cx,mushroomY1
	mov mushroomY,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
mov cx,2
L31:
	push cx
	mov cx,3
L32:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L32
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L31
;Green Pixel
	mov cx,mushroomX2
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L33:
	push cx
	mov cx,3
L34:
	push cx
	mov al,0Ah
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L34
	mov cx,mushroomX
	mov mushroomX1,cx
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L33
;Blue line
	mov cx,mushroomY1
	mov mushroomY,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
mov cx,2
L35:
	push cx
	mov cx,4
L36:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L36
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L35
;5th line
mov cx,mushroomX3
mov mushroomX,cx
mov mushroomX1,cx
mov cx,mushroomY
mov mushroomY1,cx
;Blue line
mov cx,2
L37:
	push cx
	mov cx,3
L38:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L38
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L37
;White pixel
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,mushroomX2
	mov mushroomX,cx
mov cx,2
L39:
	push cx
	mov cx,2
L40:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L40
	mov cx,mushroomX
	mov mushroomX1,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L39
;Green pixel
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L41:
	push cx
	mov cx,30
L42:
	push cx
	mov al,0Ah
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L42
	mov cx,mushroomX
	mov mushroomX2,cx
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L41
;White pixel
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,mushroomX2
	mov mushroomX,cx
mov cx,2
L43:
	push cx
	mov cx,2
L44:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L44
	mov cx,mushroomX
	mov mushroomX1,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L43
;Blue line
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L45:
	push cx
	mov cx,2
L46:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L46
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L45
;6th line
	sub mushroomX3,2
	mov cx,mushroomX3
	mov mushroomX,cx
	mov mushroomX1,cx
	
	mov cx,mushroomY
	mov mushroomY1,cx
;blue line	
	mov cx,2
L47:
	push cx
	mov cx,4
L48:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L48
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L47
;White pixel
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,mushroomX2
	mov mushroomX,cx
mov cx,2
L49:
	push cx
	mov cx,6
L50:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L50
	mov cx,mushroomX
	mov mushroomX1,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L49
;Green pixel
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L51:
	push cx
	mov cx,6
L52:
	push cx
	mov al,0Ah
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L52
	mov cx,mushroomX
	mov mushroomX2,cx
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L51
;White pixel
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,mushroomX2
	mov mushroomX,cx
mov cx,2
L53:
	push cx
	mov cx,10
L54:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L54
	mov cx,mushroomX
	mov mushroomX1,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L53
;Green pixel
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L55:
	push cx
	mov cx,6
L56:
	push cx
	mov al,0Ah
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L56
	mov cx,mushroomX
	mov mushroomX2,cx
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L55
;White pixel
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,mushroomX2
	mov mushroomX,cx
mov cx,2
L57:
	push cx
	mov cx,7
L58:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L58
	mov cx,mushroomX
	mov mushroomX1,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L57
;Blue line
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L59:
	push cx
	mov cx,3
L60:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L60
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L59
;7th line
	mov cx,mushroomX3
	mov mushroomX,cx
	mov mushroomX1,cx
	
	mov cx,mushroomY
	mov mushroomY1,cx
	
;blue line	
	mov cx,2
L61:
	push cx
	mov cx,4
L62:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L62
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L61
;White pixel
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,mushroomX2
	mov mushroomX,cx
mov cx,2
L63:
	push cx
	mov cx,6
L64:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L64
	mov cx,mushroomX
	mov mushroomX1,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L63
;Green pixel
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L65:
	push cx
	mov cx,3
L66:
	push cx
	mov al,0Ah
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L66
	mov cx,mushroomX
	mov mushroomX2,cx
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L65
;White pixel
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,mushroomX2
	mov mushroomX,cx
mov cx,2
L67:
	push cx
	mov cx,16
L68:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L68
	mov cx,mushroomX
	mov mushroomX1,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L67
;Green pixel
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L69:
	push cx
	mov cx,3
L70:
	push cx
	mov al,0Ah
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L70
	mov cx,mushroomX
	mov mushroomX2,cx
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L69
;White pixel
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,mushroomX2
	mov mushroomX,cx
mov cx,2
L71:
	push cx
	mov cx,7
L72:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L72
	mov cx,mushroomX
	mov mushroomX1,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L71
;Blue line
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L73:
	push cx
	mov cx,3
L74:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L74
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L73	
;8th line
	mov cx,mushroomX3
	mov mushroomX,cx
	mov mushroomX1,cx
	
	mov cx,mushroomY
	mov mushroomY1,cx
	
;blue line	
	mov cx,2
L75:
	push cx
	mov cx,4
L76:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L76
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L75
;White pixel
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,mushroomX2
	mov mushroomX,cx
mov cx,2
L77:
	push cx
	mov cx,6
L78:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L78
	mov cx,mushroomX
	mov mushroomX1,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L77
;Green pixel
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L79:
	push cx
	mov cx,3
L80:
	push cx
	mov al,0Ah
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L80
	mov cx,mushroomX
	mov mushroomX2,cx
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L79
;White pixel
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,mushroomX2
	mov mushroomX,cx
mov cx,2
L81:
	push cx
	mov cx,16
L82:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L82
	mov cx,mushroomX
	mov mushroomX1,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L81
;Green pixel
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L83:
	push cx
	mov cx,3
L84:
	push cx
	mov al,0Ah
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L84
	mov cx,mushroomX
	mov mushroomX2,cx
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L83
;White pixel
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,mushroomX2
	mov mushroomX,cx
mov cx,2
L85:
	push cx
	mov cx,7
L86:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L86
	mov cx,mushroomX
	mov mushroomX1,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L85
;Blue line
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L87:
	push cx
	mov cx,3
L88:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L88
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L87
;9th line
	mov cx,mushroomX3
	mov mushroomX,cx
	mov mushroomX1,cx
	
	mov cx,mushroomY
	mov mushroomY1,cx
	
;blue line	
	mov cx,2
L89:
	push cx
	mov cx,4
L90:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L90
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L89
;White pixel
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,mushroomX2
	mov mushroomX,cx
mov cx,2
L91:
	push cx
	mov cx,6
L92:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L92
	mov cx,mushroomX
	mov mushroomX1,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L91
;Green pixel
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L93:
	push cx
	mov cx,3
L94:
	push cx
	mov al,0Ah
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L94
	mov cx,mushroomX
	mov mushroomX2,cx
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L93
;White pixel
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,mushroomX2
	mov mushroomX,cx
mov cx,2
L95:
	push cx
	mov cx,16
L96:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L96
	mov cx,mushroomX
	mov mushroomX1,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L95
;Green pixel
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L97:
	push cx
	mov cx,3
L98:
	push cx
	mov al,0Ah
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L98
	mov cx,mushroomX
	mov mushroomX2,cx
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L97
;White pixel
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,mushroomX2
	mov mushroomX,cx
mov cx,2
L99:
	push cx
	mov cx,7
L100:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L100
	mov cx,mushroomX
	mov mushroomX1,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L99
;Blue line
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L101:
	push cx
	mov cx,3
L102:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L102
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L101
;10th line
	mov cx,mushroomX3
	mov mushroomX,cx
	mov mushroomX1,cx
	
	mov cx,mushroomY
	mov mushroomY1,cx
;Blue Line
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L103:
	push cx
	mov cx,4
L104:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L104
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L103
;Green pixel
	mov cx,mushroomX2
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L105:
	push cx
	mov cx,12
L106:
	push cx
	mov al,0Ah
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L106
	mov cx,mushroomX
	mov mushroomX1,cx
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L105
;White pixels
	mov cx,mushroomY1
	mov mushroomY,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
mov cx,2
L107:
	push cx
	mov cx,10
L108:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L108
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L107
;Green Pixels
	mov cx,mushroomX2
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L109:
	push cx
	mov cx,13
L110:
	push cx
	mov al,0Ah
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L110
	mov cx,mushroomX
	mov mushroomX1,cx
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L109
;Blue line
	mov cx,mushroomY1
	mov mushroomY,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
mov cx,2
L111:
	push cx
	mov cx,3
L112:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L112
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L111
;11th line
	mov cx,mushroomX3
	mov mushroomX,cx
	mov mushroomX1,cx
	
	mov cx,mushroomY
	mov mushroomY1,cx
;Blue Line
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L113:
	push cx
	mov cx,4
L114:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L114
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L113
;Green pixel
	mov cx,mushroomX2
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L115:
	push cx
	mov cx,6
L116:
	push cx
	mov al,0Ah
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L116
	mov cx,mushroomX
	mov mushroomX1,cx
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L115
;Blue line
mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L117:
	push cx
	mov cx,22
L118:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L118
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L117
;Green pixel
	mov cx,mushroomX2
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L119:
	push cx
	mov cx,7
L120:
	push cx
	mov al,0Ah
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L120
	mov cx,mushroomX
	mov mushroomX1,cx
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L119
;Blue line
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L121:
	push cx
	mov cx,3
L122:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L122
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L121
;12th line
	mov cx,mushroomX3
	mov mushroomX,cx
	mov mushroomX1,cx
	
	mov cx,mushroomY
	mov mushroomY1,cx
;Blue Line
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L123:
	push cx
	mov cx,13
L124:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L124
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L123
;White pixel
	mov cx,mushroomY1
	mov mushroomY,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
mov cx,2
L125:
	push cx
	mov cx,4
L126:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L126
	mov cx,mushroomX
	mov mushroomX1,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L125
;Blue line
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L127:
	push cx
	mov cx,2
L128:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L128
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L127
;White pixel
	mov cx,mushroomY1
	mov mushroomY,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
mov cx,2
L129:
	push cx
	mov cx,4
L130:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L130
	mov cx,mushroomX
	mov mushroomX1,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L129
;Blue line
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L131:
	push cx
	mov cx,2
L132:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L132
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L131
;White pixel
	mov cx,mushroomY1
	mov mushroomY,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
mov cx,2
L133:
	push cx
	mov cx,4
L134:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L134
	mov cx,mushroomX
	mov mushroomX1,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L133
;Blue line
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L135:
	push cx
	mov cx,13
L136:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L136
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L135
;13th line
	add mushroomX3,3
	mov cx,mushroomX3
	mov mushroomX,cx
	mov mushroomX1,cx
	
	mov cx,mushroomY
	mov mushroomY1,cx
;Blue Line
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L137:
	push cx
	mov cx,8
L138:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L138
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L137
;White pixel
	mov cx,mushroomY1
	mov mushroomY,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
mov cx,2
L139:
	push cx
	mov cx,6
L140:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L140
	mov cx,mushroomX
	mov mushroomX1,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L139
;Blue line
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L141:
	push cx
	mov cx,2
L142:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L142
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L141
;White pixel
	mov cx,mushroomY1
	mov mushroomY,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
mov cx,2
L143:
	push cx
	mov cx,4
L144:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L144
	mov cx,mushroomX
	mov mushroomX1,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L143
;Blue line
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L145:
	push cx
	mov cx,2
L146:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L146
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L145
;White pixel
	mov cx,mushroomY1
	mov mushroomY,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
mov cx,2
L147:
	push cx
	mov cx,6
L148:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L148
	mov cx,mushroomX
	mov mushroomX1,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L147
;Blue line
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L149:
	push cx
	mov cx,8
L150:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L150
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L149
;14th line
	add mushroomX3,2
	mov cx,mushroomX3
	mov mushroomX,cx
	mov mushroomX1,cx
	
	mov cx,mushroomY
	mov mushroomY1,cx
;Blue Line
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L151:
	push cx
	mov cx,6
L152:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L152
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L151
;White pixel
	mov cx,mushroomY1
	mov mushroomY,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
mov cx,2
L153:
	push cx
	mov cx,20
L154:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L154
	mov cx,mushroomX
	mov mushroomX1,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L153
;Blue Line
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L155:
	push cx
	mov cx,6
L156:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L156
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L155
;15th line
	mov cx,mushroomX3
	mov mushroomX,cx
	mov mushroomX1,cx
	
	mov cx,mushroomY
	mov mushroomY1,cx
;Blue Line
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L157:
	push cx
	mov cx,6
L158:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L158
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L157
;White pixel
	mov cx,mushroomY1
	mov mushroomY,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
	mov cx,2
L159:
	push cx
	mov cx,20
L160:
	push cx
	mov al,0Fh
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L160
	mov cx,mushroomX
	mov mushroomX1,cx
	
	mov cx,mushroomX2
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L159
;Blue Line
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L161:
	push cx
	mov cx,6
L162:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L162
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L161
;16th line
	add mushroomX3,2
	mov cx,mushroomX3
	mov mushroomX,cx
	mov mushroomX1,cx
	
	mov cx,mushroomY
	mov mushroomY1,cx
;Blue Line
	mov cx,mushroomX1
	mov mushroomX,cx
	mov cx,mushroomY1
	mov mushroomY,cx
	mov cx,2
L163:
	push cx
	mov cx,28
L164:
	push cx
	mov al,01h
	mov cx,mushroomX
	mov dx,mushroomY
	mov ah,0ch
	int 10h
	inc mushroomX
	pop cx
Loop L164
	mov cx,mushroomX
	mov mushroomX2,cx
	
	mov cx,mushroomX1
	mov mushroomX,cx
	inc mushroomY
	pop cx
Loop L163
mov cx,xrein
mov mushroomX,cx
mov mushroomX1,cx
mov cx,yrein
mov mushroomY,cx
mov mushroomY1,cx
ret
MUSHROOM ENDP

heart proc

	mov cx,heartx
	add cx,26
	mov heartxx,cx
	
	mov cx,hearty
	mov heartyy,cx
	
	mov cx,heartx
	add cx,26
	mov heartxx1,cx
	
	mov cx,hearty
	mov heartyy1,cx

	mov cx,8
	heart1:
		push cx
		mov cx,heartx
		mov dx,hearty
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartx
		pop cx
	
	loop heart1
	mov cx,heartx1
	mov heartx,cx
	
	sub heartx,2
	sub heartx1,2
	inc hearty
	mov cx,12
	heart2:
		push cx
		mov cx,heartx
		mov dx,hearty
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartx
		pop cx
	
	loop heart2
	
	mov cx,heartx1
	mov heartx,cx
	
	sub heartx,2
	sub heartx1,2
	inc hearty
	mov cx,16
	heart3:
		push cx
		mov cx,heartx
		mov dx,hearty
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartx
		pop cx
	
	loop heart3
	
	mov cx,heartx1
	mov heartx,cx
	
	sub heartx,2
	sub heartx1,2
	inc hearty
	mov cx,20
	heart4:
		push cx
		mov cx,heartx
		mov dx,hearty
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartx
		pop cx
	
	loop heart4
	
	mov cx,heartx1
	mov heartx,cx
	
	sub heartx,2
	sub heartx1,2
	inc hearty
	mov cx,24
	heart5:
		push cx
		mov cx,heartx
		mov dx,hearty
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartx
		pop cx
	
	loop heart5
	
	mov cx,heartx1
	mov heartx,cx
	
	sub heartx,1
	sub heartx1,1
	inc hearty
	mov cx,25
	heart6:
		push cx
		mov cx,heartx
		mov dx,hearty
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartx
		pop cx
	
	loop heart6
	
	mov cx,heartx1
	mov heartx,cx
	
	sub heartx,1
	sub heartx1,1
	inc hearty
	mov cx,26
	heart7:
		push cx
		mov cx,heartx
		mov dx,hearty
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartx
		pop cx
	
	loop heart7
	
	mov cx,5
	outheart:
		mov bx,cx
		mov cx,heartx1
		mov heartx,cx
		
		inc hearty
		mov cx,26
		heart8:
			push cx
			mov cx,heartx
			mov dx,hearty
			mov al,heartColor
			mov ah,0ch
			int 10h
			inc heartx
			pop cx
		
		loop heart8
	
		mov cx,bx
	loop outheart
	
	mov cx,heartx1
	mov heartx,cx
	
	add heartx,1
	add heartx1,1
	inc hearty
	mov cx,25
	heart9:
		push cx
		mov cx,heartx
		mov dx,hearty
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartx
		pop cx
	
	loop heart9
	
	mov cx,heartx1
	mov heartx,cx
	
	add heartx,1
	add heartx1,1
	inc hearty
	mov cx,24
	heart10:
		push cx
		mov cx,heartx
		mov dx,hearty
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartx
		pop cx
	
	loop heart10
	
	mov cx,heartx1
	mov heartx,cx
	
	add heartx,1
	add heartx1,1
	inc hearty
	mov cx,23
	heart11:
		push cx
		mov cx,heartx
		mov dx,hearty
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartx
		pop cx
	
	loop heart11
	
	mov cx,heartx1
	mov heartx,cx
	
	add heartx,1
	add heartx1,1
	inc hearty
	mov cx,22
	heart12:
		push cx
		mov cx,heartx
		mov dx,hearty
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartx
		pop cx
	
	loop heart12
	
	mov cx,heartx1
	mov heartx,cx
	
	add heartx,1
	add heartx1,1
	inc hearty
	mov cx,21
	heart13:
		push cx
		mov cx,heartx
		mov dx,hearty
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartx
		pop cx
	
	loop heart13
	
	mov cx,heartx1
	mov heartx,cx
	
	add heartx,1
	add heartx1,1
	inc hearty
	mov cx,20
	heart14:
		push cx
		mov cx,heartx
		mov dx,hearty
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartx
		pop cx
	
	loop heart14
	
	mov cx,heartx1
	mov heartx,cx
	
	add heartx,1
	add heartx1,1
	inc hearty
	mov cx,19
	heart15:
		push cx
		mov cx,heartx
		mov dx,hearty
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartx
		pop cx
	
	loop heart15
	
	mov cx,heartx1
	mov heartx,cx
	
	add heartx,1
	add heartx1,1
	inc hearty
	mov cx,18
	heart16:
		push cx
		mov cx,heartx
		mov dx,hearty
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartx
		pop cx
	
	loop heart16
	
	
	
	mov varht1,17
	mov cx,15
	outheart1:
		mov bx,cx
		mov cx,heartx1
		mov heartx,cx
		add heartx,1
		add heartx1,1
		inc hearty
		mov cx,varht1
		heart17:
			push cx
			mov cx,heartx
			mov dx,hearty
			mov al,heartColor
			mov ah,0ch
			int 10h
			inc heartx
			pop cx
		
		loop heart17
		mov cx,bx
		dec varht1
	loop outheart1
	;******************right side*****************
	mov cx,8
	heartr1:
		push cx
		mov cx,heartxx
		mov dx,heartyy
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartxx
		pop cx
	
	loop heartr1
	mov cx,heartxx1
	mov heartxx,cx
	
	sub heartxx,2
	sub heartxx1,2
	inc heartyy
	mov cx,12
	heartr2:
		push cx
		mov cx,heartxx
		mov dx,heartyy
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartxx
		pop cx
	
	loop heartr2
	
	mov cx,heartxx1
	mov heartxx,cx
	
	sub heartxx,2
	sub heartxx1,2
	inc heartyy
	mov cx,16
	heartr3:
		push cx
		mov cx,heartxx
		mov dx,heartyy
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartxx
		pop cx
	
	loop heartr3
	
	mov cx,heartxx1
	mov heartxx,cx
	
	sub heartxx,2
	sub heartxx1,2
	inc heartyy
	mov cx,20
	heartr4:
		push cx
		mov cx,heartxx
		mov dx,heartyy
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartxx
		pop cx
	
	loop heartr4
	
	mov cx,heartxx1
	mov heartxx,cx
	
	sub heartxx,2
	sub heartxx1,2
	inc hearty
	mov cx,24
	heartr5:
		push cx
		mov cx,heartxx
		mov dx,heartyy
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartx
		pop cx
	
	loop heartr5
	
	mov cx,heartxx1
	mov heartxx,cx
	
	sub heartxx,1
	sub heartxx1,1
	inc heartyy
	mov cx,25
	heartr6:
		push cx
		mov cx,heartxx
		mov dx,heartyy
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartxx
		pop cx
	
	loop heartr6
	
	mov cx,heartxx1
	mov heartxx,cx
	
	sub heartxx,1
	sub heartxx1,1
	inc heartyy
	mov cx,26
	heartr7:
		push cx
		mov cx,heartxx
		mov dx,heartyy
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartxx
		pop cx
	
	loop heartr7
	
	mov cx,5
	outheartr:
		mov bx,cx
		mov cx,heartxx1
		mov heartxx,cx
		
		inc heartyy
		mov cx,26
		heartr8:
			push cx
			mov cx,heartxx
			mov dx,heartyy
			mov al,heartColor
			mov ah,0ch
			int 10h
			inc heartxx
			pop cx
		
		loop heartr8
	
		mov cx,bx
	loop outheartr
	
	;****************************************
	mov cx,heartxx1
	mov heartxx,cx
	
	inc heartyy
	mov cx,25
	heartr9:
		push cx
		mov cx,heartxx
		mov dx,heartyy
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartxx
		pop cx
	
	loop heartr9
	
	mov cx,heartxx1
	mov heartxx,cx
	
	
	inc heartyy
	mov cx,24
	heartr10:
		push cx
		mov cx,heartxx
		mov dx,heartyy
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartxx
		pop cx
	
	loop heartr10
	
	mov cx,heartxx1
	mov heartxx,cx
	
	
	inc heartyy
	mov cx,23
	heartr11:
		push cx
		mov cx,heartxx
		mov dx,heartyy
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartxx
		pop cx
	
	loop heartr11
	
	mov cx,heartxx1
	mov heartxx,cx
	
	inc heartyy
	mov cx,22
	heartr12:
		push cx
		mov cx,heartxx
		mov dx,heartyy
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartxx
		pop cx
	
	loop heartr12
	
	mov cx,heartxx1
	mov heartxx,cx
	
	inc heartyy
	mov cx,21
	heartr13:
		push cx
		mov cx,heartxx
		mov dx,heartyy
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartxx
		pop cx
	
	loop heartr13
	
	mov cx,heartxx1
	mov heartxx,cx
	
	inc heartyy
	mov cx,20
	heartr14:
		push cx
		mov cx,heartxx
		mov dx,heartyy
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartxx
		pop cx
	
	loop heartr14
	
	mov cx,heartxx1
	mov heartxx,cx
	
	inc heartyy
	mov cx,19
	heartr15:
		push cx
		mov cx,heartxx
		mov dx,heartyy
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartxx
		pop cx
	
	loop heartr15
	
	mov cx,heartxx1
	mov heartxx,cx
	
	
	inc heartyy
	mov cx,18
	heartr16:
		push cx
		mov cx,heartxx
		mov dx,heartyy
		mov al,heartColor
		mov ah,0ch
		int 10h
		inc heartxx
		pop cx
	
	loop heartr16
	
	
	
	mov varht2,17
	mov cx,16
	outheartr1:
		mov bx,cx
		mov cx,heartxx1
		mov heartxx,cx
	
		inc heartyy
		mov cx,varht2
		heartr17:
			push cx
			mov cx,heartxx
			mov dx,heartyy
			mov al,heartColor
			mov ah,0ch
			int 10h
			inc heartxx
			pop cx
		
		loop heartr17
		mov cx,bx
		dec varht2
	loop outheartr1
	
	
	
	
ret
heart endp

mycloud proc
	mov cx,2
	outcloud1:
		mov bx,cx
		mov cx,20
		cloud1:
			push cx
			mov cx,cloudx
			mov dx,cloudy
			mov al,colcloud
			mov ah,0ch
			int 10h
			inc cloudx
			
			pop cx
		loop cloud1
		mov cx,cloudx1
		mov cloudx,cx
		
		mov cx,cloudy1
		mov cloudy,cx
		
		inc cloudy
		inc cloudy1
		mov cx,bx
	loop outcloud1
	
	mov cx,cloudx1
	mov cloudx,cx
	
	mov cx,cloudy1
	mov cloudy,cx
	
	
	sub cloudx,2
	sub cloudx1,2
	
	mov cx,2
	outcloud2:
		mov bx,cx
		mov cx,24
		cloud2:
			push cx
			mov cx,cloudx
			mov dx,cloudy
			mov al,colcloud
			mov ah,0ch
			int 10h
			inc cloudx
			
			pop cx
		loop cloud2
		mov cx,cloudx1
		mov cloudx,cx
		
		mov cx,cloudy1
		mov cloudy,cx
		
		inc cloudy
		inc cloudy1
		mov cx,bx
	loop outcloud2
	
	mov cx,cloudx1
	mov cloudx,cx
	
	mov cx,cloudy1
	mov cloudy,cx
	
	
	sub cloudx,2
	sub cloudx1,2
	
	mov cx,2
	outcloud3:
		mov bx,cx
		mov cx,28
		cloud3:
			push cx
			mov cx,cloudx
			mov dx,cloudy
			mov al,colcloud
			mov ah,0ch
			int 10h
			inc cloudx
			
			pop cx
		loop cloud3
		mov cx,cloudx1
		mov cloudx,cx
		
		mov cx,cloudy1
		mov cloudy,cx
		
		inc cloudy
		inc cloudy1
		mov cx,bx
	loop outcloud3
	
	mov cx,cloudx1
	mov cloudx,cx
	
	mov cx,cloudy1
	mov cloudy,cx
	
	
	sub cloudx,2
	sub cloudx1,2
	
	mov cx,2
	outcloud4:
		mov bx,cx
		mov cx,32
		cloud4:
			push cx
			mov cx,cloudx
			mov dx,cloudy
			mov al,colcloud
			mov ah,0ch
			int 10h
			inc cloudx
			
			pop cx
		loop cloud4
		mov cx,cloudx1
		mov cloudx,cx
		
		mov cx,cloudy1
		mov cloudy,cx
		
		inc cloudy
		inc cloudy1
		mov cx,bx
	loop outcloud4
	
	mov cx,cloudx1
	mov cloudx,cx
	
	mov cx,cloudy1
	mov cloudy,cx
	
	
	sub cloudx,2
	sub cloudx1,2
	
	mov cx,6
	outcloud5:
		mov bx,cx
		mov cx,36
		cloud5:
			push cx
			mov cx,cloudx
			mov dx,cloudy
			mov al,colcloud
			mov ah,0ch
			int 10h
			inc cloudx
			
			pop cx
		loop cloud5
		mov cx,cloudx1
		mov cloudx,cx
		
		mov cx,cloudy1
		mov cloudy,cx
		
		inc cloudy
		inc cloudy1
		mov cx,bx
	loop outcloud5
	
	mov cx,cloudx1
	mov cloudx,cx
	
	mov cx,cloudy1
	mov cloudy,cx
	
	
	sub cloudx,2
	sub cloudx1,2
	
	mov cx,2
	outcloud6:
		mov bx,cx
		mov cx,38
		cloud6:
			push cx
			mov cx,cloudx
			mov dx,cloudy
			mov al,colcloud
			mov ah,0ch
			int 10h
			inc cloudx
			
			pop cx
		loop cloud6
		mov cx,cloudx1
		mov cloudx,cx
		
		mov cx,cloudy1
		mov cloudy,cx
		
		inc cloudy
		inc cloudy1
		mov cx,bx
	loop outcloud6
	
	mov cx,cloudx1
	mov cloudx,cx
	
	mov cx,cloudy1
	mov cloudy,cx
	
	
	sub cloudx,7
	sub cloudx1,7
	
	mov cx,2
	outcloud7:
		mov bx,cx
		mov cx,50
		cloud7:
			push cx
			mov cx,cloudx
			mov dx,cloudy
			mov al,colcloud
			mov ah,0ch
			int 10h
			inc cloudx
			
			pop cx
		loop cloud7
		mov cx,cloudx1
		mov cloudx,cx
		
		mov cx,cloudy1
		mov cloudy,cx
		
		inc cloudy
		inc cloudy1
		mov cx,bx
	loop outcloud7
	
	mov cx,cloudx1
	mov cloudx,cx
	
	mov cx,cloudy1
	mov cloudy,cx
	
	
	sub cloudx,2
	sub cloudx1,2
	
	mov cx,2
	outcloud8:
		mov bx,cx
		mov cx,54
		cloud8:
			push cx
			mov cx,cloudx
			mov dx,cloudy
			mov al,colcloud
			mov ah,0ch
			int 10h
			inc cloudx
			
			pop cx
		loop cloud8
		mov cx,cloudx1
		mov cloudx,cx
		
		mov cx,cloudy1
		mov cloudy,cx
		
		inc cloudy
		inc cloudy1
		mov cx,bx
	loop outcloud8
	
	mov cx,cloudx1
	mov cloudx,cx
	
	mov cx,cloudy1
	mov cloudy,cx
	
	
	sub cloudx,2
	sub cloudx1,2
	
	mov cx,2
	outcloud9:
		mov bx,cx
		mov cx,58
		cloud9:
			push cx
			mov cx,cloudx
			mov dx,cloudy
			mov al,colcloud
			mov ah,0ch
			int 10h
			inc cloudx
			
			pop cx
		loop cloud9
		mov cx,cloudx1
		mov cloudx,cx
		
		mov cx,cloudy1
		mov cloudy,cx
		
		inc cloudy
		inc cloudy1
		mov cx,bx
	loop outcloud9
	
	mov cx,cloudx1
	mov cloudx,cx
	
	mov cx,cloudy1
	mov cloudy,cx
	
	
	;sub cloudx,2
	;sub cloudx1,2
	
	mov cx,2
	outcloud10:
		mov bx,cx
		mov cx,60
		cloud10:
			push cx
			mov cx,cloudx
			mov dx,cloudy
			mov al,colcloud
			mov ah,0ch
			int 10h
			inc cloudx
			
			pop cx
		loop cloud10
		mov cx,cloudx1
		mov cloudx,cx
		
		mov cx,cloudy1
		mov cloudy,cx
		
		inc cloudy
		inc cloudy1
		mov cx,bx
	loop outcloud10
	mov cx,cloudx1
	mov cloudx,cx
	
	mov cx,cloudy1
	mov cloudy,cx
	
	
	sub cloudx,2
	sub cloudx1,2
	
	mov cx,6
	outcloud11:
		mov bx,cx
		mov cx,64
		cloud11:
			push cx
			mov cx,cloudx
			mov dx,cloudy
			mov al,colcloud
			mov ah,0ch
			int 10h
			inc cloudx
			
			pop cx
		loop cloud11
		mov cx,cloudx1
		mov cloudx,cx
		
		mov cx,cloudy1
		mov cloudy,cx
		
		inc cloudy
		inc cloudy1
		mov cx,bx
	loop outcloud11
	
	mov cx,cloudx1
	mov cloudx,cx
	
	mov cx,cloudy1
	mov cloudy,cx
	
	
	sub cloudx,8
	sub cloudx1,8
	
	mov cx,2
	outcloud12:
		mov bx,cx
		mov cx,74
		cloud12:
			push cx
			mov cx,cloudx
			mov dx,cloudy
			mov al,colcloud
			mov ah,0ch
			int 10h
			inc cloudx
			
			pop cx
		loop cloud12
		mov cx,cloudx1
		mov cloudx,cx
		
		mov cx,cloudy1
		mov cloudy,cx
		
		inc cloudy
		inc cloudy1
		mov cx,bx
	loop outcloud12
	
	mov cx,cloudx1
	mov cloudx,cx
	
	mov cx,cloudy1
	mov cloudy,cx
	
	
	sub cloudx,2
	sub cloudx1,2
	
	mov cx,2
	outcloud13:
		mov bx,cx
		mov cx,78
		cloud13:
			push cx
			mov cx,cloudx
			mov dx,cloudy
			mov al,colcloud
			mov ah,0ch
			int 10h
			inc cloudx
			
			pop cx
		loop cloud13
		mov cx,cloudx1
		mov cloudx,cx
		
		mov cx,cloudy1
		mov cloudy,cx
		
		inc cloudy
		inc cloudy1
		mov cx,bx
	loop outcloud13
	
	mov cx,cloudx1
	mov cloudx,cx
	
	mov cx,cloudy1
	mov cloudy,cx
	
	
	sub cloudx,2
	sub cloudx1,2
	
	mov cx,2
	outcloud14:
		mov bx,cx
		mov cx,82
		cloud14:
			push cx
			mov cx,cloudx
			mov dx,cloudy
			mov al,colcloud
			mov ah,0ch
			int 10h
			inc cloudx
			
			pop cx
		loop cloud14
		mov cx,cloudx1
		mov cloudx,cx
		
		mov cx,cloudy1
		mov cloudy,cx
		
		inc cloudy
		inc cloudy1
		mov cx,bx
	loop outcloud14
	
	mov cx,cloudx1
	mov cloudx,cx
	
	mov cx,cloudy1
	mov cloudy,cx
	
	
	sub cloudx,2
	sub cloudx1,2
	
	mov cx,6
	outcloud15:
		mov bx,cx
		mov cx,86
		cloud15:
			push cx
			mov cx,cloudx
			mov dx,cloudy
			mov al,colcloud
			mov ah,0ch
			int 10h
			inc cloudx
			
			pop cx
		loop cloud15
		mov cx,cloudx1
		mov cloudx,cx
		
		mov cx,cloudy1
		mov cloudy,cx
		
		inc cloudy
		inc cloudy1
		mov cx,bx
	loop outcloud15
	
	mov cx,cloudx1
	mov cloudx,cx
	
	mov cx,cloudy1
	mov cloudy,cx
	
	
	sub cloudx,4
	sub cloudx1,4
	
	mov cx,4
	outcloud16:
		mov bx,cx
		mov cx,90
		cloud16:
			push cx
			mov cx,cloudx
			mov dx,cloudy
			mov al,colcloud
			mov ah,0ch
			int 10h
			inc cloudx
			
			pop cx
		loop cloud16
		mov cx,cloudx1
		mov cloudx,cx
		
		mov cx,cloudy1
		mov cloudy,cx
		
		inc cloudy
		inc cloudy1
		mov cx,bx
	loop outcloud16
	
	mov cx,cloudx1
	mov cloudx,cx
	
	mov cx,cloudy1
	mov cloudy,cx
	
	
	sub cloudx,2
	sub cloudx1,2
	
	mov cx,2
	outcloud17:
		mov bx,cx
		mov cx,92
		cloud17:
			push cx
			mov cx,cloudx
			mov dx,cloudy
			mov al,colcloud
			mov ah,0ch
			int 10h
			inc cloudx
			
			pop cx
		loop cloud17
		mov cx,cloudx1
		mov cloudx,cx
		
		mov cx,cloudy1
		mov cloudy,cx
		
		inc cloudy
		inc cloudy1
		mov cx,bx
	loop outcloud17
	
	mov cx,cloudx1
	mov cloudx,cx
	
	mov cx,cloudy1
	mov cloudy,cx
	
	
	;sub cloudx,2
	;sub cloudx1,2
	
	mov cx,2
	outcloud18:
		mov bx,cx
		mov cx,90
		cloud18:
			push cx
			mov cx,cloudx
			mov dx,cloudy
			mov al,colcloud
			mov ah,0ch
			int 10h
			inc cloudx
			
			pop cx
		loop cloud18
		mov cx,cloudx1
		mov cloudx,cx
		
		mov cx,cloudy1
		mov cloudy,cx
		
		inc cloudy
		inc cloudy1
		mov cx,bx
	loop outcloud18
	
	mov cx,cloudx1
	mov cloudx,cx
	
	mov cx,cloudy1
	mov cloudy,cx
	
	
	;sub cloudx,2
	;sub cloudx1,2
	
	mov cx,2
	outcloud19:
		mov bx,cx
		mov cx,88
		cloud19:
			push cx
			mov cx,cloudx
			mov dx,cloudy
			mov al,colcloud
			mov ah,0ch
			int 10h
			inc cloudx
			
			pop cx
		loop cloud19
		mov cx,cloudx1
		mov cloudx,cx
		
		mov cx,cloudy1
		mov cloudy,cx
		
		inc cloudy
		inc cloudy1
		mov cx,bx
	loop outcloud19
	
	mov cx,cloudx1
	mov cloudx,cx
	
	mov cx,cloudy1
	mov cloudy,cx
	
	
	add cloudx,2
	add cloudx1,2
	
	mov cx,2
	outcloud20:
		mov bx,cx
		mov cx,84
		cloud20:
			push cx
			mov cx,cloudx
			mov dx,cloudy
			mov al,colcloud
			mov ah,0ch
			int 10h
			inc cloudx
			
			pop cx
		loop cloud20
		mov cx,cloudx1
		mov cloudx,cx
		
		mov cx,cloudy1
		mov cloudy,cx
		
		inc cloudy
		inc cloudy1
		mov cx,bx
	loop outcloud20
	
	mov cx,cloudx1
	mov cloudx,cx
	
	mov cx,cloudy1
	mov cloudy,cx
	
	
	add cloudx,2
	add cloudx1,2
	
	mov cx,2
	outcloud21:
		mov bx,cx
		mov cx,80
		cloud21:
			push cx
			mov cx,cloudx
			mov dx,cloudy
			mov al,colcloud
			mov ah,0ch
			int 10h
			inc cloudx
			
			pop cx
		loop cloud21
		mov cx,cloudx1
		mov cloudx,cx
		
		mov cx,cloudy1
		mov cloudy,cx
		
		inc cloudy
		inc cloudy1
		mov cx,bx
	loop outcloud21
	
	mov cx,reincloudx
	mov cloudx,cx
	mov cloudx1,cx
	
	mov cx,reincloudy
	mov cloudy,cx
	mov cloudy1,cx
ret

mycloud endp

ROCK PROC 
;1st line
	mov cx,2
R1:
	push cx
	mov cx,16
R2:
	push cx
	mov al,08h
	mov cx,rx
	mov dx,ry
	mov ah,0ch
	int 10h
	inc rx
	pop cx
Loop R2
	mov cx,rx1
	mov rx,cx
	inc ry
	pop cx
Loop R1

;2nd line
	sub rx,4
	sub rx1,4
	sub rx3,4
	
	mov cx,ry
	mov ry1,cx

mov cx,2
R3:
	push cx
	mov cx,5
R4:
	push cx
	mov al,08h
	mov cx,rx
	mov dx,ry
	mov ah,0ch
	int 10h
	inc rx
	pop cx
Loop R4
	mov cx,rx
	mov rx2,cx
	
	mov cx,rx1
	mov rx,cx
	inc ry
	pop cx
Loop R3

;Light grey
	mov cx,rx2
	mov rx,cx
	
	mov cx,ry1
	mov ry,cx

	mov cx,2
R5:
	push cx
	mov cx,14
R6:
	push cx
	mov al,07h
	mov cx,rx
	mov dx,ry
	mov ah,0ch
	int 10h
	inc rx
	pop cx
Loop R6
	mov cx,rx
	mov rx1,cx
	
	mov cx,rx2
	mov rx,cx
	inc ry
	pop cx
Loop R5	

;Dark
	mov cx,rx1
	mov rx,cx
	
	mov cx,ry1
	mov ry,cx

mov cx,2
R7:
	push cx
	mov cx,5
Rr8:
	push cx
	mov al,08h
	mov cx,rx
	mov dx,ry
	mov ah,0ch
	int 10h
	inc rx
	pop cx
Loop Rr8
	mov cx,rx
	mov rx2,cx
	
	mov cx,rx1
	mov rx,cx
	inc ry
	pop cx
Loop R7

;3rd line
	sub rx3,4
	mov cx,rx3
	mov rx,cx
	mov rx1,cx
	
	mov cx,ry
	mov ry1,cx

mov cx,2
Rr9:
	push cx
	mov cx,3
Rr10:
	push cx
	mov al,08h
	mov cx,rx
	mov dx,ry
	mov ah,0ch
	int 10h
	inc rx
	pop cx
Loop Rr10
	mov cx,rx
	mov rx2,cx
	
	mov cx,rx1
	mov rx,cx
	inc ry
	pop cx
Loop Rr9

;Light grey
	mov cx,rx2
	mov rx,cx
	
	mov cx,ry1
	mov ry,cx

	mov cx,2
Rock11:
	push cx
	mov cx,25
Rock12:
	push cx
	mov al,07h
	mov cx,rx
	mov dx,ry
	mov ah,0ch
	int 10h
	inc rx
	pop cx
Loop Rock12
	mov cx,rx
	mov rx1,cx
	
	mov cx,rx2
	mov rx,cx
	inc ry
	pop cx
Loop Rock11	

;Dark
	mov cx,rx1
	mov rx,cx
	
	mov cx,ry1
	mov ry,cx

mov cx,2
Rock13:
	push cx
	mov cx,3
Rock14:
	push cx
	mov al,08h
	mov cx,rx
	mov dx,ry
	mov ah,0ch
	int 10h
	inc rx
	pop cx
Loop Rock14
	mov cx,rx
	mov rx2,cx
	
	mov cx,rx1
	mov rx,cx
	inc ry
	pop cx
Loop Rock13

;4th line
	sub rx3,4
	mov cx,rx3
	mov rx,cx
	mov rx1,cx
	
	mov cx,ry
	mov ry1,cx

mov cx,2
Rock15:
	push cx
	mov cx,7
Rock16:
	push cx
	mov al,08h
	mov cx,rx
	mov dx,ry
	mov ah,0ch
	int 10h
	inc rx
	pop cx
Loop Rock16
	mov cx,rx
	mov rx2,cx
	
	mov cx,rx1
	mov rx,cx
	inc ry
	pop cx
Loop Rock15

;Light grey
	mov cx,rx2
	mov rx,cx
	
	mov cx,ry1
	mov ry,cx

	mov cx,2
Rock17:
	push cx
	mov cx,28
Rock18:
	push cx
	mov al,07h
	mov cx,rx
	mov dx,ry
	mov ah,0ch
	int 10h
	inc rx
	pop cx
Loop Rock18
	mov cx,rx
	mov rx1,cx
	
	mov cx,rx2
	mov rx,cx
	inc ry
	pop cx
Loop Rock17	

;Dark
	mov cx,rx1
	mov rx,cx
	
	mov cx,ry1
	mov ry,cx

mov cx,2
Rock19:
	push cx
	mov cx,3
Rock20:
	push cx
	mov al,08h
	mov cx,rx
	mov dx,ry
	mov ah,0ch
	int 10h
	inc rx
	pop cx
Loop Rock20
	mov cx,rx
	mov rx2,cx
	
	mov cx,rx1
	mov rx,cx
	inc ry
	pop cx
Loop Rock19

;5th line
	sub rx3,4
	mov cx,rx3
	mov rx,cx
	mov rx1,cx
	
	mov cx,ry
	mov ry1,cx

mov cx,2
Rock21:
	push cx
	mov cx,3
Rock22:
	push cx
	mov al,08h
	mov cx,rx
	mov dx,ry
	mov ah,0ch
	int 10h
	inc rx
	pop cx
Loop Rock22
	mov cx,rx
	mov rx2,cx
	
	mov cx,rx1
	mov rx,cx
	inc ry
	pop cx
Loop Rock21

;Light grey
	mov cx,rx2
	mov rx,cx
	
	mov cx,ry1
	mov ry,cx

	mov cx,2
Rock23:
	push cx
	mov cx,40
Rock24:
	push cx
	mov al,07h
	mov cx,rx
	mov dx,ry
	mov ah,0ch
	int 10h
	inc rx
	pop cx
Loop Rock24
	mov cx,rx
	mov rx1,cx
	
	mov cx,rx2
	mov rx,cx
	inc ry
	pop cx
Loop Rock23	

;Dark
	mov cx,rx1
	mov rx,cx
	
	mov cx,ry1
	mov ry,cx

mov cx,2
Rock25:
	push cx
	mov cx,3
Rock26:
	push cx
	mov al,08h
	mov cx,rx
	mov dx,ry
	mov ah,0ch
	int 10h
	inc rx
	pop cx
Loop Rock26
	mov cx,rx
	mov rx2,cx
	
	mov cx,rx1
	mov rx,cx
	inc ry
	pop cx
Loop Rock25

;6th line
	sub rx3,4
	mov cx,rx3
	mov rx,cx
	mov rx1,cx
	
	mov cx,ry
	mov ry1,cx

mov cx,2
Rock27:
	push cx
	mov cx,3
Rock28:
	push cx
	mov al,08h
	mov cx,rx
	mov dx,ry
	mov ah,0ch
	int 10h
	inc rx
	pop cx
Loop Rock28
	mov cx,rx
	mov rx2,cx
	
	mov cx,rx1
	mov rx,cx
	inc ry
	pop cx
Loop Rock27

;Light grey
	mov cx,rx2
	mov rx,cx
	
	mov cx,ry1
	mov ry,cx

	mov cx,2
Rock29:
	push cx
	mov cx,48
Rock30:
	push cx
	mov al,07h
	mov cx,rx
	mov dx,ry
	mov ah,0ch
	int 10h
	inc rx
	pop cx
Loop Rock30
	mov cx,rx
	mov rx1,cx
	
	mov cx,rx2
	mov rx,cx
	inc ry
	pop cx
Loop Rock29	

;Dark
	mov cx,rx1
	mov rx,cx
	
	mov cx,ry1
	mov ry,cx

mov cx,2
Rock31:
	push cx
	mov cx,3
Rock32:
	push cx
	mov al,08h
	mov cx,rx
	mov dx,ry
	mov ah,0ch
	int 10h
	inc rx
	pop cx
Loop Rock32
	mov cx,rx
	mov rx2,cx
	
	mov cx,rx1
	mov rx,cx
	inc ry
	pop cx
Loop Rock31

;7th line
	sub rx3,4
	mov cx,rx3
	mov rx,cx
	mov rx1,cx
	
	mov cx,ry
	mov ry1,cx

	mov cx,2
Rock33:
	push cx
	mov cx,3
Rock34:
	push cx
	mov al,08h
	mov cx,rx
	mov dx,ry
	mov ah,0ch
	int 10h
	inc rx
	pop cx
Loop Rock34
	mov cx,rx
	mov rx2,cx
	
	mov cx,rx1
	mov rx,cx
	inc ry
	pop cx
Loop Rock33
	
	
;Light grey
	mov cx,rx2
	mov rx,cx
	
	mov cx,ry1
	mov ry,cx

	mov cx,2
Rock35:
	push cx
	mov cx,52
Rock36:
	push cx
	mov al,07h
	mov cx,rx
	mov dx,ry
	mov ah,0ch
	int 10h
	inc rx
	pop cx
Loop Rock36
	mov cx,rx
	mov rx1,cx
	
	mov cx,rx2
	mov rx,cx
	inc ry
	pop cx
Loop Rock35	

;Dark
	mov cx,rx1
	mov rx,cx
	
	mov cx,ry1
	mov ry,cx

mov cx,2
Rock37:
	push cx
	mov cx,3
Rock38:
	push cx
	mov al,08h
	mov cx,rx
	mov dx,ry
	mov ah,0ch
	int 10h
	inc rx
	pop cx
Loop Rock38
	mov cx,rx
	mov rx2,cx
	
	mov cx,rx1
	mov rx,cx
	inc ry
	pop cx
Loop Rock37

;8th line 
	mov cx,rx3
	mov rx,cx
	mov rx1,cx
	
	mov cx,ry
	mov ry1,cx

	mov cx,2
Rock39:
	push cx
	mov cx,3
Rock40:
	push cx
	mov al,08h
	mov cx,rx
	mov dx,ry
	mov ah,0ch
	int 10h
	inc rx
	pop cx
Loop Rock40
	mov cx,rx
	mov rx2,cx
	
	mov cx,rx1
	mov rx,cx
	inc ry
	pop cx
Loop Rock39
	
	
;Light grey
	mov cx,rx2
	mov rx,cx
	
	mov cx,ry1
	mov ry,cx

	mov cx,2
Rock41:
	push cx
	mov cx,52
Rock42:
	push cx
	mov al,07h
	mov cx,rx
	mov dx,ry
	mov ah,0ch
	int 10h
	inc rx
	pop cx
Loop Rock42
	mov cx,rx
	mov rx1,cx
	
	mov cx,rx2
	mov rx,cx
	inc ry
	pop cx
Loop Rock41

;Dark
	mov cx,rx1
	mov rx,cx
	
	mov cx,ry1
	mov ry,cx

mov cx,2
Rock43:
	push cx
	mov cx,3
Rock44:
	push cx
	mov al,08h
	mov cx,rx
	mov dx,ry
	mov ah,0ch
	int 10h
	inc rx
	pop cx
Loop Rock44
	mov cx,rx
	mov rx2,cx
	
	mov cx,rx1
	mov rx,cx
	inc ry
	pop cx
Loop Rock43


ret
ROCK ENDP

cactus proc

	mov cx,cactx 
	sub cx,40
	mov scndcactx,cx
	mov scndcactx1,cx
	
	mov cx,cacty
	add cx,20
	mov scndcacty,cx
	mov scndcacty,cx
	
	mov cx,cactx 
	add cx,40
	mov thrdcactx,cx
	mov thrdcactx1,cx
	
	mov cx,cacty
	add cx,30
	mov thrdcacty,cx
	mov thrdcacty1,cx

	mov cx,10
	cactus1:
		push cx
		mov cx,cactx
		mov dx,cacty
		mov al,col
		mov ah,0ch
		int 10h
		inc cactx
		pop cx
	loop cactus1
	
	mov cx,cactx1
	mov cactx,cx
	
	sub cactx,2
	sub cactx1,2
	inc cacty
	mov cx,14
	cactus2:
		push cx
		mov cx,cactx
		mov dx,cacty
		mov al,col
		mov ah,0ch
		int 10h
		inc cactx
		pop cx
	loop cactus2
	
	mov cx,cactx1
	mov cactx,cx
	
	sub cactx,2
	sub cactx1,2
	inc cacty
	mov cx,18
	cactus3:
		push cx
		mov cx,cactx
		mov dx,cacty
		mov al,col
		mov ah,0ch
		int 10h
		inc cactx
		pop cx
	loop cactus3
	
	mov cx,cactx1
	mov cactx,cx
	
	sub cactx,2
	sub cactx1,2
	inc cacty
	mov cx,22
	cactus4:
		push cx
		mov cx,cactx
		mov dx,cacty
		mov al,col
		mov ah,0ch
		int 10h
		inc cactx
		pop cx
	loop cactus4
	
	mov cx,cactx1
	mov cactx,cx
	
	sub cactx,2
	sub cactx1,2
	inc cacty
	mov cx,26
	cactus5:
		push cx
		mov cx,cactx
		mov dx,cacty
		mov al,col
		mov ah,0ch
		int 10h
		inc cactx
		pop cx
	loop cactus5
	
	mov cx,cactx1
	mov cactx,cx
	
	sub cactx,2
	sub cactx1,2
	inc cacty
	mov cx,30
	cactus6:
		push cx
		mov cx,cactx
		mov dx,cacty
		mov al,col
		mov ah,0ch
		int 10h
		inc cactx
		pop cx
	loop cactus6
	
	mov cx,cactx1
	mov cactx,cx
	
	sub cactx,2
	sub cactx1,2
	inc cacty
	mov cx,34
	cactus7:
		push cx
		mov cx,cactx
		mov dx,cacty
		mov al,col
		mov ah,0ch
		int 10h
		inc cactx
		pop cx
	loop cactus7
	
	
	mov cx,80
	outcactus:
		mov bx,cx
		mov cx,cactx1
		mov cactx,cx
		
		inc cacty
		mov cx,34
		cactus10:
			push cx
			mov cx,cactx
			mov dx,cacty
			mov al,col
			mov ah,0ch
			int 10h
			inc cactx
			pop cx
		loop cactus10
		mov cx,bx
	loop outcactus
	
;*******************************smaller cactus on left
	mov cx,10
	scndcact1:
		push cx
		mov cx,scndcactx
		mov dx,scndcacty
		mov al,col
		mov ah,0ch
		int 10h
		inc scndcactx
		pop cx
	loop scndcact1
	
	mov cx,scndcactx1
	mov scndcactx,cx
	
	sub scndcactx,2
	sub scndcactx1,2
	inc scndcacty
	mov cx,14
	scndcact2:
		push cx
		mov cx,scndcactx
		mov dx,scndcacty
		mov al,col
		mov ah,0ch
		int 10h
		inc scndcactx
		pop cx
	loop scndcact2
	
	mov cx,scndcactx1
	mov scndcactx,cx
	
	sub scndcactx,2
	sub scndcactx1,2
	inc scndcacty
	mov cx,18
	scndcact3:
		push cx
		mov cx,scndcactx
		mov dx,scndcacty
		mov al,col
		mov ah,0ch
		int 10h
		inc scndcactx
		pop cx
	loop scndcact3
	
	mov cx,scndcactx1
	mov scndcactx,cx
	
	sub scndcactx,2
	sub scndcactx1,2
	inc scndcacty
	mov cx,22
	scndcact4:
		push cx
		mov cx,scndcactx
		mov dx,scndcacty
		mov al,col
		mov ah,0ch
		int 10h
		inc scndcactx
		pop cx
	loop scndcact4
	
	mov cx,scndcactx1
	mov scndcactx,cx
	
	sub scndcactx,2
	sub scndcactx1,2
	inc scndcacty
	mov cx,26
	scndcact5:
		push cx
		mov cx,scndcactx
		mov dx,scndcacty
		mov al,col
		mov ah,0ch
		int 10h
		inc scndcactx
		pop cx
	loop scndcact5
	
	mov cx,20
	outscndcactus:
		mov bx,cx
		mov cx,scndcactx1
		mov scndcactx,cx
		
		inc scndcacty
		mov cx,26
		scndcact6:
			push cx
			mov cx,scndcactx
			mov dx,scndcacty
			mov al,col
			mov ah,0ch
			int 10h
			inc scndcactx
			pop cx
		loop scndcact6
		mov cx,bx
	loop outscndcactus
	
	mov cx,5
	endscndcact:
		mov bx,cx
		mov cx,scndcactx1
		mov scndcactx,cx
		
		add scndcactx,2
		add scndcactx1,2
		inc scndcacty
		mov cx,26
		scndcact7:
			push cx
			mov cx,scndcactx
			mov dx,scndcacty
			mov al,col
			mov ah,0ch
			int 10h
			inc scndcactx
			pop cx
		loop scndcact7
		mov cx,bx
	loop endscndcact
;************************third to the right
	mov cx,10
	thrdcact1:
		push cx
		mov cx,thrdcactx
		mov dx,thrdcacty
		mov al,col
		mov ah,0ch
		int 10h
		inc thrdcactx
		pop cx
	loop thrdcact1
	
	mov cx,thrdcactx1
	mov thrdcactx,cx
	
	sub thrdcactx,2
	sub thrdcactx1,2
	inc thrdcacty
	mov cx,14
	thrdcact2:
		push cx
		mov cx,thrdcactx
		mov dx,thrdcacty
		mov al,col
		mov ah,0ch
		int 10h
		inc thrdcactx
		pop cx
	loop thrdcact2
	
	mov cx,thrdcactx1
	mov thrdcactx,cx
	
	sub thrdcactx,2
	sub thrdcactx1,2
	inc thrdcacty
	mov cx,18
	thrdcact3:
		push cx
		mov cx,thrdcactx
		mov dx,thrdcacty
		mov al,col
		mov ah,0ch
		int 10h
		inc thrdcactx
		pop cx
	loop thrdcact3
	
	mov cx,thrdcactx1
	mov thrdcactx,cx
	
	sub thrdcactx,2
	sub thrdcactx1,2
	inc thrdcacty
	mov cx,22
	thrdcact4:
		push cx
		mov cx,thrdcactx
		mov dx,thrdcacty
		mov al,col
		mov ah,0ch
		int 10h
		inc thrdcactx
		pop cx
	loop thrdcact4
	
	mov cx,thrdcactx1
	mov thrdcactx,cx
	
	sub thrdcactx,2
	sub thrdcactx1,2
	inc thrdcacty
	mov cx,26
	thrdcact5:
		push cx
		mov cx,thrdcactx
		mov dx,thrdcacty
		mov al,col
		mov ah,0ch
		int 10h
		inc thrdcactx
		pop cx
	loop thrdcact5
	
	mov cx,20
	outthrdcactus:
		mov bx,cx
		mov cx,thrdcactx1
		mov thrdcactx,cx
		
		inc thrdcacty
		mov cx,26
		thrdcact6:
			push cx
			mov cx,thrdcactx
			mov dx,thrdcacty
			mov al,col
			mov ah,0ch
			int 10h
			inc thrdcactx
			pop cx
		loop thrdcact6
		mov cx,bx
	loop outthrdcactus
	
	mov cx,5
	endthrdcact:
		mov bx,cx
		mov cx,thrdcactx1
		mov thrdcactx,cx
		
		sub thrdcactx,2
		sub thrdcactx1,2
		inc thrdcacty
		mov cx,26
		thrdcact7:
			push cx
			mov cx,thrdcactx
			mov dx,thrdcacty
			mov al,col
			mov ah,0ch
			int 10h
			inc thrdcactx
			pop cx
		loop thrdcact7
		mov cx,bx
	loop endthrdcact
ret
cactus endp

music1 proc
	mov al,182
	out 43h,al
	mov ax,1140
	
	out 42h,al
	mov al,ah
	out 42h,al
	in al,61h
	
	or al,00000011b
	out 61h,al
	mov bx,25
pause1:
	mov cx,1292
pause2:
	dec cx
	jne pause2
	dec bx
	jne pause1
	in al,61h
	
	and al,11111100b
	out 61h,al
	

	ret
music1 endp

end