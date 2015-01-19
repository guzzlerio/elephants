#!/bin/bash

usage() {
    if [ "$1" ]; then
        echo "--------------------------------------------------"
        echo $1
    fi
    echo "--------------------------------------------------"
    echo "Usage: $0 list|create|delete [name|id]"
    echo
    echo "Examples:"
    echo "  Create: $0 create myname"
    echo "  Delete: $0 delete 1234"
    exit
}

list() {
    if hash jq 2>/dev/null; then
        http --body https://api.digitalocean.com/v2/droplets "Authorization: Bearer $DIGITAL_OCEAN_TOKEN" | jq '.droplets[] | {id, name, image: .image.slug, ip: .networks.v4[].ip_address, region: .region.slug, size: .size_slug}'
    else
        http --body https://api.digitalocean.com/v2/droplets "Authorization: Bearer $DIGITAL_OCEAN_TOKEN"
        echo
        echo "If you had jq installed (http://stedolan.github.io/jq/) this output would have been filtered for brevity..."
    fi
}

create() {
    if [ $# -lt 1 ]; then
        usage "You must specify the name of the droplet to create"
    fi
    http POST https://api.digitalocean.com/v2/droplets "Authorization: Bearer $DIGITAL_OCEAN_TOKEN" name=$1 region=lon1 size=512mb image=ubuntu-14-04-x64 ipv6=false
}

delete() {
    if [ $# -lt 1 ]; then
        usage "You must specify the ID of the droplet to delete"
    fi
    http DELETE https://api.digitalocean.com/v2/droplets/$1 "Authorization: Bearer $DIGITAL_OCEAN_TOKEN"
}

# switch on $1 - sh script delete <id>

case "$1" in
    list) list
        ;;
    create) create $2
        ;;
    delete) delete $2
        ;;
    *) usage
        ;;
esac
