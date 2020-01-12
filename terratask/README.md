#### Get list of the CentOS based AMIs with the following command:

```bash
$ aws ec2 describe-images --owners aws-marketplace \
            --filters Name=product-code,Values=aw0evgkw8e5c1q413zgy5pjce \
            --query 'Images[*].[CreationDate,Name,ImageId]' \
            --filters "Name=name,Values=CentOS Linux 7*"  \
            --region eu-west-1 --output table | sort -r
```

#### Before start and deploy project into the AWS please generate `AWS_ACCESS_KEY` and `AWS_SECRET_KEY` from `AWS IAM` console with the Administrator permissions. Then, copy output from console and change values inside of the `vars.tf` file for the  `AWS_ACCESS_KEY` and `AWS_SECRET_KEY` variables. 

#### To connect the new EC2 instance in the AWS, we must provide SSH key and public file path in the `vars.tf` file for `PATH_TO_PRIVATE_KEY` and `PATH_TO_PUBLIC_KEY` variables. With the `ssh-keygen -t rsa` command we can generate one new key pair and then change path to the right ones (I have used under root beacuse, I don't need define `ssh -i private_key`. It will be used automatically because defined in the `/etc/ssh/ssh_config` file like as `IdentityFile` and it is comfortable). 

#### Execute thefollowing command to download needed plugins:
```bash
$ terraform init
```

#### Deploy infrastructure to the AWS (Copy output IP from executed command):
```bash
$ echo "yes" | terraform apply
```

#### Connect to the instance and try curl command:
```bash
$ ssh -oStrictHostKeyChecking=no centos@output_IP
$ curl http://ifconfig.io
$ cat /etc/os-release | grep PRETTY_NAME
PRETTY_NAME="CentOS Linux 7 (Core)"
```


