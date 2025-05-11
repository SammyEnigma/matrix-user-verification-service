# Stage 1 - Build
FROM node:22.15.0-alpine as builder
WORKDIR /app
COPY package*.json ./
RUN npm install --only=production

# Stage 2 - Final Image
FROM node:22.15.0-alpine
WORKDIR /app

# Copy only necessary files
COPY --from=builder /app/node_modules ./node_modules/
COPY src/ ./src/

# Optional: Copy other required files
COPY package*.json ./
# COPY config/ ./config/
# COPY public/ ./public/

ENV UVS_LISTEN_ADDRESS=0.0.0.0
EXPOSE 3000
CMD ["npm", "start"]
