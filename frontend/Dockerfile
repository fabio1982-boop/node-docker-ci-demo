# Frontend Dockerfile (Nginx serving static files + proxy /api to backend)
FROM nginx:1.27-alpine

# Copy static site
COPY ./public /usr/share/nginx/html

# Replace default config to add reverse proxy for /api
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
