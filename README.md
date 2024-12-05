# quil-docker-cluster
quil集群docker

## 修改配置

### master 机器

master负责同步和提交proof，需要修改配置如下。master机器有正常节点的所有数据。

1.在 `difficulty: 0` 该行后添加

```
dataWorkerMultiaddrs: 
    # master本机的worker写在最前边, 监听地址是0.0.0.0，端口从40000开始，核心会从1开始，所以--core=1 使用的端口就是40000，--core=2使用的端口是40001，依次类推。
    # worker的地址直接向后追加，没有顺序要求。
    - /ip4/0.0.0.0/tcp/40000
    - /ip4/0.0.0.0/tcp/40001
    - /ip4/0.0.0.0/tcp/40002
    - /ip4/0.0.0.0/tcp/40003
    - /ip4/0.0.0.0/tcp/40004
    - /ip4/0.0.0.0/tcp/40005
    - /ip4/0.0.0.0/tcp/40006
    - /ip4/0.0.0.0/tcp/40007
    - /ip4/0.0.0.0/tcp/40008
    - /ip4/0.0.0.0/tcp/40009
    - /ip4/0.0.0.0/tcp/40010
    - /ip4/0.0.0.0/tcp/40011
    - /ip4/0.0.0.0/tcp/40012
    - /ip4/0.0.0.0/tcp/40013
    - /ip4/0.0.0.0/tcp/40014
    - /ip4/0.0.0.0/tcp/40015
    - /ip4/0.0.0.0/tcp/40016
    - /ip4/0.0.0.0/tcp/40017
    - /ip4/0.0.0.0/tcp/40018
    - /ip4/0.0.0.0/tcp/40019
    - /ip4/0.0.0.0/tcp/40020
    - /ip4/0.0.0.0/tcp/40021
    - /ip4/0.0.0.0/tcp/40022
    - /ip4/0.0.0.0/tcp/40023
    - /ip4/0.0.0.0/tcp/40024
    - /ip4/0.0.0.0/tcp/40025
    - /ip4/0.0.0.0/tcp/40026
    - /ip4/0.0.0.0/tcp/40027
    # worker A机器的地址，监听地址写worker的ip, 需要依次往下排列
    - /ip4/65.109.19.177/tcp/40001
    - /ip4/65.109.19.177/tcp/40002
    - /ip4/65.109.19.177/tcp/40003
    - /ip4/65.109.19.177/tcp/40004
    - /ip4/65.109.19.177/tcp/40005
    - /ip4/65.109.19.177/tcp/40006
    - /ip4/65.109.19.177/tcp/40007
    - /ip4/65.109.19.177/tcp/40008
    - /ip4/65.109.19.177/tcp/40009
    - /ip4/65.109.19.177/tcp/40010
    - /ip4/65.109.19.177/tcp/40011
    - /ip4/65.109.19.177/tcp/40012
    - /ip4/65.109.19.177/tcp/40013
    - /ip4/65.109.19.177/tcp/40014
    - /ip4/65.109.19.177/tcp/40015
    - /ip4/65.109.19.177/tcp/40016
    - /ip4/65.109.19.177/tcp/40017
    - /ip4/65.109.19.177/tcp/40018
    - /ip4/65.109.19.177/tcp/40019
    - /ip4/65.109.19.177/tcp/40020
    - /ip4/65.109.19.177/tcp/40021
    - /ip4/65.109.19.177/tcp/40022
    - /ip4/65.109.19.177/tcp/40023
    - /ip4/65.109.19.177/tcp/40024
    - /ip4/65.109.19.177/tcp/40025
    - /ip4/65.109.19.177/tcp/40026
    - /ip4/65.109.19.177/tcp/40027
    - /ip4/65.109.19.177/tcp/40028
    - /ip4/65.109.19.177/tcp/40029
    - /ip4/65.109.19.177/tcp/40030
    - /ip4/65.109.19.177/tcp/40031
    # worker B机器的地址，监听地址写worker B的ip, 需要依次往下排列
    - /ip4/65.109.19.178/tcp/40000
    # 省略
    - /ip4/65.109.19.178/tcp/40031
```

2.修改变量，CORE_RANGE 指定master开了多少worker, 和dataWorkerMultiaddrs里master的worker的数量一定要对上，
上边dataWorkerMultiaddrs里master的worker地址有28个，CORE_RANGE就是1-28
。

IS_CLUSTER=true

ROLE=master

CORE_RANGE=1-28

3.启动master

`docker compose pull`

`docker compose up -d`

### worker 机器

worker 机器只需要config.yml 和 keys.yml, 将 master 机器的 config.yml 和 keys.yml 复制到 worker。并且修改config.yml。dataWorkerMultiaddrs 只需要写本地监听的既可。

```
dataWorkerMultiaddrs:
    # worker机器的端口，40000开始依次往下排列即可
    - /ip4/0.0.0.0/tcp/40000
    - /ip4/0.0.0.0/tcp/40001
    - /ip4/0.0.0.0/tcp/40002
    - /ip4/0.0.0.0/tcp/40003
    - /ip4/0.0.0.0/tcp/40004
    - /ip4/0.0.0.0/tcp/40005
    - /ip4/0.0.0.0/tcp/40006
    - /ip4/0.0.0.0/tcp/40007
    - /ip4/0.0.0.0/tcp/40008
    - /ip4/0.0.0.0/tcp/40009
    - /ip4/0.0.0.0/tcp/40010
    - /ip4/0.0.0.0/tcp/40011
    - /ip4/0.0.0.0/tcp/40012
    - /ip4/0.0.0.0/tcp/40013
    - /ip4/0.0.0.0/tcp/40014
    - /ip4/0.0.0.0/tcp/40015
    - /ip4/0.0.0.0/tcp/40016
    - /ip4/0.0.0.0/tcp/40017
    - /ip4/0.0.0.0/tcp/40018
    - /ip4/0.0.0.0/tcp/40019
    - /ip4/0.0.0.0/tcp/40020
    - /ip4/0.0.0.0/tcp/40021
    - /ip4/0.0.0.0/tcp/40022
    - /ip4/0.0.0.0/tcp/40023
    - /ip4/0.0.0.0/tcp/40024
    - /ip4/0.0.0.0/tcp/40025
    - /ip4/0.0.0.0/tcp/40026
    - /ip4/0.0.0.0/tcp/40027
    - /ip4/0.0.0.0/tcp/40028
    - /ip4/0.0.0.0/tcp/40029
    - /ip4/0.0.0.0/tcp/40030
    - /ip4/0.0.0.0/tcp/40031
    
```

2.修改变量，CORE_RANGE 和dataWorkerMultiaddrs里地址的数量一定要对上，
上边dataWorkerMultiaddrs里worker地址有32个，CORE_RANGE就是1-32。

IS_CLUSTER=true

ROLE=worker

CORE_RANGE=1-32

3.启动worker

`docker compose pull`

`docker compose up -d`
