FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

# dir for ssl
RUN mkdir -p /etc/nginx/ssl

# self signed certificate
RUN openssl req -x509 -nodes -days 365 \
	-newkey rsa:2048 \
	-keyout /etc/nginx/ssl/nginx.key \
	-out /etc/nginx/ssl/nginx.crt \
	-subj "/C=DE/ST=Baden-Wuerttemberg/L=Heilbronn/o=42/OU=Inception/CN=omalovic.42.fr"

COPY conf/nginx.conf /etc/nginx/nginx.conf 

EXPOSE 443

# daemon off - to enable launching on pid 1 (in forderground)
CMD ["nginx", "-g", "daemon off;"]