FROM public.ecr.aws/docker/library/python:3.12 AS cli
LABEL maintainer="Javier"

RUN curl -sSL https://install.python-poetry.org | python3 -

FROM 386757133934.dkr.ecr.us-east-1.amazonaws.com/javier/poetry AS deploy

RUN apt-get update && apt-get install -y unzip curl sudo less
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN sudo ./aws/install

COPY src ./src

RUN poetry install -v

CMD ["poetry","run","python", "./src/cicd/ui/app.py"]
