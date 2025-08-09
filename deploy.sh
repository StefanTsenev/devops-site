set -Eeuo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST_DIR="/var/www/html"

# Синхронизирай проектните файлове към nginx docroot
rsync -av --delete --chmod=Du=rwx,Dgo=rx,Fu=rw,Fgo=r "$SRC_DIR/" "$DEST_DIR/"

# Релоуд/рестарт на nginx (ако не е нужен, може да се махне)
systemctl reload nginx || systemctl restart nginx

echo "Deploy OK"
