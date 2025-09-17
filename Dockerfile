FROM ubuntu:22.04

WORKDIR /app

RUN apt-get update && \
    apt-get install -y fortune-mod cowsay netcat-openbsd && \
    rm -rf /var/lib/apt/lists/*

# Make sure /usr/games is visible to all processes
ENV PATH="${PATH}:/usr/games"

COPY wisecow.sh /app/wisecow.sh
RUN chmod +x /app/wisecow.sh

EXPOSE 4499

CMD ["/app/wisecow.sh"]
