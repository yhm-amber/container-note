

klist_msvc ()
{
    
    : demo
    : REPLICAS=0 PLATMARK=ahaha NGINX_CONF='"$(cat xxx.conf)"' HOST_ALIASES='"$(cat hosts.yml)"'   klist_msvc   gateway=hub.io/out/gateway:latest  portal=hub.io/auth/portal:latest  ...
    
    
    main ()
    {
        : main gateway=hub.io/out/gateway:latest portal=hub.io/auth/portal:latest ...
        
        : ::: ::: :
        
        local PLATMARK="${PLATMARK:-funplat}" &&
        local REPLICAS="${REPLICAS:-0}" &&
        local MODULES="${MODULES:-nacos mysql redis es harbor}" &&
        
        export -- PLATMARK REPLICAS MODULES LISTPART_MODS HOST_ALIASES NGINX_CONF LISTPART_WEB LISTPART_DICT KUBELIST_BG KUBELIST_ED &&
        export -f -- kubelist &&
        
        local m="$( : &&
            
            rtb = "$@" |
                
                xargs -i -- sh -c 'kubelist micro_part {}' &&
            
            : )" &&
        
        local bg="$( : &&
            
            kubelist part KUBELIST_BG LISTPART_MODS LISTPART_DICT LISTPART_WEB &&
            
            : )" &&
        
        local ed="$(
            
            kubelist part KUBELIST_ED &&
            
            : )" &&
        
        
        echo "$bg" &&
        printf %s "$m" &&
        echo "$ed" &&
        
        :;
        
    } &&
    
    rtb ()
    {
        : W=app rtb = /opt/sdk=/opt/sdk xxx/app=/opt/app
        : get: xxx/app /opt/app
        
        : W=app F='(NF+1)"mv","from/"$1,"to/"$2' rtb : /opt/sdk:/opt/sdk /xxx/app:/opt/app
        : get: mv from//xxx/app to//opt/app
        
        :;
        
        local sp="$1" && shift 1 &&
        
        for pair in "$@" ;
        do
            echo "$pair" | tr "$sp" ' ' ;
        done |
            
            awk /"$W"/'{print$'"${F:-0}"'}' &&
        
        :;
    } &&
    
    kubelist ()
    {
        : kubelist micro_part xxx xxx ...
        : kubelist part KUBELIST_BG
        : kubelist part KUBELIST_ED
        : NGINX_CONF='"$(cat xxx/yyy.conf)"' kubelist part KUBELIST_BG KUBELIST_ED
        
        : :::: :::: :
        
        part ()
        {
            : part HOST_ALIASES
            : part KUBELIST_BG LISTPART_DICT KUBELIST_ED
            : NGINX_CONF='"$(cat xxx/yyy.conf)"' HOST_ALIASES='"$(cat xxx/hhh.yml)"' part KUBELIST_BG LISTPART_DICT
            
            : ::: ::: :
            
            part_def ()
            {
                : partsfun HOST_ALIASES "xxx..."
                
                : ::: :
                
                local k="$1" && shift 1 &&
                local v="$1" && shift 1 &&
                
                eval "
                    
                    $k ()"'
                    {
                        if : &&
                        (
                            test -z "$'"$k"'" ) ;
                        
                        then
                            
                            printf %s '"'$v'"' ;
                            
                        else
                            
                            printf %s "$'"$k"'" ;
                            
                        fi ;
                    } ' &&
                
                :;
                
            } &&
            
            part_def HOST_ALIASES "hostAliases:
  -
    hostnames:
      - node1
    ip: 10.101.100.21
  -
    hostnames:
      - node2
    ip: 10.101.100.22
  -
    hostnames:
      - node3
    ip: 10.101.100.23" &&
            
            
            
            part_def NGINX_CONF '# user  nobody;

worker_processes 1;

# error_log  logs/error.log;
# error_log  logs/error.log  notice;
# error_log  logs/error.log  info;

# pid        logs/nginx.pid;

events {
    worker_connections 1024;
}


http {
    include mime.types ;
    default_type application/octet-stream ;
    sendfile on ;
    
    keepalive_timeout 54 ;
    
    upstream gateway.domain {
        server gateway.{{ .Values.app.name }}-'"${PLATMARK}"'.svc.cluster.local:8080 weight=1 ;
    }
    
    server {
        listen 80 ;
        server_name ~^.*$ ;
        
        location / {
            root /usr/share/nginx/html ;
            index index.html index.htm ;
        }
        
        location /download {
            alias /mnt/downfile ;
            index index.html index.htm ;
            add_header Content-Disposition attachment ;
        }
        
        location /api {
            
            proxy_pass http://gateway.domain/api ;
            
            proxy_set_header   X-Forwarded-Proto $scheme ;
            proxy_set_header   Host              $http_host ;
            proxy_set_header   X-Real-IP         $remote_addr ;
            proxy_set_header   X-Forwarded-For   $proxy_add_x_forwarded_for ;
        }
        
        location /metadata {
            
            proxy_pass http://gateway.domain/api/data-metadata ;
            
            proxy_set_header   X-Forwarded-Proto $scheme ;
            proxy_set_header   Host              $http_host ;
            proxy_set_header   X-Real-IP         $remote_addr ;
            proxy_set_header   X-Forwarded-For   $proxy_add_x_forwarded_for ;
        }
        
    }
} ' &&
            
            part_def LISTPART_MODS "$(module_parts ${MODULES})" &&
            
            part_def LISTPART_WEB "
  -
    kind: Service
    metadata:
      name: ${PLATMARK}-web
      namespace: {{ .Values.app.name }}-${PLATMARK}
    spec:
      ports:
        - name: http
          protocol: TCP
          port: 80
          targetPort: 80
          nodePort: {{ .Values.svc.np }}
      selector:
        workload.app.${PLATMARK}.io/workloadselector.microsvc: svc.webout.{{ .Values.app.name }}-${PLATMARK}
      type: NodePort
      sessionAffinity: None
      externalTrafficPolicy: Cluster
    apiVersion: v1
  -
    kind: Deployment
    metadata:
      name: webout
      namespace: {{ .Values.app.name }}-${PLATMARK}
      labels:
        workload.app.${PLATMARK}.io/workloadselector.microsvc: svc.webout.{{ .Values.app.name }}-${PLATMARK}
    spec:
      replicas: ${REPLICAS}
      selector:
        matchLabels:
          workload.app.${PLATMARK}.io/workloadselector.microsvc: svc.webout.{{ .Values.app.name }}-${PLATMARK}
      template:
        metadata:
          labels:
            workload.app.${PLATMARK}.io/workloadselector.microsvc: svc.webout.{{ .Values.app.name }}-${PLATMARK}
        spec:
          volumes:
            - name: webout-conf
              configMap:
                name: webout
                defaultMode: 420
            - name: host-time
              hostPath:
                path: /etc/localtime
                type: \"\"
          containers:
            - name: webout
              image: \"hub.io/man/webout:latest\"
              ports:
                - name: http
                  containerPort: 80
                  protocol: TCP
              volumeMounts:
                - name: host-time
                  readOnly: true
                  mountPath: /etc/localtime
                - name: webout-conf
                  readOnly: true
                  mountPath: /etc/nginx/nginx.conf
                  subPath: nginx.conf
                - name: webout-conf
                  mountPath: /usr/share/nginx/html/config.js
                  subPath: config-value.js
              terminationMessagePath: /dev/termination-log
              terminationMessagePolicy: File
              imagePullPolicy: Always
          restartPolicy: Always
          terminationGracePeriodSeconds: 30
          dnsPolicy: ClusterFirst
          imagePullSecrets:
            - name: {{ .Values.app.name }}-hubsec-${PLATMARK}
          affinity:
            podAntiAffinity:
              preferredDuringSchedulingIgnoredDuringExecution:
                - weight: 100
                  podAffinityTerm:
                    labelSelector:
                      matchLabels:
                        workload.app.${PLATMARK}.io/workloadselector.microsvc: svc.webout.{{ .Values.app.name }}-${PLATMARK}
                    topologyKey: kubernetes.io/hostname
          $(echo && HOST_ALIASES | awk '{print"          "$0}')
          schedulerName: default-scheduler
      strategy:
        type: RollingUpdate
        rollingUpdate:
          maxUnavailable: 25%
          maxSurge: 25%
      revisionHistoryLimit: 10
      progressDeadlineSeconds: 600
    apiVersion: apps/v1" &&
            
            
            part_def LISTPART_DICT "
  -
    kind: Secret
    metadata:
      name: {{ .Values.app.name }}-hubsec-${PLATMARK}
      namespace: {{ .Values.app.name }}-${PLATMARK}
    data:
      .dockerconfigjson: >-
        eyJhdXRocyI6eyJodHRwOi8vMTAuMjguMy4yMDE6MzE3OTciOnsidXNlcm5hbWUiOiJhZG1pbiIsInBhc3N3b3JkIjoiYWRtaW4ifX19
    type: kubernetes.io/dockerconfigjson
    apiVersion: v1
  -
    kind: ConfigMap
    metadata:
      name: ${PLATMARK}-envs
      namespace: {{ .Values.app.name }}-${PLATMARK}
    data:
      PARAMS: >-
        -Dspring.cloud.nacos.server-addr=nacos-hs.{{ .Values.app.name }}-nacos-${PLATMARK}.svc.cluster.local:8848
        -Dfile.encoding=UTF8 -Dsun.jnu.encoding=UTF8
        -Dspring.cloud.nacos.discovery.namespace=public
    apiVersion: v1
  -
    kind: ConfigMap
    metadata:
      name: webout
      namespace: {{ .Values.app.name }}-${PLATMARK}
    data:
      config-value.js: |-
        
        (function (window){
          window.\$config = {
            BASE_URL: \"\",
          };
        })(window);
        
      nginx.conf: |-
        
        $(echo && NGINX_CONF | awk '{print"        "$0}')
    
    apiVersion: v1" &&
            
            part_def KUBELIST_BG "
kind: List
items: " &&
            
            part_def KUBELIST_ED "
apiVersion: v1" &&
            
            : :: &&
            
            for P in "$@" ;
            do
                "$P" || return $? ;
            done &&
            
            :;
            
        } &&
        
        module_parts ()
        {
            : module_parts harbor nacos mysql ...
            
            : :::: :
            
            module_part ()
            {
                : module_part harbor
                
                local mod_name="$1" && shift 1 &&
                
                printf %s "
  -
    kind: Namespace
    metadata:
      labels:
        kubesphere.io/namespace: {{ .Values.app.name }}-${mod_name}-${PLATMARK}
        kubesphere.io/workspace: {{ .Values.app.name }}-${PLATMARK}
      name: {{ .Values.app.name }}-${mod_name}-${PLATMARK}
    apiVersion: v1" &&
                
                :;
                
            } &&
            
            : &&
            
            (
                
                printf %s "
  -
    kind: Workspace
    metadata:
      name: {{ .Values.app.name }}-${PLATMARK}
    apiVersion: tenant.kubesphere.io/v1alpha1" &&
                
                printf %s "
  -
    kind: Namespace
    metadata:
      labels:
        kubesphere.io/namespace: {{ .Values.app.name }}-${PLATMARK}
        kubesphere.io/workspace: {{ .Values.app.name }}-${PLATMARK}
      name: {{ .Values.app.name }}-${PLATMARK}
    apiVersion: v1" &&
                
                : ) &&
            
            for m in "$@" ;
            do
                module_part "$m" ;
            done &&
            
            :;
            
        } &&
        
        micro_part ()
        {
            : micro_part gateway hub.io/out/gateway:latest
            
            
            : :::: :
            
            local micro_name="$1" && shift 1 &&
            local image_name="$1" && shift 1 &&
            
            echo "  -
    kind: Deployment
    metadata:
      name: ${micro_name}
      namespace: {{ .Values.app.name }}-${PLATMARK}
      labels:
        workload.app.${PLATMARK}.io/workloadselector.microsvc: svc.${micro_name}.{{ .Values.app.name }}-${PLATMARK}
    spec:
      replicas: ${REPLICAS}
      selector:
        matchLabels:
          workload.app.${PLATMARK}.io/workloadselector.microsvc: svc.${micro_name}.{{ .Values.app.name }}-${PLATMARK}
      template:
        metadata:
          labels:
            workload.app.${PLATMARK}.io/workloadselector.microsvc: svc.${micro_name}.{{ .Values.app.name }}-${PLATMARK}
        spec:
          volumes:
            - name: host-time
              hostPath:
                path: /etc/localtime
                type: ''
          containers:
            - name: ${micro_name}
              image: '${image_name}'
              ports:
                - name: micro
                  containerPort: 8080
                  protocol: TCP
              env:
                - name: PARAMS
                  valueFrom:
                    configMapKeyRef:
                      name: ${PLATMARK}-envs
                      key: PARAMS
              volumeMounts:
                - name: host-time
                  readOnly: true
                  mountPath: /etc/localtime
              terminationMessagePath: /dev/termination-log
              terminationMessagePolicy: File
              imagePullPolicy: Always
          restartPolicy: Always
          terminationGracePeriodSeconds: 30
          dnsPolicy: ClusterFirst
          serviceAccountName: default
          serviceAccount: default
          imagePullSecrets:
            - name: {{ .Values.app.name }}-hubsec-${PLATMARK}
          affinity:
            podAntiAffinity:
              preferredDuringSchedulingIgnoredDuringExecution:
                - weight: 100
                  podAffinityTerm:
                    labelSelector:
                      matchLabels:
                        workload.app.${PLATMARK}.io/workloadselector.microsvc: svc.${micro_name}.{{ .Values.app.name }}-${PLATMARK}
                    topologyKey: kubernetes.io/hostname
          $(echo && part HOST_ALIASES | awk '{print"          "$0}')
          schedulerName: default-scheduler
      strategy:
        type: RollingUpdate
        rollingUpdate:
          maxUnavailable: 25%
          maxSurge: 25%
      revisionHistoryLimit: 10
      progressDeadlineSeconds: 600
    apiVersion: apps/v1" &&
            
            :;
            
        } &&
        
        "$@" &&
        
        :;
        
    } &&
    
    (PLATMARK="$PLATMARK" REPLICAS="$REPLICAS" MODULES="$MODULES" LISTPART_MODS="$LISTPART_MODS" NGINX_CONF="$NGINX_CONF" HOST_ALIASES="$HOST_ALIASES" LISTPART_WEB="$LISTPART_WEB" main "$@") &&
    
    :;
    
} ;

