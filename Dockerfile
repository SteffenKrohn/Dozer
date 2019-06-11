FROM google/dart:2.1 AS builder
ENV PATH="${PATH}:/root/.pub-cache/bin"
RUN pub global activate webdev
COPY . /root/build-here/
WORKDIR /root/build-here
RUN pub get && \
    webdev build --output web:build && \
    dartdoc --output doc --exclude generator

FROM nginx
EXPOSE 80
RUN sed -i -e 's,   location / {,   location /ss2019/team-4a {,g' /etc/nginx/conf.d/default.conf; \
sed -i -e 's,        root   /usr/share/nginx/html;,        alias   /usr/share/nginx/html;,g' /etc/nginx/conf.d/default.conf
COPY --from=builder /root/build-here/build /usr/share/nginx/html/secure/final/m85SqzQGGZV6e7kQ
COPY --from=builder /root/build-here/doc /usr/share/nginx/html/doc/2946548lolroflhash02351040235652250569
COPY --from=builder /root/build-here/final-presentation/fake /usr/share/nginx/html/