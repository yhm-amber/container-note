test `podman` :


<pre><font color="#55FFFF"><b>container-note/build-practices/simple-proxy</b></font> on <font color="#FF55FF"><b> main</b></font> 
<font color="#55FF55"><b>❯</b></font> podman build -t &quot;$(basename &quot;$PWD&quot;)&quot; -f Dockerfile -- .
STEP 1/7: FROM nginx:stable-alpine
<font color="#00AA00">✔</font> docker.io/library/nginx:stable-alpine
Trying to pull docker.io/library/nginx:stable-alpine...
Getting image source signatures
Copying blob 28e475967295 done  
Copying blob 971eae4ccd5e done  
Copying blob 59259a997d36 done  
Copying blob 8663204ce13b done  
Copying blob 7b91d4d13e7e done  
Copying blob 68135565c585 done  
Copying config 5c05ca0458 done  
Writing manifest to image destination
Storing signatures
STEP 2/7: COPY nginx.conf /etc/nginx/nginx.conf
--&gt; d786df4aadc
STEP 3/7: RUN mkdir /etc/nginx/stream-conf.d
--&gt; 8f978f6cbf1
STEP 4/7: COPY get-stream-conf.sh /get-stream-conf.sh
--&gt; 5ec71baf079
STEP 5/7: COPY start.sh /start.sh
--&gt; ebaadd0aeaf
STEP 6/7: COPY readme /readme
--&gt; eb729b6cf57
STEP 7/7: COPY Dockerfile /Dockerfile
COMMIT simple-proxy
--&gt; 36aa634f657
Successfully tagged localhost/simple-proxy:latest
36aa634f6570127562f4014597c4d949a778ffa362a09bbef22ec9604b86f649

<font color="#55FFFF"><b>container-note/build-practices/simple-proxy</b></font> on <font color="#FF55FF"><b> main</b></font> took <font color="#FFFF55"><b>40s</b></font> 
<font color="#55FF55"><b>❯</b></font> </pre>
