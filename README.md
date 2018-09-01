# scala-builder

This is a Docker image intended for scala app builds.
This builder is oppinionated, sbt projects are packaged into an assembly
(i.e. it supposes you have sbt-assembly in your project), and then creates
a native image of that assembly using GraalVM. The resulting image
is a light image with only the resulting binary.

## Features

 - Java 10
 - SBT 1.2.1 preinstalled
 - GraalVM 1.0.0-rc5
 
 
## Usage

```Dockerfile
FROM sauldhernandez/scala-builder:latest

#Add your project
COPY . /project

#That's it.
```
