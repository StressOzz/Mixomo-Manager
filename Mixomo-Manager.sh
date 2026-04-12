#!/bin/sh

GREEN="\033[1;32m"
RED="\033[1;31m"
CYAN="\033[1;36m"
YELLOW="\033[1;33m"
MAGENTA="\033[1;35m"
BLUE="\033[0;34m"
NC="\033[0m"
DGRAY="\033[38;5;244m"

if command -v opkg >/dev/null 2>&1; then UPDATE="opkg update"; INSTALL="opkg install"; else UPDATE="apk update"; INSTALL="apk add"; fi

if ! command -v curl >/dev/null 2>&1; then clear; echo -e "${CYAN}Устанавливаем ${NC}curl"
$UPDATE >/dev/null 2>&1 && $INSTALL curl >/dev/null 2>&1 || { echo -e "\n${RED}Ошибка установки curl${NC}\n";return 1; }; fi;


CONFIGPATH="/etc/magitrickle/state/config.yaml"
URL_DEFAULT="https://raw.githubusercontent.com/StressOzz/Mixomo-Manager/refs/heads/main/files/MagiTrickle/config.yaml"
URL_ITDOG="https://raw.githubusercontent.com/StressOzz/Mixomo-Manager/refs/heads/main/files/MagiTrickle/configAD.yaml"

echo 'sh <(wget -O - https://raw.githubusercontent.com/StressOzz/Mixomo-Manager/main/Mixomo-Manager.sh)' > /usr/bin/mom; chmod +x /usr/bin/mom

PAUSE() { echo -ne "\nНажмите Enter..."; read dummy; }

magitrickle_config() {
echo -e "\n${MAGENTA}Выбор списка для MagiTrickle${NC}"
echo -e "${CYAN}1) ${GREEN}Список от${NC} ITDog"
echo -e "${CYAN}2) ${GREEN}Список от${NC} Internet Helper"
echo -e "${CYAN}Enter) ${GREEN}Выход в главное меню${NC}\n"

while true; do
  echo -en "${YELLOW}Выберите пункт: ${NC}"
  read -r choice

  case "$choice" in
    1) MAGITRICKLE_CONFIG_URL="$URL_ITDOG"; break ;;
    2) MAGITRICKLE_CONFIG_URL="$URL_DEFAULT"; break ;;
    *) return ;;
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
  PAUSE
fi
}

check_status() {
  MIHOMO_STATUS="${RED}не установлен${NC}"
  HEV_STATUS="${RED}не установлен${NC}"
  MAGITRICKLE_STATUS="${RED}не установлен${NC}"

  if [ -x /etc/init.d/mihomo ]; then
    STATUS=$(/etc/init.d/mihomo status 2>/dev/null)
    case "$STATUS" in
      running|active) MIHOMO_STATUS="${GREEN}запущен${NC}" ;;
      *)              MIHOMO_STATUS="${RED}остановлен${NC}" ;;
    esac
  fi

  if [ -x /etc/init.d/hev-socks5-tunnel ]; then
    STATUS=$(/etc/init.d/hev-socks5-tunnel status 2>/dev/null)
    case "$STATUS" in
      running|active) HEV_STATUS="${GREEN}запущен${NC}" ;;
      *)              HEV_STATUS="${RED}остановлен${NC}" ;;
    esac
  fi

  if [ -x /etc/init.d/magitrickle ]; then
    STATUS=$(/etc/init.d/magitrickle status 2>/dev/null)
    case "$STATUS" in
      running|active) MAGITRICKLE_STATUS="${GREEN}запущен${NC}" ;;
      *)              MAGITRICKLE_STATUS="${RED}остановлен${NC}" ;;
    esac
  fi

  echo -e "${YELLOW}Mihomo:${NC}              $MIHOMO_STATUS"
  echo -e "${YELLOW}MagiTrickle:${NC}         $MAGITRICKLE_STATUS"
  echo -e "${YELLOW}HevSocks5Tunnel:${NC}     $HEV_STATUS"
}

PODPISKA() {



  echo -ne "\n${YELLOW}Введите ссылку на подписку (${CYAN}https://sub....${YELLOW}): ${NC}"
  read -r SUB_URL

  [ -z "$SUB_URL" ] && echo -e "\n${RED}Ошибка! Ссылка пустая!${NC}" && PAUSE && return

  cat > /etc/mihomo/config.yaml <<EOF
mixed-port: 7890
allow-lan: false
mode: rule
log-level: error
ipv6: false
tcp-concurrent: true
find-process-mode: off
unified-delay: true

external-controller: 0.0.0.0:9090
external-ui: ui
external-ui-url: https://github.com/MetaCubeX/metacubexd/releases/latest/download/compressed-dist.tgz
secret: "CHANGE_ME_NOW"

profile:
  store-selected: false
  store-fake-ip: false

dns:
  enable: false

proxy-providers:
  my_vpn:
    type: http
    url: "$SUB_URL"
    path: ./proxy_providers/vpn.yaml
    interval: 3600
    health-check:
      enable: true
      url: https://cp.cloudflare.com/generate_204
      expected-status: 204
      interval: 120
      timeout: 5000
      lazy: false
    override:
      udp: true
      ip-version: ipv4-prefer

proxy-groups:
  - name: AUTO
    type: fallback
    use:
      - my_vpn
    url: https://cp.cloudflare.com/generate_204
    interval: 120
    tolerance: 100
    lazy: false
    max-failed-times: 3

  - name: PROXY
    type: select
    proxies:
      - AUTO
      - DIRECT
      - REJECT

  - name: VPN
    type: select
    proxies:
      - PROXY
      - DIRECT
      - REJECT

rules:
  - MATCH,VPN


EOF

/etc/init.d/mihomo reload >/dev/null 2>&1
/etc/init.d/mihomo restart >/dev/null 2>&1

  echo -e "\n${GREEN}Подписка успешно применена!${NC}"

  PAUSE
}

