#!/bin/bash

#Control_C
function ctrl_c(){
    echo -e "\n\n${redColour}[!] Saliendo... ${endColour}\n"
    exit 1

}

#Ctrl_C 
trap ctrl_c INT

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

#Variables globales
contador=0
argumentos=""
User=""
modo=""
iniciador_a=0
iniciador_b=0
iniciador_c=0
iniciador_d=0
ip=""
ports=""
P=""
S=""
V=""

#Funcion para agregar datos e iniciar ataque
function_atacar() {
    echo -e "${yellowColour}Digite la Ip Victima:${endColour} "
    read ip 
    echo -e "${greenColour}Ip guardada${endColour}"
    echo -e "${yellowColour}Digite el modo que desea usar (1,2,3)${endColour}"
    read modo
    case "$modo" in
        1)
            argumentos=" "
            ;;
        2)
            argumentos="-n -sV"
            ;;
        3)
            argumentos="-n -p- -sV -Pn " 
            ;;
    esac
    echo -e "${greenColour}Modo guardado${endColour}"
    echo -e "${grayColour}Has seleccionado la Ip ${blueColour}$ip${endColour} ${grayColour}y el modo${endColour} ${blueColour}$modo ${endColour}${endColour}"
    echo -e "${redColour}Desea iniciar el ataque? (y/n) ${endColour}"
    read user
    iniciador_a=0
    while [ $iniciador_a -lt 1 ]; do
        case "$user" in
            "y")
                tput civis 
                echo -e "${redColour}Generando Ataque${endColour}"
                sudo nmap  ${argumentos} -oN Scan$ip.txt ${ip} > /dev/null
                echo -e "${grayColour}Ataque finalizado y listo para generar reporte${endColour}"
                iniciador_a=1
                menu="n"
                tput cnorm
                ;;
            "n")
                echo -e " [!] 1)${yellowColour} Cambiar la Ip${endColour} \n [!] 2) ${yellowColour}Cambiar el modo${endColour} \n [!] 3) ${redColour}Iniciar Ataque${endColour} \n [!] 4) ${blueColour}Volver al menu principal${endColour}"
                echo -n -e "${purpleColour}que desea hacer?${endColour} \n"
                read menu
                case "$menu" in
                    1)
                        echo -e "${yellowColour}Digite la Ip Victima:${endColour} "
                        read ip 
                        echo -e "${greenColour}Ip guardada${endColour}"
                        ;;
                    2)
                        echo -e "${yellowColour}Digite el modo que desea usar (1,2,3)${endColour}"
                        read modo
                        echo -e "${greenColour}Modo guardado${endColour}"
                        ;;
                    3)
                        echo -e "${grayColour}Has seleccionado la Ip $ip y el modo $modo ${endColour}"
                        echo -e "${redColour}Iniciando Ataque ${endColour}"
                        sudo nmap  ${argumentos} -oN Scan_$ip.txt ${ip} > /dev/null
                        echo -e "${greenColour}Ataque finalizado y Reporte creado${grayColour}"
                        contador = 1
                        ;;
                    4)
                        echo -e "${blueColour}Volviendo al menu princial${endColour}"
                        iniciador_a=1
                        ;;
                    *)
                        echo -e "${redColour}Input invalido${endColour}"
                        ;;
                esac
            ;;
        esac
    done
    return
}

#Funcion para el panel de ayuda
function_ayuda() {
    iniciador_c=0
        while [ $iniciador_c -lt 1 ]; do
            echo -e "\n${purpleColour}Menu de ayuda${endColour} \n -1) ${redColour}Panel de ataque${endColour} \n -2) ${greenColour}Panel de Scaneo${endColour} \n -3) ${yellowColour}Modos${endColour} \n -4) ${blueColour}Volver${endColour}"
            echo -n -e "${purpleColour}Que ayuda desea visualizar? ${endColour}"
            read User
            case "$User" in
                "1")
                    echo -e "${redColour}Panel de Ataque${endColour} \n ${blueColour}Primero se te pedira la Ip de la maquina victima \n Luego se te pedira que indique el modo \n Se mostraran los datos para su revision \n Si todos los datos son correctos presione 'y' \n Si los datos no son corectos presione 'n' para volver a digitar los datos${endColour}"
                    echo -n -e "${greenColour}Presione Enter para continuar${endColour}"
                    read
                    ;;
                "2")
                    echo -e "${purpleColourColour}Panel de reporte${endColour} \n ${greenColour}Al ingresar al panel de ayuda se generara el reporte automaticamente \n Al finalazar la creacion del reporte se mostrara en pantalla${endColour}"
                    echo -n -e "${greenColour}Presione Enter para continuar${endColour}"
                    read
                    ;;
                "3")
                    echo -e "${yellowColour}***Modos***${endColour}"
                    echo -e "${blueColour}Modo 1) Aplicara un Scaneo unicamente a los 1000 puertos mas comunes (No los primeros 1000 puertos)${endColour}"
                    echo -e "${blueColour}Modo 2) Aplicara un Scaneo unicamente a los 1000 puertos mas comunes y muestra el servicio${endColour}"
                    echo -e "${blueColour}Modo 3) Aplicara un Scaneo a todos los puertos (65535, Esto puede tardar un poco mas) ademas de aplicar Scripts de reconocimiento de servicio en el puerto${endColour}"
                    echo -e "${yellowColour}\t[!] Todos los modos aplican un minimo de 5000 paquetes por segundo [!]${endColour}"
                    echo -n -e "${greenColour}Presione Enter para continuar${endColour}"
                    read
                    ;;
                "4")
                    echo -e "${greenColour}Volviendo al menu principal${endColour}"
                    iniciador_c=1
                    ;;
                *)
                    echo -e "${redColour}Opcion incoreccta${endColour}"
                    echo -n -e "${greenColour}Presione Enter para continuar${endColour}"
                    read
                    ;;
            esac 
        done
    return
}

