LIST  P=PIC18F4550
#include p18f4550.inc
CONFIG FOSC = HS,PWRT = OFF, WDT = OFF, LVP=OFF
;Declaración de variables en la memoria
CUENTA1    EQU    20H
CUENTA2    EQU    21H
CUENTA3    EQU    22H
CUENTA4	   EQU	  30H
OPCION     EQU    23H
VAR1       EQU    24H	;CONTADOR
VAR2       EQU    25H	;CONTADOR
TEMP       EQU    26H
VAR17      EQU    27H	;CONTADOR
VAR27      EQU    29H	;CONTADOR
VARU       EQU    28H
CONTADEC    EQU    2AH
CONTADECU   EQU    2BH
CONTADECD   EQU    2CH


F	EQU	1
W	EQU	0

	ORG 10H
	
	CLRF TRISD	;Puerto RD como salida y es limpiado
	MOVLW 0FFH
	MOVWF TRISB	;Puerto RB como salida y es limpiado
	BCF INTCON2, 7	;Resistencias Pull UP en RB
	MOVLW 0FH
	MOVWF ADCON1	;VOLVEMOS 0-4 DE RB DIGITALES
	
	;AQUI ENCENDEMOS EL DISPLAY 7SEG
	MOVLW 04H
	MOVWF PORTE
	CLRF TRISE

INICIO
	BCF STATUS,0

	MOVF PORTB, W
	MOVWF OPCION
;--------------------
;MENU DE OPCIONES
;--------------------
OPCION1
	MOVLW 01H
	SUBWF OPCION,W
	BTFSC STATUS,2
	CALL CTA1

OPCION2
	MOVLW 02H
	SUBWF OPCION,W
	BTFSC STATUS,2
	CALL CTA2

OPCION3			;Checa si es la opción 3 Y EJECUTA EL CONTADOR TRES
  MOVLW 03H
  SUBWF OPCION,W
  BTFSC STATUS,2
  CALL CTA3

OPCION4		;Checa si es la opción 3 Y EJECUTA EL CONTADOR TRES
  MOVLW 04H
  SUBWF OPCION,W
  BTFSC STATUS,2
  CALL CTA4

OPCION8		;Checa si es la opción 3 Y EJECUTA EL CONTADOR TRES
  MOVLW 08H
  SUBWF OPCION,W
  BTFSC STATUS,2
  CALL CTA8

OPCION7			;Checa si es la opción 3 Y EJECUTA EL CONTADOR TRES
  MOVLW 07H
  SUBWF OPCION,W
  BTFSC STATUS,2
  CALL CTA7

OPCION6		;Checa si es la opción 3 Y EJECUTA EL CONTADOR TRES
  MOVLW 06H
  SUBWF OPCION,W
  BTFSC STATUS,2
  CALL CTA6
GOTO INICIO
;--------------------
;CUENTAS RUTINA 1
;--------------------
CTA1
	MOVLW 00H
	MOVWF PORTD
REPETIR
	CALL DELAY

INCF PORTD, F
	MOVF PORTB, W
	MOVWF OPCION
	MOVLW 01H
	SUBWF OPCION, W
	BTFSC STATUS, 2
	GOTO REPETIR
	RETURN
;-------------------------------------------------------------
CTA2
	MOVLW 0FF
	MOVWF PORTD
REPETIR2
	CALL DELAY

	DECF PORTD 
	MOVF PORTB, W
	MOVWF OPCION
	MOVLW 02H
	SUBWF OPCION, W
	BTFSC STATUS, 2
	GOTO REPETIR2
	RETURN
;-------------------------------------------------------------------
CTA3		;Esta rutina cuenta de 0 A F
	MOVLW 00
	MOVWF VAR1	;variable que lleva la cuenta inicializar en cero
OTRO
	MOVFF VAR1,TEMP  ;se lleva a temp para convertirla en 7 segmentos
	CALL CONV7	;llama conversion a siete segentos
    MOVWF PORTD  ; saca 7 segm por puerto D
	CALL DELAY   ; llama retraso de tiempo ,5 seg aprox
	INCF VAR1    ;incrementa variable contador
    MOVLW 10H    ;checa si la lleva diez cuentas
	CPFSEQ VAR1  
	GOTO OTRO    ;no lleva diez genera  otro

    CLRF VAR1    ;ya llego a 10 inicializa contador en cero
	RETURN
;-------------------------------------------------------------
CTA4
  MOVLW  00H

  MOVWF  VAR1      ;Saca un 00H por el puerto RD
  MOVLW 3FH
  MOVWF PORTD
