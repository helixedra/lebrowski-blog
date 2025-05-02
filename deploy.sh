#!/bin/bash

set -e

echo "🔄 Pulling latest code..."
git -C /var/www/lebrowski.blog pull origin main

echo "📦 Installing deps..."
cd /var/www/lebrowski.blog
npm ci

echo "🔨 Building Astro..."
npm run build

echo "✅ Deployment complete."
