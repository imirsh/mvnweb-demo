
```
~]# docker run -d -p 8080:8080 registry.cn-beijing.aliyuncs.com/dengyou/mvnweb-demo:demo
```
```
~]# curl 127.0.0.1:8080/mvnwebapp/
<html>
<body>
<h2>Hello World!</h2>
  <h3>Successfully Deployed on Tomcat using Jenkins - Demo </h3>
</body>
</html>
```

```
~]# kubectl  get pod -o wide
NAME                                      READY   STATUS    RESTARTS   AGE     IP             NODE    NOMINATED NODE   READINESS GATES
mvnweb-demo-6c64d45468-cdnbv              1/1     Running   0          2m40s   10.244.2.121   node1   <none>           <none>
```

```
~]# curl 10.244.2.121:8080/mvnwebapp/
<html>
<body>
<h2>Hello World!</h2>
  <h3>Successfully Deployed on Tomcat using Jenkins - Demo </h3>
</body>
</html>
```
