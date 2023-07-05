[src/gh]: https://github.com/bytebase/bytebase.git "(Languages: Go 49.4%, TypeScript 25.0%, Vue 23.4%, PLpgSQL 1.5%, CSS 0.4%, Shell 0.2%, Other 0.1%) Database CI/CD for DevOps teams."
[demo/site]: https://demo.bytebase.com
[docs/site]: https://bytebase.com/docs
[site]: https://bytebase.com

[👾 site][site] | [🍥 src][src/gh] | [🥗 demo][demo/site] | [📓 docs][docs/site]

ref: 

- [Docker (5 seconds) | Bytebase Docs](https://www.bytebase.com/docs/get-started/install/deploy-with-docker)
- [Deploy to Kubernetes | Bytebase Docs](https://www.bytebase.com/docs/get-started/install/deploy-to-kubernetes)
- [Deploy to sealos | Bytebase Docs](https://www.bytebase.com/docs/get-started/install/deploy-to-sealos)
- [bytebase 1.0.1 · bytebase/bytebase | ArtifactHub](https://artifacthub.io/packages/helm/bytebase/bytebase)

~~~ sh
: start Bytebase on container port 8080 and bind to localhost:5678
docker run --init --name bytebase --restart always \
  --publish 5678:8080 --port 8080 \
  --health-cmd "curl --fail http://localhost:5678/healthz || exit 1" \
  --health-interval 5m --health-timeout 60s \
  --data /var/opt/bytebase --volume data-bytebase:/var/opt/bytebase \
  --platform linux/amd64 \
  -- bytebase/bytebase:1.14.0 ;

: start Bytebase on port 80 and visit Bytebase from https://bytebase.example.com
docker run --init --name bytebase --restart always \
  --external-url https://bytebase.example.com \
  --publish 80:8080 --port 8080 \
  --health-cmd "curl --fail http://localhost:80/healthz || exit 1" \
  --health-interval 5m --health-timeout 60s \
  --data /var/opt/bytebase --volume data-bytebase:/var/opt/bytebase \
  --platform linux/amd64 \
  -- bytebase/bytebase:1.14.0 ;

: data will in volume data-bytebase.
~~~

~~~ sh
: Prerequisites
: - Kubernetes 1.24+
: - Helm 3.9.0+

: repo
helm repo add -- bytebase https://bytebase.github.io/bytebase/

: install
helm -n <YOUR_NAMESPACE> \
--set "bytebase.option.port"={PORT} \
--set "bytebase.option.external-url"={EXTERNAL_URL} \
--set "bytebase.option.pg"={PGDSN} \
--set "bytebase.version"={VERSION} \
--set "bytebase.persistence.enabled"={TRUE/FALSE} \
--set "bytebase.persistence.storage"={STORAGE_SIZE} \
--set "bytebase.persistence.storageClass"={STORAGE_CLASS} \
upgrade --install -- <RELEASE_NAME> bytebase-repo/bytebase

: install eg
helm -n bytebase \
--set "bytebase.option.port"=443 \
--set "bytebase.option.external-url"="https://demo.some.bytebase.com" \
--set "bytebase.option.pg"="postgresql://bytebase:bytebase@database.bytebase.ap-east-1.rds.amazonaws.com/bytebase" \
--set "bytebase.version"=1.12.0 \
--set "bytebase.persistence.enabled"="true" \
--set "bytebase.persistence.storage"="10Gi" \
--set "bytebase.persistence.storageClass"="csi-disk" \
upgrade --install -- bytebase-release bytebase-repo/bytebase
~~~