REPETIR4
  CALL DELAY          ;Llama a la subrutina de retardo

  INCF VAR1			;INCREMENTA CONTADOR
  MOVLW 01H
  CPFSEQ VAR1		;COMPARA CONTADOR CON 01 SI ES SACAR SU CODIGO EN 7 SEGM
  GOTO DOS			;NO FUE UNO REVISA SI ES DOS
  MOVLW 06H			;CODIGO DEL UNO
  MOVWF PORTD		;SACAR AL DISPLAY
DOS
  MOVLW 02H			;COMPARA SI FUE DOS Y SACA CODIGO DEL DOS
  CPFSEQ VAR1		;EN SIETE SEGMENTOS SI NO FUE CHECAR SI ES TRES
  GOTO TRES
  MOVLW 5BH
  MOVWF PORTD
TRES
  MOVLW 03H			;COMPARA SI FUE TRES Y SACA CODIGO DEL TRES
  CPFSEQ VAR1		;EN SIETE SEGM SI NO FUE CHECAR SI ES CUATRO
  GOTO CUATRO
  MOVLW 4FH
  MOVWF PORTD
CUATRO
  MOVLW 04H		;COMPARA SI FUE CUATRO Y SACA CODIGO DE CUATRO
  CPFSEQ VAR1	;EN SIETE SEGMENTOS SI NO FUE CHECAR EL CINCO
  GOTO CINCO
  MOVLW 66H
  MOVWF PORTD
CINCO
  MOVLW 05H		;COMPARA SI FUE CINCO Y SACA CODIGO DE CINCO
  CPFSEQ VAR1	;EN SIETE SEGMENTOS SI NO FUE CHECAR SEIS
  GOTO SEIS
  MOVLW 6DH
  MOVWF PORTD
SEIS
  MOVLW 06H		;COMPARA SI FUE SEIS Y SACA CODIGO DE SIES
  CPFSEQ VAR1	;EN SIETE SEGMENTOS SI NO FUE CHECAR SIETE
  GOTO SIETE
  MOVLW 7DH
  MOVWF PORTD
SIETE
  MOVLW 07H		;COMPARA SI FUE SIETE Y SACA CODIGO DE SIETE
  CPFSEQ VAR1	;EN SIETE SEGMENTOS SI NO FUE CHECAR OCHO
  GOTO OCHO
  MOVLW 07H
  MOVWF PORTD
OCHO
  MOVLW 08H		;COMPARA SI FUE OCHO Y SACA CODIGO DE OCHO
  CPFSEQ VAR1	;EN SIETE SEGMENTOS SO NO FUE CHECAR NUEVE
  GOTO NUEVE
  MOVLW 7FH
  MOVWF PORTD
NUEVE
  MOVLW 09H		;COMPARA SI FUE NUEVE Y SACA CODIGO DE NUEVE
  CPFSEQ VAR1	;EN SIETE SEGMENTOS SI NO FUE CHECAR "A"
  GOTO DIEZ		;Y TERMINAR RUTINA
  MOVLW 6FH
  MOVWF PORTD
DIEZ
  MOVLW 0AH
  CPFSEQ VAR1
  GOTO REPETIR4       ;Brinca a la etiqueta REPETIR
  RETURN
;-------------------------------------------------------------------
CTA7
    CLRF VAR1	;inicializa en cero la cuenta
REPETIR7
	MOVFF VAR1,VARU ;llevamos la cuenta a la variable VARU
	MOVLW 0FH       ;elimina la parte alta de VARU
    ANDWF VARU,W
    MOVWF TEMP		;lleva parte baja de cuenta a temp. para 
	CALL CONV7      ;convertir en siete sementos el resulatdo queda en W
;	MOVWF PORTD
    MOVWF VAR17,F   ;se guarda parte baja del conta en 7 segm en VAR17
    MOVFF VAR1,VARU  ;se lleva contador a VARU
	SWAPF VARU       ;se intercambia primer digito del segundo digito de contador
    MOVLW 0FH			;se elimina la parte alta
    ANDWF VARU,W
    
    MOVWF TEMP		; se lleva a temp para su conversion
	CALL CONV7		; a siete segmentos

    MOVWF VAR27,F 	; se guarda la conversion en VAR27
	CALL DELAY2     ;llama delay2 para multiplexar y esperar un tiempo
					
	MOVF VAR1,W     ;LLEVAR CONTADOR A W
    ADDLW 01        ;INCREMENTAR CONTADOR
    DAW				;AJUSTAR A DECIMAL
    MOVWF VAR1,F    ;REGRESAR CONTADOR EN DECIMAL A VAR1
    MOVLW 60H
	CPFSEQ VAR1		;compara contador con SESENTA p' checar si ya dio vuelta
	GOTO REPETIR7		;no ha terminado de dar vuelta continua
    RETURN  
 
  RETURN

