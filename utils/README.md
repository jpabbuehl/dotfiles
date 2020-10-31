# Evaluating dot files in vanilla OS system

commands
```
docker build -t dot_test:latest .
docker build --build-arg caching=1 --ssh default -t dot_test:latest .
```

todos

add dockerfile for
ubuntu 18.04, 20.04, 20.10
debian
alpine
busybox
centos
amazon linux ami 1,2

Determine if you can install dotfiles without sshd (only curl)

Deploy latest script with url shortener

write function to save last N commands into files

write helper pages with existing shortcut

write helper pages with advance git commands and use cases
