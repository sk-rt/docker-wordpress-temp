```
docker run -it --rm \
    --volumes-from myapp_wordpress_1 \
    --network container:myapp_wordpress_1 \
    wordpress:cli user list
```


docker run -it --rm --volumes-from my-wordpress_wordpress_1 --network container:my-wordpress_wordpress_1 wordpress:cli core install  --url="https://localhost:8080" \
                --title="Wordpress" \
                --admin_user="admin" \
                --admin_email="admin@example.com" \
                --admin_password="admin" \


docker run -it --rm --volumes-from '${PROJECT_NAME}-wordpress --network container:'${PROJECT_NAME}-wordpress wordpress:cli wp option update siteurl="https://localhost:8080"

docker exec -it my-wordpress-wordpress env sudo -u www-data wp core install --path="/var/www/html" --url="http://localhost:${SERVER_PORT}" --title="test" --admin_user=admin --admin_password=admin --admin_email=admin@example.com