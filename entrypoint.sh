#!/bin/sh

# Bootstrap the database if clamav is running for the first time
[ -f /data/main.cvd ] || freshclam

# Run the update daemon
freshclam -d -c 6

echo "Run command '$@'..."
exec $@
