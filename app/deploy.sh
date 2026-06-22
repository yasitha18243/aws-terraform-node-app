#!/bin/bash
set -e   # stop immediately if any command fails

echo "Starting deployment at $(date)"

# Download latest app code from S3
aws s3 cp s3://${APP_BUCKET_NAME}/app/server.js /app/server.js
aws s3 cp s3://${APP_BUCKET_NAME}/app/package.json /app/package.json

# Install dependencies
cd /app
npm install

# Stop any previous running instance (ignore error if not running yet)
pkill -f "node server.js" || true
sleep 2

# Start the app in the background, logging output to a file
nohup node server.js > /app/app.log 2>&1 &

echo "Deployment finished at $(date)"