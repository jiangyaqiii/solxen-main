echo "此为简单重启，使用现有参数"
cd solxen
screen -dmS solxen bash -c './solxen-tx miner'
echo ""
echo "重启成功"
