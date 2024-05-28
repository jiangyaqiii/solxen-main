
sh -c "$(curl -sSfL https://release.solana.com/v1.18.12/install)"
export PATH="/home/ubuntu/.local/share/solana/install/active_release/bin:$PATH"
solana --version

# 安装nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
##导入nvm环境
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
##安装nvm 20
nvm install 20
# 验证安装
node -v # should print `v20.13.1`
npm -v # should print `10.5.2`
# 查看当前所处环境
# solana config get

solana config set -u http://69.10.34.226:8899
solana config set -u mainnet-beta

##新建钱包
solana-keygen new --no-passphrase -o ~/.config/solana/id0.json

##切换至第一个钱包
solana config set -k id0.json

# 获得主网代码
cd ~
git clone https://github.com/FairCrypto/sol-xen.git
cd sol-xen/
git checkout epsilon
npm i
npm i -g tsx

# 配置环境文件
echo "USER_WALLET=/root/.config/solana
ANCHOR_PROVIDER_URL=https://45.250.254.197:8899
PROGRAM_ID=Dx7zjkWZbUStmhjo8BrhbprtQCcMByJgCTEC6TLgkH8n
PROGRAM_ID_MINTER=8HTvrqZT1JP279DMLT5SfNfGHxUeznem48h7zy92sWWx" > .env


# 有问题
node ./client/multiminer.js mine --address 0x9C963258278DB2ccdc07A7F68d080D8333EFe084 -f 500000 -d 1 -a100


sudo apt install jq
bash utils/block_scanner.sh
