FROM n8nio/n8n:latest

USER root
RUN cd /usr/local/lib/node_modules/n8n && pnpm add @n8n/n8n-nodes-langchain
USER node
