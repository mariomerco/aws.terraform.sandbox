#! /bin/bash
sudo amazon-linux-extras install -y nginx1
sudo service nginx start
sudo rm /usr/share/nginx/html/index.html
echo '<html><head><title>Testing Terraform</title></head><body><h1>You definitely know Terraform!</h1></body></html>' | sudo tee /usr/share/nginx/html/index.html
