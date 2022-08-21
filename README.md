# Aptos-AIT3


# <h1 align="center">Aptos AIT 3</h1>

![aptos](https://user-images.githubusercontent.com/73015593/177651583-9bfbdf15-79ee-447e-8442-5230a47fefff.jpg)

# Testnet detayları
Aptos AIT 3 testnetine dünya genelinden 225 kişi seçilecek.Her bir katılımcı 800 aptos token kazanacak. Daha iyi performans gösteren bazı katılımcılar ek 200 aptos token daha kazanacak.

* [Daha fazla detay için medium makalesi](https://aptoslabs.medium.com/welcome-to-aptos-incentivized-testnet-3-9d7ce888205c)


# Sistem gereksinimleri
```
CPU: 8 cores, 16 threads
2.8GHz, or faster
Memory: 32GB RAM.
Disk: 300GB ssd 
```

# Node kurulumu

## Kurulum için bu kodu terminale eklemeniz yeterlidir.
```
wget https://raw.githubusercontent.com/chainlabs1/Aptos-AIT3/main/aptos.sh -O aptos.sh && chmod +x aptos.sh && ./aptos.sh
```

## Ardından değişkenleri sisteme kaydetmek için bu kod ile devam ediyoruz.
```
source $HOME/.bash_profile
```
## Ayrıca bazı portları açmamız gerekiyor. Bunları açalım.
```
sudo ufw enable
```
```
ufw allow 80
ufw allow 8080
```

## NODE REGISTRATION kısmında gireceğimiz bilgileri öğreniyoruz.
```
cat ~/$WORKSPACE/keys/public-keys.yaml
```

##  NOT: NODE REGISTRATION kısmında API PORT Kısmına 80 yazıyoruz.

# Testnet registration
## Tüm işlemler doğruysa (aptoslabs)[https://aptoslabs.com/community] sitesine giderek GET STARTED diyoruz.
![image](https://user-images.githubusercontent.com/73015593/185756923-95c0e568-8d17-4491-9b08-15831da44151.png)

##  Aptos lab github'ından petra wallet indiriyoruz. [LINK](https://github.com/aptos-labs/aptos-core/releases/download/wallet-v0.1.6/wallet-extension.zip)

##  İndirdiğimiz zipli klasörü winrar gibi bir unzip aracı ile çıkartıyoruz. 
![image](https://user-images.githubusercontent.com/73015593/185758793-4347bfd8-587f-41e2-897c-e32daf5b99f8.png)

## Connect wallet kısmı için wallet eklememiz gerekiyor.
![image](https://user-images.githubusercontent.com/73015593/185757229-7d458615-2666-4a3d-81e9-953c7fd1e694.png)

## (Chrome extensions)[chrome://extensions/] adresine gidiyoruz.

##  Sağ üstten geliştirici modunu açıyoruz.
![image](https://user-images.githubusercontent.com/73015593/185757293-4e716003-bfd6-4a85-8945-25aa3d830873.png)

##  Sol üstten paketlenmemiş öğe yükle seçiyoruz. ve zipten çıkardığımız cüzdan klasörünü yüklüyoruz.(varsayılan klasör ismi build)
![image](https://user-images.githubusercontent.com/73015593/185757360-2a15e493-bbe1-45f4-a001-a9cc1357e422.png)

## Petra Aptos wallet eklentilerde gözüküyor. Ardından cüzdan oluşturuyoruz. [aptoslabs](https://aptoslabs.com/it3) sitesine giderek cüzdanımızı bağlıyoruz. 
![image](https://user-images.githubusercontent.com/73015593/185758968-1553f391-6703-4be2-b63a-00b48af88de7.png)












