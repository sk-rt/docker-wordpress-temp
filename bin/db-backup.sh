#!/bin/bash
# **************************************
# mysqlのバックアップ
# `/db-data/backup-${SUFFIX}.sql` として保存
# **************************************
cd `dirname $0`
# .envを変数として読み込み
set -o allexport
[[ -f ../.env ]] && source ../.env
set +o allexport
echo "SUFFIXを入力して下さい: " 
while read -p "" PREFIX ; do
    if [ -z ${SUFFIX} ]; then
       SUFFIX='deg'
    fi
    docker exec -it ${PROJECT_NAME}-mysql \
        /usr/bin/mysqldump --defaults-extra-file=/etc/mysql.conf wordpress > \
        ../db-backup/backup-${SUFFIX}.sql
    echo "バックアップしました `backup-${SUFFIX}.sql`" 
    break
done
