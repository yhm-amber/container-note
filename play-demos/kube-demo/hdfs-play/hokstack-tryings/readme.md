

### `hokstack/hokstack`

- https://github.com/hokstack/hok-helm.git
- https://artifacthub.io/packages/helm/hokstack/hokstack
- https://github.com/hokstack/hok-operator.git
- https://hokstack.io

#### install

~~~~ bash
helm repo add -- hok https://charts.hokstack.io
helm repo update
helm install --namespace hokstack-ns --create-namespace \
        --set postgres.storageClassName=openebs-jiva-csi-sc \
        --set ambariserver.persistentVolume.storageClassName=openebs-jiva-csi-sc \
        --set masternode.persistentVolume.storageClassName=local-hostpath,datanode.persistentVolume.storageClassName=local-hostpath \
        --set edgenode.persistentVolume.storageClassName=local-hostpath \
        --set kdc.persistentVolume.storageClassName=openebs-jiva-csi-sc \
        -- hokstack-app hok/hokstack
~~~~

