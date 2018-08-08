ARG BASE_IMAGE_TAG

FROM anaxexp/php-nginx:${BASE_IMAGE_TAG}

COPY templates /etc/gotpl/