#!/bin/sh
# 自定义默认配置：LAN 与 WiFi
# 以 999 开头，确保在 991_custom_settings / 992_set-wifi-uci.sh 之后执行并覆盖其设置。

board_name=$(cat /tmp/sysinfo/board_name 2>/dev/null)
case "$board_name" in
jdcloud,re-cs-02 | jdcloud,ax6600) ;;
*) exit 0 ;;
esac

# LAN 口 IP
uci set network.lan.ipaddr='192.168.10.1'
uci set network.lan.netmask='255.255.255.0'

# 仅保留 5.2G（radio2，信道 44）；关闭 5.8G（radio0，信道 149）与 2.4G（radio1，信道 1）
uci set wireless.radio0.disabled='1'
uci set wireless.radio1.disabled='1'
uci set wireless.radio2.disabled='0'
uci set wireless.default_radio2.ssid='open5'
uci set wireless.default_radio2.encryption='psk2+ccmp'
uci set wireless.default_radio2.key='1234567890'

uci commit network
uci commit wireless
exit 0