;-----------------------------------------------------------
CTA6
    CLRF VAR1	;inicializa en cero la cuenta
REPETIR6
	MOVFF VAR1,VARU ;llevamos la cuenta a la variable VARU
	MOVLW 0FH       ;elimina la parte alta de VARU
    ANDWF VARU,W
    MOVWF TEMP		;lleva parte baja de cuenta a temp. para 
	CALL CONV7      ;convertir en siete sementos el resulatdo queda en W
;	MOVWF PORTD
    MOVWF VAR17,F   ;se guarda parte baja del conta en 7 segm en VAR17
    MOVFF VAR1,VARU  ;se lleva contador a VARU
	SWAPF VARU       ;se intercambia primer digito del segundo digito de contador
    MOVLW 0FH			;se elimina la parte alta
    ANDWF VARU,W
    
    MOVWF TEMP		; se lleva a temp para su conversion
	CALL CONV7		; a siete segmentos
;	MOVWF PORTD
    MOVWF VAR27,F 	; se guarda la conversion en VAR27
	CALL DELAY2     ;llama delay2 para multiplexar y esperar un tiempo
;	INCF VAR1		;incrementa contador
	MOVF VAR1,W     ;LLEVAR CONTADOR A W
    ADDLW 01        ;INCREMENTAR CONTADOR
    DAW				;AJUSTAR A DECIMAL
    MOVWF VAR1,F    ;REGRESAR CONTADOR EN DECIMAL A VAR1
    MOVLW 00H
	CPFSEQ VAR1		;compara contador con cero p' checar si ya dio vuelta
	GOTO REPETIR6		;no ha terminado de dar vuelta continua
    RETURN 
 RETURN
;-----------------------------------------------------------------
CTA8
    CLRF VAR1	;inicializa en cero la cuenta
REPETIR8
	MOVFF VAR1,VARU ;llevamos la cuenta a la variable VARU
	MOVLW 0FH       ;elimina la parte alta de VARU
    ANDWF VARU,W
    MOVWF TEMP		;lleva parte baja de cuenta a temp. para 
	CALL CONV7      ;convertir en siete sementos el resulatdo queda en W
	MOVWF PORTD
    MOVWF VAR17,F   ;se guarda parte baja del conta en 7 segm en VAR17
    MOVFF VAR1,VARU  ;se lleva contador a VARU
	SWAPF VARU       ;se intercambia primer digito del segundo digito de contador
    MOVLW 0FH			;se elimina la parte alta
    ANDWF VARU,W
    
    MOVWF TEMP		; se lleva a temp para su conversion
	CALL CONV7		; a siete segmentos
	MOVWF PORTD
    MOVWF VAR27,F 	; se guarda la conversion en VAR27
	CALL DELAY2     ;llama delay2 para multiplexar y esperar un tiempo
	INCF VAR1		;incrementa contador
    MOVLW 00H
	CPFSEQ VAR1		;compara contgador con cero p' checar si ya dio vuelta
	GOTO REPETIR8		;no ha terminado de dar vuelta continua
  ;  CLRF VAR1
;	INCF VAR2
 ;   MOVLW 10H
;	CPFSEQ VAR2
;	CLRF VAR2
	RETURN
;-------------------------------------------------------------------
CONV7				;RUTINA DE CONVERSION A 7 SEGMENTOS
	   	 MOVF TEMP,W
		 ADDWF TEMP,W
         MOVFF PCL, 01H ;HACE UN RESPALDO DEL PCL
