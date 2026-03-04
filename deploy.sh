#!/bin/bash
set -e

TEMPLATE_NAME="sample_site"
SOURCE_DIR="website-templates/$TEMPLATE_NAME"
DEST_DIR="/var/www/html"
DEST_DIR="/var/www/html"

# Create web root if not exists
if [ ! -d "$DEST_DIR" ]; then
  sudo mkdir -p $DEST_DIR
fi

echo "=== Deployment Started ==="

# Update system
sudo apt update -y

# Install nginx if not installed
if ! command -v nginx &> /dev/null
then
  echo "Installing Nginx..."
  sudo apt install nginx -y
fi

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo "ERROR: Template directory $SOURCE_DIR not found!"
  exit 1
fi

# Clean old website
sudo rm -rf $DEST_DIR/*

# Copy new website
sudo cp -r $SOURCE_DIR/* $DEST_DIR/

# Restart nginx
sudo systemctl restart nginx

echo "=== Deployment Completed Successfully ==="
echo "Template deployed: $TEMPLATE_NAME"
