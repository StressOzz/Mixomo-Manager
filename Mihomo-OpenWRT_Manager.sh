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
URL_DEFAULT="https://raw.githubusercontent.com/StressOzz/Use_WARP_on_OpenWRT/refs/heads/main/files/MagiTrickle/config.yaml"
URL_ITDOG="https://raw.githubusercontent.com/StressOzz/Use_WARP_on_OpenWRT/refs/heads/main/files/MagiTrickle/configAD.yaml"

PAUSE() { echo -ne "\nНажмите Enter..."; read dummy; }

magitrickle_config() {
echo
echo -e "Выбор списка для MagiTrickle"
echo -e "1) ITDog Allow Domains"
echo -e "2) Internet Helper"
echo -e "3) Оставить текущий список"
echo

while true; do
  echo -en "Введите номер: "
  read -r choice
  choice="${choice:-2}"

  case "$choice" in
    1) MAGITRICKLE_CONFIG_URL="$URL_ITDOG"; break ;;
    2) MAGITRICKLE_CONFIG_URL="$URL_DEFAULT"; break ;;
    3) MAGITRICKLE_CONFIG_URL=""; break ;;
    *) echo "Неверный выбор. Введите 1, 2 или 3." ;;
  esac
done

if [ -n "$MAGITRICKLE_CONFIG_URL" ]; then
  echo -e "${CYAN}Скачивание конфигурации...${NC}"
  wget -q -O "$CONFIGPATH" "$MAGITRICKLE_CONFIG_URL" || {
    echo -e "${RED}Ошибка: не удалось скачать список!${NC}"
    echo "URL: $MAGITRICKLE_CONFIG_URL"
    return 1
  }

  if [ ! -s "$CONFIGPATH" ]; then
    echo -e "${RED}Ошибка: файл пустой или не создан:${NC} $CONFIGPATH"
    return 1
  fi

  echo -e "${GREEN}Готово.${NC}"
  /etc/init.d/magitrickle enable >/dev/null 2>&1
  /etc/init.d/magitrickle reload  >/dev/null 2>&1
  /etc/init.d/magitrickle start >/dev/null 2>&1
  /etc/init.d/magitrickle restart >/dev/null 2>&1
else
  echo -e "${YELLOW}Текущий список оставлен без изменений.${NC}"
fi
}

show_menu() {
clear
echo -e "╔═══════════════════════════════════════════╗"
echo -e "║ ${BLUE}mixomo-openwrt on Internet-Helper Manager${NC} ║"
echo -e "╚═══════════════════════════════════════════╝"
echo -e "                                 ${DGRAY}by StressOzz${NC}"
echo
echo -e "${CYAN}1) ${GREEN}Установить ${NC}mixomo-openwrt"
echo -e "${CYAN}2) ${GREEN}Удалить ${NC}mixomo-openwrt"
echo -e "${CYAN}3) ${GREEN}Сменить список ${NC}MagiTrickle"
echo -e "${CYAN}4) ${GREEN}Сгенерировать ${NC}WARP"
echo -e "${CYAN}5) ${GREEN}Интегрировать ${NC}WARP${GREEN} в ${NC}mixomo-openwrt"
echo -e "${CYAN}6) ${GREEN}Удалить ${NC}→ ${GREEN}установить ${NC}→ ${GREEN}настроить ${NC}mixomo-openwrt"
echo -e "${CYAN}Enter) ${GREEN}Выход"
echo
echo -ne "${YELLOW}Выберите пункт: ${NC}"
read choiceM

case "$choiceM" in
1)
  sh <(wget -O - https://raw.githubusercontent.com/StressOzz/WARP_on_OpenWRT/main/mixomo_openwrt_install.sh)
  PAUSE
  ;;
2)
  sh <(wget -O - https://raw.githubusercontent.com/StressOzz/WARP_on_OpenWRT/main/mixomo_openwrt_delete.sh)
  PAUSE
  ;;
3)
  magitrickle_config
  PAUSE
  ;;
4)
  sh <(wget -O - https://raw.githubusercontent.com/StressOzz/WARP_on_OpenWRT/main/gen_WARP.sh)
  PAUSE
  ;;
5)
  sh <(wget -O - https://raw.githubusercontent.com/StressOzz/WARP_on_OpenWRT/main/WARP_to_conf.sh)
  PAUSE
  ;;
6)
  sh <(wget -O - https://raw.githubusercontent.com/StressOzz/WARP_on_OpenWRT/main/mixomo_openwrt_delete.sh)
  sh <(wget -O - https://raw.githubusercontent.com/StressOzz/WARP_on_OpenWRT/main/mixomo_openwrt_install.sh)
  sh <(wget -O - https://raw.githubusercontent.com/StressOzz/WARP_on_OpenWRT/main/gen_WARP.sh)
  sh <(wget -O - https://raw.githubusercontent.com/StressOzz/WARP_on_OpenWRT/main/WARP_to_conf.sh)
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
