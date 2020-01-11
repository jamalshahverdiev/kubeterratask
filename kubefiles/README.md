
##### If you want to deploy Python app inside of the Kubernetes cluster first of all we must prepate nginx ingress controller itself. By default `kube-apiserver` port ragne is between `30000 - 32767`. If we want to expose needed port to our worker nodes we must change this range. That is why inside of the master nodes we will edit `/etc/kubernetes/manifests/kube-apiserver.yaml` file and add `- --service-node-port-range=1-32767` line to change port range. 
`Note:` We must restart `kube-apiserver` services in the master nodes.

##### Create new `namespace` for our Ingress controller
```bash
$ kubectl create namespace ingress
```
##### Create deployment and service for the Nginx ingress controller to get healtch `/healthz` check from port  `8080` in the `ingress` namespace.
```bash
$ kubectl create -f default-backend-deployment.yaml -f default-backend-service.yaml -n=ingress
```

##### Inside the `ingress` namespace create new `configmap` which will be used inside the `nginx-ingress-controller`:
```bash
$ kubectl create -f nginx-ingress-controller-config-map.yaml -n=ingress
```

##### Create new RBAC to get access to the API endpoints for our *ServiceAccount* with name `nginx` which will be used in the `nginx-ingress-controller` Deployment.
```bash
$ kubectl create -f nginx-ingress-controller-roles.yaml -n=ingress
```

##### Now create `nginx-ingress-controller` which will use app `nginx-ingress-lb` inside `nginx-ingress` service. It will select `default-backend` service, configmap and *ServiceAccount* `nginx` which we created before.
```bash
$ kubectl create -f nginx-ingress-controller-deployment.yaml -n=ingress
```

##### Create Ingress rule to health check of controller itself:
```bash
$ kubectl create -f nginx-ingress.yaml -n=ingress
``` 

##### Create our python app with the following command (It will create `pythonapp` deployment with the selection of `pythonapp` conatiner and with the 3 pod replicas. Then it will create the service with name `python-service` which matchs to the created deployment `pythonapp`):
```bash
$ kubectl create -f pythondockerpod.yaml
```

`Note:` To use `nginxingress.loc` DNS name we must add new zone to our DNS server with the `A` records for our worker nodes. Otherwise we must add DNS name with the IP addresses of worker nodes to the `c:\windows\system32\drivers\etc\hosts`(For the windows Desktop) or `/etc/hosts` (For the Linux Desktop file) file.

##### Create new `python-ingress` Ingress with name which matchs to our `python-service` service which listen on the port `8080`. As the external DNS name we must use `nginxingress.loc`.
```bash
$ kubectl create -f pythoningress.yaml
```

`Note:` If you want use GoAPP inside of the Kubernetes cluster, just execute `kubectl create -f godockerpod.yaml` and `kubectl create -f goingress.yaml` commands.

##### At the end just execute the following command to create service with name `nginx-ingress` which exposes port `80` to our ingress controller which mapped our ingress rule in the port `8080`.
```bash
$ kubectl create -f nginx-ingress-controller-service.yaml -n=ingress
```

##### Result must be like as the following:
```bash
$ curl -XGET http://nginxingress.loc/
Success!
$ curl -XGET http://nginxingress.loc/ping
Ok
```

##### Or:
![RESULT](images/RESULT.PNG)
