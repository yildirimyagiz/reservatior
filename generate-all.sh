#!/bin/bash

# Script to generate Prisma clients for all region schemas

echo "Generating Prisma clients for all regions..."

for config in prisma/*.config.ts; do
  if [ -f "$config" ]; then
    region=$(basename "$config" .config.ts | cut -d'.' -f2)
    echo "Generating for region: $region"
    bunx zenstack generate --config "$config"
  fi
done

echo "All Prisma clients generated."