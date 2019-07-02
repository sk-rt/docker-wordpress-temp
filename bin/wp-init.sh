#!/bin/bash
# **************************************
# Wordpressのセットアップ
# **************************************
cd `dirname $0`
# .envを変数として読み込み
set -o allexport
[[ -f ../.env ]] && source ../.env
set +o allexport

# WP インストール
echo "============================ \n以下でインストールしますか？[y/n]:" 
echo "- Url:$LOCAL_PROTOCOL://localhost:$LOCAL_PORT\n- User:$WP_ADMIN_USER\n- Password:$WP_ADMIN_PASSWORD"
read INS_CORE
if [ "$INS_CORE" = 'yes' ] || [ "$INS_CORE" = 'YES' ] || [ "$INS_CORE" = 'y' ] ; then
    if ! $(docker exec -it $PROJECT_NAME-wordpress env sudo -u www-data wp core is-installed); then
        docker exec -it $PROJECT_NAME-wordpress env \
            sudo -u www-data wp core install \
                --path="/var/www/html$WP_INSTALL_DIR" \
                --url="$LOCAL_PROTOCOL://localhost:$LOCAL_PORT$WP_INSTALL_DIR/" \
                --title="$PROJECT_NAME" \
                --admin_user=$WP_ADMIN_USER \
                --admin_password=$WP_ADMIN_PASSWORD \
                --admin_email=$WP_ADMIN_EMAIL
         echo "$LOCAL_PROTOCOL://localhost:$LOCAL_PORT$WP_INSTALL_DIR/\nインストール完了"
    else 
        echo "既にインストール済みです\n"
    fi
fi

# WP 言語のインストール
echo "============================ \n言語ファイルをインストールしますか？[y/n]:" 
echo "- Lang:$WP_LOCALE"
read INS_LANG
if [ "$INS_LANG" = 'yes' ] || [ "$INS_LANG" = 'YES' ] || [ "$INS_LANG" = 'y' ] ; then
    docker exec -it $PROJECT_NAME-wordpress env \
        sudo -u www-data wp language core install $WP_LOCALE
    docker exec -it $PROJECT_NAME-wordpress env \
        sudo -u www-data wp language core activate $WP_LOCALE
    echo "言語ファイルをインストールしました\n"
fi

# 必須プラグインインストール & アクティブ
echo "============================ \n必須プラグインをインストールしますか？[y/n]:" 
echo "- Plugins:$WP_REQUIED_PLUGINS"
read INS_PLUGINS
if [ "$INS_PLUGINS" = 'yes' ] || [ "$INS_PLUGINS" = 'YES' ] || [ "$INS_PLUGINS" = 'y' ] ; then
    docker exec -it $PROJECT_NAME-wordpress env \
        sudo -u www-data wp plugin uninstall akismet hello
    docker exec -it $PROJECT_NAME-wordpress env \
        sudo -u www-data wp plugin install $WP_REQUIED_PLUGINS --activate
    echo "必須プラグインをインストールしました\n"
fi


# テーマ アクティブ
echo "============================ \nテーマをアクティブにしますか？[y/n]:" 
echo "- Theme:$WP_THEME_NAME"
read INS_THEME
if [ $INS_THEME = 'yes' ] || [ $INS_THEME = 'YES' ] || [ $INS_THEME = 'y' ] ; then
    docker exec -it $PROJECT_NAME-wordpress env \
        sudo -u www-data wp theme activate $WP_THEME_NAME
    docker exec -it $PROJECT_NAME-wordpress env \
        sudo -u www-data wp theme uninstall twentynineteen twentyseventeen twentysixteen twentyfifteen
    echo "テーマ'$WP_THEME_NAME'をアクティブにしました"
fi
