
# mysql docker container name
MYSQL_CONTAINER_NAME=lion-mysql

# mysql root password
MYSQL_ROOT_PW=password


echo "/////////////////////"
echo "apt-get update..."
echo "/////////////////////"

sudo apt-get update -y

echo "/////////////////////"
echo "apt-get update done!"
echo "/////////////////////"

echo "/////////////////////"
echo "install libraries..."
echo "/////////////////////"

sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y

echo "/////////////////////"
echo "install done!"
echo "/////////////////////"

echo "////////////////////"
echo "registry key"
echo "////////////////////"

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


sudo apt-get update -y

sudo apt-get install docker-ce docker-ce-cli containerd.io -y

sudo docker run -d --name $MYSQL_CONTAINER_NAME -p 3306:3306 -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PW mysql


