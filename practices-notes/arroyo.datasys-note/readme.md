[src/gh]: https://github.com/ArroyoSystems/arroyo.git "(MIT Apache-2.0) (Languages: Rust 75.1%, TypeScript 23.8%, Dockerfile 0.5%, Smarty 0.2%, CSS 0.1%, HTML 0.1%, Other 0.2%) Distributed stream processing engine in Rust"
[site]: https://www.arroyo.dev/ "Arroyo - Serverless stream processing"
[docs]: https://doc.arroyo.dev/ ""

[🍥 docs][docs] | [⛵ site][site] | [👾 src][src/gh]




[docs:deploy/nomad]: https://doc.arroyo.dev/deployment/nomad
[docs:deploy/kubernetes]: https://doc.arroyo.dev/deployment/kubernetes

### nomad

*needs:* 

[needs:nomad-pack]: https://developer.hashicorp.com/nomad/tutorials/nomad-pack/nomad-pack-intro "Introduction to Nomad Pack | Nomad | HashiCorp Developer"

- [nomad pack][needs:nomad-pack]

[*ref*][docs:deploy/nomad]

~~~ sh
nomad-pack registry add -- arroyo https://github.com/ArroyoSystems/arroyo-nomad-pack.git ;

nomad-pack run arroyo --registry=arroyo \
    --var arroyo.postgres_db=arroyo \
    --var arroyo.postgres_host=postgres-host.cluster \
    --var arroyo.postgres_user=arroyodb \
    --var arroyo.postgres_password=arroyodb \
    --var arroyo.datacenters='["us-east-1"]' \
    --var arroyo.s3_bucket=arroyo-prod \
    --var arroyo.prometheus_endpoint="http://prometheus.cluster:9090" ;

nomad service info api-http ;
~~~

### kubernetes

[*ref*][docs:deploy/kubernetes]

~~~ sh
helm repo add -- arroyo https://arroyosystems.github.io/helm-repo
helm show values -- arroyo/arroyo
~~~


~~~ sh
: no s3 simple :

helm install arroyo arroyo/arroyo -f <(echo '
outputDir: "/tmp/arroyo-test"

volumes:
  - name: checkpoints
    hostPath:
      path: /tmp/arroyo-test
      type: DirectoryOrCreate

volumeMounts:
  - name: checkpoints
    mountPath: /tmp/arroyo-test') ;

kubectl get service/arroyo-api -o jsonpath='{.spec.clusterIP}' ;
~~~

~~~ sh
: eks example :

helm install arroyo arroyo/arroyo -f <(echo '
postgresql:
    externalDatabase:
    host: db.prod.iad.arroyo.cluster
    name: arroyo_test
    user: arroyodb
    password: arroyodb

s3:
  bucket: "arroyo-testing"
  region: "us-east-1"') ;

kubectl port-forward service/arroyo-api 8000:80 8001:8001 ;
~~~
