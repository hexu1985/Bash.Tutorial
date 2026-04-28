使用 `sar -n` 监控网络 I/O 的核心理念是“对症下药”，不同问题用不同命令，才能真正发挥大作用。

它的核心语法是 `sar -n {keyword} [interval] [count]`。其中的 `keyword` 是你要监控的目标，常见的有：

#### 🎯 监控网络流量 (`-n DEV`)
快速了解网卡的整体流量和负载。
*   **命令**：`sar -n DEV 1 3` (每1秒采样1次，共3次)
*   **典型输出**：
```
$ sar -n DEV 1 3
10:15:22 AM     IFACE   rxpck/s   txpck/s    rxkB/s    txkB/s   rxcmp/s   txcmp/s  rxmcst/s   %ifutil
10:15:23 AM        lo      0.00      0.00       0.00       0.00      0.00      0.00      0.00      0.00
10:15:23 AM      eth0   1200.00    800.00      85.20      65.40      0.00      0.00      0.00      1.20
10:15:23 AM      eth1      5.00     10.00       0.56       1.20      0.00      0.00      0.00      0.01
```
*   **关键字段解析**：
    *   **`IFACE`**：网卡名称，如 `eth0`、`ens33`、`bond0` 等。
    *   **`rxpck/s`**：每秒接收的数据包数。**过高可能面临小包攻击**。
    *   **`txpck/s`**：每秒发送的数据包数。
    *   **`rxkB/s` / `txkB/s`**：每秒收发数据的速率。**瓶颈分析的核心**。
    *   **`%ifutil`**：网卡利用率。**千兆网卡约 120,000 kB/s 可达 100%**。
    *   **`rxmcst/s`**：每秒接收的多播包数。**突然升高可能是多播风暴**。

#### 🔍 排查错误与丢包 (`-n EDEV`)
定位网卡硬件、驱动或缓冲区问题。
*   **命令**：`sar -n EDEV 1 3`
*   **典型输出**：
```
$ sar -n EDEV 1 3
10:15:23 AM     IFACE   rxerr/s   txerr/s   coll/s   rxdrop/s   txdrop/s  txcarr/s  rxfram/s  rxfifo/s  txfifo/s
10:15:23 AM       lo       0.00      0.00     0.00       0.00       0.00      0.00      0.00      0.00      0.00
10:15:23 AM     eth0       0.00      0.00     0.00       2.50       0.00      0.00      0.00      0.00      0.00
```
*   **关键字段解析**：
    *   **`rxerr/s` / `txerr/s`**：收发错误包数。**持续 > 0 通常意味着物理链路问题**。
    *   **`rxdrop/s` / `txdrop/s`**：收发丢弃包数。**> 0 说明网卡缓冲区满了，系统处理不过来**。
    *   **`coll/s`**：网络冲突数。仅在旧式半双工模式下有意义。

#### 🔌 监控连接数 (`-n SOCK`)
判断是否有大量连接积压或泄露。
*   **命令**：`sar -n SOCK 1 1`
*   **典型输出**：
```
$ sar -n SOCK 1 1
10:15:22 AM    totsck   tcpsck   udpsck   rawsck   ip-frag   tcp-tw
10:15:23 AM        500      300      100        0        0        10
```
*   **关键字段解析**：
    *   **`totsck`**：已使用的 socket 总数。
    *   **`tcpsck`**：**TCP 连接数**。
    *   **`tcp-tw`**：TIME_WAIT 状态的连接数。
    *   **`ip-frag`**：IP 分片数。

#### 🧩 查看TCP统计 (`-n TCP`)
深入观察TCP层的连接状态、段收发和重传率。
*   **命令**：`sar -n TCP 1 3`
*   **典型输出**：
```
$ sar -n TCP 1 3
10:15:22 AM  active/s passive/s    iseg/s    oseg/s
10:15:23 AM      5.00      2.00   1500.00   1200.00
```
*   **关键字段解析**：
    *   **`active/s`**：每秒主动发起的连接。**该值持续升高可能遭遇SYN Flood攻击**。
    *   **`passive/s`**：每秒被动接受的连接。
    *   **`iseg/s` / `oseg/s`**：每秒收发的 TCP 段数。
    *   **`retrans/s`**：**TCP 重传率，网络质量的最敏感指标**。

### 💾 数据保存与分析

`sar` 支持将监控数据保存下来，便于事后或长时间跨度的分析。
*   **保存数据**：使用 `-o [文件名]` 参数。
    ```bash
    sar -n DEV -o network_sar.bin 1 5
    ```
    该命令会将采样数据保存为特殊格式的**二进制文件**，此文件**只能用 `sar` 自身读取**，不可直接用 `cat` 等文本工具查看。
*   **读取数据**：使用 `-f [文件名]` 参数。
    ```bash
    sar -n DEV -f network_sar.bin
    ```
*   **高级分析**：可以结合 `-s`（起始）和 `-e`（结束）时间，提取特定时间段的数据。
    ```bash
    sar -n DEV -f /var/log/sa/sa28 -s 14:00:00 -e 15:00:00
    ```

### 💡 快速实战指南
*   **响应慢，判断网卡是否饱和**: `sar -n DEV 1`，重点看 `%ifutil` 是否接近 100%。
*   **网络不稳定，检查线路**: `sar -n EDEV 1`，重点看 `rxerr/s`、`txerr/s`、`coll/s`。
*   **服务拒绝连接，查连接数**: `sar -n SOCK 1`，关注 `totsck` 是否异常超标。
*   **上传下载慢，测TCP质量**: `sar -n TCP 1`，重点看 `retrans/s` 的重传率。

`sar` 所有的网络统计指标都存储在 **`/var/log/sa/`** 目录下的二进制文件 `sa[日期]` 中，由 `sysstat` 服务自动收集。启用数据收集只需编辑配置文件 `/etc/default/sysstat`，将 `ENABLED="false"` 改为 `"true"`，并重启 `sysstat` 服务。

### 💎 总结

`sar -n` 命令通过 `keyword` 实现对不同层面的精准监控。监控网络I/O，最关键的是：**通用流量用 `DEV`，排查错误用 `EDEV`，查看连接用 `SOCK`，分析协议用 `TCP/IP`**。
