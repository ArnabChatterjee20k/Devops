source ./utils/logger.sh
source ./tools/disk.sh
source ./tools/memory.sh

createLogFile
interval=${1:-2}
while true; do
    # running them in background and waiting for both of them to execute
    recordDisk &
    recordMemory &
    wait
    sleep "$interval"
done