ADDWF PCL, F ;SUMA EL REGISTRO W CON PCL EL RESULTADO SE           ALMACENA EN   
;PCL Y     BRINCA DEACUERDO AL DATO REQUERIDO
 RETLW 3Fh	;CODIGO DE 7 SEGMENTOS P'CERO 0gfedcba  <--MENOS SIGNIFICATIVO
 RETLW 06h	;CODIGO DE 7 SEGM P'UNO 0gfedcba  <--MENOS SIGNIFICATIVO
 RETLW 5Bh	;CODIGO DE 7 SEGM P'DOS 0gfedcba  <--MENOS SIGNIFICATIVO
 RETLW 4Fh	;CODIGO DE 7 SEGM P'TRES 0gfedcba  <--MENOS SIGNIFICATIVO
 RETLW 66h	;CODIGO DE 7 SEGM P'CUATRO 0gfedcba  <--MENOS SIGNIFICATIVO
 RETLW 6Dh    ;CODIGO DE 7 SEGM P'CINCO 0gfedcba  <--MENOS SIGNIFICATIVO
 RETLW 7Dh	;CODIGO DE 7 SEGM P'SEIS 0gfedcba  <--MENOS SIGNIFICATIVO
 RETLW 07h	;CODIGO DE 7 SEGM P'SIETE 0gfedcba  <--MENOS SIGNIFICATIVO
 RETLW 7Fh	;CODIGO DE 7 SEGM P'OCHO 0gfedcba  <--MENOS SIGNIFICATIVO
 RETLW 6Fh	;CODIGO DE 7 SEGM P'NUEVE 0gfedcba  <--MENOS SIGNIFICATIVO
 RETLW 77h	;CODIGO DE 7 SEGMENTOS P'A 0gfedcba  <--MENOS SIGNIFICATIVO
 RETLW 7Ch	;CODIGO DE 7 SEGMENTOS P'B 0gfedcba  <--MENOS SIGNIFICATIVO
 RETLW 39h	;CODIGO DE 7SIETE SEGM P'C 0gfedcba  <--MENOS SIGNIFICATIVO
 RETLW 5Eh	;CODIGO DE 7 SEGMENTOS P'D 0gfedcba  <--MENOS SIGNIFICATIVO
 RETLW 79h	;CODIGO DE 7 SEGMENTOS P'E 0gfedcba  <--MENOS SIGNIFICATIVO
 RETLW 71h	;CODIGO DE 7 SEGMENTOS P'F 0gfedcba  <--MENOS SIGNIFICATIVO
;-------------------------------------------------------------
;-------------------------------------------------------------

;-------------------------------------------------------------
;DELAY PARA CONTAR CON LOS LEDS
DELAY 
      MOVLW    10DH        ;Carga el W con el valor 01H
      MOVWF  CUENTA3       ;Carga CUENTA3 con el valor del W

LAZO3 MOVLW  0F9H          ;Carga el W con el valor F9H
      MOVWF  CUENTA2        ;Carga CUENTA2 con el valor del W                                       
LAZO2 MOVLW 0FAH          ;Carga el W con el valor FAH
      MOVWF  CUENTA1        ;Carga CUENTA1 con el valor del W
LAZO1 NOP
      DECFSZ CUENTA1,F       ;Decrementa CUENTA1 y sigue en el
      GOTO  LAZO1                  ;lazo1 mientras no sea 0
                                        
      DECFSZ CUENTA2,F       ;Decrementa CUENTA2 y sigue en el
      GOTO LAZO2                    ;lazo2 mientras no sea 0
                                      
      DECFSZ CUENTA3,F       ;Decrementa CUENTA3 y sigue en el  
      GOTO LAZO3                   ;lazo3 mientras no sea 0
      RETURN                           ;retorna al programa principal
;---------------------------------------------------------------------
 DELAY2 
      MOVLW    10H                ;Carga el W con el valor 01H
      MOVWF  CUENTA3       ;Carga CUENTA3 con el valor del W

LAZO32 MOVLW  0F9H          ;Carga el W con el valor F9H
      MOVWF  CUENTA2        ;Carga CUENTA2 con el valor del W                                       
LAZO22 MOVLW 0FAH          ;Carga el W con el valor FAH
      MOVWF  CUENTA1        ;Carga CUENTA1 con el valor del W
LAZO12 
MUX		BCF PORTE, 1
			BSF PORTE, 2
		MOVFF VAR17, PORTD

		CALL DELAY4
		NOP
		NOP
		CLRF PORTD

		NOP
		NOP
		NOP
		
		BCF PORTE, 2
		BCF PORTE, 1
		BCF PORTE, 0
		BCF PORTE, 2
		BSF PORTE, 1

		MOVFF VAR27, PORTD
		CALL DELAY4
		NOP
		CLRF PORTD

		NOP		NOP
	DECFSZ	CUENTA2, F
		GOTO LAZO22
		
		DECFSZ CUENTA3, F
		GOTO LAZO32
;------------------------------------------------------------------

;---------------------------------------------------
DELAY4
	MOVLW 01DH
	MOVWF CUENTA4

LAZO43 NOP
	DECFSZ CUENTA4, F
	GOTO LAZO43

	RETURN
	END
;------------------------------------------------------
	END ;FIN DEL PROGRAMA