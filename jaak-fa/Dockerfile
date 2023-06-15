FROM almalinux
MAINTAINER Alberto Juan Gabino "alberto.juan@jaak.ai"


WORKDIR /opt/jaak/
RUN mkdir -p /opt/jaak/installer/
RUN mkdir -p /opt/jaak/bin/
RUN yum -y update 
#RUN dnf -y install wget
#RUN /usr/bin/crb enable

COPY jaak-files/jaak-fa.tar.gz /opt/jaak/bin/
RUN tar -xvzf /opt/jaak/bin/jaak-fa.tar.gz -C /opt/jaak/bin/

COPY jaak-files/jaak-lv.service /opt/systemd/system/
#RUN chmod +x /opt/systemd/system/jaak-lv.service
RUN systemctl enable /opt/systemd/system/jaak-fa.service
#RUN systemctl start /opt/systemd/system/jaak-lv.service


CMD ["/bin/bash"]