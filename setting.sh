
# mysql docker container name
MYSQL_CONTAINER_NAME=lion-mysql

# mysql root password
MYSQL_ROOT_PW=password

# crontab deploy scripts
CRONTAB_ADD_LIST=mutsasns.sh


echo "apt-get update..."

sudo apt-get update -y

echo "apt-get update done!"

echo "install libraries..."

sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y

echo "install done!"

echo "registry key"

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


echo "apt-get update..."

sudo apt-get update -y

echo "apt-get update done!"

echo "Docker install..."

sudo apt-get install docker-ce docker-ce-cli containerd.io -y

echo "Docker install done!"

echo "MySQL Run..."

sudo docker run -d --name $MYSQL_CONTAINER_NAME -p 3306:3306 -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PW mysql

echo "MySQL Done!"

for SCRIPT in $CRONTAB_ADD_LIST
do
  cat <(crontab -l) <(echo "* * * * * /home/ubuntu/deploy/$SCRIPT") | crontab -
done
