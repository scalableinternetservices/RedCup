# RedCup

RedCup is a social networking service developed as the course project of CS291A Scalable Web Services@University of California, Santa Barbara. It is implemented with Ruby on Rails, and load-tested with Tsung.



### Deploy

During the course, RedCup is deployed to AWS Elastic Beanstalk. A simple way to do this is to run the following commands after ssh into your AWS account:

```
eb init --keyname $(whoami) --platform "64bit Amazon Linux 2 v3.3.7 running Ruby 2.7" --region us-west-2 RedCup
```

```
eb create --envvars SECRET_KEY_BASE=BADSECRET -db.engine postgres -db.i db.t3.micro -db.user u -i t3.micro --single <instance_name>
```

RedCup can also be deployed to other web services.



### Load Test

See README.txt in path `./tsung/`.



### Contributors

Chaofan Shou: @shouc

Lijuan Cheng: @lijuancheng

Xinyu Liu: @adaliuBC

Zuying Hu: @CollinHU