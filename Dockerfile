FROM debian:10.1-slim

ENV KUBE_LATEST_VERSION="v1.16.2"
RUN apt update && apt install -y curl rclone jq python-pip && \
 pip install yq && \
 curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
 chmod +x /usr/local/bin/kubectl

COPY backup.sh /
RUN chmod +x /backup.sh
COPY restore.sh /
RUN chmod +x /restore.sh

CMD /backup.sh