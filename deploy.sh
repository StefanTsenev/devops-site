set -Eeuo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST_DIR="/var/www/html"

# Копирай само нужните файлове на сайта
rsync -av --delete \
  --exclude='.git' \
  --exclude='.github' \
  --exclude='deploy.sh' \
  "$SRC_DIR/" "$DEST_DIR/"

echo "Deploy OK"
