
# మీ Docker Hub username ఇక్కడ పెట్టండి
NEW_USER="srinuas"   # ఉదా: srinuas లేదా మీకు నpush చేయదు)NEW_USER="srinuas"   # ఉదా: srinuas లేదా మీకు నచ్చినది
docker images --format '{{.Repository}} {{.Tag}}' \
| awk '$1 != "<none>" && $2 != "<none>" {print $1, $2}' \
| while read -r repo tag; do
  base="${repo##*/}"                      # shaikmustafa/paytm -> paytm
  src="${repo}:${tag}"                    # shaikmustafa/paytm:movie
  dst="${NEW_USER}/${base}:${tag}"        # srinuas/paytm:movie

  echo "[TAG] ${src} -> ${dst}"
  docker tag "${src}" "${dst}"
done

