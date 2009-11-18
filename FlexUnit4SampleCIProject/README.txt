This is a sample project showing how the FlexUnit4 Ant task can be used to build a project.  Below is a description of the 
possible configuration options for the FlexUnit4 Ant task:

<flexunit 
	player="flash|air"
	swf="<path to your SWF file>"
	toDir="<path where XML reports should be written>"
	haltonfailure="true|false"
	verbose="true|false"
	localTrusted="true|false"
	port="<port number on which to run the XMLSocket>"
	timeout="<timeout for the runner in milliseconds>"
	failureproperty="<property name to set to "true" if any tests fail>" />

Below is a more detailed description of each attribute of the task:

- player - DEFAULT: flash
         - This toggles the ability to execute the test SWF using the Flash Player or ADL.  Test SWF's executed using
           ADL should be built using the amxmlc executable or mxmlc.jar with the parameter "+configname=air".
         - If building on Linux, the AIR SDK folders must be extracted on top of the Flex SDK folders for the Ant task
           to properly function.

- swf - This is a relative or absolute path to the SWF file which has been compiled with the CIListener class added as a 
        listener to the FlexUnitCore.  See src/test/flex/TestRunner.mxml for an example.  Please note that paths containing 
        spaces are not currently supported.
        
- toDir - DEFAULT: Project base directory 
        - This is a relative or absolute path to the directoy where the task should write the XML test result reports.  The
          report files will be named in the pattern "TEST-*.xml".

- haltonfailure - DEFAULT: false
                - Setting this attribute to true will cause the build to stop when tests within the SWF have failed.  All tests
                  within the SWF will execute before the build is halted to maximize the test results returned from a test run.

- verbose - DEFAULT: false
          - Setting this attribute to true will cause the task to output which tests have failed, errored, and been ignored as
            well as a summary of test counts per test class.

- localTrusted - DEFAULT: false
               - Setting this attribute to true will add the path passed into the "swf" attribute to the local FlashPlayer Trust.
                This trust entry is made in the flexUnit.cfg file on your machine's local trust folder for the Flash Player.  If
                this attribute is set to false, the flexUnit.cfg file will be removed.
               - Optional if using player="air".

- port - DEFAULT: 1024
       - Setting this attribute informs the task to listen for test results on the specified port.  Using this attribute implies 
         that the port on the CIListener instance registered on the FlexUnitCore is registered with the same port number.
         
- timeout - DEFAULT: 60000 (60s)
          - Setting this attribute will dictate the amount of time the task listens for test results until it times out.

- failureproperty - DEFAULT: flexunit.failed
                  - If a test failure occurs during the test run, the property name set in this attribute will receive a value of 
                    true.  Per Ant conventions, this property will not exist unless a test in the run has failed or errored. 

In terms of this sample project, the project folder layout is as such:

- bin-debug
- html-template
- libs
- src
  - main
    - flex
  - test
    - flex
- build.xml      <-- Ant build file using the Flash Player for testing
- build.air.xml  <-- Ant build file using ADL for testing
- pom.xml        <-- Maven build file using FlexMojos

The Ant build file using the Flash Player, when run successfully, will produce a folder layout as such:

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
    - TestRunner.swf
  - reports            <-- FlexUnit4 xml reports
- build.xml
- build.air.xml
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
    - AirTestRunner.swf
    - flexUnitDescriptor.xml
    - Main.swf
  - reports                   <-- FlexUnit4 xml reports
- build.xml
- build.air.xml
- pom.xml

The Maven build file using FlexMojos, when run successfully, will produce a folder layout as such:

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
- pom.xml

The builds in the sample project were tested using Ant 1.7.1, Maven 2.0.10, and FlexMojos 3.4.2.  The FlexUnit4 Ant task JAR 
was built using Java 5.  The source for the sample project was built using Flex 3.4.0.9271 and Flash Player 10.  Please consult 
the individual build files for more details on each's implementation of the build process.  Currently there are plans to support 
xvfb in the next release of the Ant task, but currently this feature is not available, making truly headless builds using 
FlexUnit4 not possible at this time.   

Please keep in mind, these Ant and Maven builds have been created as suggestions for how to employ FlexUnit4 in a project's build
process.  These build files are not intended to dictate good practice with respect to using Ant or Maven.  For more details 
on the Apache Ant project visit http://ant.apache.org/, for Apache Maven visit http://maven.apache.org/, and for FlexMojos visit 
http://flexmojos.sonatype.org/.
