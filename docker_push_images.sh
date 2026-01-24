
docker images --format "{{.Repository}}:{{.Tag}}" \
| grep "^srinuas/" \
| grep -v "<none>" \
| while read -r img; do
  echo "[PUSH] $img"
  docker push "$img"
done
