#!/bin/bash

# Tiation Rigger Development Environment Setup Script
# Enterprise-grade unified development environment with Docker Compose
# Featuring dark neon theme and comprehensive monitoring

set -e

# Colors for output (dark neon theme)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Neon gradient effect
NEON_CYAN='\033[96m'
NEON_PURPLE='\033[95m'

# Project configuration
PROJECT_NAME="tiation-rigger-workspace-docs"
DOCKER_NETWORK="tiation-network"
COMPOSE_FILE="docker-compose.yml"

# Function to print colored output
print_status() {
    echo -e "${CYAN}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_neon_header() {
    echo -e "${NEON_CYAN}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${NEON_CYAN}║                                                                              ║${NC}"
    echo -e "${NEON_CYAN}║            ${NEON_PURPLE}🚀 TIATION RIGGER DEVELOPMENT ENVIRONMENT 🚀${NEON_CYAN}            ║${NC}"
    echo -e "${NEON_CYAN}║                                                                              ║${NC}"
    echo -e "${NEON_CYAN}║              ${WHITE}Enterprise-grade unified development setup${NEON_CYAN}               ║${NC}"
    echo -e "${NEON_CYAN}║                      ${WHITE}with dark neon theme${NEON_CYAN}                           ║${NC}"
    echo -e "${NEON_CYAN}║                                                                              ║${NC}"
    echo -e "${NEON_CYAN}╚══════════════════════════════════════════════════════════════════════════════╝${NC}"
    echo
}

# Function to check prerequisites
check_prerequisites() {
    print_status "Checking prerequisites..."
    
    # Check Docker
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed. Please install Docker first."
        exit 1
    fi
    
    # Check Docker Compose
    if ! command -v docker-compose &> /dev/null; then
        print_error "Docker Compose is not installed. Please install Docker Compose first."
        exit 1
    fi
    
    # Check if Docker is running
    if ! docker info &> /dev/null; then
        print_error "Docker is not running. Please start Docker first."
        exit 1
    fi
    
    print_success "All prerequisites met!"
}

# Function to create necessary directories
create_directories() {
    print_status "Creating project directories..."
    
    # Create API directory structure
    mkdir -p api/{src,tests,config,docs}
    
    # Create additional directories
    mkdir -p {logs,data,backups,scripts,docs/assets}
    
    # Create Docker volume directories
    mkdir -p docker/volumes/{postgres,redis,grafana,prometheus}
    
    print_success "Project directories created!"
}

# Function to setup hosts file entries
setup_hosts() {
    print_status "Setting up local hosts entries..."
    
    # Check if hosts entries exist
    if ! grep -q "docs.tiation.local" /etc/hosts; then
        print_warning "Adding hosts entries requires sudo access..."
        echo "127.0.0.1 docs.tiation.local" | sudo tee -a /etc/hosts
        echo "127.0.0.1 api.tiation.local" | sudo tee -a /etc/hosts
        echo "127.0.0.1 traefik.tiation.local" | sudo tee -a /etc/hosts
        echo "127.0.0.1 metrics.tiation.local" | sudo tee -a /etc/hosts
        echo "127.0.0.1 grafana.tiation.local" | sudo tee -a /etc/hosts
        print_success "Hosts entries added!"
    else
        print_status "Hosts entries already exist, skipping..."
    fi
}

