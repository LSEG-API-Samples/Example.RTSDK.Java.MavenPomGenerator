# RTSDK Java Maven Pom file Generator (using Ruby)
- version: 3.0
- Last update: Dec 2024
- Environment: Windows
- Prerequisite: [Prerequisite](#prerequisite)

## <a id="Introduction"></a>Introduction

[LSEG Real-Time SDK (Java Edition)](https://developers.lseg.com/en/api-catalog/refinitiv-real-time-opnsrc/rt-sdk-java) (RTSDK, formerly known as Elektron SDK) is a suite of modern and open source APIs that aim to simplify development through a strong focus on ease of use and standardized access to a broad set of Refinitiv proprietary content and services via the proprietary TCP connection named RSSL and proprietary binary message encoding format named OMM Message. The capabilities range from low latency/high-performance APIs right through to simple streaming Web APIs. 

The SDK has been released on the [Maven Central Repository](https://central.sonatype.com/) to support the modern Java development life cycle since the RTSDK Java (formerly known as Elektron SDK) version 1.2. The Maven Central Repository supported also lets SDK compatibilities with the Java build automation tools like [Gradle](https://gradle.org/) and [Apache Maven](https://maven.apache.org/). This helps Java developers to build RTSDK Java applications, manage its dependencies (Java Developers do not need to manually manage different versions of jar files anymore), and better collaboration in the team.

The RTSDK Java package comes with the Gradle build tool supported by default. Some developers who are using Maven might feel difficult to try the SDK example codes in their Maven development workflow. 

To make Maven developers life easier, I am creating simple tool for generating RTSDK Java Examples Maven's pom.xml file to run the RTSDK Java example source code. The tool supports RTSDK Java since the rebranding version 2.0.0.L1 (EMA/ETA 3.6.0), and you can customize the configuration file to make it supports the future versions of the SDK.

### Caution

The generated pom.xml file is for running EMA or ETA APIs examples only. The file is **not optimized and not recommended for the Production use!**. I am not provide any supports for this simple tool.


## <a id="prerequisite"></a>Prerequisite

All scripts require [Ruby](https://www.ruby-lang.org/en/) compiler or [Docker Desktop](https://www.docker.com/products/docker-desktop/) application to run.

The application logic of this tool is simple enough that you can re-create in other programming language. I am choosing Ruby because its simplicity. 

## <a id="rtsdkj_maven"></a>Maven pom.xml setting for RTSDK Java

The ```pom.xml``` file the main Maven's project configuration. This XML file contains the information required to build a project.

### Maven pom.xml file for EMA Java Examples

The EMA API Java edition has two type of example applications as follows:
- console example applications in the *training* folder (for Consumer, Interactive Provider, and Non-Interactive Provider applications)
- GUI consumer example application in the *rrtmdviewer** folder.

The GUI example needs [JavaFX](https://openjfx.io/) dependency, so the pom.xml file need JavaFX dependency information too.

You can specify the following EMA Java API and JavaFX dependencies in the Maven pom.xml file for running the EMA Java example applications.

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    ...
<properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.compiler.source>11</maven.compiler.source>
    <maven.compiler.target>11</maven.compiler.target>
    <rtsdk.version>3.7.2.0</rtsdk.version>
    <javafx.version>15.0.1</javafx.version>
</properties>

    <dependencies>
        <!-- RTSDK -->
        <!-- For EMA Java Project -->
        <dependency>
            <groupId>com.refinitiv.ema</groupId>
            <artifactId>ema</artifactId>
            <version>${rtsdk.version}</version>
        </dependency>
    </dependencies>
    <dependency>
			<groupId>org.openjfx</groupId>
			<artifactId>javafx-fxml</artifactId>
			<version>${javafx.version}</version>
		</dependency>
		<dependency>
			<groupId>org.openjfx</groupId>
			<artifactId>javafx-controls</artifactId>
			<version>${javafx.version}</version>
		</dependency>
</project>
```

### Maven pom.xml file for ETA Java Examples

The pom.xml file for the ETA Java application is the following. The Maven can automatic pull ETA, ETA ValueAdd and ETA JSON Converter artifacts within Maven central for the application with the ```com.refinitiv.eta.valueadd.cache``` dependency declaration.

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    ...
<properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.compiler.source>11</maven.compiler.source>
    <maven.compiler.target>11</maven.compiler.target>
    <rtsdk.version>3.7.2.0</rtsdk.version>
</properties>
    <!-- RTSDK -->
    <!-- For ETA Java Project -->
    <dependency>
			<groupId>junit</groupId>
			<artifactId>junit</artifactId>
			<version>4.11</version>
			<scope>compile</scope>
		</dependency>
        
		<dependency>
			<groupId>org.mockito</groupId>
			<artifactId>mockito-core</artifactId>
			<version>1.9.5</version>
		</dependency>
		<dependency>
			<groupId>com.refinitiv.eta.valueadd.cache</groupId>
			<artifactId>etaValueAddCache</artifactId>
			<version>${rtsdk.version}</version>
		</dependency>
		<dependency>
			<groupId>com.refinitiv.eta.ansi</groupId>
			<artifactId>ansipage</artifactId>
			<version>${rtsdk.version}</version>
		</dependency>
</project>
```

## How to add new RTSDK Java version

The RTSDK Java version detail is available in the ```config/rtsdk_versions.yaml``` file in the YAML format as follows:

``` YAML
--- # RTSDK Version Mapping
rtsdk_versions:
  2.1.0: '3.7.0.0'
  2.1.1: '3.7.1.0'
  2.1.2: '3.7.2.0'
  2.1.3: '3.7.3.0'

latest_version: '2.1.3'
```

You can add more versions by add the RTSDK Java version as a Key (```2.2.0```, ```2.2.1```, and so on), then add the [EMA/ETA Java Maven Central](https://central.sonatype.com/?smo=true) version as a string value. The EMA/ETA Java Maven Central version number is available on the *# Maven Central* section of the RTSDK Java's README file and the [Maven Central](https://central.sonatype.com/?smo=true) website.

**Update Nov 2022**: 
- For RTSDK version 2.0.7.**L2**, please specify the RTSDK version as **3.6.7.3** in the pom.xml file.

Example *with dummy versions*:
``` YAML
--- # RTSDK Version Mapping
rtsdk_versions:
  2.0.7: '3.6.7.3'
  2.0.8: '3.6.8.0'
  3.0.1: '4.7.1.0' 

latest_version: '3.0.1'
```

## How to Use with Ruby

1. Open a project folder in command prompt and run the following command
    ```bash
    $> bundle install
    ```
2. Run the *maven_pom_generator.rb* script with the following command line argument:
    ``` Bash
    $>ruby maven_pom_generator.rb --api <EMA (default)/ETA> --version <RTSDK version, ex 2.0.8>
    ```
3. The result ```pom.xml``` file will be generated in the ```output_pom``` folder.

Example result:
``` Bash
$>ruby maven_pom_generator.rb --API EMA --version 2.0.8
EMA
3.6.8.0
use JDK 11
Done creating pom.xml
```

## How to use with Docker
1. Open a ```compose.yaml``` file and edit the following content to match your requirements
    
    ```yaml
    version: "3"
    name: maven_pom_generator
    services:
    app:
        build: 
        context: .
        volumes:
         - "<Your Host OS full Path>\\output_pom:/App/output_pom"
        command:
        - --API=EMA
        #- --version=2.1.3
        #- --API=ETA
        #- --version=<RTSDK Java version>
    ```
    Note: For the Windows OS, the host volume must be full path like ```"C:\\Users\\<user>\\output_pom:/App/output_pom"```
2. Start a container with the following command
    ```bash
    $> docker compose up
    ```
3. The result ```pom.xml``` file will be generated in the ```output_pom``` folder.
4. To remove a container, use ```docker compose down``` command.
5. To remove an image, use ```docker rmi maven_pom_generator-app``` command.

Example result:
```Bash
C:\drive_d\Project\Code\EMA_Ruby_Maven_Generator>docker compose up
[+] Running 1/0
 ✔ Container maven_pom_generator-app-1  Created                                                                        0.0s 
Attaching to app-1
app-1  | EMA
app-1  | 3.7.3.0
app-1  | use JDK 11
app-1  | Done creating pom.xml
app-1 exited with code 0
```

## <a id="ref"></a>References

* [Refinitiv Real-Time SDK Java page](https://developers.lseg.com/en/api-catalog/refinitiv-real-time-opnsrc/rt-sdk-java) on the [Refinitiv Developer Community](https://developers.lseg.com/) website.
* [Refinitiv Real-Time SDK Family](https://developers.lseg.com/en/use-cases-catalog/refinitiv-real-time) page.
* [Apache Maven Project page](https://www.apache.org/)
* [Maven Getting Started Guide](https://maven.apache.org/guides/getting-started/)
* [Maven in 5 Minutes](https://maven.apache.org/guides/getting-started/maven-in-five-minutes.html)
* [Maven Central Repository Search](https://search.maven.org/)
* [Developer Article: How to Set Up Refinitiv Real-Time SDK Java Application with Maven](https://developers.lseg.com/en/article-catalog/article/how-to-set-up-refinitiv-real-time-sdk-java-application-with-mave).
* [Developer Article: How to deploy and run Real-Time Java Application with Maven in Docker](https://developers.lseg.com/en/article-catalog/article/how-to-deploy-and-run-real-time-java-application-with-maven-in-d).
* [How to Set Up Real-Time SDK Java Application with Maven on the Eclipse IDE](https://developers.lseg.com/en/article-catalog/article/how-to-set-up-real-time-sdk-java-application-with-maven-on-the-e) on the the [LSEG Developer Community](https://developers.lseg.com/) web site.
