#!/bin/bash

# E-Bills Processing Service Startup Script

echo "🚀 Starting E-Bills Processing Service..."

# Check if Python is installed
if ! command -v python3 &> /dev/null
then
    echo "❌ Python 3 is required but not installed."
    exit 1
fi

# Check if required packages are installed
echo "📦 Checking dependencies..."
python3 -m pip install fastapi uvicorn python-multipart

# Create storage directories
echo "📁 Creating storage directories..."
mkdir -p storage/e-bills/uploads
mkdir -p storage/e-bills/processed
mkdir -p storage/e-bills/cache

# Set permissions
chmod 755 storage/e-bills
chmod 755 storage/e-bills/uploads
chmod 755 storage/e-bills/processed
chmod 755 storage/e-bills/cache

# Start the service
echo "🌐 Starting E-Bills Processing Service on port 8001..."
echo "📚 API Documentation: http://localhost:8001/docs"
echo "🔍 Health Check: http://localhost:8001/health"
echo ""

cd "$(dirname "$0")"
python3 app/e_bills.py
