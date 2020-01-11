#### With the following code files we will prepare docker image with `index.html` app which return us `Hello World` in the `/` routing

#### From `FROM nginx` image `Dockerfile` does prepare environment and copies `index.html` file to the `/usr/share/nginx/html` public_html folder which at the run time will be listened on port `80`.

#### Note if you want to push your image like as public to the `https://hub.docker.com` registry server use this command `docker login` with the your own credentials.

#### Execute the following command inside of the current folder to prepare image and push it to the public `https://hub.docker.com` registry server
```bash
$ docker build -t jamalshahverdiev/ngapp .
$ docker push jamalshahverdiev/ngapp:latest
```

#### To run and test the current image use the following commands:
```bash
$ docker container run --name ngapp -p 8000:80 -d jamalshahverdiev/ngapp
$ curl -XGET http://localhost:8000/
Hello World.
```

