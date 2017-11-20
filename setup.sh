echo "######### UPDATE REPOSITORY ###########"
yum update -y
sleep 2
#
#
echo "######### INSTALL REPOSITORY EPEL AND WEBTATIC ##########"
yum install epel-release -y
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm -y
sleep 2
#
#
echo "######### INSTALL APACHE AND PHP 7.1 ############"
yum install php71w-openssl php71w-tokenizer php71w-mbstring php71w-common php71w-mcrypt php71w-gd php71w-phar php71w-xml php71w-pdo php71w-cli httpd -y
systemctl start httpd
systemctl enable httpd
sleep 2
#
#
echo "######### INSTALL COMPOSER ############"
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/bin/composer
sleep 2
#
#
echo "######## CREATE PROJECT ############"
composer create-project laravel/laravel /var/www/html/laravel
echo "Your project has been created on /var/www/html"
sleep 2
#
#
echo "######### Change Permission and Owner ##########"
chmod -R 755 /var/www/html/laravel/storage/
chown -R apache:apache /var/www/html/laravel/storage/
#
#
# Now change DocumentRoot on /etc/httpd/conf/httpd.conf
# from /var/www/html/ to /var/www/html/laravel/public
# On <Directory "/var/www/html"> change to <Directory "/var/www/html/laravel/public">
# Still on section <Directory "/var/www/html/laravel/public"> find AllowOverride
# change None to All