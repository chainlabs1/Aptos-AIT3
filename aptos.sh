#!/bin/bash
echo -e ''
echo -e '\e[0;36m'
echo -e '___________                                                                                                  '
echo -e ' _________/ ___       __  ___________  ___   ______   ____  ___        ___________  __________   ___________ '
echo -e ' |          |  |     |  | |   ___   |  |  |  |     \  |  |  |  |       |   ___   |  |   ___   \  |  |_______|' 
echo -e ' |          |  |_____|  | |  |   |  |  |  |  |  |\  \ |  |  |  |       |  |   |  |  |  |___|  |  |  |_______ '
echo -e ' |          |  |_____|  | |  |___|  |  |  |  |  | \  \|  |  |  |       |  |___|  |  |  |___|  |  |_______   |' 
echo -e ' |________  |  |     |  | |  |___|  |  |  |  |  | \  \|  |  |  |_____  |  |___|  |  |  |___|  |   _______|  |'
echo -e '__________/ |__|     |__| |__|   |__|  |__|  |__|  \_____|  |________| |__|   |__|  |__|___|__/  |_______|__|'
echo -e '\e[0m'
echo -e ''
GREEN="\e[32m"
NC="\e[0m"
RED='\033[0;31m'
YELLOW='\033[1;33m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'

dependencies () {
    echo -e ''
    echo -e ${YELLOW}'Wait for update & upgrade...\e[0m'${NC} && sleep 3
    echo -e ''
    sudo apt-get update && sudo apt install curl wget zip unzip -y
    echo -e ''
    echo -e ${YELLOW}'İnstalling Docker & Docker compose...\e[0m'${NC} && sleep 3
    echo -e ''
    curl -s https://api.testnet.run/docker.sh | bash -s --
    echo -e ''
}

cli () {
    cd $HOME && mkdir aptos && cd aptos
    echo -e ${YELLOW}'İnstalling Aptos CLI...\e[0m'${NC} && sleep 4
    echo -e ''
    wget -q https://github.com/aptos-labs/aptos-core/releases/download/aptos-cli-v0.3.1/aptos-cli-0.3.1-Ubuntu-x86_64.zip
    sudo unzip aptos-cli-0.3.1-Ubuntu-x86_64.zip 
    sudo mv aptos /usr/bin
    echo -e ''
    aptos --version
    echo -e ''
}

binaries () {
    if [ ! $USERNAME ]; then
        read -p ' Enter your node name: ' USERNAME
        echo 'export USERNAME='$USERNAME >> $HOME/.bash_profile
    fi
    . $HOME/.bash_profile
    wget -q https://raw.githubusercontent.com/aptos-labs/aptos-core/main/docker/compose/aptos-node/docker-compose.yaml
    wget -q https://raw.githubusercontent.com/aptos-labs/aptos-core/main/docker/compose/aptos-node/validator.yaml
}

keys_conf () {
    aptos genesis generate-keys --output-dir $HOME/aptos/keys
    EXTERNAL=$(curl -s -4 ifconfig.co)
    aptos genesis set-validator-configuration \
    --local-repository-dir $HOME/aptos \
    --username $USERNAME \
    --owner-public-identity-file $HOME/aptos/keys/public-keys.yaml \
    --validator-host $EXTERNAL:6180 \
    --stake-amount 100000000000000
    sleep 2
    aptos genesis generate-layout-template --output-file $HOME/aptos/layout.yaml
    sudo tee $HOME/aptos/layout.yaml > /dev/null <<EOF 
root_key: "D04470F43AB6AEAA4EB616B72128881EEF77346F2075FFE68E14BA7DEBD8095E"
users: ["$USERNAME"]
chain_id: 43
allow_new_validators: false
epoch_duration_secs: 7200
is_test: true
min_stake: 100000000000000
min_voting_threshold: 100000000000000
max_stake: 100000000000000000
recurring_lockup_duration_secs: 86400
required_proposer_stake: 100000000000000
rewards_apy_percentage: 10
voting_duration_secs: 43200
voting_power_increase_limit: 20
EOF
    wget -q https://github.com/aptos-labs/aptos-core/releases/download/aptos-framework-v0.3.0/framework.mrb -P $HOME/aptos
    aptos genesis generate-genesis --local-repository-dir $HOME/aptos --output-dir $HOME/aptos
    docker-compose up -d
    timeout 5s docker-compose -f $HOME/aptos/docker-compose.yaml logs -f --tail 10
}

info () {
    echo -e ''
    echo -e "#################################################################"
    LOG_SEE="docker-compose -f $HOME/aptos/docker-compose.yaml logs -f --tail 10"
    EXTIP=$(curl -s -4 ifconfig.co)
    echo -e "Check logs: ${YELLOW}$LOG_SEE${NC}"
    echo -e "Here is your external IP: ${YELLOW}$EXTIP${NC}"
    echo -e "#################################################################"
    echo -e ''
}

PS3="What do you want?: "
select opt in Install Update Additional quit; 
do

  case $opt in
    Install)
    echo -e '\e[1;32mThe installation process begins...\e[0m'
    sleep 1
    dependencies
    cli
    binaries
    keys_conf
    info
    sleep 3
      break
      ;;
    Update)
    echo -e '\e[1;32mThe updating process begins...\e[0m'
    echo -e ''
    echo -e '\e[1;32mSoon...'
    info
    sleep 1
      break
      ;;
    Additional)
    info
      ;;
    quit)
    echo -e '\e[1;32mexit...\e[0m' && sleep 1
      break
      ;;
    *) 
      echo "Invalid $REPLY"
      ;;
  esac
done
