# syntax=docker/dockerfile:experimental
FROM ubuntu:20.04

RUN apt-get update && apt-get install -y --no-install-recommends \
  openssh-client \
  git \
  vim

ARG group_name=test_group
ENV group_name=${group_name}
ARG group_id=123
ENV group_id=${group_id}
ARG user_name=test_user
ENV user_name=${user_name}
ARG user_id=123
ENV user_id=${user_id}

RUN echo ${user_id}
RUN addgroup --gid ${group_id} ${group_name} && \
    adduser \
    --home /home/${user_name} \
    --disabled-password \
    --gecos "" \ 
    --ingroup "$group_name" \
    --uid "$user_id" \
    --shell /bin/bash \
    "$user_name"

USER $user_name
WORKDIR /home/$user_name
RUN mkdir -p -m 0700 ~/.ssh && ssh-keyscan gitlab.com >> ~/.ssh/known_hosts
RUN --mount=type=ssh,uid=123 ssh -Tv git@gitlab.com
RUN --mount=type=ssh,uid=123 git clone --bare git@gitlab.com:jpabbuehl/dotfiles.git .cfg
COPY --chown=${user_name}:{$group_name} installer_dot.sh installer_dot.sh
RUN chmod +x installer_dot.sh
ENTRYPOINT ["/home/test_user/installer_dot.sh"]
CMD ["/bin/bash"]
