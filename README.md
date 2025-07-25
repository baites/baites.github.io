# baites.github.io

## Installation

### Building container

* Cloning and creating docker image

**NOTE**: This installation requires installed docker server.

```bash
$ git clone git clone https://github.com/baites/baites.github.io.git
$ cd baites.github.io
$ docker build -t jekyll -f jekyll.dockerfile .
...
Successfully tagged jekyll:latest
```

### On Windows

* Installation is simpler as by default, files and directories mounted from Windows into a Linux container will often appear to be owned by root within the container, regardless of the original Windows user or group permissions. This is because Docker's bind mount mechanism on Windows doesn't directly translate Windows ACLs (Access Control Lists) to Linux permissions.

```powershell
docker create --name jekyll-blog --mount type=bind,source=$(pwd),target=/blog --workdir /blog -t -p 4000:4000 jekyll
docker start jekyll-blog
docker exec -it jekyll-blog /bin/bash
```

### On Linux

* Creating container

```bash
$ USER_ID=$(id -u)
$ USER_NAME=$(id -un)
$ GROUP_ID=$(id -g)
$ GROUP_NAME=$(id -gn)
$ docker create \
--name jekyll-blog-$USER_NAME \
--mount type=bind,source=$PWD,target=/home/$USER_NAME/baites.github.io \
--mount type=bind,source=$HOME/.ssh,target=/home/$USER_NAME/.ssh \
--workdir /home/$USER_NAME/baites.github.io \
-t -p 4000:4000 jekyll
$ docker start jekyll-blog-$USER_NAME
```

* Mirror user and group to the container

```bash
$ CMD="useradd -u $USER_ID -N $USER_NAME && \
groupadd -g $GROUP_ID $GROUP_NAME && \
usermod -g $GROUP_NAME $USER_NAME &&\
echo '$USER_NAME ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/$USER_NAME &&\
chown -R $USER_NAME:$GROUP_NAME /home/$USER_NAME"
docker exec jekyll-blog-$USER_NAME /bin/bash -c "$CMD"

* Start the container

```bash
$ docker exec -it -u $USER_NAME jekyll-blog-$USER_NAME /bin/bash
```

## Bulding/update the blog from inside of container

* Entering in the container install gihub pages

```bash
$ gem install bundler
# Follow instruction to set path (ex using ver 3.4.0)
$ export PATH="/home/baites/.gem/ruby/3.4.0/bin:$PATH"
$ bundle install
$ bundle exec jekyll serve -I --future --host 0.0.0.0 --force_polling --livereload
```

* Open browser at http://localhost:4000/

* OPTIONAL: update blog dependency

```bash
$ bundle update
$ bundle exec jekyll serve -I --future --host 0.0.0.0 --force_polling --livereload
```
