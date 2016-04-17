# Introducing PastaBin, a secure way to share
[![PastaBin TravisCI](https://img.shields.io/travis/Ogromny/PastaBin/master.svg?style=flat)](https://travis-ci.org/Ogromny/PastaBin)

PastaBin aims to be a secure, modern and fully-featured Pastebin replacement.  
It has been designed with the following things in mind: Security, Simplicity and Elegance.

PastaBin is free software. That's free as in freedom, as well as in price. This means PastaBin is yours — to use, modify, and share — because PastaBin is developed by and for the users.

## Technologies behind PastaBin
We doesn't want to make another PasteBin PHP clone, so we decided to do it in D. You would probably ask us why we choosed D to code this webapp and we would answer you that's it was a nice programming language, running pretty fast, handling MongoDB very well, permiting us to do rapid prototypes and even because that's a cool language!

Of course, we doesn't only use D but also ; MongoDB for encrypted data storage, Vibe.D as a webserver (that's what permited you to read this page) and OpenSSL for doing encryption things!

![PastaBin screenshot](http://i.imgur.com/vR0Hgjd.png)

## Install
```sh
git clone https://github.com/Ogromny/PastaBin.git && cd PastaBin
dub
```

Your local PastaBin instance is now available at http://127.0.0.1:8080

## Dependencies
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
