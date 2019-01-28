# WordPress Docker

# 環境設定
`.env`ファイルを編集
＊設定例
```
PROJECT_NAME=my-wordpress
LOCAL_PROTOCOL=http
LOCAL_PORT=8080
WP_LOCALE=ja
WP_ADMIN_USER=admin
WP_ADMIN_PASSWORD=admin
WP_ADMIN_EMAIL=admin@example.com
WP_THEME_NAME=mytheme
WP_REQUIED_PLUGINS="classic-editor custom-post-type-permalinks wp-multibyte-patch"
```
# セットアップ（初回のみ）
Dockerの起動
```
docker-compose up -d --build
```
WordPressの初期設定
```
sh bin/wp-init.sh
```
# 起動
```
docker-compose up -d
```
local server: `http://localhost:8080`

# 停止
```
docker-compose stop
```