import nmap   #需要安装nmap模块（注意是安装  python-nmap，而不是nmap，如果不懂安装的可以参考https://blog.csdn.net/q759451733/article/details/84038114）。


nm = nmap.PortScanner() #设置为nmap扫描状态。

ping_scan_raw = nm.scan(hosts = '127.0.0.1',arguments='-sn')   #hosts可以是单个IP地址也可以是一整个网段。    arguments就是运用什么方式扫描，-sn就是ping扫描。

print(ping_scan_raw)
