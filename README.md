# Инструкция по установке и настройке через скрипт:

- в **SSH** запустите скрипт:
```
sh <(wget -O - https://raw.githubusercontent.com/StressOzz/Mixomo-Manager/main/Mixomo-Manager.sh)
```

- Установите **Mixomo**

   При установки **MagiTrickle** появится меню выбора версии: `Оригинальный MagiTrickle` или `MagiTrickle badigit mod`
   
   Для обычного пользователя достаточно `Оригинальной версии`
- Сгенерируйте **WARP** 
 
   Для генерации **WARP** через скрипт возможно понадобится установить **[Zapret](https://github.com/StressOzz/Zapret-Manager)**
   
   При генерации появится меню выбора `endpoind` по странам
- Интегрируйте **WARP**

   Для интеграции своего **WARP** файла - скиньте его в `/root/WARP.conf`
- Зайдите на http://192.168.1.1:8080/ выберите списки, которые Вам нужны, нажмите **Сохранить изменения**

```
Меню 
1) Установить Mixomo
2) Удалить Mixomo
3) Сменить список MagiTrickle
   1) Список от ITDog
   2) Список от Internet Helper
4) Сгенерировать WARP в /root/WARP.conf
5) Интегрировать /root/WARP.conf в Mihomo
```

---

# Ручная установка и настройка:

# Генерируем WARP

Генерируем **WARP** в TГ боте - https://t.me/warp_generator_bot

<img width="350" height="121" alt="Image" src="https://github.com/user-attachments/assets/f5385211-4ae6-4132-97a5-864ee6daa4b6" />

- Затем на `Подтвердить` (можно выбрать другую локацию для экспериментов)

<img width="381" height="1293" alt="Image" src="https://github.com/user-attachments/assets/c6f512ff-d4e9-4668-821b-c8a17bf58d92" />

- Скачайте `WARP*.conf`
<img width="300" height="497" alt="Image" src="https://github.com/user-attachments/assets/a0a6fa0b-3992-4572-9fe5-5b7fab52419c" />

---
Генерируем **WARP** на сайте - https://warp-generator.github.io/warp/

- Выбираем один из 3 вариантов, при нажатии произойдёт скачивание `WARP*.conf` файла...
<img width="280" height="549" alt="{927F7FEB-A180-4E97-8BA8-DCC1512EFD74}" src="https://github.com/user-attachments/assets/499096ce-d0a0-48c1-8fa5-ae2547bb929f" />

- При нажатии на шестерёнку в углу, можно сменить DNS и выбрать локацию
<img width="300" height="1441" alt="{A26E8E6A-0DC5-4F59-9F00-C77D7CD258B8}" src="https://github.com/user-attachments/assets/c9934736-a2ff-47c8-813f-16f4c0f750bc" />

---

# Генерируем конфигурацию 

- Зайдите на сайт https://spatiumstas.github.io/web4core/ 

<img width="411" height="693" alt="Image" src="https://github.com/user-attachments/assets/2507d9a9-b4e7-4a89-8a62-958a0cfcae23" />

- Нажмите на <img width="29" height="85" alt="Image" src="https://github.com/user-attachments/assets/685c9527-4c5d-4664-af88-58edaceb7b44" />

- Нажмите на <img width="100" height="91" alt="Image" src="https://github.com/user-attachments/assets/f583ff2a-7b49-4726-baea-3f4dd03a5339" />

- Выбирите файл `WARP*.conf`
- Нажмите <img width="90" height="101" alt="Image" src="https://github.com/user-attachments/assets/ed1f3143-1a2e-460d-9e27-cbf8d69b3ae4" />

- Нажмите на  <img width="41" height="150" alt="Image" src="https://github.com/user-attachments/assets/12660858-7a96-4fa3-b0f3-c3bc6bad6a3c" /> это скопирует результат

---

# Установка Mixomo
```
sh <(wget -O - https://raw.githubusercontent.com/StressOzz/Mixomo-Manager/main/mixomo_openwrt_install.sh)
```

---

# Настраиваем Mihomo

- Зайдите на роутер в **LuCI**
- Вкладка `Services` → `Mihomo`
- Вставьте скопированный результат
- Внизу нажмите <img width="103" height="69" alt="Image" src="https://github.com/user-attachments/assets/1c620792-a0bd-49d7-8030-ac1ad68442c3" />
- Нажмите <img width="187" height="73" alt="Image" src="https://github.com/user-attachments/assets/cc11862f-ac70-4958-9186-5bed1569705f" />
- Должно появится, что-то типа этого

<img width="797" height="333" alt="Image" src="https://github.com/user-attachments/assets/c5e736d4-c4fa-473e-930d-5cfd98d5d33e" />

- Нажмите на `Запустить` <img width="280" height="73" alt="Image" src="https://github.com/user-attachments/assets/0bc2d735-c50c-4cf6-ac9e-8703b184d3da" />

---

## После этого должно всё работать...

- Если не работает, выполните `Остановить` и `Запустить` **Mihomo**

---

# Настраиваем списки в Magitrickle

- Зайдите на роутер в **LuCI**, вкладка `Services` → `Magitrickle` или в браузере http://192.168.1.1:8080/
- Тут можете ВКЛ или ВЫКЛ списки, которые пойдут через WARP
- После ВКЛ или ВЫКЛ списка(ов) - нужно нажать на <img width="41" height="105" alt="{BA726D0E-69AF-4E81-8BE5-88BC332DADF1}" src="https://github.com/user-attachments/assets/34785256-cafc-46e6-bae7-be18b50330ce" />

---

## Смена списков вручную

- Переходим по ссылке 
  https://github.com/StressOzz/Mixomo-Manager/blob/main/files/MagiTrickle/config_from_internet_helper.mtrickle
  
  или
  
  https://github.com/StressOzz/Mixomo-Manager/blob/main/files/MagiTrickle/AllowDomainsList.mtrickle
- Скачиваем файл <img width="197" height="155" alt="Image" src="https://github.com/user-attachments/assets/e07b23d3-f7cb-4fb8-a272-f46199cdd990" />
- Зайдите на роутер в **LuCI** → `Services` → `Magitrickle` или в браузере http://192.168.1.1:8080/
- Удалите `Example` <img width="371" height="401" alt="Image" src="https://github.com/user-attachments/assets/0f1c5f77-c72e-4790-8a22-d9277cfce934" />
- Нажмите на Импортировать конфиг <img width="147" height="173" alt="Image" src="https://github.com/user-attachments/assets/70f92a9e-85cb-4fe8-b5ed-b2cb6c6c9a3e" />
- Выбираете `config_from_internet_helper.mtrickle`
- Выбираете `Все` или то, что Вам нужно и нажмите `Импортировать` 

<img width="327" height="1105" alt="Image" src="https://github.com/user-attachments/assets/3f6e50dc-5f97-4f6c-abbb-2e7369398324" />

- Нажмите `Сохранить изменения` <img width="45" height="111" alt="Image" src="https://github.com/user-attachments/assets/510dce31-20aa-44a1-a92d-6ed2c18fc5e0" />

---

Cписок из **IT Dog Allow Domains** для **MagiTrickle**:
https://github.com/StressOzz/Mixomo-Manager/blob/main/files/MagiTrickle/AllowDomainsList.mtrickle

Так же скрипт для создания этого списка из **Allow Domains**:
```
sh <(wget -O - https://raw.githubusercontent.com/StressOzz/Mixomo-Manager/main/AllowDomain_to_MagiTrickle.sh)
```

---

# Удаление Mihomo
```
sh <(wget -O - https://raw.githubusercontent.com/StressOzz/Mixomo-Manager/main/mixomo_openwrt_delete.sh)
```

---
Можете генерировать разные WARP и пробовать, т.к. в `По умолчанию` не будет работать `GeoBlock`...

Для смены WARP:
- Генерируем WARP
- Генерируем конфигурацию
- Настраиваем Mihomo (останавливаем, удаляем, вставляем, сохраняем и запускаем)

---

Совместно с Zapret работает...
Можно использовать как отдельный инструмент, так и в помощь Zapret...

---

# Благодарности

Спасибо [Internet Helper](https://github.com/Internet-Helper/) за [Mixomo](https://github.com/Internet-Helper/mixomo-openwrt)
