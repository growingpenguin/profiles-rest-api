#!/usr/bin/env bash

set -e  # Exit immediately if any command fails

# Git repository URL
PROJECT_GIT_URL='https://github.com/growingpenguin/profiles-rest-api.git'

# Base directory where the project will be stored
PROJECT_BASE_PATH='/usr/local/apps/profiles-rest-api'

# Set Ubuntu Language
locale-gen en_GB.UTF-8 || true  # Avoid script failure if already set

# Install required dependencies
echo "Installing dependencies..."
apt-get update
apt-get install -y python3-dev python3-venv python3-pip sqlite supervisor nginx git

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

# Install Python dependencies
$PROJECT_BASE_PATH/env/bin/pip install --upgrade pip  # Upgrade pip first
$PROJECT_BASE_PATH/env/bin/pip install -r $PROJECT_BASE_PATH/requirements.txt uwsgi==2.0.21

# Run database migrations
$PROJECT_BASE_PATH/env/bin/python $PROJECT_BASE_PATH/manage.py migrate

# Configure Supervisor to run uWSGI
cp $PROJECT_BASE_PATH/deploy/supervisor_profiles_api.conf /etc/supervisor/conf.d/profiles_api.conf

# Ensure Supervisor is running before updating
systemctl restart supervisor.service
supervisorctl reread
supervisorctl update
supervisorctl restart profiles_api || true  # Avoid script failure if process does not exist yet

# Setup nginx configuration
cp $PROJECT_BASE_PATH/deploy/nginx_profiles_api.conf /etc/nginx/sites-available/profiles_api.conf

# Enable nginx configuration
rm -f /etc/nginx/sites-enabled/default
ln -sf /etc/nginx/sites-available/profiles_api.conf /etc/nginx/sites-enabled/profiles_api.conf
systemctl restart nginx.service

echo "Deployment complete! ✅"
