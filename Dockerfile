FROM node:20-alpine

WORKDIR /app

# Install dependencies first (cached layer)
COPY package.json package-lock.json ./
RUN npm ci --omit=dev

# Copy application code
COPY server.js ./
COPY db/ ./db/
COPY routes/ ./routes/
COPY middleware/ ./middleware/
COPY services/ ./services/
COPY public/ ./public/

# Seed the database
RUN node db/seed.js

EXPOSE 4000

ENV NODE_ENV=production
ENV PORT=4000

CMD ["node", "server.js"]
