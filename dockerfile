FROM openjdk:11.0.2-jdk-oraclelinux7
RUN curl https://www-eu.apache.org/dist/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz --output /tmp/apache-maven-3.6.0-bin.tar.gz \
    && cd /opt \
    && tar xzvf /tmp/apache-maven-3.6.0-bin.tar.gz
ENV PATH="/opt/apache-maven-3.6.0/bin:${PATH}"
RUN mkdir /app
WORKDIR /app
COPY . /app
# Cache maven locally on host
VOLUME "$HOME"/.m2:/root/.m2
RUN mvn package
ENTRYPOINT java -jar target/hello-dropwizard-1.0-SNAPSHOT.jar server example.yaml