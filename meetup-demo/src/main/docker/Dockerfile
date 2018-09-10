FROM anapsix/alpine-java:8_server-jre
VOLUME /tmp
ADD meetup-demo.jar app.jar
RUN bash -c 'touch /app.jar'
EXPOSE 8080
ENTRYPOINT exec java $JAVA_OPTS \
    -Djava.security.egd=file:/dev/./urandom \
    -jar /app.jar \
