# !/bin/bash
source ./utils/getDate.sh

LOG_FILE="monitor.log"
createLogFile(){
    if [ -f "$LOG_FILE" ]; then
        # create logger file and do nothing
        :
    else
        touch "$LOG_FILE"
    fi
}

createLogFile

log(){
    status="$1"
    message="$2"
    type="$3"
    dateState=$(getDate)
    data="[$status][$type][$dateState] $message"
    echo -e "$data" >> $LOG_FILE;
}