#!/bin/bash
set -e
export SSHPASS="KelAlaka@9182"
echo "Syncing server files..."
sshpass -e rsync -avz -e "ssh -o StrictHostKeyChecking=no" ./server/ root@72.61.71.6:/root/reservatior/server/ --exclude node_modules --exclude dist --exclude .env --exclude data --exclude logs --exclude .wwebjs_auth --exclude .wwebjs_cache
echo "Syncing client dist files..."
sshpass -e rsync -avz -e "ssh -o StrictHostKeyChecking=no" ./client/dist/ root@72.61.71.6:/root/reservatior/client/dist/
echo "Restarting containers on the server..."
sshpass -e ssh -o StrictHostKeyChecking=no root@72.61.71.6 "cd /root/reservatior && docker compose restart server client"
echo "Deployment successful!"
