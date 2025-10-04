# 42 Inception Infrastructure

A fully containerized WordPress stack built for the 42 *Inception* project. This repository orchestrates a production-style environment using custom Docker images, multi-service networking, and persistent volumes.

---

## What you get

- **HTTPS reverse proxy** with an Nginx container that terminates TLS and routes traffic to every service.
- **WordPress + MariaDB** configured automatically with WP-CLI, seeded users, and a Redis-backed object cache.
- **Bonus services**: Adminer (database dashboard), Portainer (container management UI), FTP (vsftpd), a static website, and a standalone Redis instance.
- **Persisted data**: bind mounts keep your database and WordPress files on the host, surviving container rebuilds.
- **Self-contained workflow** using a simple `Makefile` for building, starting, stopping, and cleaning the stack.

---

## Architecture at a glance

```
                           ┌─────────────┐
                           │   Browser    │
                           └──────┬───────┘
                                  │ 443 (HTTPS)
                         ┌────────▼─────────┐
                         │      nginx       │
                         └─┬──────┬──────┬──┘
                           │      │      │
                /adminer ┌─▼─┐  ┌─▼─┐  ┌─▼──────┐ /portainer
                        │DB │  │WP │  │ Portainer│
                        │UI │  │PHP│  └──────────┘
                        └───┘  │FPM│
                        Adminer│9000
                                │
               ┌────────────────┴─────────────┐
               │                              │
        ┌──────▼─────┐                 ┌──────▼─────┐
        │  MariaDB   │                 │   Redis    │
        │   3306     │                 │   6379     │
        └────────────┘                 └────────────┘
              │                              │
              └────── persistent volumes ────┘

Additional routes:
  • `https://<domain>/static/`  → Python HTTP server with the gym static site
  • `https://<domain>/adminer`  → Adminer UI (port 8080 inside container)
  • `https://<domain>/portainer/` → Portainer UI (port 9000 inside container)
  • FTP access is available inside the Docker network via the `ftp` service.
```

All containers communicate on a dedicated user-defined bridge network (`mynetwork`). WordPress, Adminer, Redis, and FTP rely on the MariaDB and WordPress volumes:

- `db` → `/home/amounadi/data/DB`
- `wb` → `/home/amounadi/data/WB`

> **Note**: Update these paths if your username differs from `amounadi`; the `Makefile` and `docker-compose.yml` expect matching directories.

---

## Repository layout

```
├── docker-compose.yml          # Multi-service orchestration
├── Makefile                    # Convenience targets for compose lifecycle
├── requirements/
│   ├── nginx/                  # TLS-enabled reverse proxy
│   ├── mariadb/                # Custom MariaDB server build
│   ├── wordpress/              # PHP-FPM + WP-CLI auto-bootstrap
│   └── bonus/
│       ├── adminer/            # Lightweight DB management UI
│       ├── ftp/                # vsftpd configuration & scripts
│       ├── portainer/          # Portainer Community Edition
│       ├── redis/              # Redis cache server
│       └── static/             # Static "Gym" website assets
└── requirements/**/tools       # Initialization scripts and configs
```

---

## Prerequisites

- Linux / macOS host (42 school evaluations expect Linux).
- Docker Engine ≥ 20.10 and Docker Compose plugin (`docker compose`) or standalone `docker-compose` binary.
- GNU Make (ships by default on most UNIX-like systems).
- Internet connectivity for the first build (downloads WordPress, WP-CLI, Portainer binaries, etc.).

---

## Quick start

1. **Clone the project**
   ```bash
   git clone https://github.com/Mounadi05/42-inception.git && cd 42-inception
   ```

2. **Create persistent volume directories**
   ```bash
   sudo mkdir -p /home/amounadi/data/DB /home/amounadi/data/WB
   sudo chown "$USER" /home/amounadi/data/DB /home/amounadi/data/WB
   ```
   Adjust the path if your username differs.

3. **Create a `.env` file**
   ```bash
   cp .env.example .env   # then edit .env with your own secrets
   ```
   Populate it with the variables described below.

4. **Build the images**
   ```bash
   make build
   ```

5. **Launch the stack**
   ```bash
   make up
   ```

6. **Visit your site**
   - WordPress: `https://<DOMAIN_NAME>` (self-signed certificate warning expected on first visit)
   - Adminer: `https://<DOMAIN_NAME>/adminer`
   - Portainer: `https://<DOMAIN_NAME>/portainer/`
   - Static site: `https://<DOMAIN_NAME>/static/`

To stop everything: `make down`. To remove containers and volumes: `make clean`. To wipe host data: `make fclean`.

---

## Environment variables

Create a `.env` file in the repository root. The build arguments and runtime configuration consume the following keys:

