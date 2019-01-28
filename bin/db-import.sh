#!/bin/bash
# *********************************************************
# mysqlのインポート
# *********************************************************
cd `dirname $0`
# .envを変数として読み込み
set -o allexport
[[ -f ../.env ]] && source ../.env
set +o allexport
echo "インポートするファイル名を入力してください: /db-backup/?" 
while read -p "" FILE ; do
    if [ -z ${FILE} ]; then
      echo "exit"
      break 
    else 
        cat ../db-backup/${FILE} | docker exec -i ${PROJECT_NAME}-mysql \
            mysql --defaults-extra-file=/etc/mysql.conf wordpress
        echo "インポート完了" 
        break
    fi
done