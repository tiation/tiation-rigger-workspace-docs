# 📖 RiggerConnect Workspace Documentation

Welcome to the RiggerConnect workspace documentation repository. This repository
contains comprehensive documentation, guides, and resources for the
RiggerConnect platform.

## 🌐 Live Site

Visit our GitHub Pages site:
**[tiation.github.io/tiation-rigger-workspace-docs](https://tiation.github.io/tiation-rigger-workspace-docs)**

## 📁 Repository Structure

```
tiation-rigger-workspace-docs/
├── index.html              # Main landing page
├── getting-started.html    # Getting started guide
├── api-reference.html      # API documentation
├── architecture.html       # System architecture
├── dependencies.html       # Dependency management
├── styles.css             # Site styling
├── script.js              # Interactive features
├── .github/
│   └── workflows/
│       └── deploy-pages.yml # GitHub Pages deployment
├── docs/                  # Additional documentation
└── README.md             # This file
```

## 🔗 Related Repositories

The RiggerConnect platform consists of the following repositories:

### Core Applications

- **[tiation-rigger-automation-server](https://github.com/tiation/tiation-rigger-automation-server)** -
  Backend API server
- **[tiation-rigger-mobile-app](https://github.com/tiation/tiation-rigger-mobile-app)** -
  React Native mobile application
- **[tiation-rigger-connect-app](https://github.com/tiation/tiation-rigger-connect-app)** -
  Web application for riggers
- **[tiation-rigger-jobs-app](https://github.com/tiation/tiation-rigger-jobs-app)** -
  Employer job posting application

### Supporting Services

- **[tiation-rigger-metrics-dashboard](https://github.com/tiation/tiation-rigger-metrics-dashboard)** -
  Analytics and reporting
- **[tiation-rigger-shared-libraries](https://github.com/tiation/tiation-rigger-shared-libraries)** -
  Shared utilities and types
- **[tiation-rigger-infrastructure](https://github.com/tiation/tiation-rigger-infrastructure)** -
  Infrastructure as Code

## 🚀 Quick Start

### Prerequisites

- Node.js (v18 or higher)
- Git
- Modern web browser
- Docker & Docker Compose (for unified development environment)

### Option 1: Docker Development Environment (Recommended)

**🐋 Enterprise-grade unified development environment with dark neon theme**

```bash
# One-command setup
./scripts/setup-dev-env.sh

# Access services:
# 📖 Documentation: http://localhost:3000
# 🔗 API Server: http://localhost:8080
# 📊 Monitoring: http://localhost:9090
# 📈 Analytics: http://localhost:3001
```

**Features:**

- 🎨 Dark neon theme across all services
- 🔄 Hot reloading and file watching
- 📊 Comprehensive monitoring with Prometheus & Grafana
- 🗄️ PostgreSQL database with sample data
- 💾 Redis cache and session management
- 🔐 Enterprise-grade security and rate limiting
- 🛠️ Complete development toolchain

👉 **[Full Docker Environment Guide](DOCKER_ENVIRONMENT.md)**

### Option 2: Local Development

1. Clone this repository:

   ```bash
   git clone https://github.com/tiation/tiation-rigger-workspace-docs.git
   cd tiation-rigger-workspace-docs
   ```

2. Open `index.html` in your browser or use a local server:

   ```bash
   # Using Python
   python -m http.server 8000

   # Using Node.js
   npx http-server
   ```

3. Navigate to `http://localhost:8000` to view the site

### Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/new-documentation`
3. Make your changes
4. Commit your changes: `git commit -m 'Add new documentation'`
5. Push to the branch: `git push origin feature/new-documentation`
6. Submit a pull request

## 📚 Documentation Sections

### 🏁 Getting Started

Complete setup guide for developers including:

- Prerequisites and installation
- Environment configuration
- Development workflow
- Testing and deployment

### 🔧 API Reference

Comprehensive API documentation with:

- Endpoint descriptions
- Request/response examples
- Authentication methods
- Error handling

### 🏗️ Architecture

System architecture documentation covering:

- Component overview
- Data flow diagrams
- Technology stack
- Design patterns

### 🔗 Dependencies

Cross-repository dependency management:

- Dependency relationships
- Version management
- Integration testing
- Release coordination

## 🛠️ Technology Stack

- **Frontend**: HTML5, CSS3, JavaScript (ES6+)
- **Styling**: Custom CSS with Flexbox/Grid
- **Fonts**: Inter (Google Fonts)
- **Deployment**: GitHub Pages
- **CI/CD**: GitHub Actions

## 📝 Features

- **Responsive Design**: Works on desktop, tablet, and mobile
- **Interactive Navigation**: Smooth scrolling and animations
- **Search Functionality**: Easy navigation through documentation
- **Live Repository Links**: Direct links to all related repositories
- **Comprehensive Guides**: Step-by-step instructions for setup and usage

## 🔄 Deployment

The site is automatically deployed to GitHub Pages using GitHub Actions:

1. Push changes to the `main` branch
2. GitHub Actions workflow triggers
3. Site builds and deploys automatically
4. Changes are live within minutes

## 📊 Analytics

The site includes basic analytics to track:

- Page views and user engagement
- Popular documentation sections
- User navigation patterns

## 🐛 Issues and Support

- **Bug Reports**:
  [GitHub Issues](https://github.com/tiation/tiation-rigger-workspace-docs/issues)
- **Feature Requests**:
  [GitHub Discussions](https://github.com/tiation/tiation-rigger-workspace-docs/discussions)
- **Wiki**:
  [Project Wiki](https://github.com/tiation/tiation-rigger-workspace-docs/wiki)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file
for details.

## 🤝 Contributing

We welcome contributions! Please read our [Contributing Guide](CONTRIBUTING.md)
for details on:

- Code of conduct
- Development process
- Pull request process
- Issue reporting

## 🔗 Links

- **GitHub Organization**: [tiation](https://github.com/tiation)
- **Main Repository**:
  [tiation-rigger-workspace](https://github.com/tiation/tiation-rigger-workspace)
- **Documentation Site**:
  [tiation.github.io/tiation-rigger-workspace-docs](https://tiation.github.io/tiation-rigger-workspace-docs)

---

**RiggerConnect** - Professional rigging management platform connecting riggers
with opportunities.

Built with ❤️ by the [Tiation](https://github.com/tiation) team.
