upstream php {
    server {{ getenv "NGINX_BACKEND_HOST" }}:9000;
}

map $http_x_forwarded_proto $fastcgi_https {
    default $https;
    http '';
    https on;
}

server {
    server_name {{ getenv "NGINX_SERVER_NAME" "wordpress" }};
    listen 80 default_server{{ if getenv "NGINX_HTTP2" }} http2{{ end }};

    root {{ getenv "NGINX_SERVER_ROOT" "/var/www/html/" }};
    index index.php;

    add_header Cache-Control "store, must-revalidate, post-check=0, pre-check=0";

    include fastcgi.conf;
    include healthz.conf;
    include pagespeed.conf;

    location ~* ^/.well-known/ {
        allow all;
    }

    location = /favicon.ico {
        try_files $uri =204;
        log_not_found off;
        access_log off;
    }

    location = /robots.txt {
        allow all;
        log_not_found off;
        access_log off;
    }

    location = /readme.html {
        return 404;
    }

    location ~* ^.*(\.(?:git|svn|htaccess|txt|pot?))$ {
        return 404;
    }

    location ~ /\. {
        deny all;
    }

    location ~* /(?:uploads|files)/.*\.php$ {
        deny all;
    }

    location ~* \.flv$ {
        flv;
    }

    location ~* .*\.(?:m4a|mp4|mov)$ {
        mp4;
        mp4_buffer_size 1M;
        mp4_max_buffer_size 5M;
    }

    location ~* ^.+\.(?:ogg|pdf|pptx?)$ {
        expires max;
        tcp_nodelay off;
    }

    location / {
        try_files $uri $uri/ /index.php?$args;
    }

    # Admin for subdir multisite.
    if (!-e $request_filename) {
        rewrite /wp-admin$ $scheme://$host$uri/ permanent;
        rewrite ^/[_0-9a-zA-Z-]+(/wp-.*) $1 last;
        rewrite ^/[_0-9a-zA-Z-]+(/.*\.php)$ $1 last;
    }

    # Add trailing slash to */wp-admin requests.
    rewrite /wp-admin$ $scheme://$host$uri/ permanent;

    # Directives to send expires headers and turn off 404 error logging.
    location ~* ^.+\.(ogg|ogv|svg|svgz|eot|otf|woff|woff2|mp4|ttf|rss|atom|jpg|jpeg|gif|png|ico|zip|tgz|gz|rar|bz2|doc|xls|exe|ppt|tar|mid|midi|wav|bmp|rtf)$ {
        access_log off;
        log_not_found off;
        expires max;
    }

    location ~ [^/]\.php(/|$) {
        fastcgi_split_path_info ^(.+?\.php)(/.*)$;
        if (!-f $document_root$fastcgi_script_name) {
            return 404;
        }

        fastcgi_pass php;
        track_uploads uploads 60s;
    }

{{ if getenv "NGINX_SERVER_EXTRA_CONF_FILEPATH" }}
    include {{ getenv "NGINX_SERVER_EXTRA_CONF_FILEPATH" }};
{{ end }}
}