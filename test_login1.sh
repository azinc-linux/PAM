#!/bin/sh

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

cat <<EOF > /usr/local/bin/test_login1.sh
#!/bin/bash

if [ \$PAM_USER = "root" ]
then 
exit 0
fi

groups=\$( groups \$PAM_USER | awk -F":" '{print\$2}')
IFS=' '
read -ra ADDR <<< "\$groups"
for i in "\${ADDR[@]}"
do
if [ \$i = "admin" ]
then
exit 0
fi
done

if [ \$(date +%a) = "Sat" ] || [ \$(date +%a) = "Sun" ]
then
exit 1
else
exit 0
fi
EOF

chmod +x /usr/local/bin/test_login1.sh
echo "session required pam_exec.so /usr/local/bin/test_login1.sh" >> /etc/pam.d/system-auth

groupadd admin

groupadd ordinary

useradd first -g admin -G ordinary
useradd second -g ordinary
useradd third -g admin 
usermod -G admin vagrant

echo "first" | passwd --stdin first
echo "second" | passwd --stdin second
echo "third" | passwd --stdin third
echo "third ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/third

