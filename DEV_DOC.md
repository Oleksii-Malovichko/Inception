# Developer Documentation

This document explains how to set up, build and manage the Inception project.

## Environment Setup

### Prerequisites
- Docker
- Docker Compose
- Make

### Configuration Files
The project requires the following configuration files:

### .env file
Used for non-sensitive configuration, such as:
- WordPress database name and user
- WordPress admin and user credentials
- domain name

#### Docker secrets
Used for sensitive data:
- db_password
- db_root_password

Secrets are stored securely and injected into containers at runtime.

## Project Setup from Scratch
Clone the repository and ensure the following directory exists (they should be automatically created by the Makefile):<br>
```mkdir -p /home/login/data/db```<br>
```mkdir -p /home/login/data/wordpress```<br>

This directory is used for persistent storage

## Build and Launch the Project
### Using Makefile (recommended):
```make up```

This will:
- create required directories
- build Docker images
- start all containers

### Using Docker Compose (alternative):
```docker compose -f srcs/docker-compose.yml up --build -d```

## Stop The Project
### Makefile:
```make down```
### Docker Compose:
```docker compose -f srcs/docker-compose.yml down```

## Rebuild the Project
### Makefile:
```make re```
### Docker Compose:
```docker compose -f srcs/docker-compose.yml down -v && docker compose -f srcs/docker-compose.yml up --build -d```

## Full Cleanup (volumes and data)
### Makefile:
```make fclean```
### Docker Compose:
```docker compose -f srcs/docker-compose.yml down -v```

## Container Management Commands
### Makefile:
```make mariadb```<br>
```make wordpress```<br>
```make nginx```<br>

### Docker Compose:
```docker exec -it mariadb bash```<br>
```docker exec -it wordpress bash```<br>
```docker exec -it nginx bash```

## Data Persistence
All persistent data is stored on the host machine:
- MariaDB data: ```/home/login/data/db```
- WordPress data: ```/home/login/data/wordpress```

This was implemented using Docker volumes with bind-backend storage.

Data persists across:
- container restarts
- system reboots
- project rebuilds (if volumes are not removed)

## Networking
All containers communicate through a Docker bridge network.
- internal DNS resolution via container names
- isolated from host network
