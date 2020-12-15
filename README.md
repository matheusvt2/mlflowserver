# mlflowserver
Mlflow server image with some essential dependencies.

[Mlflow Documentation](https://www.mlflow.org/docs/latest/tracking.html)

## Objective

Provide an easy-to-go version of Mlflow with minimum effort for the user.


## Env list

- BACKEND_URI - Choose here your backend, can be:
    - Database - `<dialect>+<driver>://<username>:<password>@<host>:<port>/<database>`
    - File store - `./path_to_store or file:/path_to_store`

- ARTIFACT_ROOT - Where mlflow will save your artifacts (images, models, etc), can be:
    - Bucket (s3, min.io) - `s3://my-mlflow-bucket/`
    - Directory - `./mlruns`

- MLFLOW_PORT - Port to expose (inside your container).

## Examples

First of all, lets start a mysql container:

```
docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=root -e MYSQL_TCP_PORT=3306 -p 3306:3306  mysql:latest mysql --default-authentication-plugin=mysql_native_password
```
Now, just star a container setting the BACKEND_URI, MLFLOW_PORT and  ARTIFACT_ROOT as follow:

```
docker run -it --rm --name mlflow -p 5000:5000 -e BACKEND_URI=mysql+pymysql://root:root@192.168.15.17:3306/mlflow -e MLFLOW_PORT=5000 -e ARTIFACT_ROOT=/mlflow/mlflow-artifacts  matheusvt/mlflowserver:1.12.1
Artifact Root is /mlflow/mlflow-artifacts
```

## Recommendations
This image runs with a non-root user *mlflow*, so, be aware that changing the ARTIFACT_ROOT to a path outside /mlflow/ will cause permission issues.

It is highly reccomended to use a bucket to store your artifacts. Can't use AWS? Don't worry, it works fine with (min.io)[]