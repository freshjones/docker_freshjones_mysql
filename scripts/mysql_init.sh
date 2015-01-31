#!/bin/bash

echo "Initializing mysql"
mysql_install_db > /dev/null 2>&1

echo "creating new admin user"
/mysql_admin_user.sh