////////////////////////////////////////////////////////////////////////////////
        Gozde DOGAN - 131044019
        CSE312 OPERATIN SYSTEMS
        
        Homework2
 
        DESCRIPTION
////////////////////////////////////////////////////////////////////////////////


/////////////////////////// CALISTIRILMA SEKLI /////////////////////////////////
        make yapildi.
        make icerigi:
            g++ *.cpp -o emu8080
        Sonrasinda ise 
            ./emu8080 .com type 
        seklinde calistirabilirsin.
        Calistirirken make yapabilirsiniz.
////////////////////////////////////////////////////////////////////////////////



//////////////////////// HW1'de YAPILANLAR /////////////////////////////////////
Search.asm, Sort.asm, PrintNumbers.asm, PrintNumbersRev.asm, test.asm yazildi. (HW1)

Search yaparken hexadecimal bir sayi giriniz(eg. 1A gibi)
Program onu kabul ediyor.

        PrintNumbers.asm ->
            sayilari 0 dan baslayip 50 ye kadar yaziyor
            PRINT_B kullanildi
            
        PrintNumbersRev.asm ->
            sayilari 100 den baslayip 50 ye kadar yaziyor
            PRINT_B kullanildi
        
        Search.asm ->
            Userdan READ_B ile deger aliyor
            Bu degeri PRINT_B ile ekrana yaziyor
            Girilen degeri array de ariyor
            Buldugu index'i PRINT_B ile ekrana yaziyor
            Sort.asm icinde dw ile tanimlanacak dediginiz 
            icin burada array db ile tanimlandi
        
        Sort.asm ->
           dw ile tanimlanan arrayi siralamaya calisiyor.
           Siralanmis arrayi PRINT_STR ile ekrana yaziyor.
        
        test.asm ->
            Burada yazilan system call lar test edildi.
            READ_B ile klavyeden deger aliyor.
            PRINT_B ile aldigi bu degeri ekrana yaziyor.
            READ_MEM ile klavyeden deger aliyor.
            PRINT_MEM ile aldigi bu degeri ekrana basiyor.
            READ_STR ile klavyeden string aliyor.
            PRINT_STR ile bu stringi ekrana basiyor.        

Odev ile gelen printstr.asm, sum.asm ve sum2.asm icin de .com uzantili dosyalar 
olusturuldu.
///////////////////////////////////////////////////////////////////////////////



/////////////////////////// HW2'de YAPILANLAR /////////////////////////////////
p1.asm, p2.asm, p3.asm, parallel.asm yazildi.

        p1.asm ->
            Olusturulan ilk fork icin yapilmasi istenilen islem.
            Sayilari 0 dan baslayip 50'ye kadar yazar. (0 ve 50 dahil)
        
        p2.asm ->
            Olusturulan ikinci fork icin yapilmasi istenilen islem.
            Sayilari 0 dan baslayip 10'a kadar yazar. (0 ve 10 dahil)

        p3.asm ->
            Olusturulan son fork icin yapilmasi istenilen islem.
            Sayilari 100 den baslayip 50 ye kadar yazar. (100 dahil 50 degil)
        
        parallel.asm ->
            forklari sira ile olusturup cagirir.
            Ama sonsuz donguye giriyor ve islemi gerceklestiremiyor.
            SORUNU COZEMEDIM!!
        
p1.com, p2.com, p3.com, parallel.com lar olsuturuldu.

FORK, EXEC ve WAITPID system call'lari gtuos.cpp dosyasinda eklendi.
Gereken metotlar yazildi.
Cycle hesaplanan fonksiyonda da bu system call'lar icin hesaplanmasi 
gereken cycle degerleri eklendi.

gtuos.h'da bir struct yapisi olsuturuldu.
struct yapisi page table icin olusturuldu ve gerekli degerleri tuttu.

    gtuos.h dosyasi icine 
        page table arrayi 
        page table'in arrayinin indexini 
    tutan 2 attribute eklendi.
////////////////////////////////////////////////////////////////////////////////
