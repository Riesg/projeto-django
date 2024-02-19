FROM python:3.11.3-alpine3.18
LABEL mantainer="riesgdesigner@gmail.com"


ENV PYTHONDONTWRITEBYTECODE 1

ENV PHYTHONUNBUFFERED 1

COPY djangoapp /djangoapp
COPY scripts /scripts

WORKDIR /djangoapp

EXPOSE 8000


RUN python -m venv /venv && \
/venv/bin/pip install --upgrade pip && \
/venv/bin/pip install -r requirements.txt && \
adduser --disabled-password --no-create-home duser && \
mkdir -p /data/web/static && \
mkdir -p /data/web/media && \
chown -R duser:duser /venv && \
chown -R duser:duser /data/web/static && \
chown -R duser:duser /data/web/media && \
chmod -R 775 /data/web/static && \
chomd -R 755 /data/web/media && \
chmod -R +x /scripts


# Adiciona a pasta scripts e venv/bin
ENV PATH="/scripts/venv/bin:$PATH"

# Muda o usuário para duser
USER duser

# Executa o arquivo scripts/commands.sh
CMD  ["commands.sh"]