# Домашнее задание к занятию «Введение в Terraform» - Натетков Александр

Чек-лист готовности к домашнему заданию

Скачайте и установите Terraform версии =1.5.Х (версия 1.6 может вызывать проблемы с Яндекс провайдером) . Приложите скриншот вывода команды terraform --version.
Скачайте на свой ПК этот git-репозиторий. Исходный код для выполнения задания расположен в директории 01/src.
Убедитесь, что в вашей ОС установлен docker.
Зарегистрируйте аккаунт на сайте https://hub.docker.com/, выполните команду docker login и введите логин, пароль.

![Скриншот terraform -version](https://github.com/karapuze/terraform/blob/main/Img/Снимок%20экрана%202024-05-05%20в%2008.33.06.png)

### Задание 1.

1. Перейдите в каталог src. Скачайте все необходимые зависимости, использованные в проекте.
2. Изучите файл .gitignore. В каком terraform-файле, согласно этому .gitignore, допустимо сохранить личную, секретную информацию?
3. Выполните код проекта. Найдите в state-файле секретное содержимое созданного ресурса random_password, пришлите в качестве ответа конкретный ключ и его значение.
4. Раскомментируйте блок кода, примерно расположенный на строчках 29–42 файла main.tf. Выполните команду terraform validate. Объясните, в чём заключаются намеренно допущенные ошибки. Исправьте их.
5. Выполните код. В качестве ответа приложите: исправленный фрагмент кода и вывод команды docker ps.
6. Замените имя docker-контейнера в блоке кода на hello_world. Не перепутайте имя контейнера и имя образа. Мы всё ещё продолжаем использовать name = "nginx:latest". Выполните команду terraform apply -auto-approve. Объясните своими словами, в чём может быть опасность применения ключа  -auto-approve. Догадайтесь или нагуглите зачем может пригодиться данный ключ? В качестве ответа дополнительно приложите вывод команды docker ps.
7. Уничтожьте созданные ресурсы с помощью terraform. Убедитесь, что все ресурсы удалены. Приложите содержимое файла terraform.tfstate.
8. Объясните, почему при этом не был удалён docker-образ nginx:latest. Ответ ОБЯЗАТЕЛЬНО НАЙДИТЕ В ПРЕДОСТАВЛЕННОМ КОДЕ, а затем ОБЯЗАТЕЛЬНО ПОДКРЕПИТЕ строчкой из документации terraform провайдера docker. (ищите в классификаторе resource docker_image )

### Ответ 1.

2. personal.auto.tfvars
3. "result": "NX7Hi9BQZa3Zm76F"
4. Первая ошибка допущена в блоке с описанием ресурса "docker_image", отсутсвует name. Вторая ошибка в блоке "docker_container", неверное значение в name, должно начинаться либо с букв либо с _, а начинается с цифры. Также была ошибка в "name  = "example_${random_password.random_string_FAKE.resulT}"
5. Исправленный фрагмент:
```
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "example_${random_password.random_string.result}"

  ports {
    internal = 80
    external = 9090
  }
}
```
![Docker ps](https://github.com/karapuze/terraform/blob/main/Img/Снимок%20экрана%202024-05-05%20в%2011.56.12.png)

6. Ключ -auto-approve опасен тем что не запрашивает подтверждения перед применением и не показывает результат terraform plan, соответсвенно автоматически примененные изменения могут сломать всю инфру. Данный ключ можно использовать например в CI/CD для автоматизации, возможно также использовать для быстрого и автоматизированного восстановления инфры.

![**Docker ps**](https://github.com/karapuze/terraform/blob/main/Img/Снимок%20экрана%202024-05-05%20в%2012.48.20.png)

7. 
```
{
  "version": 4,
  "terraform_version": "1.5.7",
  "serial": 11,
  "lineage": "0fdd4726-7754-42d9-282a-617ccc3841e8",
  "outputs": {},
  "resources": [],
  "check_results": null
}
```
8. Образ не был удален из-за значения "keep_locally = true"
keep_locally (Boolean) If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation.