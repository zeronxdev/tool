#!/bin/bash
bytes_to_mbps() {
    awk -v bytes="$1" 'BEGIN { printf "%.2f\n", bytes * 8 / 1000000 }'
}

bytes_to_gbps() {
    awk -v bytes="$1" 'BEGIN { printf "%.2f\n", bytes * 8 / 1000000000 }'
}
while true; do
    RX1=$(cat /sys/class/net/eth0/statistics/rx_bytes)
    TX1=$(cat /sys/class/net/eth0/statistics/tx_bytes)
    sleep 1
    RX2=$(cat /sys/class/net/eth0/statistics/rx_bytes)
    TX2=$(cat /sys/class/net/eth0/statistics/tx_bytes)
    RX_SPEED=$(($RX2 - $RX1))
    TX_SPEED=$(($TX2 - $TX1))
    if [ $RX_SPEED -ge 125000000 ]; then
        RX_SPEED=$(bytes_to_gbps $RX_SPEED)
        RX_UNIT="Gbps"
    else
        RX_SPEED=$(bytes_to_mbps $RX_SPEED)
        RX_UNIT="Mbps"
    fi
    
    if [ $TX_SPEED -ge 125000000 ]; then
        TX_SPEED=$(bytes_to_gbps $TX_SPEED)
        TX_UNIT="Gbps"
    else
        TX_SPEED=$(bytes_to_mbps $TX_SPEED)
        TX_UNIT="Mbps"
    fi 
    echo "IN: $RX_SPEED $RX_UNIT | OUT: $TX_SPEED $TX_UNIT"
done
