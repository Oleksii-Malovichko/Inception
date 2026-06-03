# User Documentation

This document explains how an end user or administrator can use the Inception.

## Services Provided
The stack includes:<br>
- NGINX: HTTPS web server and reverse proxy
- WordPress: website and administration panel
- MariaDB: database for WordPress

## Start and Stop the Project

Start all services:<br>
```make up```

Stop all services:<br>
```make down```

Completely removing containers and data:<br>
```make fclean```

## Access the Website
Main website:<br>
https://yourlogin.42.fr/<br>

WordPress admin panel:<br>
https://yourlogin.42.fr/wp-admin/

## Credentials Management
All credentials are defined in the .env file.

This includes:
- WordPress admin user
- WordPress regular user
- database configuration

These credentials are required for initial setup and login.

## Check Service Status
Check running containers:<br>
```make ps```

View logs:<br>
```make logs```
