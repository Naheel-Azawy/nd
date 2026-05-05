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
    cd /tmp                                             &&
        git clone https://github.com/Naheel-Azawy/nd    &&
        cd nd                                           &&
        make install                                    &&
        /opt/nd/nd --override init-system base base-gui &&
        sudo -u $user /opt/nd/nd --override init-user base base-gui
fi
