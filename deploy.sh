set -euopipefail

RC_DIR="$(cd "$(dirname "$0")" && pwd)"
DEST_DIR="/var/www/html"

rsync -av --delete --chmod=Du=rwx,Dgo=rx,Fu=rw,Fgo=r "$SRC_DIR/" "$DEST_DIR/"
systemctl reload nginx || systemctl restart nginx
echo "Deploy OK → http://127.0.0.1:8080"
