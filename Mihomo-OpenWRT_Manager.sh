#!/bin/sh

GREEN="\033[1;32m"
RED="\033[1;31m"
CYAN="\033[1;36m"
YELLOW="\033[1;33m"
MAGENTA="\033[1;35m"
BLUE="\033[0;34m"
NC="\033[0m"
DGRAY="\033[38;5;244m"

CONFIGPATH="/etc/magitrickle/state/config.yaml"
URL_DEFAULT="https://raw.githubusercontent.com/StressOzz/Mihomo-OpenWRT_Manager/refs/heads/main/files/MagiTrickle/config.yaml"
URL_ITDOG="https://raw.githubusercontent.com/StressOzz/Mihomo-OpenWRT_Manager/refs/heads/main/files/MagiTrickle/configAD.yaml"

echo 'sh <(wget -O - https://raw.githubusercontent.com/StressOzz/Mihomo-OpenWRT_Manager/main/Mihomo-OpenWRT_Manager.sh)' > /usr/bin/mom; chmod +x /usr/bin/mom

PAUSE() { echo -ne "\nНажмите Enter..."; read dummy; }

magitrickle_config() {
echo
echo -e "${YELLOW}Выбор списка для MagiTrickle${NC}"
echo -e "${CYAN}1) ${GREEN}ITDog Allow Domains${NC}"
echo -e "${CYAN}2) ${GREEN}Internet Helper${NC}"
echo -e "${CYAN}3) ${GREEN}Оставить текущий список${NC}"
echo -e "${CYAN}Enter) ${GREEN}Выход в главное меню${NC}"
echo

while true; do
  echo -en "${YELLOW}Введите номер: ${NC}"
  read -r choice

  case "$choice" in
    1) MAGITRICKLE_CONFIG_URL="$URL_ITDOG"; break ;;
    2) MAGITRICKLE_CONFIG_URL="$URL_DEFAULT"; break ;;
    3) MAGITRICKLE_CONFIG_URL=""; break ;;
    *) echo; break ;;
  esac
done

if [ -n "$MAGITRICKLE_CONFIG_URL" ]; then
  echo -e "\n${CYAN}Скачиванем и устанавливаем список${NC}"
  wget -q -O "$CONFIGPATH" "$MAGITRICKLE_CONFIG_URL" || {
    echo -e "${RED}Ошибка: не удалось скачать список!${NC}"
    echo "URL: $MAGITRICKLE_CONFIG_URL"
    return 1
  }

  if [ ! -s "$CONFIGPATH" ]; then
    echo -e "${RED}Ошибка: файл пустой или не создан:${NC} $CONFIGPATH"
    return 1
  fi

  echo -e "${GREEN}Список успешно изменён!${NC}"
  /etc/init.d/magitrickle enable >/dev/null 2>&1
  /etc/init.d/magitrickle reload >/dev/null 2>&1
  /etc/init.d/magitrickle start >/dev/null 2>&1
  /etc/init.d/magitrickle restart >/dev/null 2>&1
else
  echo -e "${YELLOW}Текущий список оставлен без изменений.${NC}"
fi
}

check_status() {
  MIHOMO_STATUS="${RED}не установлен${NC}"; HEV_STATUS="${RED}не установлен${NC}"; MAGITRICKLE_STATUS="${RED}не установлен${NC}"

  [ -x /etc/init.d/mihomo ] && MIHOMO_STATUS="${GREEN}установлен${NC}"
  [ -x /etc/init.d/hev-socks5-tunnel ] && HEV_STATUS="${GREEN}установлен${NC}"
  [ -x /etc/init.d/magitrickle ] && MAGITRICKLE_STATUS="${GREEN}установлен${NC}"

  echo -e "${YELLOW}mihomo-openwrt:${NC}    $MIHOMO_STATUS"
  echo -e "${YELLOW}hev-socks5-tunnel:${NC} $HEV_STATUS"
  echo -e "${YELLOW}magitrickle:${NC}       $MAGITRICKLE_STATUS"
}

show_menu() {
clear
echo -e "╔═══════════════════════════════════════════╗"
echo -e "║ ${BLUE}mihomo-openwrt on Internet-Helper Manager${NC} ║"
echo -e "╚═══════════════════════════════════════════╝"
echo -e "                                 ${DGRAY}by StressOzz${NC}"

echo
check_status
echo

echo -e "${CYAN}1) ${GREEN}Установить ${NC}mihomo-openwrt"
echo -e "${CYAN}2) ${GREEN}Удалить ${NC}mihomo-openwrt"
echo -e "${CYAN}3) ${GREEN}Сменить список ${NC}MagiTrickle"
echo -e "${CYAN}4) ${GREEN}Сгенерировать ${NC}WARP"
echo -e "${CYAN}5) ${GREEN}Интегрировать ${NC}/root/WARP.conf${GREEN} в ${NC}mihomo-openwrt"
# echo -e "${CYAN}6) ${GREEN}Удалить ${NC}→ ${GREEN}установить ${NC}→ ${GREEN}настроить ${NC}mihomo-openwrt"
echo -e "${CYAN}Enter) ${GREEN}Выход"
echo
echo -ne "${YELLOW}Выберите пункт: ${NC}"
read choiceM

case "$choiceM" in
1)
  sh <(wget -q -O - https://raw.githubusercontent.com/StressOzz/Mihomo-OpenWRT_Manager/main/mihomo_openwrt_install.sh)
  PAUSE
  ;;
2)
  sh <(wget -q -O - https://raw.githubusercontent.com/StressOzz/Mihomo-OpenWRT_Manager/main/mihomo_openwrt_delete.sh)
  PAUSE
  ;;
3)
  magitrickle_config
  PAUSE
  ;;
4)
  sh <(wget -q -O - https://raw.githubusercontent.com/StressOzz/Mihomo-OpenWRT_Manager/main/gen_WARP.sh)
  PAUSE
  ;;
5)
  sh <(wget -q -O - https://raw.githubusercontent.com/StressOzz/Mihomo-OpenWRT_Manager/main/WARP_to_conf.sh)
  PAUSE
  ;;
6)
  sh <(wget -q -O - https://raw.githubusercontent.com/StressOzz/Mihomo-OpenWRT_Manager/main/mihomo_openwrt_delete.sh)
  sh <(wget -q -O - https://raw.githubusercontent.com/StressOzz/Mihomo-OpenWRT_Manager/main/mihomo_openwrt_install.sh)
  sh <(wget -q -O - https://raw.githubusercontent.com/StressOzz/Mihomo-OpenWRT_Manager/main/gen_WARP.sh)
  sh <(wget -q -O - https://raw.githubusercontent.com/StressOzz/Mihomo-OpenWRT_Manager/main/WARP_to_conf.sh)
  PAUSE
  ;;
*)
  echo
  exit 0
  ;;
esac
}

while true; do
  show_menu
done
