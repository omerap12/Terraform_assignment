# compute.tf
resource "aws_instance" "example" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public-subnet[0].id
  depends_on = [ aws_elasticache_cluster.redis ]

  user_data = <<-EOF
                #!/bin/bash
                # Update and install necessary packages
                sudo yum update -y
                sudo yum install -y python3-pip

                # Install required Python packages
                sudo pip3 install requests redis

                # Get the Redis endpoint from metadata service and store it in an environment variable
                export REDIS_ENDPOINT="${data.aws_elasticache_cluster.my_cluster.cache_nodes.0.address}"
                
                # Create a Python script file
                echo '
                import requests
                import redis
                from datetime import datetime
                import time
                import os

                def get_bitcoin_value_getter() -> tuple:
                    response = requests.get("https://api.blockchain.com/v3/exchange/tickers/BTC-USD")
                    dt = datetime.now()
                    current_time = str(dt)
                    bitcoin_price = str(response.json()["last_trade_price"])
                    return current_time, bitcoin_price

                # Connect to Redis using the environment variable
                redis_host = os.environ.get("REDIS_ENDPOINT")
                redis_port = 6379
                redis_client = redis.StrictRedis(host=redis_host, port=redis_port, db=0)

                while True:
                    current_time, bitcoin_price = get_bitcoin_value_getter()
                    redis_client.set("bitcoin_price", bitcoin_price)
                    redis_client.set("last_updated", current_time)
                    time.sleep(5)
                ' > /tmp/bitcoin_script.py

                # Run the Python script in the background
                python3 /tmp/bitcoin_script.py &
              EOF

  tags = {
    Name = "ec2-public-subnet"
  }
}