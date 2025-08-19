# Backend Dockerfile
FROM node:18-alpine AS base
WORKDIR /app

# Install dependencies first (better layer caching)
COPY package*.json ./
RUN npm ci --omit=dev

# Copy source
COPY server.js ./

# Expose the port used by Express
EXPOSE 3000

# Run the app
ENV NODE_ENV=production
CMD ["node", "server.js"]
