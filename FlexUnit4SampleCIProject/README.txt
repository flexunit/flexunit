------------------------------------------------------------------------
Configuration
------------------------------------------------------------------------
This is a sample project showing how the FlexUnit4 Ant task can be used to build a project.
In terms of this sample project, the project folder layout is as such:

- bin-debug
- html-template
- libs
- src
  - main
    - flex
  - test
    - flex
- build.xml         <-- Ant build file using the Flash Player for testing
- build.air.xml     <-- Ant build file using ADL for testing
- build.browser.xml <-- Ant build file using the browser for testing
- build.custom.xml  <-- Ant build file showing how to test a custom built SWF
- pom.xml           <-- Maven build file using FlexMojos

The Ant build file using the Flash Player (stand alone, browser, or custom), when run successfully, 
will produce a folder layout as such:

- bin-debug
- html-template
- libs
- src
  - main
    - flex
  - test
    - flex
- target               <-- Location of final Flex website zip
  - bin                <-- Binary working folder for build
    - Main.swf
    - TestRunner.mxml  <-- In all builds but build.custom.xml
    - TestRunner.swf
  - reports            <-- FlexUnit4 xml reports
- build.xml
- build.air.xml
- build.browser.xml
- build.custom.xml
- pom.xml

The Ant build file using ADL, when run successfully, will produce a folder layout as such:

- bin-debug
- html-template
- libs
- src
  - main
    - flex
  - test
    - flex
- target                      <-- Location of final Flex website zip
  - bin                       <-- Binary working folder for build
    - flexUnitDescriptor.xml
    - Main.swf
    - TestRunner.mxml         
    - TestRunner.swf
  - reports                   <-- FlexUnit4 xml reports
- build.xml
- build.air.xml
- build.browser.xml
- build.custom.xml
- pom.xml

The Maven build file using FlexMojos, when run successfully, will produce a folder layout 
as such:

- bin-debug
- html-template
- libs
- src
  - main
    - flex
  - test
    - flex
- target
  - classes
  - test-classes        
    - TestRunner.swf
  - surefire-reports    <-- FlexUnit4 xml reports
  - demo-1.0.0-swf            
- build.xml
- build.air.xml
- build.browser.xml
- build.custom.xml
- pom.xml

------------------------------------------------------------------------
Disclaimer and support
------------------------------------------------------------------------
The builds in the sample project were tested using Ant 1.7.1, Maven 2.0.10, and FlexMojos 
3.6.1.  The FlexUnit4 Ant task JAR was built for Java 5 using JDK 6.  Validation of the 
source for the sample project was built using Flex 3.5.0.12683 and Flash Player 10.0 r42.  
Please consult the individual build files for more details on each's implementation of 
the build process.

Please keep in mind, these Ant and Maven builds have been created as suggestions for how 
to employ FlexUnit4 in a project's build process.  These build files are not intended to 
dictate good practice with respect to using Ant or Maven.  For more details on the FlexUnit 
Ant task visit http://docs.flexunit.org/index.php?title=Ant_Task, Apache Ant project visit 
http://ant.apache.org/, for Apache Maven visit http://maven.apache.org/, and for 
FlexMojos visit http://flexmojos.sonatype.org/.  If you require assistance in using this Ant 
task, please utilize the user forums listed at http://flexunit.org as well as the wiki at 
the same location.  To read more about Continuous Integration methods using FlexUnit visit 
http://docs.flexunit.org/index.php?title=Continuous_Integration_Support.