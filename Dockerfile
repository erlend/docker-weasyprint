FROM containerstack/alpine

ARG FLASK_VERSION=1.0.2
ARG WEASY_VERSION=0.42.3

RUN apk add --no-cache \
      cairo-gobject \
      pango \
      py3-cffi \
      py3-pillow \
      py3-gunicorn \
      ttf-freefont

RUN pip3 install -U pip && \
    pip3 install flask==$FLASK_VERSION weasyprint==$WEASY_VERSION && \
    find /usr/lib/python3.6 -name '*.pyc' -delete && \
    rm -rf /root/.cache/pip

COPY wsgi.py /

EXPOSE 5001

CMD gunicorn --bind 0.0.0.0:5001 wsgi:app
