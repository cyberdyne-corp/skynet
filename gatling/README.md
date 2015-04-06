
Pre-requisites

* The backend app should be already up and running.
* A routable IP must be set in the .scala files

From the base directory of the project, start the simulation using:

```
mkdir -p /tmp/results
docker run -it --rm  -v $(pwd)/gatling/user-files:/opt/gatling/user-files -v /tmp/results:/opt/gatling/results denvazh/gatling
```

Then, with any decent web browser, point to the url indicated by gatling when the test ends. Don't forget to prepend "/tmp/" to that url!

