FROM archlinux:latest
LABEL maintainer='Naheel-Azawy'
COPY . /opt/nd
RUN /opt/nd/nd --override init-system base base-gui
RUN useradd -m -g wheel me
RUN sudo -u me /opt/nd/nd --override init-user base base-gui
CMD sudo -u me sh -c 'cd && . ~/.profile && zsh'

