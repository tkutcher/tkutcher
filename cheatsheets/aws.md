

## Deploying Dockerized Service to EC2 Instance


### (Optional) Create own VPC (Virtual Private Cloud)
- This is a space where you can configure internal network virtually
- Give a name, and then specify a range of IPs available in this network (check out cidr.xyz)
- Then create a subnet as a subset of these IP addresses, this one would be for public web apps
- To give it access to the internet...
  - https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html#Add_IGW_Attach_Gateway
  - You go to VPC Networking Components &rarr; Internet Gateways
  - Create it, then select Actions &rarr; Attach, and then select the VPC just created
  - Add a route table for the subnet and add a destination of all IP addresses and add the igw just added
  - **Set it as the main route table** to override the VPC default one.


### Create the initial EC2
1. Instances &rarr; Launch Instance
2. Select Ubuntu 18.04, 64-bit x86 Architecture
3. t2.micro is free
4. Select VPC and relevant subnet
5. Leave Auto-assign Public IP as "Use subnet setting (Disable)"
6. Skip IAM role for now
7. Protect against accidental termination
8. Select volume type by https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html
9. Go to Configure Security Group
  - Keep the rule which allows SSH from anywhere
  - Add a rule for all HTTP and all HTTPS connections
  
10. Create a new keypair and tuck away the .pem file it gives you (use this to ssh in to machine)
11. Launch

### Configure a static IP address
1. From EC2 Dashboard, go to Elastic IP's
2. Allocate new address, select VPC, from Amazon pool
3. Associate it and close, verify you have an Elastic IP in the EC2 dashboard


### SSH in to box and configure a user
- Click connect to get example of what to do, but essentially
  - Give the key file appropriate permissions: `chmod 400 <pem-file>` 
  `ssh -i <pem-file-from-earlier> ubuntu@<ip-address>`
  - Any issues likely a routing/connectivity issue
- Create a new user:
```bash
sudo useradd -s /bin/bash -d /home/<name> -m -G sudo <name>
sudo psswd <name>
```
- On your local machine, ssh-keygen to create a key-pair for the new user
- In the ubuntu session,
```bash
sudo -- sh -c "echo '<public-key>' > /home/<name>/.ssh/authorized_keys"
sudo chown -R <name>:<name> /home/<name>/.ssh/
```
- Now you should be able to ssh in using that username (with it's private key)


### Install docker and docker-compose on the machine
```bash
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable"
sudo apt-get update
sudo apt-get install docker-ce
docker -v
```

```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

Add users who need to run docker commands to the docker group:
```bash
sudo usermod -aG docker <user>
```

Log out and back in for this to take effect (`logout`)

### Pull images from the GitLab registry
Create a GitLab token with api access and registry read access, stash that token

On the machine:

`docker login registry.gitlab.com -u <gitlab-username> -p <token>`

Create a docker-compose.yml file so that we can describe the network for the app:

```yaml
version: '3.7'

services:

  web:
    image: '<image-tag>' # (e.g. "registry.gitlab.com/mygroup/myproj/myimage:mytag")
    restart: always  # if we go down, let's get back up
    command: sh scripts/docker.start.sh # wherever script is in docker container to start
    expose:  # ports to expose (internally to the docker container)
      - "8888"
    environment: # environment variables to pump in
      - APP_SETTINGS=src.config.ProductionConfig

  nginx:
    image: '<image>'
    ports:  # forward actual web traffic for the machine to nginx server port 80
      - 80:80
    depends_on:
      - web
```

To test you can pull the images, `docker-compose pull`

Bring them up `docker-compose up`

If all goes well, you should be able to point the browser to the IP address and hit the flask server.
Bring docker-compose down (or Ctrl+C to kill).

Throw the task of bringing-down &rarr; fetching-new-images &rarr; bringing-back-up in to a script:

`update.sh`
```bash
docker-compose down
docker login registry.gitlab.com -u <username> -p <token>
docker-compose pull
docker-compose up -d
```

### Bring it all together via CI

- Make one more ssh keypair, specifically for CI `ssh-keygen`
- **Do not set a password**
- Cat the public key to the `~/.ssh/authorized_keys` on the remote
- For the ci script:
  - See [this](https://docs.gitlab.com/ee/ci/ssh_keys/#verifying-the-ssh-host-keys)
  - Run `ssh-keyscan` of the IP address and copy the outputs
  - In Settings &rarr; CI/CD &rarr; Variables, add 2:
    - SSH_KNOWN_HOSTS, with the value of the keyscan
    - SSH_PRIVATE_KEY, with the private key from the keygen
```yaml
deploy:
  stage: deploy
  before_script:
    - 'which ssh-agent || ( apt-get update -y && apt-get install openssh-client -y )'
    - eval $(ssh-agent -s)
    - echo "$SSH_PRIVATE_KEY" | tr -d '\r' | ssh-add -
    - mkdir -p ~/.ssh
    - chmod 700 ~/.ssh
    - echo "$SSH_KNOWN_HOSTS" > ~/.ssh/known_hosts
    - chmod 644 ~/.ssh/known_hosts
  script:
    - ssh onmot@3.21.81.214 "sh update_maf_dev.sh"
```

- We authenticate, then ssh in to the remote machine and run the update script!



---


## Creating a DB instance.

- Create another subnet that is the next range of IPs (e.g.) X.X.16.0/20
- Create another security group for db access (part of the same VPC that the subnet is a part of)
- Create a Postgres DB and make it part of that sg and corresponding subnet
- Have to make it public otherwise will not be able to ssh in (the sg defines what traffic is allowed)
  - To allow TCP connections from your public subnet, copy that security group to the field in a custom TCP rule, opening up the DBs port
  
  
## Setting up logging

- Create a loggly account
- Source Setup - grab your customer token
- https://<BLAH>.loggly.com/sources/setup/python-app-setup

