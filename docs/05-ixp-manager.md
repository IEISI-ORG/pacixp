Here is the production-ready `docker-compose.yml` template for deploying **IXP Manager**.

This setup orchestrates the Web Server (Nginx), Application (PHP-FPM), Database (MariaDB), and Task Scheduler (Cron) required to run the platform.

### ⚠️ Prerequisite: Environment Configuration
Before running this, you must create a `.env` file in the same directory. This file manages secrets so they aren't hardcoded in the YAML.

**Create a file named `.env`:**
```bash
# Database Secrets
DB_PASSWORD=strong_db_password_here
DB_ROOT_PASSWORD=strong_root_password_here
DB_DATABASE=ixp
DB_USERNAME=ixp

# Application URL (Change this to your FQDN)
APP_URL=http://ixp.PacIXP.net
IXP_TRUSTED_PROXIES=10.0.0.0/8,172.16.0.0/12,192.168.0.0/16

# Identity
IXP_NAME="PacIXP"
IXP_COUNTRY="WS"
```

---

### File: `templates/ixp-manager-docker-compose.yml`

```yaml
version: '3.8'

services:
  # ------------------------------------------------------------------
  # DATABASE SERVICE (MariaDB)
  # ------------------------------------------------------------------
  db:
    image: mariadb:10.6
    restart: unless-stopped
    command: --transaction-isolation=READ-COMMITTED --binlog-format=ROW
    volumes:
      - db-data:/var/lib/mysql
    environment:
      - MYSQL_ROOT_PASSWORD=${DB_ROOT_PASSWORD}
      - MYSQL_PASSWORD=${DB_PASSWORD}
      - MYSQL_DATABASE=${DB_DATABASE}
      - MYSQL_USER=${DB_USERNAME}
    networks:
      - ixp-backend

  # ------------------------------------------------------------------
  # APP SERVICE (IXP Manager Core - PHP-FPM)
  # ------------------------------------------------------------------
  ixp-manager:
    image: inex/ixp-manager:latest
    restart: unless-stopped
    depends_on:
      - db
    volumes:
      # Mount your local .env file into the container
      - ./.env:/var/www/ixp-manager/.env
      # Persist storage (logos, skins)
      - ixp-storage:/var/www/ixp-manager/storage
      # Custom skinning (optional)
      # - ./skins:/var/www/ixp-manager/resources/skins
    environment:
      - DB_HOST=db
      - DB_USERNAME=${DB_USERNAME}
      - DB_PASSWORD=${DB_PASSWORD}
      - DB_DATABASE=${DB_DATABASE}
    networks:
      - ixp-backend

  # ------------------------------------------------------------------
  # WEB SERVER (Nginx)
  # ------------------------------------------------------------------
  nginx:
    image: nginx:alpine
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
    volumes:
      # Share static assets from the app container
      - ixp-storage:/var/www/ixp-manager/storage
      # Custom Nginx config (optional, uses default if omitted)
      # - ./nginx.conf:/etc/nginx/conf.d/default.conf
    depends_on:
      - ixp-manager
    networks:
      - ixp-backend

  # ------------------------------------------------------------------
  # TASK SCHEDULER (Cron / Artisan)
  # Required for generating router configs and updating stats
  # ------------------------------------------------------------------
  cron:
    image: inex/ixp-manager:latest
    restart: unless-stopped
    depends_on:
      - db
      - ixp-manager
    volumes:
      - ./.env:/var/www/ixp-manager/.env
      - ixp-storage:/var/www/ixp-manager/storage
    # Run the laravel scheduler every minute
    entrypoint: ["/usr/sbin/crond", "-f", "-l", "8"]
    networks:
      - ixp-backend

  # ------------------------------------------------------------------
  # CACHE (Redis) - Optional but recommended for performance
  # ------------------------------------------------------------------
  redis:
    image: redis:alpine
    restart: unless-stopped
    networks:
      - ixp-backend

volumes:
  db-data:
    driver: local
  ixp-storage:
    driver: local

networks:
  ixp-backend:
    driver: bridge
```

### 🚀 Deployment Instructions

1.  **Install Docker & Compose:**
    ```bash
    apt-get update && apt-get install docker.io docker-compose-plugin
    ```

2.  **Setup Directory:**
    ```bash
    mkdir -p /opt/ixp-manager
    cd /opt/ixp-manager
    # Copy the docker-compose.yml here
    # Create the .env file here
    ```

3.  **Initialize the Database:**
    Run this command **once** to set up the initial schema and admin user.
    ```bash
    docker compose run --rm ixp-manager php artisan migrate --seed
    
    # Create the Admin User
    docker compose run --rm ixp-manager php artisan ixp:admin-create \
      --user="admin" \
      --email="admin@PacIXP.net" \
      --password="YourStrongAdminPassword" \
      --name="PacIXP Admin"
    ```

4.  **Start Services:**
    ```bash
    docker compose up -d
    ```

5.  **Generate Encryption Key:**
    ```bash
    docker compose run --rm ixp-manager php artisan key:generate
    # Note the output key, and add it to your .env file: APP_KEY=...
    docker compose restart ixp-manager
    ```

6.  **Access the GUI:**
    Open `http://<server-ip>` and login with the admin credentials created in step 3.
