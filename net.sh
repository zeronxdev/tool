#!/bin/bash
bytes_to_mbps() {
    awk -v bytes="$1" 'BEGIN { printf "%.2f\n", bytes * 8 / 1000000 }'
}
while true; do
    RX1=$(cat /sys/class/net/eth0/statistics/rx_bytes)
    TX1=$(cat /sys/class/net/eth0/statistics/tx_bytes)
    sleep 1
    RX2=$(cat /sys/class/net/eth0/statistics/rx_bytes)
    TX2=$(cat /sys/class/net/eth0/statistics/tx_bytes)
    RX_SPEED=$(bytes_to_mbps $(($RX2 - $RX1)))
    TX_SPEED=$(bytes_to_mbps $(($TX2 - $TX1)))
    echo "IN: $RX_SPEED Mbps | OUT: $TX_SPEED Mbps"
done
