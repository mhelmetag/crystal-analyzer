FROM crystallang/crystal

WORKDIR /app

ADD shard.yml /app/shard.yml
RUN crystal deps

ADD . /app

RUN crystal build /app/src/crystal_analyzer.cr

EXPOSE 80

CMD ["./crystal_analyzer", "-p", "80"]
