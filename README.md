# n8n on Railway — Build Container

This repo builds the Docker image that Railway deploys for our n8n instance
(`n8n.ahimsa.is`, project `n8n` / `b84523da-b185-45f5-bcc2-bcba41ba988f`).

## What this image is

A thin wrapper that pins a specific version of the upstream `n8nio/n8n` image.
Railway watches `main` and rebuilds on every push.

## Upgrading n8n

1. Pick a target version from <https://github.com/n8n-io/n8n/releases>.
   Read the release notes and any breaking-changes notice.
2. Update the `FROM` line in `Dockerfile`:

   ```dockerfile
   FROM n8nio/n8n:<new-version>
   ```

3. Open a PR. Railway builds a preview deploy on the PR.
4. After merge, watch the production rollout:

   ```bash
   railway logs --service Worker --deployment   # build/deploy logs
   curl -fsS https://n8n.ahimsa.is/healthz       # should return {"status":"ok"}
   ```

5. Smoke-test critical workflows (manual trigger of at least one webhook + one
   scheduled workflow) before walking away.

## Rollback

`Railway dashboard → Service → Deployments → previous successful → "Redeploy"`,
or revert the PR and push.

## Why we pin (never `:latest`)

Past incident (2026-05-25): the image rebuilt automatically because Railway’s
build cache invalidated, picked up a newer `n8n:latest`, and a stale
post-install step (`npm install @n8n/n8n-nodes-langchain`) duplicated a
dependency that newer n8n versions ship in the base image. Workflows started
failing.

Pinning the tag means a rebuild produces a deterministic image regardless of
when Railway decides to build it.

## Database

The `Postgres` service in the same Railway project holds n8n’s state. Daily
backups land in DigitalOcean Spaces (`do-spaces:openclaw-servers/n8n/`) — see
Athena’s runbook in Cortex.
