
### `itzg/minecraft-server`

~~~ yml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: minecraft
  name: minecraft
spec:
  replicas: 1
  selector:
    matchLabels:
      app: minecraft
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: minecraft
    spec:
      containers:
      - image: itzg/minecraft-server:java17
        name: minecraft-server
        env:
        - name: EULA
          value: "TRUE"
        - name: ONLINE_MODE
          value: "FALSE"
        - name: DIFFICULTY
          value: peaceful
        - name: PVP
          value: "false"
        - name: UID
          value: "0"
        - name: GID
          value: "0"
        - name: MEMORY
          value: "4G"
        resources: {}
        ports:
        - containerPort: 25565
          protocol: TCP
        volumeMounts:
        - name: persistent-storage
          mountPath: /data
      volumes:
        - name: persistent-storage
          persistentVolumeClaim:
            claimName: minecraft-pvc
---
apiVersion: v1
kind: Service
metadata:
  labels:
    app: minecraft
  name: minecraft
spec:
  ports:
  - port: 25565
    protocol: TCP
    targetPort: 25565
  selector:
    app: minecraft
  type: NodePort
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: minecraft-pvc
spec:
  storageClassName: 你的存储类
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 100Gi
~~~

sc e.g.

~~~ yml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: minecraft-pvc
spec:
  storageClassName: blob-fuse
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 100Gi
---
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: blob-fuse
provisioner: blob.csi.azure.com
allowVolumeExpansion: true
parameters:
  # need: kubectl create secret generic azure-secret --from-literal azurestorageaccountname=[ACCOUNT HERE] --from-literal azurestorageaccountkey=[KEY HERE] --type=Opaque
  csi.storage.k8s.io/provisioner-secret-name: azure-secret
  csi.storage.k8s.io/provisioner-secret-namespace: default
  csi.storage.k8s.io/node-stage-secret-name: azure-secret
  csi.storage.k8s.io/node-stage-secret-namespace: default
~~~
