FROM FROM python:3.7-stretch
WORKDIR /opt/my-web-app/

RUN apt-get update \ 
    && apt install \
        --no-install-recommends --yes \
        build-essential libpq-dev \
    && true

COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt \
    && rm /tmp/requirements.txt \
    && true

COPY ./mywebapp /opt/my-web-app/mywebapp
COPY .deploy /opt/my-web-app/deploy
COPY ./manage.py /opt/my-web-app/manage.py

ENV PYTHONUNBUFFERED=1 \
    PYTHONIOENCODIND=UTF-8 \
    PYTHONDONTWRITEBYTECODE=1 \
    DJANGO_SETTINGS_MODULE=deploy.settings

EXPOSE 80
ENTRYPOINT ["/dev/init", "--"]
CMD ["/opt/backend/deploy/run.sh"]