#Funcion para el panel de reportes
function_reporte() {
    
    echo -e "${redColour}\t\tReporte del ataque realizado a la IP $ip${endColour}\n"
    echo -e "${yellowColour}Guardando Puertos Abiertos "
    sleep 2
    P=$(cat Scan$ip.txt | grep "^[0-9]" | awk -F ' ' '{print $1}')
    echo -e "Puertos Guardados\n"
    echo -e "Guardando Servicios "
    sleep 2
    S=$(cat Scan$ip.txt | grep "^[0-9]" | awk -F ' ' '{print $3}')
    echo -e "Los servicios han sido guardados\n" 
    echo -e "Guardando Version del servicio"
    sleep 2
    V=$(cat Scan$ip.txt | grep "^[0-9]" | awk -F ' ' '{for (i=4; i<=NF; i++) printf "%s ", $i; printf "\n"}')
    echo -e "Las Versiones han sido guardadas\n${endColour}"

    echo -e "${greenColour}\n\tREPORTE FINALIZADO\n\n${endColour}"
    echo -e "${greenColour}Puertos Encontrados${endColour}"
    echo -e "${redColour}$P\n${endColour}"
    echo -e "${greenColour}Servicios Detectados${endColour}"
    echo -e "${redColour}$S\n${endColour}"
    echo -e "${greenColour}Versiones Detectadas${endColour}"
    echo -e "${redColour}$V\n${endColour}"

}

#Brand
brand="  
  ▄▄▄▄▄.........▄.▄·.▄▄▄·..▄..▄
  ██▪.██.▪.....▪█·█▌▐█.▀█.██▪▐█
  ▐█·.▐█▌.▄█▀▄.▐█▐█•▄█▀▀█.██▀██
  ██..██.▐█▌.▐▌.███.▐█.▪▐▌██▌.█
  ▀▀▀▀▀•..▀█▄▀▪..▀...▀..▀.▀▀▪.▀
  .▄▄▄·......▄▄▄..▄▄▄▄▄.▄▄.·...
  ▐█.▄█▪.....▀▄.█·•██..▐█.▀....
  .██▀·.▄█▀▄.▐▀▀▄..▐█.▪▄▀▀▀█▄..
  ▐█▪·•▐█▌.▐▌▐█•█▌.▐█▌·▐█▄▪▐█..
  .▀....▀█▄▀▪.▀..▀.▀▀▀..▀▀▀▀..."

brand=$(echo "$brand" | tr -d ' ')



#Comienzo de Script
echo -e "$blueColour $brand $endColour"
contador=0
while [ $contador -lt 1 ]
    do
        echo -n -e ${purpleColour}"Menu DovahPorts ${endColour}\n [!]-1) ${redColour}Generar Ataque ${endColour}\n [!]-2) ${greenColour}Generar Reporte ${endColour}\n [!]-3) ${yellowColour}Ayuda ${endColour}\n [!]-4) ${purpleColour}Salir ${endColour}\n ${greenColour}-̲-̲-̲> : ${endColour}"
        read User
        case "$User" in
            "1")
                function_atacar
                ;;
            "2")
                function_reporte
                ;;
            "3")
                function_ayuda
                ;;
            "4")
                echo -e "\n${redColour}Saliendo...${endColour}"
                exit 0
                ;;
            *)
                echo -e $yellowColour "Opcion incorrecta" $endColour
                ;;
    esac


done