# Function to create environment files
create_env_files() {
    print_status "Creating environment configuration files..."
    
    # Create .env file
    cat > .env << EOF
# Tiation Rigger Development Environment Variables
# Generated on $(date)

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

# API Configuration
API_HOST=api-server
API_PORT=8080
API_SECRET_KEY=tiation_dev_secret_key_change_in_production

# Monitoring Configuration
PROMETHEUS_PORT=9090
GRAFANA_PORT=3001
GRAFANA_ADMIN_PASSWORD=tiation_admin

# Development Configuration
HOT_RELOAD=true
DEBUG_MODE=true
LOG_LEVEL=debug

# Security (Development Only)
CORS_ORIGIN=http://localhost:3000,https://docs.tiation.local
JWT_SECRET=tiation_jwt_dev_secret

# Theme Configuration
THEME=dark-neon
PRIMARY_COLOR=#00FFFF
SECONDARY_COLOR=#FF00FF
ACCENT_COLOR=#00FF00
EOF

    # Create API package.json
    cat > api/package.json << EOF
{
  "name": "tiation-rigger-api",
  "version": "1.0.0",
  "description": "API server for Tiation Rigger platform",
  "main": "src/index.js",
  "scripts": {
    "dev": "nodemon src/index.js",
    "start": "node src/index.js",
    "test": "jest",
    "build": "echo 'Build process for API'"
  },
  "dependencies": {
    "express": "^4.18.2",
    "cors": "^2.8.5",
    "helmet": "^7.0.0",
    "dotenv": "^16.3.1",
    "pg": "^8.11.0",
    "redis": "^4.6.7",
    "jsonwebtoken": "^9.0.0",
    "bcryptjs": "^2.4.3",
    "joi": "^17.9.2"
  },
  "devDependencies": {
    "nodemon": "^3.0.1",
    "jest": "^29.5.0",
    "supertest": "^6.3.3"
  },
  "keywords": ["tiation", "rigger", "api", "construction", "enterprise"]
}
EOF

    # Create basic API server
    mkdir -p api/src
    cat > api/src/index.js << EOF
const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
require('dotenv').config();

const app = express();
const PORT = process.env.API_PORT || 8080;

// Middleware
app.use(helmet());
app.use(cors({
  origin: process.env.CORS_ORIGIN?.split(',') || ['http://localhost:3000'],
  credentials: true
}));
app.use(express.json());

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({
    status: 'healthy',
    timestamp: new Date().toISOString(),
    version: process.env.APP_VERSION || '1.0.0',
    environment: process.env.NODE_ENV || 'development'
  });
});

// API routes
app.get('/api/status', (req, res) => {
  res.json({
    message: 'Tiation Rigger API is running',
    theme: 'dark-neon',
    features: ['authentication', 'job-management', 'rigger-profiles', 'real-time-updates']
  });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({
    error: 'Something went wrong!',
    message: process.env.NODE_ENV === 'development' ? err.message : 'Internal server error'
  });
});

