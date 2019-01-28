#!/bin/bash
# **************************************
# Wordpressのセットアップ
# **************************************
cd `dirname $0`
# .envを変数として読み込み
set -o allexport
[[ -f ../.env ]] && source ../.env
set +o allexport

# WP 言語のインストール
docker exec -it $PROJECT_NAME-wordpress env \
    sudo -u www-data wp language core install $WP_LOCALE
# WP インストール
if ! $(docker exec -it $PROJECT_NAME-wordpress env sudo -u www-data wp core is-installed); then
    docker exec -it $PROJECT_NAME-wordpress env \
        sudo -u www-data wp core install \
            --path="/var/www/html" \
            --url="$LOCAL_PROTOCOL://localhost:$LOCAL_PORT" \
            --title="$PROJECT_NAME" \
            --admin_user=$WP_ADMIN_USER \
            --admin_password=$WP_ADMIN_PASSWORD \
            --admin_email=$WP_ADMIN_EMAIL
    echo "$LOCAL_PROTOCOL://localhost:$LOCAL_PORT\nインストール完了"
else 
    echo "既にインストール済み"
fi

# 必須プラグインインストール & アクティブ
docker exec -it $PROJECT_NAME-wordpress env \
    sudo -u www-data wp plugin uninstall akismet hello
docker exec -it $PROJECT_NAME-wordpress env \
    sudo -u www-data wp plugin install $WP_REQUIED_PLUGINS --activate
echo "必須プラグインをインストールしました"

# テーマ アクティブ
docker exec -it $PROJECT_NAME-wordpress env \
    sudo -u www-data wp theme activate $WP_THEME_NAME
docker exec -it $PROJECT_NAME-wordpress env \
    sudo -u www-data wp theme uninstall twentynineteen twentyseventeen twentysixteen twentyfifteen
echo "テーマ'$WP_THEME_NAME'をアクティブにしました"