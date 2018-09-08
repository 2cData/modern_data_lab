FROM modern_data_lab:lab_one AS lab_two

MAINTAINER 2CData <david.callaghan@2c-data.com>

# Install SSH
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
chmod 0600 ~/.ssh/authorized_keys
