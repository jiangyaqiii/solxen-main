##删除上一个会话
screen -X -S solxen quit

SOLXEN_DIR="$HOME/solxen"
SOLXEN_FILE="$SOLXEN_DIR/solxen-tx.yaml"
# 更新 solxen-tx.yaml 文件
sed -i "s|Mnemonic:.*|Mnemonic: \"$mnemonic\"|" $SOLXEN_FILE
sed -i "s|Num:.*|Num: $num|" $SOLXEN_FILE
sed -i "s|Fee:.*|Fee: $fee|" $SOLXEN_FILE
sed -i "s|Time:.*|Time: $time|" $SOLXEN_FILE
sed -i "s|Url:.*|Url: $url|" $SOLXEN_FILE
sed -i "s|evm:.*|evm: $url|" $SOLXEN_FILE

# 清理临时目录
cd ~
rm -rf $TMP_DIR

# 启动 screen 会话并运行命令
cd solxen
screen -dmS solxen bash -c './solxen-tx miner'

cd ~
rm -f restart.sh
