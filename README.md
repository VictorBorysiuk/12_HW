# Balancing and delivery by GeoIP in Nginx
## Goal
Set up load balancer on nginx with balancing and deleivery by GeoIP to one UK, two US and one server for rest countries. In case of failure send all traffic to backup server. Healtch check happen every 5 seconds.
 
## Run project
Change docker-compose file name for testing different balancing and delivery
```
docker-compose -f "docker-compose-US.yml" up
```
 
## Test balancing and delivery
Call application
```
curl balancer
curl localhost
```
 
And see results.
For US:
```
<!DOCTYPE html>
<html>
<body>
<h1>US</h1>
</body>
```
 
![image](https://user-images.githubusercontent.com/52753625/196203538-869f26c4-6a45-42ae-b228-9231f4c76d52.png)

![image](https://user-images.githubusercontent.com/52753625/196204828-e6606f33-5a42-4f13-b44d-ca6115051fd3.png)

 
For other:
```
<!DOCTYPE html>
<html>
<body>
<h1>rest</h1>
</body>
```

![image](https://user-images.githubusercontent.com/52753625/196203980-b5c7bba2-7efc-4843-bd1a-ed64597644fb.png)
