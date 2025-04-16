FROM python:3.12 AS cli
LABEL maintainer="Javier"

RUN curl -sSL https://install.python-poetry.org | python3 -

FROM python:3.12-slim AS deploy

COPY --from=cli /root/.local/ /root/.local/

ENV PATH="${PATH}:/root/.local/bin"
RUN alias ls='ls --color=auto'


WORKDIR /code
COPY poetry.lock ./
COPY pyproject.toml ./
COPY README.md ./
COPY ./src/ ./

RUN poetry -V
RUN poetry install -v --no-root

COPY src ./src

RUN poetry install -v

EXPOSE 8000
CMD ["poetry","run","fastapi", "run", "sdlc_trace/main.py", "--port", "8000", "--host","0.0.0.0"]
