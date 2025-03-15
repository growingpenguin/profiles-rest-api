#!/usr/bin/env bash

set -e  # Exit immediately if any command fails

# Git repository URL
PROJECT_GIT_URL='https://github.com/growingpenguin/profiles-rest-api.git'

# Base directory where the project will be stored
PROJECT_BASE_PATH='/usr/local/apps/profiles-rest-api'

# Set Ubuntu Language
locale-gen en_GB.UTF-8 || true  # Avoid script failure if already set

# Install system-wide dependencies (EXCLUDING supervisor)
echo "Installing system dependencies..."
apt-get update
apt-get install -y python3-dev python3-venv python3-pip sqlite nginx git

# Create project directory if it doesn't exist
mkdir -p $PROJECT_BASE_PATH

# Clone the Git repository (or pull latest changes)
if [ -d "$PROJECT_BASE_PATH/.git" ]; then
    echo "Repository already exists. Pulling latest changes..."
    cd $PROJECT_BASE_PATH
    git pull origin main
else
    echo "Cloning repository..."
    git clone $PROJECT_GIT_URL $PROJECT_BASE_PATH
fi

# Create a Python virtual environment if not already created
if [ ! -d "$PROJECT_BASE_PATH/env" ]; then
    python3 -m venv $PROJECT_BASE_PATH/env
fi

# Activate virtual environment
source $PROJECT_BASE_PATH/env/bin/activate

# Upgrade pip and install Python dependencies
pip install --upgrade pip  # Upgrade pip first
pip install -r $PROJECT_BASE_PATH/requirements.txt uwsgi==2.0.21

# Install Supervisor in the virtual environment (NOT system-wide)
pip install 'supervisor>=4.0.0,<5.0.0'

# Run database migrations
$PROJECT_BASE_PATH/env/bin/python $PROJECT_BASE_PATH/manage.py migrate

# Configure Supervisor to run uWSGI
if [ -f "$PROJECT_BASE_PATH/deploy/supervisor_profiles_api.conf" ]; then
    cp $PROJECT_BASE_PATH/deploy/supervisor_profiles_api.conf /etc/supervisor/conf.d/profiles_api.conf
else
    echo "Supervisor configuration file is missing!"
    exit 1  # Exit script if the config file is missing
fi

# Ensure Supervisor is running before updating
supervisord -c /etc/supervisor/supervisord.conf || true  # Start supervisor in the background
supervisorctl reread
supervisorctl update
supervisorctl restart profiles_api || true  # Avoid script failure if process does not exist yet

# Setup nginx configuration
if [ -f "$PROJECT_BASE_PATH/deploy/nginx_profiles_api.conf" ]; then
    cp $PROJECT_BASE_PATH/deploy/nginx_profiles_api.conf /etc/nginx/sites-available/profiles_api.conf
else
    echo "Nginx configuration file is missing!"
    exit 1  # Exit script if the config file is missing
fi

# Enable nginx configuration
rm -f /etc/nginx/sites-enabled/default
ln -sf /etc/nginx/sites-available/profiles_api.conf /etc/nginx/sites-enabled/profiles_api.conf
systemctl restart nginx.service

echo "Deployment complete! ✅"
