## Intro to aws ssh access to ec2 nodes plus installing cockroach and running through demo


### Step 0 - start node

```
~/projects/CLF-C01_AWS-Certified-Cloud-Practitioner_notes_and_scripts $ ./aws-ec2-describe-instance-start.sh i-0f4b5b1ab299e960e
Pre state (all instances)
InstanceId		State&code	Tag
i-0f4b5b1ab299e960e	stopped	None	None
Startingg  i-0f4b5b1ab299e960e
{
    "StartingInstances": [
        {
            "InstanceId": "i-0f4b5b1ab299e960e",
            "CurrentState": {
                "Code": 0,
                "Name": "pending"
            },
            "PreviousState": {
                "Code": 80,
                "Name": "stopped"
            }
        }
    ]
}
Post state (all instances)
InstanceId		State&code	Tag
i-0f4b5b1ab299e960e	pending	None	None
```



## Step 1 - connect via ssh
Before you can connect via ssh you need
* the .pem file generated when you created the ec2 instance i.e. `~/.ssh/sb20220516.pem` in my SandBox 2022-05-16 example  
* public IP address (can be seen via consul)



```
~/projects/CLF-C01_AWS-Certified-Cloud-Practitioner_notes_and_scripts $ ssh -i ~/.ssh/sb20220516.pem ec2-user@184.73.118.53
Last login: Mon May 16 20:20:08 2022 from ec2-18-206-107-24.compute-1.amazonaws.com

       __|  __|_  )
       _|  (     /   Amazon Linux 2 AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-2/
2 package(s) needed for security, out of 6 available
Run "sudo yum update" to apply all updates.
-bash: warning: setlocale: LC_CTYPE: cannot change locale (UTF-8): No such file or directory
```

I don't know too much about Amazon Linux but it appears to be using yum/rpm

```
[ec2-user@ip-10-0-0-70 ~]$ sudo -i
[root@ip-10-0-0-70 ~]# yum list installed
Failed to set locale, defaulting to C
Loaded plugins: extras_suggestions, langpacks, priorities, update-motd
Installed Packages
GeoIP.x86_64                                                                     1.5.0-11.amzn2.0.2                                                       installed
PyYAML.x86_64                                                                    3.10-11.amzn2.0.2                                                        installed
...
[root@ip-10-0-0-70 ~]# uptime
 16:50:15 up 16 min,  1 user,  load average: 0.00, 0.00, 0.00
```



### Step 2 - install cockroach 

Normally we would do this on a non-public node

```
[root@ip-10-0-0-70 ~]# yum list available|grep roach
Failed to set locale, defaulting to C
```

Following https://www.cockroachlabs.com/docs/v22.1/install-cockroachdb-linux

```
[root@ip-10-0-0-70 ~]# curl https://binaries.cockroachdb.com/cockroach-v22.1.0.linux-amd64.tgz | tar -xz && sudo cp -i cockroach-v22.1.0.linux-amd64/cockroach /usr/local/bin/
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 82.4M  100 82.4M    0     0  24.7M      0  0:00:03  0:00:03 --:--:-- 24.7M
[root@ip-10-0-0-70 ~]# mkdir -p /usr/local/lib/cockroach
[root@ip-10-0-0-70 ~]# cp -i cockroach-v22.1.0.linux-amd64/lib/libgeos.so /usr/local/lib/cockroach/
[root@ip-10-0-0-70 ~]# cp -i cockroach-v22.1.0.linux-amd64/lib/libgeos_c.so /usr/local/lib/cockroach/
[root@ip-10-0-0-70 ~]# which cockroach
/usr/bin/which: no cockroach in (/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin)
[root@ip-10-0-0-70 ~]# env|grep ^PATH
PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
[root@ip-10-0-0-70 ~]# PATH=$PATH:/usr/local/bin/
[root@ip-10-0-0-70 ~]# env|grep PATH
PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/usr/local/bin/
[root@ip-10-0-0-70 ~]# which cockroach
/usr/local/bin/cockroach
```

and testing via `cockroach demo`
```
[root@ip-10-0-0-70 ~]# cockroach demo
#
# Welcome to the CockroachDB demo database!
#
# You are connected to a temporary, in-memory CockroachDB cluster of 1 node.
#
# This demo session will attempt to enable enterprise features
# by acquiring a temporary license from Cockroach Labs in the background.
# To disable this behavior, set the environment variable
# COCKROACH_SKIP_ENABLING_DIAGNOSTIC_REPORTING=true.
#
# Beginning initialization of the movr dataset, please wait...
#
# The cluster has been preloaded with the "movr" dataset
# (MovR is a fictional vehicle sharing company).
#
# Reminder: your changes to data stored in the demo session will not be saved!
#
# If you wish to access this demo cluster using another tool, you will need
# the following details:
#
#   - Connection parameters:
#     (webui)    http://127.0.0.1:8080/demologin?password=demo3643&username=demo
#     (sql)      postgresql://demo:demo3643@127.0.0.1:26257/movr?sslmode=require
#     (sql/jdbc) jdbc:postgresql://127.0.0.1:26257/movr?password=demo3643&sslmode=require&user=demo
#     (sql/unix) postgresql://demo:demo3643@/movr?host=%2Ftmp%2Fdemo3484047053&port=26257
#
#   - Username: "demo", password: "demo3643"
#   - Directory with certificate files (for certain SQL drivers/tools): /tmp/demo3484047053
#
# Server version: CockroachDB CCL v22.1.0 (x86_64-pc-linux-gnu, built 2022/05/23 16:27:47, go1.17.6) (same version as client)
# Cluster ID: ec84db60-daef-43a2-81e0-c54654ad439e
# Organization: Cockroach Demo
#
# Enter \? for a brief introduction.
#
demo@127.0.0.1:26257/movr> SELECT ST_IsValid(ST_MakePoint(1,2));
  st_isvalid
--------------
     true
(1 row)


Time: 1ms total (execution 1ms / network 0ms)

demo@127.0.0.1:26257/movr> \q
[root@ip-10-0-0-70 ~]# logout

```


### Step 3 - stop node

finally don't forget to stop node... dont want to hit any AWS cost

```
~/projects/CLF-C01_AWS-Certified-Cloud-Practitioner_notes_and_scripts $ ./aws-ec2-describe-instance-stop.sh i-0f4b5b1ab299e960e
Pre state (all instances)
InstanceId		State&code	Tag
i-0f4b5b1ab299e960e	running	None	None
Stopping  i-0f4b5b1ab299e960e
{
    "StoppingInstances": [
        {
            "InstanceId": "i-0f4b5b1ab299e960e",
            "CurrentState": {
                "Code": 64,
                "Name": "stopping"
            },
            "PreviousState": {
                "Code": 16,
                "Name": "running"
            }
        }
    ]
}
Post state (all instances)
InstanceId		State&code	Tag
i-0f4b5b1ab299e960e	stopping	None	None
```