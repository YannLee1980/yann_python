import nmap
nm = nmap.PortScanner()
ret = nm.scan('115.239.210.26','20')
print(ret)
