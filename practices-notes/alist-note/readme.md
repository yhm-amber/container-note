
[repo]: https://github.com/alist-org/alist.git
[repo-past]: https://github.com/Xhofe/alist.git
[site]: https://alist.nn.ci
[docs]: https://alist.nn.ci/guide
[demo]: https://al.nn.ci

~~~ sh
: daemon, port 5244

docker run -d --restart=always \
  -v alist-disco:/opt/alist/data \
  -p 5244:5244 --name="alist" \
  -- xhofe/alist:latest ; 

: get user,pass

docker logs -- alist ; 
~~~

