#### With the following code files we will prepare docker image to push `example.war` for `/sample` routing

#### From `tomcat:8.0` image `Dockerfile` does prepare environment and copies `sample.war` file to the `/usr/local/tomcat/webapps/` deploy folder which at the run time will be listened on the `8080` port.

#### Note if you want to push your image like as public to the `https://hub.docker.com` registry server use this command `docker login` with the your own credentials.

#### Execute the following command inside of the current folder to prepare image and push it to the public `https://hub.docker.com` registry server
```bash
$ docker image build -t jamalshahverdiev/tv8app . 
$ docker push jamalshahverdiev/tv8app:latest
```

#### To run and test the current image use the following commands:
```bash
$ docker container run --name tv8app -d --publish 8090:8080 jamalshahverdiev/tv8app
$ curl -s -XGET http://localhost:8090/sample/ | egrep 'title'
<title>Sample "Hello, World" Application</title>
```
