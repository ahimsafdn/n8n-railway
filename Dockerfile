# Pin n8n base image — never use floating `:latest` here, see PR #fix/remove-redundant-langchain-install.
# When upgrading, bump this tag deliberately and smoke-test workflows.
FROM n8nio/n8n:2.21.7
