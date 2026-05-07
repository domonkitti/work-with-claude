# Docker

The app and API are intentionally separate. Build and deploy each folder on its
own server.

For local development, start the API first, then start the app in another
terminal. The app calls `http://localhost:8080/api/v1` by default, so the API
must be running or the browser will show `ERR_CONNECTION_REFUSED`.

## App only

From `budget-app`:

```bash
cd budget-app
docker compose up --build
```

The app listens on http://localhost:3000.

Set the API URL when building the app image:

```bash
NEXT_PUBLIC_API_URL=https://api.example.com/api/v1 docker compose up --build
```

For local development, the default API URL is `http://localhost:8080/api/v1`.

## API only

From `budget-app-api`:

```bash
docker compose up --build
```

This starts:

- API: http://localhost:8080
- Health: http://localhost:8080/health
- Local Postgres: localhost:5433

The local Postgres service is only for development. In deployment, run the API
Dockerfile by itself and provide the managed database values as environment
variables:

```bash
DB_HOST=your-db-host
DB_PORT=5432
DB_USER=your-db-user
DB_PASSWORD=your-db-password
DB_NAME=your-db-name
PORT=8080
```

The API image does not contain or start Postgres; only the API compose file does.
