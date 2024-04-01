#!/bin/bash
calculate_speed() {
    local total_rx_speed=0
    local total_tx_speed=0
    interfaces=$(ls /sys/class/net | grep -v lo)

    for interface in $interfaces; do
        rx_prev=$(cat /sys/class/net/$interface/statistics/rx_bytes)
        tx_prev=$(cat /sys/class/net/$interface/statistics/tx_bytes)
        sleep 1
        rx_now=$(cat /sys/class/net/$interface/statistics/rx_bytes)
        tx_now=$(cat /sys/class/net/$interface/statistics/tx_bytes)
        rx_speed=$((rx_now - rx_prev))
        tx_speed=$((tx_now - tx_prev))

        total_rx_speed=$((total_rx_speed + rx_speed))
        total_tx_speed=$((total_tx_speed + tx_speed))
    done
    total_rx_speed_mbps=$(echo "scale=2; $total_rx_speed * 8 / 1024 / 1024" | bc)
    total_tx_speed_mbps=$(echo "scale=2; $total_tx_speed * 8 / 1024 / 1024" | bc)

    echo "IN: $total_rx_speed_mbps Mbps | OUT: $total_tx_speed_mbps Mbps"
}
while true; do
    calculate_speed
done
