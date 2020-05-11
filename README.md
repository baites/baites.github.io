# baites.github.io

# Installation

* Cloning and creating docker image

**NOTE**: This installation requires installed docker server.

```bash
$ git clone git clone https://github.com/baites/baites.github.io.git
$ cd baites.github.io
$ docker build -t jekyll -f jekyll.dockerfile .
...
Successfully tagged jekyll:latest
```

* Creating container

```bash
$ USER_ID=$(id -u)
$ USER_NAME=$(id -un)
$ GROUP_ID=$(id -g)
$ GROUP_NAME=$(id -gn)
$ docker create \
--name jekyll-$USER_NAME \
--mount type=bind,source=$PWD,target=/home/$USER_NAME/baites.github.io \
--mount type=bind,source=$HOME/.ssh,target=/home/$USER_NAME/.ssh \
--workdir /home/$USER_NAME/baites.github.io \
-t -p 4000:4000 jekyll
$ docker start jekyll-$USER_NAME
```

* Mirror user and group to the container

```bash
$ CMD="useradd -u $USER_ID -N $USER_NAME && \
groupadd -g $GROUP_ID $GROUP_NAME && \
usermod -g $GROUP_NAME $USER_NAME &&\
echo '$USER_NAME ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/$USER_NAME &&\
chown -R $USER_NAME:$GROUP_NAME /home/$USER_NAME"
docker exec jekyll-$USER_NAME /bin/bash -c "$CMD"
```

* Entering in the container install gihub pages

```bash
$ docker exec -it -u $USER_NAME jekyll-$USER_NAME /bin/bash
$USER_NAME@bcfa7ea7eb52 baites.github.io$ export PATH="/home/baites/.gem/ruby/2.7.0/bin:$PATH"
$USER_NAME@bcfa7ea7eb52 baites.github.io$ gem install bundler
...
$USER_NAME@bcfa7ea7eb52 baites.github.io$ bundle exec jekyll serve -I --future --host 0.0.0.0
...
```

* Open browser at http://localhost:4000/