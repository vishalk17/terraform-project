sudo apt-get update -y
sudo apt-get install apache2 -y
sleep 60s
sudo touch /var/www/html/index.html
sudo bash -c 'echo "hello vishal this is server 1" > /var/www/html/index.html'