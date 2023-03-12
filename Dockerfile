FROM devkrolikowski/swiss-army-knife:0.2.0
WORKDIR /usr/local/bin
COPY run.sh .
RUN chmod +x run.sh
ENTRYPOINT [ "/bin/bash", "./run.sh" ]