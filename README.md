
# Задание 1

1. Изучите проект. В файле variables.tf объявлены переменные для Yandex provider.
2. Создайте сервисный аккаунт и ключ. service_account_key_file.
3. Сгенерируйте новый или используйте свой текущий ssh-ключ. Запишите его открытую(public) часть в переменную vms_ssh_public_root_key.
4. Инициализируйте проект, выполните код. Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть.
5. Подключитесь к консоли ВМ через ssh и выполните команду  curl ifconfig.me. Примечание: К OS ubuntu "out of a box, те из коробки" необходимо подключаться под пользователем ubuntu: "ssh ubuntu@vm_ip_address". Предварительно убедитесь, что ваш ключ добавлен в ssh-агент: eval $(ssh-agent) && ssh-add Вы познакомитесь с тем как при создании ВМ создать своего пользователя в блоке metadata в следующей лекции.;
6. Ответьте, как в процессе обучения могут пригодиться параметры preemptible = true и core_fraction=5 в параметрах ВМ.

В качестве решения приложите:
скриншот ЛК Yandex Cloud с созданной ВМ, где видно внешний ip-адрес;
скриншот консоли, curl должен отобразить тот же внешний ip-адрес;
ответы на вопросы.

## Ответ 1

3. Открытую часть ключа указал в файле personal.auto.tfvars чтобы не показывать ее в variables.tf
4. Не совсем понял какие ошибки должны возникнуть, в ходе выполнения terraform apply возникла единственная ошибка, неверно указан параметр "platform_id" при создании вычислительных ресурсов в main.tf,  "standart-v4" такой платформы не существует, правильно пишется "standard", также нет значения v4, выбрал v1 и установил значения cores=2, т.к. это минимальное значение
5. ![alt text](https://github.com/karapuze/terraform/blob/main/Img/Снимок%20экрана%202024-05-18%20в%2014.27.12.png)

![alt text](https://github.com/karapuze/terraform/blob/main/Img/Снимок%20экрана%202024-05-18%20в%2014.27.19.png)


6. preemptible = true означает тип ВМ "прерываемая" что позволяет экономить деньги, описание "ВМ, которая работает не более 24 часов и может быть остановлена Compute Cloud в любой момент. После остановки ВМ не удаляется, все ее данные сохраняются. Чтобы продолжить работу, запустите ВМ повторно. Предоставляется с большой скидкой."
core_fraction=5 означает гарантированная доля cpu, используется также для экономии

# Задание 2

1. Замените все хардкод-значения для ресурсов yandex_compute_image и yandex_compute_instance на отдельные переменные. К названиям переменных ВМ добавьте в начало префикс vm_web_ . Пример: vm_web_name.
2. Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их default прежними значениями из main.tf.
3. Проверьте terraform plan. Изменений быть не должно.

## Ответ 2

![alt text](https://github.com/karapuze/terraform/blob/main/Img/Снимок%20экрана%202024-05-18%20в%2015.24.22.png)

# Задание 3

1. Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ.
2. Скопируйте блок ресурса и создайте с его помощью вторую ВМ в файле main.tf: "netology-develop-platform-db" ,  cores  = 2, memory = 2, core_fraction = 20. Объявите её переменные с префиксом vm_db_ в том же файле ('vms_platform.tf'). ВМ должна работать в зоне "ru-central1-b"
3. Примените изменения.

## Ответ 3

1. Новая VM создана успешно



# Задание 4

1. Объявите в файле outputs.tf один output , содержащий: instance_name, external_ip, fqdn для каждой из ВМ в удобном лично для вас формате.
2. Примените изменения.
В качестве решения приложите вывод значений ip-адресов команды terraform output.

## Ответ 4

# Задание 5

1. В файле locals.tf опишите в одном local-блоке имя каждой ВМ, используйте интерполяцию ${..} с НЕСКОЛЬКИМИ переменными по примеру из лекции.
2. Замените переменные внутри ресурса ВМ на созданные вами local-переменные.
3. Примените изменения.

## Ответ 5

# Задание 6

Вместо использования трёх переменных ".._cores",".._memory",".._core_fraction" в блоке resources {...}, объедините их в единую map-переменную vms_resources и внутри неё конфиги обеих ВМ в виде вложенного map.

пример из terraform.tfvars:
vms_resources = {
  web={
    cores=
    memory=
    core_fraction=
    ...
  },
  db= {
    cores=
    memory=
    core_fraction=
    ...
  }
}
Создайте и используйте отдельную map переменную для блока metadata, она должна быть общая для всех ваших ВМ.

пример из terraform.tfvars:
metadata = {
  serial-port-enable = 1
  ssh-keys           = "ubuntu:ssh-ed25519 AAAAC..."
}
Найдите и закоментируйте все, более не используемые переменные проекта.

Проверьте terraform plan. Изменений быть не должно.

## Ответ 6

