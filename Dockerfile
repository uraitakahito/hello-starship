FROM debian:bullseye

ARG user_id=501
ARG group_id=20
ARG user_name=developer
# The WORKDIR instruction can resolve environment variables previously set using ENV.
# You can only use environment variables explicitly set in the Dockerfile.
# https://docs.docker.com/engine/reference/builder/#/workdir
ARG home=/home/${user_name}

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y procps && \
  apt-get install -y zsh && \
  apt-get install -y vim && \
  apt-get install -y sed && \
  apt-get install -y curl && \
  apt-get install -y git && \
  apt-get install -y sudo

COPY bin/set-superuser-and-group.sh ${home}/bin/
RUN ${home}/bin/set-superuser-and-group.sh ${group_id} ${user_id} ${user_name}

# an empty file to suppress zsh initial messages
RUN touch ${home}/.zshrc

#
# Starship
# https://starship.rs/
#
RUN curl -sS https://starship.rs/install.sh > ${home}/bin/install-starship.sh && \
  chmod 0755 ${home}/bin/install-starship.sh && \
  ${home}/bin/install-starship.sh --yes && \
  echo 'eval "$(starship init zsh)"' >> ${home}/.zshrc

RUN chown -R ${user_id}:${group_id} ${home}

USER ${user_name}
WORKDIR /home/${user_name}

ENTRYPOINT ["tail", "-F", "/dev/null"]
