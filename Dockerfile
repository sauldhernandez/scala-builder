FROM openjdk:10

RUN apt-get update && apt-get install -y --no-install-recommends build-essential libz-dev && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://piccolo.link/sbt-1.2.1.tgz | tar -xvz  && \
    ln -s /sbt/bin/sbt /bin/sbt
RUN sbt sbtVersion

RUN curl -sL https://github.com/oracle/graal/releases/download/vm-1.0.0-rc5/graalvm-ce-1.0.0-rc5-linux-amd64.tar.gz | tar -xz && \
    mv graalvm-ce-1.0.0-rc5 graalvm

ENV PATH=$PATH:/graalvm/bin

WORKDIR /project

ONBUILD COPY . .
ONBUILD RUN sbt assembly
ONBUILD RUN mkdir -p /tmp/image && cd /tmp/image && \
            native-image --static --no-server -jar /project/target/scala-2.12/project-assembly*.jar && \
            mkdir -p /project/target/linux && mv /tmp/image/project-assembly-* /project/target/linux/assembly

