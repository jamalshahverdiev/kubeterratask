##### Build docker image with jenkins:
```bash
$ docker image build -t jamalshahverdiev/jenkapp .
```

##### Note: Use `docker login` command to login to your own account in the 'hub.docker.com' docker registry server.

##### Push new image to the registry server:
```bash
$ docker push jamalshahverdiev/jenkapp
```

Note: After starting jenkins go to the admin page and change admin password then, change `<useSecurity>false</useSecurity>` to `true` in the `/var/jenkins_home/config.xml` file 

##### To test your container just execute the following command and open http://jenkins_ip:8091 linkin your web browser:
```bash
$ docker container run -d --name jenkins -p 8091:8080 -p 50000:50000 jamalshahverdiev/jenkapp
``` 
