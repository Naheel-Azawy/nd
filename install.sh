#!/bin/sh

DOCKER_CMD=docker

if [ "$1" = '--docker' ]; then
    IMG='arch-naheel'
    if $DOCKER_CMD images | cut -d ' ' -f 1 | grep "$IMG" -q; then
        echo "Image '$IMG' already exist"
        echo "remove with '$DOCKER_CMD rmi $IMG'"
    else
        echo "Building image ($IMG)..."
        $DOCKER_CMD build -t "$IMG" .
    fi
    echo "Running $DOCKER_CMD image..."
    $DOCKER_CMD run -it --rm "$IMG"

else
    if [ "$1" = '--nogui' ]; then
        pacs='base'
        shift
    else
        pacs='base base-gui'
    fi
    user=$1
    [ -n "$user" ] || {
        echo 'usage: install.sh [USER]' >&2
        exit 1
    }
    if [ "$(id -u)" != 0 ]; then
        echo 'Root is needed' >&2
        exit 1
    fi
    echo 'Downloading nd...'
    d=/var/cache/pacgit-repos/nd # to be managed by pacgit
    # shellcheck disable=SC2086
    git clone https://github.com/Naheel-Azawy/nd "$d"     &&
        cd "$d"                                           &&
        make install                                      &&
        /opt/nd/nd --override init-system $pacs           &&
        sudo -u "$user" /opt/nd/nd --override init-user $pacs
fi
