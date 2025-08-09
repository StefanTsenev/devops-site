set -Eeuo pipefail

SITE_ROOT="/srv/www/devops-site"
RELEASES="$SITE_ROOT/releases"
CURRENT="$SITE_ROOT/current"

# Уникален идентификатор на релийза (GIT SHA или timestamp)
if GIT_SHA="$(git rev-parse --short HEAD 2>/dev/null)"; then
  REL_ID="$GIT_SHA"
else
  REL_ID="$(date +%Y%m%d%H%M%S)"
fi

NEW_REL="$RELEASES/$REL_ID"

mkdir -p "$NEW_REL"

# Копирай само нужните файлове
rsync -av --delete \
  --exclude='.git' \
  --exclude='.github' \
  --exclude='deploy.sh' \
  ./ "$NEW_REL/"

# Превключи симлинка (атомично)
ln -sfn "$NEW_REL" "$CURRENT"

# Релоуд на nginx (по избор)
if command -v systemctl >/dev/null 2>&1; then
  systemctl reload nginx || true
fi

echo "Deployed release: $REL_ID"
