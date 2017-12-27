data segment
   sayilar db 4,5,6,1,2,3,8,9,6,1
   enbuyuk db ?
ends

stack segment  
    dw   128  dup(0)
ends

code segment
start:

    mov ax,data
    mov ds,ax
    mov cx,10
    
    lea si,sayilar ; sayilar dizisinin offset de�erini si isimli kaydediciye at�yor. (Source Index)
    mov al,[si]     ; [] kullanmak o adresteki veriyi getirmek anlam�na gelir. al = 1 oldu.
    
    dongu:
      inc si
      cmp al,[si]  ; al b�y�kse devamet �al���r
      JA devamet
      mov al,[si]
    
      devamet:
        loop dongu
        mov enbuyuk,al    
    
        call ekraniTemizle
    
        ;ekrana ��kt� verme
        mov ah,02
        mov dl,enbuyuk
        add dl,30h
        int 21h 
        
        mov ax, 4c00h
        int 21h  
        
        
    
    ekraniTemizle proc
       mov ah,06h         ;6 numaral� fonk ekran� tmeizler. Ka� sat�r ...
       mov bh,30h
       mov cx,0000h   ; �lk arkaplan rengi, sonraki yaz� rengi
       mov dx,0909h  ; tamam�n� temizlemesin
       int 10h
    
        mov ah,02h   ; cursor'�n konumunubelirtir
        mov bh,00h
        mov dh,00h
        mov dl,00h
        int 10h
        
    
       RET ; Alt fonksiyon yaz�ld��� zaman her zaman RET yaz�lmal� ki program kald��� yerden devam edebilsin.
    
    ekraniTemizle endp
code ends    

end start