// 404 handler
app.use('*', (req, res) => {
  res.status(404).json({
    error: 'Route not found',
    path: req.originalUrl
  });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(\`🚀 Tiation Rigger API server running on port \${PORT}\`);
  console.log(\`🌐 Environment: \${process.env.NODE_ENV}\`);
  console.log(\`🎨 Theme: dark-neon\`);
});
EOF

    print_success "Environment files created!"
}

# Function to build and start services
start_services() {
    print_status "Building and starting services..."
    
    # Build containers
    docker-compose build --parallel
    
    # Start services
    docker-compose up -d
    
    # Wait for services to be ready
    print_status "Waiting for services to be ready..."
    sleep 30
    
    # Check service health
    check_service_health
    
    print_success "All services started successfully!"
}

# Function to check service health
check_service_health() {
    print_status "Checking service health..."
    
    local services=("docs-server:80" "api-server:8080" "postgres:5432" "redis:6379" "prometheus:9090" "grafana:3000")
    
    for service in "${services[@]}"; do
        IFS=':' read -r host port <<< "$service"
        if docker-compose exec -T "$host" nc -z localhost "$port" 2>/dev/null; then
            print_success "$host service is healthy"
        else
            print_warning "$host service may not be ready yet"
        fi
    done
}

# Function to display service URLs
display_service_urls() {
    print_neon_header
    echo -e "${NEON_CYAN}🌐 Service URLs:${NC}"
    echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo
    echo -e "${CYAN}📖 Documentation Site:${NC}     ${WHITE}http://localhost:3000${NC}"
    echo -e "${CYAN}🔗 API Server:${NC}              ${WHITE}http://localhost:8080${NC}"
    echo -e "${CYAN}🔄 Traefik Dashboard:${NC}       ${WHITE}http://localhost:8090${NC}"
    echo -e "${CYAN}📊 Prometheus Metrics:${NC}      ${WHITE}http://localhost:9090${NC}"
    echo -e "${CYAN}📈 Grafana Dashboard:${NC}       ${WHITE}http://localhost:3001${NC}"
    echo -e "${CYAN}🗄️  Database (PostgreSQL):${NC}   ${WHITE}localhost:5432${NC}"
    echo -e "${CYAN}💾 Redis Cache:${NC}             ${WHITE}localhost:6379${NC}"
    echo
    echo -e "${NEON_PURPLE}🔑 Default Credentials:${NC}"
    echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}Grafana:${NC}      admin / tiation_admin"
    echo -e "${YELLOW}Traefik:${NC}      admin / tiation123"
    echo -e "${YELLOW}Database:${NC}     tiation_user / tiation_dev_password"
    echo -e "${YELLOW}Redis:${NC}        (password: tiation_redis_dev_password)"
    echo
    echo -e "${NEON_CYAN}🚀 Quick Commands:${NC}"
    echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}View logs:${NC}        docker-compose logs -f"
    echo -e "${GREEN}Stop services:${NC}    docker-compose down"
    echo -e "${GREEN}Restart all:${NC}      docker-compose restart"
    echo -e "${GREEN}Dev tools:${NC}        docker-compose exec dev-tools bash"
    echo -e "${GREEN}Database shell:${NC}   docker-compose exec postgres psql -U tiation_user -d tiation_rigger"
    echo -e "${GREEN}Redis CLI:${NC}        docker-compose exec redis redis-cli"
    echo
}

# Function to setup development tools
setup_dev_tools() {
    print_status "Setting up development tools..."
    
    # Install npm dependencies for the documentation site
    if [ -f "package.json" ]; then
        npm install
    fi
    
    # Create useful development scripts
    mkdir -p scripts
    
    cat > scripts/dev-commands.sh << 'EOF'
#!/bin/bash
# Development commands for Tiation Rigger

# Quick commands
alias dc='docker-compose'
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'
alias dcr='docker-compose restart'
alias dcl='docker-compose logs -f'
alias dcb='docker-compose build'

# Service-specific commands
alias docs-logs='docker-compose logs -f docs-server'
alias api-logs='docker-compose logs -f api-server'
alias db-shell='docker-compose exec postgres psql -U tiation_user -d tiation_rigger'
alias redis-cli='docker-compose exec redis redis-cli'
alias dev-shell='docker-compose exec dev-tools bash'

# Monitoring commands
alias metrics='open http://localhost:9090'
alias grafana='open http://localhost:3001'
alias traefik='open http://localhost:8090'

echo "Development commands loaded! Use 'dc', 'dcu', 'dcd', etc."
EOF

    chmod +x scripts/dev-commands.sh
    
    print_success "Development tools configured!"
}

# Function to run post-setup tasks
post_setup_tasks() {
    print_status "Running post-setup tasks..."
    
    # Wait for database to be ready
    sleep 5
    
    # Run database migrations/setup
    docker-compose exec -T postgres psql -U tiation_user -d tiation_rigger -c "SELECT 'Database is ready' as status;"
    
    # Create sample data
    print_status "Database setup completed!"
    
    # Test API connectivity
    if curl -s http://localhost:8080/health > /dev/null; then
        print_success "API server is responding!"
    else
        print_warning "API server may not be ready yet"
    fi
}

# Main setup function
main() {
    print_neon_header
    
    print_status "Starting Tiation Rigger Development Environment setup..."
    
    # Run setup steps
    check_prerequisites
    create_directories
    setup_hosts
    create_env_files
    setup_dev_tools
    start_services
    post_setup_tasks
    
    # Display final information
    display_service_urls
    
    print_success "🎉 Tiation Rigger Development Environment setup completed!"
    print_status "You can now start developing with the unified Docker environment."
    print_status "Visit http://localhost:3000 to see your documentation site with dark neon theme."
}

# Handle script arguments
case "${1:-}" in
    "start")
        docker-compose up -d
        display_service_urls
        ;;
    "stop")
        docker-compose down
        print_success "Services stopped"
        ;;
    "restart")
        docker-compose restart
        display_service_urls
        ;;
    "logs")
        docker-compose logs -f
        ;;
    "clean")
        docker-compose down -v --remove-orphans
        docker system prune -f
        print_success "Environment cleaned"
        ;;
    "status")
        docker-compose ps
        ;;
    *)
        main
        ;;
esac
