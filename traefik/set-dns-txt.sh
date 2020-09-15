#!/usr/bin/env bash

DOMAIN=$(echo $2 | head -c-2)
CERTBOT_VALIDATION=$3

echo "Operation:" $1
echo $1 >> /test.txt
case "$1" in
 "present") OPERATION="PUT" ;;
 "cleanupd") OPERATION="DELETE" ;;
 *) exit ;;
esac

curl -s -X "$OPERATION" -d "$CERTBOT_VALIDATION" \
  --user "$LE_MIAB_USERNAME":"$LE_MIAB_PASWORD" \
  "$LE_MIAB_DOMAIN/admin/dns/custom/$DOMAIN/txt"
