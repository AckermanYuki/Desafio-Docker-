#!/bin/bash

function upgrade(){
    ./manage.py migrate
    ./manage.py collectstatic
}
upgrade & 

exec /usr/sbin/uwsgi \
    --master \
    --processes 2 \
    --plugins python3 \
    --die-on-term \
    --uwsgi-socket 0.0.0.0:80 \
    --chdir /opt/my-web-app \
    --module mywebapp.wsgi:application   