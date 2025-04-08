FROM openjdk:17-jdk

# Set the working directory
WORKDIR /usr/app

# Copy application files to the container
COPY ./ ./

# Environment variable for Java options
ENV JAVA_OPTS="\
    -Xmx512m -Xms512m \
    -XX:+HeapDumpOnOutOfMemoryError \
    -XX:HeapDumpPath=/heapdumps \
    -XX:+ExitOnOutOfMemoryError \
    -Djavax.management.builder.initial= \
    -Dcom.sun.management.jmxremote \
    -Dcom.sun.management.jmxremote.host=34.44.234.65 \
    -Dcom.sun.management.jmxremote.port=4044 \
    -Dcom.sun.management.jmxremote.rmi.port=4046 \
    -Djava.rmi.server.hostname=34.44.234.65 \
    -Dcom.sun.management.jmxremote.local.only=false \
    -Dcom.sun.management.jmxremote.authenticate=false \
    -Dcom.sun.management.jmxremote.ssl=false"

ENV PROBLEM=""

# Create heapdump directory (optional inside container)
RUN mkdir -p /heapdumps && chmod 777 /heapdumps

# Entry point
ENTRYPOINT exec java ${JAVA_OPTS} -jar buggyApp.jar ${PROBLEM}
