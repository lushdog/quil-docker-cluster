#!/bin/bash

# 获取当前脚本的 PID 作为父进程 PID
PARENT_PROCESS_PID=$$

# 是否为集群模式（默认单机模式）
IS_CLUSTER=${IS_CLUSTER:-"false"}

# 当前机器角色：主机（"master"）或从机（"worker"）
ROLE=${ROLE:-"worker"}

# 核心范围变量（集群模式使用），例如 "29-58"
CORE_RANGE=${CORE_RANGE:-"29-58"}

if [[ "$IS_CLUSTER" == "false" ]]; then
  # 单机模式，仅运行单个节点
  echo "Running in standalone mode..."
  node
elif [[ "$IS_CLUSTER" == "true" ]]; then
  if [[ "$ROLE" == "master" ]]; then
    # 主机模式：运行主节点程序并按核心范围运行子进程
    echo "Running in cluster mode as master..."

    # 提取核心范围的起始和结束值
    IFS="-" read CORE_START CORE_END <<< "$CORE_RANGE"

    # 循环启动子进程
    for ((CORE=CORE_START; CORE<=CORE_END; CORE++)); do
      node --core $CORE --parent-process $PARENT_PROCESS_PID &
    done

    # 运行主节点程序
    node

    # 确保脚本不会退出，让容器保持运行
    wait

  elif [[ "$ROLE" == "worker" ]]; then
    # 从机模式：按核心范围运行子进程
    echo "Running in cluster mode as worker..."

    # 提取核心范围的起始和结束值
    IFS="-" read CORE_START CORE_END <<< "$CORE_RANGE"

    # 循环启动子进程
    for ((CORE=CORE_START; CORE<=CORE_END; CORE++)); do
      node --core $CORE --parent-process $PARENT_PROCESS_PID &
    done

    # 确保脚本不会退出，让容器保持运行
    wait

  else
    echo "Invalid role specified: $ROLE. Must be 'master' or 'worker'."
    exit 1
  fi
else
  echo "Invalid IS_CLUSTER value: $IS_CLUSTER. Must be 'true' or 'false'."
  exit 1
fi
