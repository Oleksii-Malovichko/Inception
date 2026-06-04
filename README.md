*This project has been created as part of the 42 curriculum by omalovic.*

# Inception

## Description
Inception is a system administration project, which is focused on Docker and container orchestration through Docker Compose. The goal is to build a small infrastructure composed of multiple containers running different services such as NGINX, WordPress and MariaDB.

### Virtual Machines vs Docker
Virtual Machines simulate a full computer. Each virtual machine has its own operating system, kernel, drivers and everything a real physical server is supposed to have. Because of that, VMs provide a strong isolation, but the trade-off is high resource usage and slow startup times.

Docker works differently: it does not create a separate operating system. Instead, containers share the host operating system's kernel. Inside a container there's only the application and its dependencies. This makes Docker much ligher, faster and more efficient in case of resources.

### Secrets vs Environment Variables
Secrets and environment variables are both ways to pass configuration into applications, but they are used for different purposes.

Environment variables are a simple way to provide configuration data to an application, such as URLs, feature flags or non-sensitive settings. They are easy to use, but they are not secure because they can often be exposed through logs, process listings or dubugging tools.

Secrets are designed specifically for sensitive data like passwords, API key and certificates. They are stored and managed more securely.

### Docker Network vs Host Network
Docker networking controls how containers communicate with each other and with the outside world.

In a default Docker Network, containers are isolated in their own virtual network. Docker manages routing between containers and the host, also containers communicate using internal IP addresses or service names. This provides a better isolation and control.

Host Network mode removes this isolation and makes the container use the host machine's network directly. The container shares the same network stack as the host, which can improve performance and simplify networking, but it reduces isolation and might create security risks.

### Docker Volumes vs Bind Mounts
Docker Volumes and Bind Mounts are both used for persistent data storage, but they work differently.

Docker Volumes are managed by Docker itself. The data is stored in a Docker-controlled location on the host system, and Docker handles lifecycle, permissions, and portability. Volumes are the recommended way to persist data because they are safer and more flexible.

Bind Mounts map is a specific directory or file from the host directly into the container. This gives a full control over the data location, but it's less portable and more dependent on the host filesystem structure.

## Instructions
Here is the list of the commands, which show how to run, stop and log the entire infrastructure.

- Build and start:<br>
```make up```
- Stop (save-mode):<br>
```make down```
- Completely cleaning:<br>
```make fclean```
- Rebuilding:<br>
```make re```
- See running containers and their status:<br>
```make ps```
- View logs:<br>
```make logs```
- Access containers:<br>
```make mariadb```<br>
```make wordpress```<br>
```make nginx```

#### After starting the project:
After running "_make up_", WordPress will automatically create two user accounts (admin and regular user). The credentials are defined in the .env file used for initial setup.

- Website: https://yourlogin.42.fr/
- WordPress Admin: https://yourlogin.42.fr/wp-admin/

## Resources

### Documentation
- Docker Documentation:<br>https://docs.docker.com/

- Docker Compose Documentation:<br>https://docs.docker.com/compose/

- NGINX Documentation:<br>https://docs.nginx.com/nginx/admin-guide/web-server/

- WordPress Documentation:<br>https://wordpress.org/documentation/

- MariaDB Documentation:<br>https://mariadb.com/docs/

### AI Usage
AI was used during this project to better understand the technical concepts behind Inception. It was also helpfull with researching the documentations for Docker and Docker Compose. At the start of doing this project it was difficult to understand how mariadb should be managed and configured, in this case, AI also helped me to get it in easier way.