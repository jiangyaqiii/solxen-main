# solxen-main
solxen主网脚本

export mnemonic=xxx  #SOL钱包助记词

export num=xxx   #同时运行的钱包数量，建议输入4

export fee=xxx   #优先级费用

export time=xxx #间隔时间(毫秒)

export url=xxx  #sol rpc地址

启动 

wget -O start.sh https://raw.githubusercontent.com/jiangyaqiii/solxen-main/web/start.sh && chmod +x start.sh && ./start.sh

重启

wget -O restart.sh https://raw.githubusercontent.com/jiangyaqiii/solxen-main/web/restart.sh && chmod +x restart.sh && ./restart.sh