show_menu() {
clear
echo -e "╔═══════════════════════════════════╗"
echo -e "║ ${BLUE}Mixomo by Internet-Helper Manager${NC} ║"
echo -e "╚═══════════════════════════════════╝"
echo -e "                         ${DGRAY}by StressOzz${NC}\n"

check_status

[ -f /etc/mihomo/config.yaml ] && while IFS='|' read -r c a; do h=${a%%:*}
grep -qF "$h" /etc/mihomo/config.yaml && echo -e "${YELLOW}WARP endpoint:       ${CYAN}$c${NC}" && break
done <<EOF
Россия CF|engage.cloudflareclient.com:4500
Россия CF ALT|engage.cloudflareclient.com:2408
Нидерланды|45.84.222.208:4500
Америка|usa-pop.astracat.ru:4500
Сингапур|5.34.176.170:4500
Латвия|150.241.75.91:4500
Нидерланды 1|nl.tribukvy.ltd:4500
Нидерланды 2|nl0.tribukvy.ltd:4500
Финляндия 1|fi.tribukvy.ltd:4500
Финляндия 2|fi0.tribukvy.ltd:4500
Россия|ru.tribukvy.ltd:4500
Эстония|ee.tribukvy.ltd:4500
Польша|pl.tribukvy.ltd:4500
Германия|de.tribukvy.ltd:4500
Литва|lt.tribukvy.ltd:4500
EOF

if [ -f "$CONFIGPATH" ]; then
    grep -Fq 'name: Google_ai' "$CONFIGPATH" && echo -e "${YELLOW}Используется список: ${NC}ITDog"
    grep -Fq 'name: Meta (WA+FB+Instagram)' "$CONFIGPATH" && echo -e "${YELLOW}Используется список: ${NC}Internet Helper"
fi

[ -f "$CONFIGPATH" ] && echo -e "${YELLOW}Web-интерфейс MagiTrickle:${NC}  ${CYAN}192.168.1.1:8080${NC}"
[ -f /etc/mihomo/config.yaml ] && echo -e "${YELLOW}Web-интерфейс Mihomo:${NC}       ${CYAN}192.168.1.1:9090/ui${NC}"



echo -e "\n${CYAN}1) ${GREEN}Установить ${NC}Mixomo"
echo -e "${CYAN}2) ${GREEN}Удалить ${NC}Mixomo"
echo -e "${CYAN}3) ${GREEN}Сменить список ${NC}MagiTrickle"
if [ -f /etc/mihomo/config.yaml ] && grep -q 'url: "' /etc/mihomo/config.yaml; then
  echo -e "${CYAN}4) ${GREEN}Сменить ${NC}VPN${GREEN} подписку${NC}"
else
  echo -e "${CYAN}4) ${GREEN}Интегрировать ${NC}VPN${GREEN} подписку в ${NC}Mihomo${NC}"
fi
echo -e "${CYAN}5) ${GREEN}Сгенерировать ${NC}WARP ${GREEN}в ${NC}/root/WARP.conf"
echo -e "${CYAN}6) ${GREEN}Интегрировать ${NC}/root/WARP.conf${GREEN} в ${NC}Mihomo"
# echo -e "${CYAN}888) ${GREEN}Удалить ${NC}→ ${GREEN}установить ${NC}→ ${GREEN}настроить ${NC}mihomo-openwrt"
echo -e "${CYAN}Enter) ${GREEN}Выход\n"
echo -ne "${YELLOW}Выберите пункт: ${NC}"
read choiceM

case "$choiceM" in
1)
  sh <(wget -q -O - https://raw.githubusercontent.com/StressOzz/Mixomo-Manager/main/mixomo_openwrt_install.sh)
  PAUSE
  ;;

2)
  sh <(wget -q -O - https://raw.githubusercontent.com/StressOzz/Mixomo-Manager/main/mixomo_openwrt_delete.sh)
  PAUSE
  ;;

3)
  magitrickle_config
  ;;


4) 
  PODPISKA
  ;;

5)
  sh <(wget -q -O - https://raw.githubusercontent.com/StressOzz/Mixomo-Manager/main/gen_WARP.sh)
  PAUSE
  ;;
6)
  sh <(wget -q -O - https://raw.githubusercontent.com/StressOzz/Mixomo-Manager/main/WARP_to_conf.sh)
  PAUSE
  ;;
  
888)
  sh <(wget -q -O - https://raw.githubusercontent.com/StressOzz/Mixomo-Manager/main/mixomo_openwrt_delete.sh)
  sh <(wget -q -O - https://raw.githubusercontent.com/StressOzz/Mixomo-Manager/main/mixomo_openwrt_install.sh)
  sh <(wget -q -O - https://raw.githubusercontent.com/StressOzz/Mixomo-Manager/main/gen_WARP.sh)
  sh <(wget -q -O - https://raw.githubusercontent.com/StressOzz/Mixomo-Manager/main/WARP_to_conf.sh)
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
