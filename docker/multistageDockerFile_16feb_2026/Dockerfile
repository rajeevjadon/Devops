# ---------- Stage 1: Build ----------
FROM node:16.20.2-alpine AS builder

# Git install karna padega
RUN apk add --no-cache git

WORKDIR /app

# Clone repo inside container
RUN git clone https://github.com/devopsinsiders/ReactTodoUIMonolith.git .

# Install dependencies
RUN npm install

# Build React app
RUN npm run build


# ---------- Stage 2: Production ----------
FROM nginx:alpine

# Remove default nginx files
RUN rm -rf /usr/share/nginx/html/*

# Copy build files from builder stage
COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
