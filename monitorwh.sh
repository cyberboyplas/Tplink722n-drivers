#!/bin/bash

#colores
cyan='\033[1;36m'
amarillo='\033[1;33m'
blanco='\033[1;37m'
verde='\033[1;32m'
lila='\033[1;35m'
rojo='\033[1;31m'


 
R='\e[0;31m' # Rojo fuerte            
G='\e[0;32m' # Verde Fuerte         
Y='\e[0;33m' # Amarillo Fuerte       
B='\e[0;34m' # Azul fuerte          
M='\e[0;35m' # Purpura o algo asi   
C='\e[0;36m' # Cyan color fuerte     
W='\e[0;37m' # Blanco Fuerte       
P='\e[0;35m' # Purpura               
Green='\e[32m' # Verde             
Gr='\e[5m\e[32m' # verde           
Gris='\e[90m' # Gris               

pollas() {
echo -e "${amarillo}- ${cyan}(${lila}S${cyan})${blanco} para saltarlo ${cyan}(${lila}N${cyan})${blanco} para no saltarlo."
echo
echo -e -n "${amarillo}--> ${lila}"
read mierdaca
case $mierdaca in
               S | s)
               echo
               echo -e "${amarillo}- ${rojo}Recuerda no pausar el proceso."
               sleep 3
               echo
               echo -e "${amarillo}- ${verde}Iniciando Instalación${Gris}..."
               sleep 2
               sudo apt install bc
               sudo apt-get install build-essential
               sudo apt-get install libelf-dev
               sudo apt-get install linux-headers-$(uname -r)
               cd files
               unzip drivers.zip
               cd drivers
               sudo -i
               echo "blacklist r8188eu" > "/etc/modprobe.d/realtek.conf"
               sh -c "$(curl -fsSL https://raw.githubusercontent.com/KanuX-14/rtl8188eus/v5.3.9/build.sh)"
               echo
               echo -e "${verde}Instalación completada"
               sleep 3
               clear
               banner
               menuprincipal
               ;;
               
               N | n)
               echo
               echo -e "${amarillo}- ${rojo}Recuerda no pausar el proceso. ${verde}Iniciando Instalación${Gris}..."
               sleep 3
               clear
               sudo apt update
               sudo apt upgrade
               sudo apt install bc
               sudo apt-get install build-essential
               sudo apt-get install libelf-dev
               sudo apt-get install linux-headers-$(uname -r)
               cd files
               unzip drivers.zip
               cd drivers
               sudo -i
               echo "blacklist r8188eu" > "/etc/modprobe.d/realtek.conf"
               sh -c "$(curl -fsSL https://raw.githubusercontent.com/KanuX-14/rtl8188eus/v5.3.9/build.sh)"
               echo
               echo -e "${amarillo}- ${verde}Instalación completada!"
               sleep 3
               clear
               banner
               menuprincipal
               ;;
               
               *)
               echo
               echo -e "${rojo}Cómo?, no entendi. Escribe ${cyan}(${lila}S${cyan}) ${rojo}o ${cyan}(${lila}N${cyan})${Gris}!"
               sleep 3
               clear
               banner
               menuprincipal
               ;;
esac
}

banner() {
figlet -f slant Tplink-722n | lolcat
echo -e " ${verde}Made by ${blanco}WhBeatZ ${cyan}| ${rojo}v1.0 ${blanco}"
}

comprobrarinterfaz() {
echo -e "${verde}"
sudo airmon-ng
echo
echo -e "${amarillo}- ${cyan}Escribe el nombre de la interfaz. ${Gris}(${amarillo}Ejemplo: ${lila}wlan0${Gris},${lila} wlan1${Gris})"
echo
echo -e -n "${amarillo}--> ${blanco}"
read ojo
echo
echo -e "${verde}- ${blanco}Antena: ${verde}$ojo"
echo
echo -e "${amarillo}- ${Gris}Presiona cualquier tecla si está bien."
read
}

modomonitor() {
comprobrarinterfaz
sudo rmmod r8188eu.ko
sudo modprobe 8188eu
echo -e "${amarillo}- ${cyan}Desconecta tu antena, despues conectala y preciona enter para continuar" && sleep 1
read
echo -e "${amarillo}- ${amarillo}Matando conexiones${Gris}... "
sudo airmon-ng check kill
sudo ifconfig $ojo down  
sudo iw dev $ojo set type monitor 
sudo ifconfig $ojo up
clear 
echo -e "${amarillo}- ${verde}Modo Monitor Activado :D"
}

quitarmonitor() {
comprobrarinterfaz
echo -e "${amarillo}- ${verde}Restaurando procesos${Gris}..."
sudo systemctl restart NetworkManager.service
sudo service wpa_supplicant start 
sudo ifconfig $ojo down
sudo iw dev $ojo set type managed
sudo ifconfig $ojo up
echo -e "${amarillo}- ${cyan}Restaurado, conecta y desconecta la antena para captar la red${verde}!"
echo
}

menuprincipal() {
echo
echo -e "${Gris}┌----------------------${Gris}"
echo -e "${Gris}|${cyan} 1${amarillo}. ${blanco}Instalar Drivers ${Gris} |"
echo -e "${Gris}└----------------------"
echo -e "${Gris}┌--------------------------${Gris}"
echo -e "${Gris}|${cyan} 2${amarillo}. ${blanco}Poner en modo Monitor ${Gris}|"
echo -e "${Gris}└--------------------------"
echo -e "${Gris}┌------------------------${Gris}"
echo -e "${Gris}|${cyan} 3${amarillo}. ${blanco}Quitar modo Monitor ${Gris}|"
echo -e "${Gris}└------------------------"
echo
echo -e -n "${amarillo}--> ${blanco}"
read polla
case $polla in
            1 | 1.)
            echo
            echo -e "${verde}--------------------------------------------------------------------------------------------"
            echo -e "${amarillo}- ${cyan}Recuerda ${blanco}no detener el proceso, esto podría tardar un poco dependiendo de la conexión."
            echo -e "  Suele tardar más si se actualizan los repositorios. Y si se salta puede que no funcione "
            echo -e "  la instalación."
            echo
            echo -e "${amarillo}- ${cyan}Recomendación:${blanco} Probar Primero a Actualizar sin actualizar los repositorios ${cyan}(${lila}S${cyan}) ${blanco}y si no" 
            echo -e "  funciona, actualizar los repositorios ${cyan}(${lila}N${cyan})"
            echo -e "${verde}--------------------------------------------------------------------------------------------"
            echo
            echo -e "${rojo}----${verde}----${rojo}----${verde}----${rojo}----${verde}----${rojo}----${verde}----${rojo}----${verde}----${rojo}----${verde}----${rojo}----${verde}----${rojo}----${verde}----${rojo}----${verde}----${rojo}----${verde}----${rojo}----${verde}----${rojo}----"
            echo -e "${amarillo}- ${blanco}Deseas ${lila}saltarte${blanco} la actualización de Repositorios${blanco}? ${lila}(${blanco}Puede que ${rojo}no ${blanco}funcione${lila})"
            echo
            pollas
            ;;
            2 | 2.)
            modomonitor    
            ;;
            3 | 3.)
            quitarmonitor
            ;;
            *)
            echo
            echo -e "${rojo}No entendí :c"
            sleep 3
            clear
            banner
            menuprincipal
            ;;
esac
}

clear

root() {
case `whoami` in
              root)
              banner
              menuprincipal
              ;;
              
              *)
              banner
              echo
              echo -e "${amarillo}- ${rojo}Bro, necesitas ser root!"
              sleep 3
              ;;
esac
}

root
