FROM codelittinc/nginx
COPY public/ /var/www/html/
COPY ../nginx/nginx.conf /etc/nginx/sites-available/default
COPY ../nginx/blacklist.conf		/etc/nginx/
COPY ../nginx/nginx.main.conf /etc/nginx/nginx.conf
EXPOSE 80
