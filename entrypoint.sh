#!/bin/sh

function required () {
    eval v="\$$1";

    if [ -z "$v" ]; then
        echo "$1 envvar is not configured, exiting..."
        exit 0;
    else
        [ ! -z "${ENTRYPOINT_DEBUG}" ] && echo "Rewriting required variable '$1' in file '$2'"
        sed -i "s~{{ $1 }}~$v~g" $2
    fi
}

function optional () {
    eval v="\$$1";

    [ ! -z "${ENTRYPOINT_DEBUG}" ] && echo "Rewriting optional variable '$1' in file '$2'"
    sed -i "s~{{ $1 }}~$v~g" $2
}

echo "ClamAV Version: $(clamscan --version)"

for file in $(find /etc/clamav -type f); do
    required CLAMAV_PORT ${file}
done

# Bootstrap the database if clamav is running for the first time
[ -f /data/main.cvd ] || freshclam --stdout

# Run the update daemon
freshclam -d -c 6

echo "Run command '$@'..."
exec $@
