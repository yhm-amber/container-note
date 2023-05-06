[src/gh]: https://github.com/SigNoz/signoz.git "(Languages: TypeScript 58.2%, Go 40.2%, Shell 0.8%, JavaScript 0.4%, Makefile 0.2%, Dockerfile 0.1%, Other 0.1%) SigNoz is an open-source APM. It helps developers monitor their applications & troubleshoot problems, an open-source alternative to DataDog, NewRelic, etc. 🔥 🖥. 👉 Open source Application Performance Monitoring (APM) & Observability tool"

[site]: https://signoz.io/
[docs]: https://signoz.io/docs/

[🍌 src][src/gh] | [🍎 site][site] | [🥑 docs][docs]

~~~ sh
helm repo add -- signoz https://charts.signoz.io
helm repo list
~~~

~~~ sh
kubectl create ns -- plat

helm -n plat upgrade --install --set global.storageClass=... -- signoz signoz/signoz
: need a storage class set if u dont have a default.
~~~

~~~ sh
kubectl -n plat port-forward -- svc/"$(
    
    kubectl get svc -n plat -l "app.kubernetes.io/component=frontend" -o jsonpath="{.items[0].metadata.name}"
    
    )" 3301:3301
: then link the localhost:3301
~~~
