# !/bin/bash
source ./utils/logger.sh
recordDisk(){
    usedDiskSpace=$(df | grep "^/dev" | awk '{print $3}')
    log "INFO" "$usedDiskSpace" "DISK"
}