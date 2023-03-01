[src/gh]: https://github.com/trinodb/trino.git "(Apache-2.0) (Languages: Java 99.5%, JavaScript 0.3%, ANTLR 0.1%, Shell 0.1%, HTML 0.0%, CSS 0.0%) Official repository of Trino, the distributed SQL query engine for big data, formerly known as PrestoSQL"
[docs]: https://trino.io/docs/current
[blog:from-presto]: https://trino.io/blog/2021/01/04/migrating-from-prestosql-to-trino.html
[blog:renameto-trino]: https://trino.io/blog/2020/12/27/announcing-trino.html
[site]: https://trino.io

[docs:containers]: https://trino.io/docs/current/installation/containers.html ": install if needed and run : ; docker run --name trino -d -p 8080:8080 -- trinodb/trino ; : client : ; trino --server http://localhost:8080"
[docs:kubernetes]: https://trino.io/docs/current/installation/kubernetes.html ": repo add : ; helm repo add -- trino https://trinodb.github.io/charts ; : install : ; helm install -- example-trino-cluster trino/trino ; : run : ; POD_NAME=$(kubectl get pods -l 'app=trino,release=example-trino-cluster,component=coordinator' -o name) && kubectl port-forward -- $POD_NAME 8080:8080 ; : client is same : ; : helm set demo : --set server.workers=3,coordinator.jvm.maxHeapSize=8G,worker.jvm.maxHeapSize=8G,image.tag=latest"

[oci/dockerhub]: https://hub.docker.com/r/trinodb/trino
