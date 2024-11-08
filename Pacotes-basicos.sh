#!/bin/bash

# Defina a senha do seu root
# Automatizando a entrada da senha para o sudo (não recomendado para ambientes de produção)
 sudo -S pacman -Syu --noconfirm

sudo rm /var/lib/pacman/db.lck
# Definindo o array com os pacotes para o Arch Linux (pacman e yay)

pacotesArc=("curl" "git" "neovim" "htop" "wget" "vlc" "firefox" "ntfs-3g" "dbeaver" "gcc" "make" "telegram-desktop" 
"code" "docker" "discord" "ttf-liberation" "ttf-dejavu" "noto-fonts" "fontconfig" "noto-fonts-emoji" "noto-fonts-cjk"
"obs-studio" "mkvtoolnix-gui" "gimp" "qbittorrent")

pacotesYay=("google-chrome" "postman-bin")

# Loop para instalar os pacotes do pacman
for pacote in "${pacotesArc[@]}"; do
    echo "Instalando $pacote..."
    sudo pacman -S "$pacote" --noconfirm
done

# Verificar se o diretório yay-bin existe, senão clonar
if [ ! -d "yay-bin" ]; then
    git clone https://aur.archlinux.org/yay-bin.git
fi
cd yay-bin

# Executar makepkg como usuário normal

makepkg -si --noconfirm

# Instalar pacotes do AUR com yay
for pacote in "${pacotesYay[@]}"; do
    echo "Instalando $pacote..."
    yay -S "$pacote" --noconfirm
done

#Config do docker
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -a -G docker mrrobot

echo "Todos os pacotes foram instalados!"
