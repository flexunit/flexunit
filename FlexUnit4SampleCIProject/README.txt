This is a sample project showing how the FlexUnit4 Ant task can be used to build a project.  Below is a description of the 
possible configuration options for the FlexUnit4 Ant task:

<flexunit 
	swf="<path to your SWF file>"
	toDir="<path where XML reports should be written>"
	haltonfailure="true|false"
	verbose="true|false"
	localTrusted="true|false"
	port="<port number on which to run the XMLSocket>"
	timeout="<timeout for the runner in milliseconds>"
	failureproperty="<property name to set to "true" if any tests fail>" />

Below is a more detailed description of each attribute of the task:
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

-localTrusted - DEFAULT: false
              - Setting this attribute to true will add the path passed into the "swf" attribute to the local FlashPlayer Trust.
                This trust entry is made in the flexUnit.cfg file on your machine's local trust folder for the Flash Player.  If
                this attribute is set to false, the flexUnit.cfg file will be removed.

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
- build.xml  <-- Ant build file
- pom.xml    <-- Maven build file

The Ant build file, when run successfully, will produce a folder layout as such:

- bin             <-- Binary working folder for build
  - Main.swf
  - TestRunner.swf
- bin-debug
- dist            <-- Location of final Flex website zip
- html-template
- libs
- reports         <-- FlexUnit4 xml reports
- src
  - main
    - flex
  - test
    - flex
- build.xml
- pom.xml

The Maven build file, when run successfully, will produce a folder layout as such:

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
  - Main.swf            
- build.xml
- pom.xml

The builds in the sample project were tested using Ant 1.7.1 and Maven 2.0.10.  The FlexUnit4 Ant task JAR was built using 
Java 5.  The source for the sample project was built using Flex 3.3.0.4852.  Please consult the individual build files for 
more details on each's implementation of the build process.  Currently there are plans to support xvfb-run in the next 
release of the Ant task, but currently this feature is not available, making truly headless builds using FlexUnit4 not possible 
at this time.   

Please keep in mind, these Ant and Maven builds have been created as suggestions for how to employ the FlexUnit4 
Ant task.  These build files are not intended to dictate good practice with respect to using Ant or Maven.  For more details 
on the Apache Ant project visit http://ant.apache.org/ and for Apache Maven visit http://maven.apache.org/.