## Create a Spring Cloud Config Server and Client

** Part 1 - Create Config Server 

1. Create a new Spring Boot application. 
   Name the project "config-server”, and use this value for the Artifact.  
	* access http://start.spring.io/ or any IDE, create a new project

2. Edit the main Application class (probably named ConfigServerApplication).  Add the @EnableConfigServer to the application class.

3. Create a new repository on GitHub to hold your application configuration data.  Call the repository "config-repo" or a name of your choosing.  Note the full URI of the repository, you will need this in a following step.

4. Add a new file to your GitHub repository called "{spring-application}-{profile}.yml” (or properties).
Add a key called "database.username" and value of "admin", or any other value of your favourite.
Create "test" branch,Add a key called "database.username" and a value of "[test]admin", or any other value of your choosing.

5. Back in your project, create an application.yml (or application.properties) file in the root of your classpath (src/main/resources recommended). 
Add the key "spring.cloud.config.server.git.uri" and the value "https://github.com/"YOUR-GITHUB-ID"/config-repo", substituting the value for Github ID and repository name as needed.  Also set the “server.port” to 8888.

6. Run the application.  Open the URL [http://localhost:8888/event-service/default/](http://localhost:8001/event-service/default/).  You should see the JSON result that will actually be used by Spring.  If the server is not working, review the prior steps to find the issue before moving on.

And please access the following url:
    /{application}/{profile}
    http://localhost:8888/event-service/development
    event-service-development.properties

    http://localhost:8888/event-service/production
    event-service-production.properties

    /{application}/{profile}[/{label}]
    http://localhost:8888/event-service/development/master
    event-service-development.properties in master branch

    http://localhost:8888/event-service/production/test
    http://localhost:8888/event-service/development/test
    event-service-production.properties in test branch

------------------------------------------------------------------------------------------

**Part 2 - Create Config Client:**

9. Create a new, separate Spring Boot application. 
Name the project "event-service", and use this value for the Artifact.  
Add the web dependency.  
Use Jar packaging and the latest versions of Java.  
	* access http://start.spring.io/ or any IDE, create a new project
	* Open ConfigServerApplication and add annotation @EnableConfigServer


10. Add a bootstrap.yml (or bootstrap.properties) file in the root of your classpath (src/main/resources recommended).  Add the following key/values using the appropriate format:
spring.application.name=event-service
server.port=8001
spring.cloud.config.uri=http://localhost:8888

_(Note that this file must be "boostrap" -- not "application" -- so that it is read early in the application startup process.  The server.port could be specified in either file, but the URI to the config server affects the startup sequence.)_

11. Add a REST controller to obtain and display the db relevant configurations:

12.  Start your client.  Open [http://localhost:9999](http://localhost:9999).  
You should see the config message in your browser.

------------------------------------------------------------------------------------------

** Part 3 - Access configuration file by Spring profile

13. Create a separate file in your GitHub repository called "event-service-production.properties” (or .yml).  
Populate it with the "db*" key and a different value than used in the original file.

14. Stop the client application.  Modify the boostrap file to contain a key of spring.profiles.active: production.  Save, and restart your client.  
Access the URL.  Which db* is displayed?  (You could also run the application with -Dspring.profiles.active=production rather than changing the bootstrap file)


------------------------------------------------------------------------------------------

** Part 4 - Access configuration file by automatically refresh
15. Add Spring Boot Actuator 
16. Return to your EventController and convert to @RefreshScope
17. Change the configuration in event-service.properties, for instance "database.password=password3333"
18. execute 'curl -X POST http://localhost:9999/refresh', you will get the result includes '["database.password"]' in console to represent the database.password has been changed
19. then, refresh the page 'http://localhost:9999', you will get the new password value in browser.

------------------------------------------------------------------------------------------




  