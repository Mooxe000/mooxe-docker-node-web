FROM mooxe/base:latest

MAINTAINER FooTearth "footearth@gmail.com"

ENV NODE_VERSION 4.1.1

WORKDIR /root

RUN \
  # update
  apt-get update && \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get autoremove -y

RUN \

  # nvm
  curl https://raw.githubusercontent.com/creationix/nvm/v0.24.0/install.sh | bash && \

  # nvm - zsh support
  echo ". ~/.nvm/nvm.sh" >> ~/.zshrc && \

  # nvm - fish support
  git clone https://github.com/passcod/nvm-fish-wrapper.git ~/.config/fish/nvm-wrapper && \
  echo ". ~/.config/fish/nvm-wrapper/nvm.fish" >> ~/.config/fish/config.fish && \

  # npm
  cp -f ~/.nvm/nvm.sh ~/.nvm/nvm-tmp.sh && \
  echo "nvm install $NODE_VERSION" >> ~/.nvm/nvm-tmp.sh && \
  echo "nvm alias 4 $NODE_VERSION" >> ~/.nvm/nvm-tmp.sh && \
  echo "nvm alias default 4" >> ~/.nvm/nvm-tmp.sh && \
  echo "nvm use default" >> ~/.nvm/nvm-tmp.sh && \
  sh ~/.nvm/nvm-tmp.sh && \
  rm ~/.nvm/nvm-tmp.sh && \

  cp /etc/profile /etc/profile.bak && \
  echo '. /root/.nvm/nvm.sh' >> /etc/profile && \

  # global package
  /bin/bash -l -c 'npm install -g cnpm --registry=https://r.cnpmjs.org' && \
  /bin/bash -l -c 'cnpm install -g \
    coffee-script http-server supervisor nodemon forever pm2'
