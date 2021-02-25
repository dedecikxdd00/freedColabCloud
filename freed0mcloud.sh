b='\033[1m'
r='\E[31m'
g='\E[32m'
c='\E[36m'
endc='\E[0m'
enda='\033[0m'

clear

# Branding

printf """$c$b
     _______  _______  _______  _______  ______   _______  _______  __    ______        
    (  ____ \(  ____ )(  ____ \(  ____ \(  __  \ (  __   )(       )/  \  / ___  \ 
    | (    \/| (    )|| (    \/| (    \/| (  \  )| (  )  || () () |\/) ) \/   \  \
    | (__    | (____)|| (__    | (__    | |   ) || | /   || || || |  | |    ___) /
    |  __)   |     __)|  __)   |  __)   | |   | || (/ /) || |(_)| |  | |   (___ ( 
    | (      | (\ (   | (      | (      | |   ) ||   / | || |   | |  | |       ) \
    | )      | ) \ \__| (____/\| (____/\| (__/  )|  (__) || )   ( |__) (_/\___/  /
    |/       |/   \__/(_______/(_______/(______/ (_______)|/     \|\____/\______/ 
    $r  GoogleColab freedMethod v1 | by=freed0M13#2199
      Discord : https://discord.gg/awNx7bBHv8       
$endc$enda""";



# Used Two if else type statements, one is simple second is complex. So, don't get confused or fear by seeing complex if else statement '^^.

# Creation of user
printf "\n\nKullanıcı Oluşturuluyor... " >&2
if sudo useradd -m user &> /dev/null
then
  printf "\rKullanıcı Oluşturuldu. $endc$enda\n" >&2
else
  printf "\r$r$b Hata Meydana Geldi Lütfen Tekrar Deneyin. $endc$enda\n" >&2
  exit
fi

# Add user to sudo group
sudo adduser user sudo

# Set password of user to 'root'
echo 'user:root' | sudo chpasswd

# Change default shell from sh to bash
sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd

# Initialisation of Installer
printf "\n\n$c$b    Güncelleme Yapılıyor... $endc$enda" >&2
if sudo apt-get update &> /dev/null
then
    printf "\r$g$b    Güncelleme Tamamlandı. $endc$enda\n" >&2
else
    printf "\r$r$b    Hata Oluştu Lütfen Tekrar Deneyin. $endc$enda\n" >&2
    exit
fi

# Installing Chrome Remote Desktop
printf "\n$g$b    VNC Servisi İndiriliyor... $endc$enda" >&2
{
    sudo apt-get install vnc-server 
    sudo apt install --assume-yes --fix-broken
} &> /dev/null &&
printf "\r$c$b    VNC Servisi Kuruldu. $endc$enda\n" >&2 ||
{ printf "\r$r$b    Hata Oluştu Lütfen Tekrar Deneyin. $endc$enda\n" >&2; exit; }



# Install Desktop Environment (XFCE4)
printf "$g$b    Sistem Arayüzü İndiriliyor... $endc$enda" >&2
{
    sudo DEBIAN_FRONTEND=noninteractive \
    apt install --assume-yes gnome-core
	sudo apt install --assume-yes gnome
	sudo apt install --assume-yes anacron
	sudo apt install --assume-yes network-manager-gnome
	sudo apt install --assume-yes libproxy1-plugin-networkmanager
    sudo apt install --assume-yes xscreensaver
    sudo systemctl disable lightdm.service
} &> /dev/null &&
printf "\r$c$b    Sistem Arayüzü Kuruldu. $endc$enda\n" >&2 ||
{ printf "\r$r$b    Hata Oluştu Lütfen Tekrar Deneyin. $endc$enda\n" >&2; exit; }



# Install Google Chrome
printf "$g$b    Google Chrome İndiriliyor... $endc$enda" >&2
{
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg --install google-chrome-stable_current_amd64.deb
    sudo apt install --assume-yes --fix-broken
} &> /dev/null &&
printf "\r$c$b    Google Chrome Kuruldu $endc$enda\n" >&2 ||
printf "\r$r$b    Hata Oluştu Lütfen Tekrar Deneyin. $endc$enda\n" >&2



# Install CrossOver (Run exe on linux)
printf "$g$b    CrossOver İndiriliyor... $endc$enda" >&2
{
    wget https://media.codeweavers.com/pub/crossover/cxlinux/demo/crossover_20.0.2-1.deb
    sudo dpkg -i crossover_20.0.2-1.deb
    sudo apt install --assume-yes --fix-broken
} &> /dev/null &&
printf "\r$c$b    CrossOver Kuruldu. $endc$enda\n" >&2 ||
printf "\r$r$b    Hata Oluştu Lütfen Tekrar Deneyin. $endc$enda\n" >&2



# Install OBS-Studio (Livestream)
printf "$g$b    Obs-Studio İndiriliyor... $endc$enda" >&2
{
    sudo apt install ffmpeg -y
    sudo add-apt-repository ppa:obsproject/obs-studio -y
    sudo apt install obs-studio -y
    sudo apt install --assume-yes --fix-broken
} &> /dev/null &&
printf "\r$c$b    OBS-Studio Kuruluyor. $endc$enda\n" >&2 ||
printf "\r$r$b    Hata Oluştu Lütfen Tekrar Deneyin. $endc$enda\n" >&2

# Install VLC Media Player 
printf "$g$b    VLC Media Player İndiriliyor... $endc$enda" >&2
{
    sudo apt install vlc -y
} &> /dev/null &&
printf "\r$c$b    VLC Media Player Kuruldu. $endc$enda\n" >&2 ||
printf "\r$r$b    Hata Oluştu Lütfen Tekrar Deneyin. $endc$enda\n" >&2

# Install other tools like nano
sudo apt-get install gdebi -y &> /dev/null
sudo apt-get install vim -y &> /dev/null
sudo apt-get install gedit -y &> /dev/null
printf "$g$b    Araçlar İndiriliyor... $endc$enda" >&2
if sudo apt install nautilus nano -y &> /dev/null
then
    printf "\r$c$b    Araçlar Kuruldu. $endc$enda\n" >&2
else
    printf "\r$r$b    Hata Oluştu Lütfen Tekrar Deneyin. $endc$enda\n" >&2
fi



printf "\n$g$b    Sunucu Başarıyla Kuruldu! $endc$enda\n\n" >&2



# Adding user to CRP group
sudo adduser user chrome-remote-desktop

# Finishing Work
printf '\n http://remotedesktop.google.com/headless Sitesine Giriş Yap ve Debian Linux Seçeneğini Kopyala.\n'
read -p "Komudu Yapıştır: " CRP
su - user -c """$CRP"""

printf "\n$c$b Yapılan Herşey Doğruysa Sunucu Açılmıştır, Eğer Hata Yaptıysan F5 Çek Ve Yeniden Dene ! 'su - user -c '<CRP Command Here>' $endc$enda\n" >&2
printf "\n$c$b https://remotedesktop.google.com/access Sunucuna Giriş Yapmak İçin Bu Linke Tıkla Ve Sunucuyu Seç. ' $endc$enda\n" >&2
printf "\n$g$b Sunucun Açıldı İyi Eğlenceler !$endc$enda"

