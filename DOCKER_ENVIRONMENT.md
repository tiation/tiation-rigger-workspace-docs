# 🐋 Tiation Rigger Docker Development Environment

**Enterprise-grade unified development environment with Docker Compose featuring
dark neon theme**

[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Docker Compose](https://img.shields.io/badge/Docker%20Compose-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://docs.docker.com/compose/)
[![Nginx](https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white)](https://nginx.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Redis](https://img.shields.io/badge/Redis-DC382D?style=for-the-badge&logo=redis&logoColor=white)](https://redis.io/)
[![Prometheus](https://img.shields.io/badge/Prometheus-E6522C?style=for-the-badge&logo=prometheus&logoColor=white)](https://prometheus.io/)
[![Grafana](https://img.shields.io/badge/Grafana-F46800?style=for-the-badge&logo=grafana&logoColor=white)](https://grafana.com/)
[![Traefik](https://img.shields.io/badge/Traefik-24A1C1?style=for-the-badge&logo=traefik&logoColor=white)](https://traefik.io/)

## 🌟 Overview

This unified development environment provides a complete, enterprise-grade
Docker Compose setup for the Tiation Rigger platform. It includes all necessary
services for local development, testing, and documentation with a sleek dark
neon theme.

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│                        🚀 Tiation Rigger Dev Environment            │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  ┌───────────────┐    ┌───────────────┐    ┌───────────────┐      │
│  │   📖 Docs     │    │   🔗 API      │    │   🔄 Traefik  │      │
│  │   Server      │    │   Server      │    │   Proxy       │      │
│  │   (Nginx)     │    │   (Node.js)   │    │   (Load Bal.) │      │
│  │   Port: 3000  │    │   Port: 8080  │    │   Port: 80    │      │
│  └───────────────┘    └───────────────┘    └───────────────┘      │
│                                                                     │
│  ┌───────────────┐    ┌───────────────┐    ┌───────────────┐      │
│  │   🗄️ Database │    │   💾 Redis    │    │   📊 Prometheus│      │
│  │   (PostgreSQL)│    │   Cache       │    │   Metrics     │      │
│  │   Port: 5432  │    │   Port: 6379  │    │   Port: 9090  │      │
│  └───────────────┘    └───────────────┘    └───────────────┘      │
│                                                                     │
│  ┌───────────────┐    ┌───────────────┐    ┌───────────────┐      │
│  │   📈 Grafana  │    │   🛠️ Dev Tools │    │   👀 File     │      │
│  │   Dashboard   │    │   Container   │    │   Watcher     │      │
│  │   Port: 3001  │    │   (Ubuntu)    │    │   (Hot Reload)│      │
│  └───────────────┘    └───────────────┘    └───────────────┘      │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

## 🚀 Quick Start

### Prerequisites

- **Docker** (v20.10+)
- **Docker Compose** (v2.0+)
- **Node.js** (v18+) - for local development
- **Git** - for version control

### 1. One-Command Setup

```bash
# Run the automated setup script
./scripts/setup-dev-env.sh
```

### 2. Manual Setup

```bash
# Create necessary directories
mkdir -p docker/{nginx,postgres,redis,traefik,prometheus,grafana,dev-tools,file-watcher}

# Build and start all services
docker-compose up -d --build

# Check service status
docker-compose ps
```

### 3. Access Services

Once the environment is running, access these services:

| Service                   | URL                   | Description                             |
| ------------------------- | --------------------- | --------------------------------------- |
| 📖 **Documentation Site** | http://localhost:3000 | Main documentation with dark neon theme |
| 🔗 **API Server**         | http://localhost:8080 | Development API server                  |
| 🔄 **Traefik Dashboard**  | http://localhost:8090 | Load balancer and reverse proxy         |
| 📊 **Prometheus**         | http://localhost:9090 | Metrics and monitoring                  |
| 📈 **Grafana**            | http://localhost:3001 | Analytics dashboard                     |
| 🗄️ **PostgreSQL**         | localhost:5432        | Database server                         |
| 💾 **Redis**              | localhost:6379        | Cache and session store                 |

## 🎨 Dark Neon Theme

The entire environment is designed with a **dark neon theme** featuring:

- **Primary Colors**: Cyan (#00FFFF), Magenta (#FF00FF), Green (#00FF00)
- **Dark Backgrounds**: Deep blacks and grays for reduced eye strain
- **Neon Accents**: Bright, vibrant colors for important elements
- **Smooth Animations**: Subtle transitions and hover effects

## 🛠️ Service Details

### 📖 Documentation Server (Nginx)

**Container**: `tiation-rigger-docs` **Port**: 3000 **Features**:

- Optimized Nginx configuration for documentation serving
- Gzip compression and caching
- Security headers and rate limiting
- Health checks and status monitoring
- Dark neon theme asset optimization

### 🔗 API Server (Node.js)

**Container**: `tiation-rigger-api` **Port**: 8080 **Features**:

- Express.js with TypeScript support
- Hot reloading with nodemon
- CORS configuration for development
- Health check endpoints
- Error handling and logging

### 🗄️ Database (PostgreSQL)

**Container**: `tiation-rigger-db` **Port**: 5432 **Features**:

- PostgreSQL 15 with Alpine Linux
- Automated schema initialization
- Sample data for development
- Performance optimizations
- Backup and restore capabilities

### 💾 Cache (Redis)

**Container**: `tiation-rigger-cache` **Port**: 6379 **Features**:

- Redis 7 with persistence
- Custom configuration for development
- Memory optimization
- Session storage capabilities
- Pub/Sub messaging support

### 🔄 Load Balancer (Traefik)

**Container**: `tiation-rigger-proxy` **Port**: 80, 443, 8090 **Features**:

- Automatic service discovery
- SSL termination
- Rate limiting and security
- Dashboard with dark theme
- Health checks and monitoring

### 📊 Monitoring (Prometheus)

**Container**: `tiation-rigger-prometheus` **Port**: 9090 **Features**:

- Service metrics collection
- Custom alerting rules
- Performance monitoring
- Integration with Grafana
- Data retention policies

### 📈 Analytics (Grafana)

**Container**: `tiation-rigger-grafana` **Port**: 3001 **Features**:

- Pre-configured dashboards
- Dark neon theme
- Prometheus data source
- Custom visualizations
- Alerting capabilities

### 🛠️ Development Tools

**Container**: `tiation-rigger-dev-tools` **Features**:

- Ubuntu 22.04 with development tools
- Node.js, Python, Docker CLI
- Git, vim, htop, and more
- GitHub CLI integration
- Custom aliases and shortcuts

### 👀 File Watcher

**Container**: `tiation-rigger-watcher` **Features**:

- Hot reloading for documentation
- CSS/JS change detection
- Automatic server restart
- Customizable watch patterns
- Performance optimizations

## 🔧 Configuration

### Environment Variables

The environment uses a `.env` file for configuration:

```env
# Application Settings
NODE_ENV=development
APP_NAME=tiation-rigger-workspace-docs
APP_VERSION=1.0.0

# Database Configuration
POSTGRES_HOST=postgres
POSTGRES_PORT=5432
POSTGRES_DB=tiation_rigger
POSTGRES_USER=tiation_user
POSTGRES_PASSWORD=tiation_dev_password

# Redis Configuration
REDIS_HOST=redis
REDIS_PORT=6379
REDIS_PASSWORD=tiation_redis_dev_password

# Theme Configuration
THEME=dark-neon
PRIMARY_COLOR=#00FFFF
SECONDARY_COLOR=#FF00FF
ACCENT_COLOR=#00FF00
```

### Docker Compose Override

Create a `docker-compose.override.yml` for local customizations:

```yaml
version: '3.8'

services:
  docs-server:
    volumes:
      - ./custom-docs:/usr/share/nginx/html/custom
    environment:
      - CUSTOM_THEME=true

  api-server:
    environment:
      - DEBUG=true
      - LOG_LEVEL=debug
```

## 🚀 Development Commands

### Quick Commands

```bash
# Start all services
./scripts/setup-dev-env.sh start

# Stop all services
./scripts/setup-dev-env.sh stop

# Restart all services
./scripts/setup-dev-env.sh restart

# View logs
./scripts/setup-dev-env.sh logs

# Check status
./scripts/setup-dev-env.sh status

# Clean environment
./scripts/setup-dev-env.sh clean
```

### Docker Compose Commands

```bash
# Build and start services
docker-compose up -d --build

# View logs (all services)
docker-compose logs -f

# View logs (specific service)
docker-compose logs -f docs-server

# Scale a service
docker-compose up -d --scale api-server=3

# Execute commands in containers
docker-compose exec api-server npm install
docker-compose exec postgres psql -U tiation_user -d tiation_rigger
docker-compose exec redis redis-cli
docker-compose exec dev-tools bash

# Stop and remove containers
docker-compose down

# Stop and remove containers + volumes
docker-compose down -v
```

### Development Shortcuts

```bash
# Load development aliases
source scripts/dev-commands.sh

# Use shortcuts
dc up -d          # docker-compose up -d
dcl              # docker-compose logs -f
dcd              # docker-compose down
docs-logs        # docker-compose logs -f docs-server
api-logs         # docker-compose logs -f api-server
db-shell         # docker-compose exec postgres psql -U tiation_user -d tiation_rigger
redis-cli        # docker-compose exec redis redis-cli
dev-shell        # docker-compose exec dev-tools bash
```

## 🔐 Security

### Development Security Features

- **Rate Limiting**: Configured in Traefik and Nginx
- **CORS Protection**: API server with environment-specific origins
- **Security Headers**: Comprehensive security headers in all services
- **Input Validation**: API endpoints with Joi validation
- **Authentication**: JWT-based authentication ready
- **SSL/TLS**: Ready for HTTPS with Let's Encrypt

### Production Security Notes

⚠️ **Important**: This environment is configured for development. For
production:

1. Change all default passwords
2. Enable SSL/TLS certificates
3. Configure proper firewall rules
4. Enable audit logging
5. Use secrets management
6. Configure backups

## 📊 Monitoring & Metrics

### Available Metrics

- **Application Metrics**: Response times, error rates, throughput
- **Infrastructure Metrics**: CPU, memory, disk usage
- **Database Metrics**: Connections, queries, performance
- **Cache Metrics**: Hit rates, memory usage, operations
- **Network Metrics**: Request/response patterns

### Grafana Dashboards

Pre-configured dashboards include:

1. **Application Overview**: High-level application metrics
2. **Infrastructure**: System resource utilization
3. **Database Performance**: PostgreSQL metrics
4. **Cache Performance**: Redis metrics
5. **API Performance**: Endpoint-specific metrics

### Alerting Rules

Configured alerts for:

- Service downtime
- High error rates
- Resource exhaustion
- Database connection issues
- Cache memory usage

## 🐛 Troubleshooting

### Common Issues

#### Services Not Starting

```bash
# Check Docker daemon
docker info

# Check service logs
docker-compose logs [service-name]

# Restart specific service
docker-compose restart [service-name]
```

#### Port Conflicts

```bash
# Check port usage
netstat -tulpn | grep [port]

# Change ports in docker-compose.yml
services:
  docs-server:
    ports:
      - "3001:80"  # Change from 3000 to 3001
```

#### Database Connection Issues

```bash
# Check database logs
docker-compose logs postgres

# Test database connection
docker-compose exec postgres psql -U tiation_user -d tiation_rigger -c "SELECT 1;"

# Reset database
docker-compose down -v
docker-compose up postgres -d
```

#### File Permissions

```bash
# Fix permissions
sudo chown -R $(id -u):$(id -g) docker/volumes/

# Check container permissions
docker-compose exec docs-server ls -la /usr/share/nginx/html
```

### Debug Mode

Enable debug mode for detailed logging:

```bash
# Set environment variable
export DEBUG=true

# Or in .env file
DEBUG=true
LOG_LEVEL=debug
```

## 📚 Documentation

### Additional Resources

- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Nginx Configuration Guide](https://nginx.org/en/docs/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Redis Documentation](https://redis.io/documentation)
- [Prometheus Documentation](https://prometheus.io/docs/)
- [Grafana Documentation](https://grafana.com/docs/)
- [Traefik Documentation](https://doc.traefik.io/)

### Project Structure

```
tiation-rigger-workspace-docs/
├── docker/
│   ├── nginx/
│   │   └── nginx.conf
│   ├── postgres/
│   │   └── init.sql
│   ├── redis/
│   │   └── redis.conf
│   ├── traefik/
│   │   ├── traefik.yml
│   │   └── dynamic.yml
│   ├── prometheus/
│   │   └── prometheus.yml
│   ├── grafana/
│   │   ├── provisioning/
│   │   └── dashboards/
│   ├── dev-tools/
│   │   └── Dockerfile
│   └── file-watcher/
│       └── Dockerfile
├── api/
│   ├── src/
│   │   └── index.js
│   ├── package.json
│   └── Dockerfile.dev
├── scripts/
│   ├── setup-dev-env.sh
│   └── dev-commands.sh
├── docker-compose.yml
├── Dockerfile.docs
├── .env
└── DOCKER_ENVIRONMENT.md
```

## 🤝 Contributing

### Development Workflow

1. Fork the repository
2. Create a feature branch
3. Make changes in the unified environment
4. Test using the Docker environment
5. Submit a pull request

### Adding New Services

1. Add service to `docker-compose.yml`
2. Create configuration files in `docker/`
3. Update monitoring configuration
4. Add service to documentation
5. Test the integration

### Code Style

- Follow existing Docker Compose patterns
- Use descriptive service names
- Include health checks
- Add proper labels and metadata
- Document configuration options

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file
for details.

## 🔗 Links

- **GitHub Repository**:
  [tiation-rigger-workspace-docs](https://github.com/tiation/tiation-rigger-workspace-docs)
- **GitHub Organization**: [tiation](https://github.com/tiation)
- **Live Documentation**:
  [tiation.github.io/tiation-rigger-workspace-docs](https://tiation.github.io/tiation-rigger-workspace-docs)

---

**🎯 Built with ❤️ by the [Tiation](https://github.com/tiation) team**

_Enterprise-grade development environment featuring dark neon theme and
comprehensive monitoring_
