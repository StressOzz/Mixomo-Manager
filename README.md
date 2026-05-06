<h1 align="center">Точечная маршрутизация сетевого трафика через WARP при помощи Mihomo, hev-socks5-tunnel и MagiTrickle на роутере OpenWRT.</h1>

<div align="center">

![Platform](https://img.shields.io/badge/Platform-OpenWrt-orange)
![Architecture](https://img.shields.io/badge/Architecture-All%20(OpenWrt)-yellow)
![Script](https://img.shields.io/badge/Script-sh-informational)
![Status](https://img.shields.io/badge/Status-Active-success)
![Community](https://img.shields.io/badge/Community-Enabled-green)
[![Views](https://views.whatilearened.today/views/github/StressOzz/Mixomo-Manager.svg)](https://github.com/StressOzz/Mixomo-Manager)
![GitHub last commit](https://img.shields.io/github/last-commit/StressOzz/Zapret-Manager)

</div>

# Инструкция по установке и настройке через скрипт:

> [!IMPORTANT]
> При возникновении проблем с запуском скрипта или его функций выполните в **SSH** следующую команду:
> ```
> git="githubusercontent.com"; printf "#$git\n185.199.109.133 raw.$git release-assets.$git\n185.199.108.133 private-user-images.$git\n" >> /etc/hosts; /etc/init.d/dnsmasq restart >/dev/null 2>&1; echo -e "\n\033[0;32mOK\n\033[0m"
> ```

- в **SSH** запустите скрипт:
```
sh <(wget -O - https://raw.githubusercontent.com/StressOzz/Mixomo-Manager/main/Mixomo-Manager.sh)
```

- Установите **Mixomo**

   При установки **MagiTrickle** появится меню выбора версии: `Оригинальный MagiTrickle` или `MagiTrickle badigit mod`
   
   Для обычного пользователя достаточно `Оригинальной версии`

- Интегрировать **VPN** подписку в **Mihomo**

   Вставьте ссылку на свою подписку.
   Можете воспользоваться [**StressKVN**](https://github.com/StressOzz/StressKVN)
   
- Сгенерируйте **WARP** 
 
   Для генерации **WARP** через скрипт понадобится установить **[Zapret](https://github.com/StressOzz/Zapret-Manager)**
   
- Интегрируйте **WARP**

   Для интеграции своего **WARP** файла - скиньте его в `/root/WARP.conf`
   
- Зайдите на http://192.168.1.1:8080/ выберите списки, которые Вам нужны, нажмите **Сохранить изменения**

- Зайдите на http://192.168.1.1:9090/ui 
   в поле **Хост** введите 192.168.1.1
   во вкладке **Прокси** выберите **Сервер для YouTube** и **Сервер для остального трафика** который поёдйт через списки **MagiTrickle**

```
Меню 
1) Установить Mixomo
2) Удалить Mixomo
3) Сменить список MagiTrickle
   1) Список от ITDog
   2) Список от Internet Helper
4) Интегрировать VPN подписку в Mihomo / Сменить VPN подписку
5) Сгенерировать WARP в /root/WARP.conf
6) Интегрировать /root/WARP.conf в Mihomo
```

---

<table>
  <tr>
    <td>
      <a href="https://github.com/StressOzz#-поддержать-проект">
        <img width="280" height="130" src="https://github.com/user-attachments/assets/2999757b-fbf3-4149-bf6c-48bf3e241529">
      </a>
    </td>
    <td>
      <a href="https://github.com/StressOzz/StressKVN">
        <img width="270" height="80" src="https://github.com/user-attachments/assets/7dbb964b-bb79-461a-9f47-9ca73323ebac">
      </a>
    </td>
  </tr>
</table>

---

# Благодарности

Спасибо [Internet Helper](https://github.com/Internet-Helper/) за [Mixomo](https://github.com/Internet-Helper/mixomo-openwrt)
