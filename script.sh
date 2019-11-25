#!/bin/bash

redis-server /usr/local/etc/redis.conf &

python3 -m venv venv
. venv/bin/activate
pip3 install -r requirements.txt
export FLASK_APP=monolith
python3 setup.py develop

celery -A monolith.tasks worker -B --loglevel=info &

python3 -m flask run --port=5010
