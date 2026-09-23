FROM python:3.12-slim

LABEL authors="Erik Andri Budiman, Steve Clement"
LABEL optimized-by="Gordon, Rofly Antonio"

WORKDIR /app
COPY . .

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    nano \
    ca-certificates \
    libmaxminddb0 \
    && rm -rf /var/lib/apt/lists/*

ENV PATH="/root/.local/bin:$PATH"

RUN curl -sSL https://install.python-poetry.org | python3 -
RUN poetry install --only main --no-interaction --no-ansi

RUN cp /app/etc/server.conf.sample /app/etc/server.conf

RUN ./update.sh

CMD ["poetry", "run", "serve"]