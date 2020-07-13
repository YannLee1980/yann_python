import nmap   #需要安装nmap模块（注意是安装  python-nmap，而不是nmap，如果不懂安装的可以参考https://blog.csdn.net/q759451733/article/details/84038114）。

def nmap_ping_scan(network_prefix):

    nm = nmap.PortScanner() #设置为nmap扫描状态。

    ping_scan_raw = nm.scan(hosts = network_prefix,arguments='-sn')   #hosts可以是单个IP地址也可以是一整个网段。    arguments就是运用什么方式扫描，-sn就是ping扫描。

    host_list_ip = []``
    
    for result in ping_scan_raw['scan'].values():  #将scan下面的数值赋值给result，并开始遍历。
        if result['status']['state'] == 'up':  #如果是up则表明对方主机是存活的。
            host_list_ip.append(result['addresses']['ipv4']) #在addresses层下的ipv4，也就是IP地址添加到result字典中。
        
        return host_list_ip   #返回字典。

if __name__ == '__main__':

    for host in nmap_ping_scan('127.0.0.1'):  #输入你要扫描的网段。
        
        print('%-20s %5s' % (host,'is UP'))  #打印所有存活的主机。