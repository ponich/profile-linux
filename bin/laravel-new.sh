#!/usr/bin/env bash

WWW=/var/www/
LARAVEL_PATH=${1}
DOMAIN=$(echo "$LARAVEL_PATH" | cut -d "/" -f1)
MYSQL_USER=dev
MYSQL_DB=$(echo $DOMAIN | sed 's/\./_/g')

project_root(){
	eval cd "${LARAVEL_PATH}"
}

text_replace_create(){
	if grep -q ${1} ${3}; then
		sed -i "/${1}/c\\${2}" ${3}
	else
	    echo ${2} >> ${3}
	fi
}

laravel_install(){
	cd ${WWW}
	laravel new ${LARAVEL_PATH}
}

database(){
	mysql -u$MYSQL_USER -e "CREATE DATABASE ${MYSQL_DB} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
}

htaccess(){
cat << EOF > .htaccess
<IfModule mod_rewrite.c>
  RewriteEngine On
  RewriteRule ^(.*)$ public/$1 [L]
</IfModule>
EOF
}

move_user_model(){
	mkdir -p app/Models
	mv app/User.php app/Models/

	namespaces=(
		"app/Http/Controllers/Auth/RegisterController.php" 
		"app/Http/Controllers/Auth/RegisterController.php" 
		"database/factories/UserFactory.php" 
		"config/auth.php"
		"config/services.php"
	)


	for i in ${!namespaces[*]}
	do
		sed -i -- 's/App\\User/App\\Models\\User/g' ${namespaces[$i]}
	done

	text_replace_create "namespace" "namespace App\\\Models;" app/Models/User.php
}

fix_db_provider(){
	provider=app/Providers/AppServiceProvider.php

	if ! grep -q 'Facades\\Schema;' ${provider}; then
  		sed -i '6 i\use Illuminate\\Support\\Facades\\Schema;' ${provider}
	fi

	if ! grep -q 'defaultStringLength' ${provider}; then
  		sed -i '18 i\\t\tSchema::defaultStringLength(191);' ${provider}
	fi
}

init_project(){
	git init
	git config --global core.fileMode false
	chmod +x artisan

	text_replace_create "APP_URL" "APP_URL=https://${DOMAIN}" .env
	text_replace_create "DB_DATABASE" "DB_DATABASE=${MYSQL_DB}" .env
	text_replace_create "DB_USERNAME" "DB_USERNAME=${MYSQL_USER}" .env
	text_replace_create "DB_PASSWORD" "DB_PASSWORD=" .env

	echo "_ide_helper.php" >> .gitignore
	echo ".phpstorm.meta.php" >> .gitignore
	echo "composer.lock" >> .gitignore
	echo "package-lock.json" >> .gitignore

	chmod 777 bootstrap -R
	chmod 777 storage -R

	htaccess
	move_user_model
	fix_db_provider

	git add .
	git commit -m 'init'
}

laravel_install
database
project_root
init_project
