
~~~ sh
: daemon, port 5244

docker run -d --restart=always \
  -v alist-disco:/opt/alist/data \
  -p 5244:5244 --name="alist" \
  -- xhofe/alist:latest ; 

: get user,pass

docker logs -- alist ; 
~~~

