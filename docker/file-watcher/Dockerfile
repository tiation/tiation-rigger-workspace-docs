# File Watcher for Tiation Rigger Development Environment
# Provides hot reloading capabilities for the documentation site
FROM node:18-alpine

# Install file watching tools
RUN apk add --no-cache \
    inotify-tools \
    bash \
    curl \
    jq

# Set working directory
WORKDIR /workspace

# Install global packages for file watching
RUN npm install -g \
    chokidar-cli \
    nodemon \
    browser-sync \
    live-server

# Create watcher script
RUN cat > /usr/local/bin/watch-files.sh << 'EOF'
#!/bin/bash

# File watcher script for Tiation Rigger Documentation
# Watches for changes and triggers appropriate actions

WATCH_PATHS=${WATCH_PATHS:-/workspace}
IGNORE_PATTERNS=${IGNORE_PATTERNS:-node_modules,*.git*,.DS_Store}
DOCS_SERVER_URL=${DOCS_SERVER_URL:-http://docs-server:80}

echo "🔍 Starting file watcher for Tiation Rigger Documentation"
echo "📁 Watching paths: $WATCH_PATHS"
echo "🚫 Ignoring patterns: $IGNORE_PATTERNS"
echo "🌐 Docs server URL: $DOCS_SERVER_URL"

# Function to reload the documentation server
reload_docs() {
    echo "📄 Documentation files changed, reloading..."
    curl -X POST "$DOCS_SERVER_URL/reload" 2>/dev/null || echo "⚠️  Could not reload docs server"
}

# Function to restart API server
restart_api() {
    echo "🔄 API files changed, restarting..."
    curl -X POST "http://api-server:8080/restart" 2>/dev/null || echo "⚠️  Could not restart API server"
}

# Function to handle CSS changes
handle_css_change() {
    echo "🎨 CSS files changed, applying dark neon theme updates..."
    reload_docs
}

# Function to handle JavaScript changes
handle_js_change() {
    echo "⚡ JavaScript files changed, reloading..."
    reload_docs
}

# Function to handle HTML changes
handle_html_change() {
    echo "📝 HTML files changed, reloading..."
    reload_docs
}

# Start file watching with chokidar
chokidar "$WATCH_PATHS/**/*" \
    --ignore "**/node_modules/**" \
    --ignore "**/.git/**" \
    --ignore "**/.DS_Store" \
    --ignore "**/docker/**" \
    --ignore "**/dist/**" \
    --ignore "**/build/**" \
    --initial \
    --verbose | while read -r line; do
    
    # Extract file path from chokidar output
    file_path=$(echo "$line" | grep -o '/.*' | head -1)
    
    if [[ -n "$file_path" ]]; then
        extension="${file_path##*.}"
        
        case "$extension" in
            css)
                handle_css_change "$file_path"
                ;;
            js)
                handle_js_change "$file_path"
                ;;
            html|htm)
                handle_html_change "$file_path"
                ;;
            md)
                echo "📚 Markdown file changed: $file_path"
                reload_docs
                ;;
            json)
                echo "📋 JSON file changed: $file_path"
                reload_docs
                ;;
            *)
                echo "📄 File changed: $file_path"
                ;;
        esac
    fi
done
EOF

# Make the script executable
RUN chmod +x /usr/local/bin/watch-files.sh

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD pgrep -f "chokidar" || exit 1

# Start the file watcher
CMD ["/usr/local/bin/watch-files.sh"]
