## PAM
Во вложении test_login1.sh скрипт в котором реализованы следующие пункты домашнего задания

 1 ограничить вход в систему всем пользователям не входящим в группу admin в выходные дни. Для этого был создан скрипт, проверяющий прина
    длежность к группе аутентифицируемого пользователя, и помещен в /usr/loca/bin.  В модуль /etc/pam.d/system-auth добавлена запись вызова скрипта
    В итоге пользователи first, third могут беспрепятсвенно заходить а пользователь second - нет.
 2 наделить конкретного пользователя правами root. В моем случае это пользователь third. Для этого был создан файл  /etc/sudoers.d/third c записью привелегий для перехода по sudo -s без пароля

Скрипт test_login1.sh нужно положить в одну директорию с Vagrantfile при загрузке
