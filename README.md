# RTSDK Java Maven Pom file Generator (using Ruby)
- version: 1.0
- Last update: March 2023
- Environment: Windows
- Prerequisite: [Prerequisite](#prerequisite)

## Introduction

This is an example tool for generating RTSDK Java Examples Maven's pom.xml file. The tool just creates a ```pom.xml``` file for running EMA or ETA Java API example project. 

The tool supports RTSDK Java since the rebranding version 2.0.0.L1 (EMA/ETA 3.6.0).

### Caution
 The generated ```pom.xml``` file aims for using with the RTSDK Java examples only. The file is **not optimized and not recommended for the Production use!**. I am not provide any supports for this simple tool.

## <a id="prerequisite"></a>Prerequisite
All scripts require [Ruby](https://www.ruby-lang.org/en/) compiler.

## How to add new RTSDK Java version

The RTSDK Java version detail is available in the ```config/rtsdk_versions.yaml``` file in the YAML format as follows:

``` YAML
--- # RTSDK Version Mapping
rtsdk_versions:
  2.0.5: '3.6.5.0'
  2.0.6: '3.6.6.0'
  2.0.7: '3.6.7.3'
  2.0.8: '3.6.8.0'
  2.1.0: '3.7.0.0'
```

You can add more versions by add the RTSDK Java version as a Key (```2.1.0```, ```2.2.0```, and so on), then add the EMA/ETA Java Maven Central version as a string value. The EMA/ETA Java Maven Central version number is available on the *# Maven Central* section of the RTSDK Java's README file.

**Update Nov 2022**: 
- For RTSDK version 2.0.7.**L2**, please specify the RTSDK version as **3.6.7.3** in the pom.xml file.

Example *with dummy version*:
``` YAML
--- # RTSDK Version Mapping
rtsdk_versions:
  2.0.7: '3.6.7.3'
  2.0.8: '3.6.8.0'
  3.0.1: '4.7.1.0' 
```

## How to Use

1. Go to the project *src* folder in a command prompt.
2. Run the *maven_pom_generator.rb* in the *src* folder with the following command line argument:
    ``` Bash
    $>ruby maven_pom_generator.rb --api <EMA (default)/ETA> --version <RTSDK version, ex 2.0.8>
    ```

Example result:
``` Bash
$>ruby maven_pom_generator.rb --API EMA --version 2.0.8
EMA
3.6.8.0
use JDK 11
Done creating pom.xml
```

## <a id="ref"></a>References

* [Refinitiv Real-Time SDK Java page](https://developers.refinitiv.com/en/api-catalog/refinitiv-real-time-opnsrc/rt-sdk-java) on the [Refinitiv Developer Community](https://developers.refinitiv.com/) web site.
* [Refinitiv Real-Time SDK Family](https://developers.refinitiv.com/en/use-cases-catalog/refinitiv-real-time) page.
* [Apache Maven Project page](https://www.apache.org/)
* [Maven Getting Started Guide](https://maven.apache.org/guides/getting-started/)
* [Maven in 5 Minutes](https://maven.apache.org/guides/getting-started/maven-in-five-minutes.html)
* [Maven Central Repository Search](https://search.maven.org/)
* [Developer Article: How to Set Up Refinitiv Real-Time SDK Java Application with Maven](https://developers.refinitiv.com/en/article-catalog/article/how-to-set-up-refinitiv-real-time-sdk-java-application-with-mave).
* [Developer Article: How to deploy and run Real-Time Java Application with Maven in Docker](https://developers.refinitiv.com/en/article-catalog/article/how-to-deploy-and-run-real-time-java-application-with-maven-in-d).
* [How to Set Up Real-Time SDK Java Application with Maven on the Eclipse IDE](https://developers.refinitiv.com/en/article-catalog/article/how-to-set-up-real-time-sdk-java-application-with-maven-on-the-e) on the the [Refinitiv Developer Community](https://developers.refinitiv.com/) web site.
