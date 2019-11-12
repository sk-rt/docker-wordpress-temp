# WordPress Development

-   `mysql:5.7` + `wordpress` + `wp-cli`
-   `webpack` + `TypeScript` + `Scss`

---

## 環境設定

`.env`ファイルを編集
＊設定例

```bash
PROJECT_NAME=my-wordpress # コンテナ ネームスペース
LOCAL_PROTOCOL=http # http or https
LOCAL_PORT=8080 # WordPressの動作するポート
MYSQL_PORT=3306 # mySqlのポート
WP_LOCALE=ja # 言語設定
WP_ADMIN_USER=admin # WordPress管理者アカウント
WP_ADMIN_PASSWORD=admin
WP_ADMIN_EMAIL=admin@example.com
WP_THEME_NAME=mytheme # テーマディレクトリ名
WP_INSTALL_DIR=/ # インストールディレクトリ
WP_REQUIED_PLUGINS="classic-editor custom-post-type-permalinks wp-multibyte-patch" # 必須プラグイン(スペース区切り)
```

---

## セットアップ（初回のみ）

### ・ Docker イメージのビルド＆軌道

```
docker-compose up -d --build
```

### ・ WordPress の初期設定

```sh
sh bin/wp-init.sh
```

### ・ node_module インストール

```sh
yarn install
```

---

## 開発ビルド

### ・Docker スタート

```sh
docker-compose up -d
# or
yarn start:docker
```

### ・フロント(Webpack / Browsersync etc. )

＊ Docker が動いている状態で

```sh
yarn start
```

### ・Docker 停止

```sh
docker-compose stop
# or
yarn stop:docker
```

---

## 本番ビルド

```sh
yarn dist
```

---

## MySQL のダンプ

```sh
sh bin/db-backup.sh
```

## MySQL のインポート

```sh
sh bin/db-import.sh
```

## wp-cli

＊`${PROJECT_NAME}`は.env の`PROJECT_NAME`

```sh
# wordpressコンテナに入る
docker exec -it ${PROJECT_NAME}-wordpress /bin/bash
# www-dataユーザーでwpコマンド実行
sudo -u www-data wp --info
```

## SQL

＊`${PROJECT_NAME}`は.env の`PROJECT_NAME`

```sh
# mysqlコンテナに入りrootでログイン
docker exec -it ${PROJECT_NAME}-mysql /usr/bin/mysql -u root -p
Enter Password: root
# mysqlコマンド実行
mysql> show databases;
```

---
