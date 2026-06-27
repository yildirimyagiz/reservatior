# FastAPI Service

This is the Orchestrator Service for the ComfyStaging application. It handles job queuing, RunPod communication, and webhook processing.

## Setup

1.  **Install Dependencies**:

    ```bash
    cd backend
    pip install -r requirements.txt
    ```

2.  **Environment Variables**:
    Create a `.env` file in the `backend` directory (see `app/core/config.py` for available options).

3.  **Run Dev Server**:
    ```bash
    python main.py
    ```
    The API will be available at `http://localhost:8000`.
    OpenAPI documentation is at `http://localhost:8000/docs`.

## Architecture

- **`main.py`**: Entry point.
- **`app/api/v1`**: API endpoints (jobs, webhooks).
- **`app/services`**: Logic for Queue and ComfyUI.
- **`app/core`**: Configuration and settings.