| Variable | Required? | Purpose | Default (if omitted) |
|----------|-----------|---------|-----------------------|
| `DOMAIN_NAME` | ✅ | FQDN used by Nginx and certificates. | `def` |
| `DB_ROOT_PASSWORD` | ✅ | MariaDB root password. | `default_root_password` |
| `DB_USER` | ✅ | WordPress database user. | `default_user` |
| `DB_USER_PASSWORD` | ✅ | Password for `DB_USER`. | `default_password` |
| `DB_DATABASE` | ✅ | WordPress database name. | `default_database` |
| `url` | ✅ | Site URL passed to WP-CLI (e.g., `https://example.com`). | `def` |
| `title` | ✅ | Title for the WordPress site. | `def` |
| `wordpress_admin` | ✅ | WP administrator username. | `def` |
| `wordpress_password` | ✅ | WP administrator password. | `def` |
| `admin_email` | ✅ | WP administrator email. | `def` |
| `WP_user` | ✅ | Additional WordPress author username. | *(no default)* |
| `user_mail` | ✅ | Email for the additional author. | *(no default)* |
| `user_pass` | ✅ | Password for the additional author. | *(no default)* |
| `FTP_HOST` | ✅ | Hostname configured in WordPress for FTP transfers (typically `co_ftp`). | `def` |
| `FTP_USER` | ✅ | Username for vsftpd. | `def` |
| `FTP_PASS` | ✅ | Password for vsftpd. | `def` |
| `PORTAINER_PASS` | ✅ | Password for the Portainer admin user. | `def` |

> **Tip:** Keep your `.env` file out of version control by adding it to `.gitignore` if it isn’t already.

---

## Make targets

| Command | What it does |
|---------|--------------|
| `make up` | Starts every service in detached mode (`docker-compose up -d`). |
| `make build` | Rebuilds all images (`docker-compose build`). |
| `make down` | Stops and removes containers (`docker-compose down`). |
| `make clean` | Stops containers and removes volumes (`docker-compose down -v`). |
| `make fclean` | Hard reset: removes the host bind-mount contents in `/home/amounadi/data/DB` and `/home/amounadi/data/WB`. |

---

## Service catalog

| Service | Container | Ports | Highlights |
|---------|-----------|-------|------------|
| **nginx** | `co_nginx` | `443:443` | Serves WordPress over HTTPS, proxies Adminer, Portainer, and the static site. Generates a self-signed certificate during build. |
| **wordpress** | `co_wordpress` | `9000` (internal) | PHP-FPM + WP-CLI bootstrap. Creates admin + author accounts, installs Redis cache plugin, and configures FTP constants. |
| **mariadb** | `co_mariadb` | `3306` (internal) | Initializes user/database according to `.env`. Listens on all interfaces (within the Docker network). |
| **redis** | `co_redis` | `6379` (internal) | Provides object caching for WordPress (`redis-cache` plugin enabled). Configured to accept remote connections within the network. |
| **ftp** | `co_ftp` | none exposed | vsftpd server that shares the WordPress volume. Accessible to other containers; expose a host port in `docker-compose.yml` if external FTP access is required. |
| **adminer** | `co_adminer` | `8080` (internal) | One-file PHP Adminer instance served via Nginx reverse proxy at `/adminer`. |
| **portainer** | `co_portainer` | `9000` (internal) | Portainer CE binary runs inside the container and is proxied at `/portainer/`. Requires `PORTAINER_PASS`. |
| **static** | `co_static` | `80` (internal) | Python HTTP server serving the Gym static site at `/static/`. |

All services share the `mynetwork` bridge, keeping traffic isolated from the default Docker network.

---

## Data persistence

- **MariaDB** data files live under `/home/amounadi/data/DB`.
- **WordPress** uploads, themes, and core files bind-mount to `/home/amounadi/data/WB`.

Because these are bind mounts on the host, containers can be rebuilt or replaced without wiping data. Use `make fclean` only when you intentionally want a fresh reset.

---

## SSL & certificates

During the Nginx image build, an RSA 2048-bit self-signed certificate is generated with OpenSSL and copied to `/etc/nginx/ssl/`. Browsers will warn about the certificate on first access—add a security exception during local development. For production usage, swap in a certificate issued by a trusted CA and update the build step accordingly.

---

## Customizing the stack

- **Change domain name**: Update `DOMAIN_NAME` in `.env` and re-run `make build` so Nginx receives the new value.
- **Different data paths**: Edit the `device` field under the `db` and `wb` volumes in `docker-compose.yml`, plus the `fclean` target in the `Makefile`.
- **Expose FTP externally**: Add a `ports` mapping (e.g., `"21:21"`) under the `ftp` service; adjust firewall rules as needed.
- **Swap or add plugins/themes**: Utilize the WP-CLI binary available inside the WordPress container (`docker exec -it co_wordpress wp plugin ...`).

---

## Monitoring & troubleshooting

- **Check logs**
  ```bash
  docker compose logs -f nginx
  docker compose logs -f wordpress
  docker compose logs -f mariadb
  ```
- **Inspect container status**
  ```bash
  docker compose ps
  ```
- **Verify WordPress CLI access**
  ```bash
  docker exec -it co_wordpress wp plugin status --allow-root
  ```
- **MariaDB shell**
  ```bash
  docker exec -it co_mariadb mysql -u${DB_USER} -p${DB_USER_PASSWORD} ${DB_DATABASE}
  ```

Common pitfalls:

- The host directories `/home/amounadi/data/DB` and `/home/amounadi/data/WB` must exist before `docker-compose up`. Missing directories cause bind mount failures.
- Ensure every required variable is set in `.env`. Missing values make the initialization scripts fall back to insecure defaults or break WP-CLI commands.
- First-run race conditions are mitigated with startup `sleep` commands, but if WordPress fails to connect to MariaDB, rerun `make up` once MariaDB is healthy.

---

## Cleanup

- `make down` – stop everything but keep data.
- `make clean` – stop everything and delete Docker-managed volumes.
- `make fclean` – additionally wipe the bind-mounted directories on the host (irreversible).

