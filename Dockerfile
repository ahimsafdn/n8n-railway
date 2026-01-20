FROM n8nio/n8n:latest

USER root
ENV CI=true
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm init -y && \
    npm install @n8n/n8n-nodes-langchain && \
    chown -R node:node /home/node/.n8n
USER node
