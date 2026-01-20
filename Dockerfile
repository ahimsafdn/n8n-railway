FROM n8nio/n8n:latest

USER root
RUN cd /usr/local/lib/node_modules/n8n && \
    pnpm config set store-dir /root/.local/share/pnpm/store/v10 --global && \
    pnpm install && \
    pnpm add @n8n/n8n-nodes-langchain
USER node
