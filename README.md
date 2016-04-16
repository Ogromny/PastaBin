# PastaBin
Current version: 0.1.0

![PastaBin screenshot](http://i.imgur.com/vR0Hgjd.png)

## Dependencies:
#### Archlinux
```bash
pacman -S dub dmd
```

#### Fedora
```bash
dnf install curl libcurl libcurl-devel mongodb mongodb-server
wget https://mattdm.org/misc/fedora/libcurl-gnutls-7.43.0-4.1.fc23.i386.rpm
dnf install tls-7.43.0-4.1.fc23.i386.rpm
curl -fsS https://dlang.org/install.sh | bash -s dmd
```

#### Debian
```bash
apt-get install dub dmd
```

#### Ubuntu
```d
OS ubuntu = Bullshit();
ubuntu.goTo("Debian");
```
