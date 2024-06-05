#!/bin/bash

# 检查是否以root用户运行脚本
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要以root用户权限运行。"
    echo "请尝试使用 'sudo -i' 命令切换到root用户，然后再次运行此脚本。"
    exit 1
fi

function install_node() {

# 获取操作系统类型和架构
OS=$(uname -s)
ARCH=$(uname -m)

# 确定下载 URL
case "$OS" in
  "Darwin")
    if [ "$ARCH" = "x86_64" ]; then
      URL="https://github.com/mmc-98/solxen-tx/releases/download/mainnet-beta5/solxen-tx-mainnet-beta5-darwin-amd64.tar.gz"
    elif [ "$ARCH" = "arm64" ]; then
      URL="https://github.com/mmc-98/solxen-tx/releases/download/mainnet-beta5/solxen-tx-mainnet-beta5-darwin-arm64.tar.gz"
    else
      echo "不支持的架构: $ARCH"
      exit 1
    fi
    ;;
  "Linux")
    if [ "$ARCH" = "x86_64" ]; then
      URL="https://github.com/mmc-98/solxen-tx/releases/download/mainnet-beta5/solxen-tx-mainnet-beta5-linux-amd64.tar.gz"
    elif [ "$ARCH" = "aarch64" ]; then
      URL="https://github.com/mmc-98/solxen-tx/releases/download/mainnet-beta5/solxen-tx-mainnet-beta5-linux-arm64.tar.gz"
    else
      echo "不支持的架构: $ARCH"
      exit 1
    fi
    ;;
  *)
    echo "无法支持的系统: $OS"
    exit 1
    ;;
esac

# 创建临时目录并下载文件
TMP_DIR=$(mktemp -d)
cd $TMP_DIR
echo "下载对应文件 $URL..."
curl -L -o solxen-tx.tar.gz $URL

# 创建用户主目录的 solxen 文件夹
SOLXEN_DIR="$HOME/solxen"
mkdir -p $SOLXEN_DIR

# 解压缩文件
echo "解压文件中 solxen-tx.tar.gz..."
tar -xzvf solxen-tx.tar.gz -C $SOLXEN_DIR

# 检查文件是否存在
SOLXEN_FILE="$SOLXEN_DIR/solxen-tx.yaml"
if [ ! -f $SOLXEN_FILE ]; then
  echo "Error: $SOLXEN_FILE 不存在。"
  exit 1
fi

# read -p "请输入SOL钱包助记词: " mnemonic
# read -p "请输入同时运行的钱包数量，建议输入4: " num
# read -p "请输入优先级费用: " fee
# read -p "请输入间隔时间(毫秒): " time
# read -p "请输入sol rpc地址: " url
# read -p "请输入空投接收地址，需要ETH钱包地址: " evm


# 更新 solxen-tx.yaml 文件
sed -i "s|Mnemonic:.*|Mnemonic: \"$mnemonic\"|" $SOLXEN_FILE
sed -i "s|Num:.*|Num: $num|" $SOLXEN_FILE
sed -i "s|Fee:.*|Fee: $fee|" $SOLXEN_FILE
sed -i "s|Time:.*|Time: $time|" $SOLXEN_FILE
sed -i "s|ToAddr:.*|ToAddr: $evm|" $SOLXEN_FILE
sed -i "s|Url:.*|Url: $url|" $SOLXEN_FILE

# 清理临时目录
cd ~
rm -rf $TMP_DIR

# ================================================================================================================================
# 启动 screen 会话并运行命令
cd ~
#监控screen脚本
echo '#!/bin/bash
while true
do
    if ! screen -list | grep -q "solxen"; then
        echo "Screen session not found, restarting..."
        cd /root/solxen
        screen -dmS solxen bash -c './solxen-tx miner'
    fi
    sleep 10  # 每隔10秒检查一次
done' > monit.sh
##给予执行权限
chmod +x monit.sh
# ================================================================================================================================
echo '[Unit]
Description=Quili Monitor Service
After=network.target

[Service]
Type=simple
ExecStart=/bin/bash /root/monit.sh

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/solxen_monitor.service
sudo systemctl daemon-reload
sudo systemctl enable solxen_monitor.service
sudo systemctl start solxen_monitor.service
sudo systemctl status solxen_monitor.service
# ================================================================================================================================
}
install_node
cd ~
rm -f start.sh
