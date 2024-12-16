# !/bin/bash
source ./utils/logger.sh
recordMemory(){
    usedMemorySpace=$(free | grep -i "mem" | awk '{print $3}')
    log "INFO" "$usedMemorySpace" "MEMORY"
}