FROM python:3.11-slim

WORKDIR /app

# Install dependencies
RUN pip install --no-cache-dir \
    fastapi==0.115.0 \
    uvicorn[standard]==0.32.0 \
    pika==1.3.2 \
    pydantic==2.10.0 \
    python-dotenv==1.0.1 \
    google-api-python-client==2.149.0 \
    google-auth-httplib2==0.2.0 \
    google-auth-oauthlib==1.2.1 \
    requests==2.32.3 \
    pandas==2.2.2 \
    openpyxl==3.1.5

# Copy application
COPY . .

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD python -c "import requests; requests.get('http://localhost:8080/health')"

# Run application
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8080"]
