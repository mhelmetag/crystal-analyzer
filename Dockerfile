FROM crystallang/crystal

WORKDIR /app

ADD shard.yml /app/shard.yml
RUN crystal deps

ADD . /app

RUN crystal build --release /app/src/crystal_analyzer.cr

# Only used locally... Heorku doesn't allow EXPOSE
EXPOSE 80

RUN useradd -m app
USER app

CMD ./crystal_analyzer -p $PORT
