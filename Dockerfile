FROM nginx:alpine

# Install ngrok and other required tools
RUN apk add --no-cache wget procps

# Install ngrok
RUN wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz \
    && tar xvzf ngrok-v3-stable-linux-amd64.tgz -C /usr/local/bin \
    && rm ngrok-v3-stable-linux-amd64.tgz

# Create ngrok config directory
RUN mkdir -p /root/.ngrok2

# Copy ngrok config
COPY ngrok.yml /root/.ngrok2/ngrok.yml

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy your application files
COPY . /usr/share/nginx/html

# Copy and set permissions for startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80
EXPOSE 4040

# Start nginx and ngrok
CMD ["/start.sh"]
