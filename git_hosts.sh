#!/bin/bash

host_tmp=/tmp/host_tmp$$ #临时文件
ref_host=/etc/hosts      #目标hosts

if [ ! $1 ]; then
    sed '/#github/d' $ref_host | sed '/#|/d' >$host_tmp #删除目标hosts中标记的host，并复制到临时文件
else
    host_tmp=$1/hosts_tmp
    ref_host=$1/hosts
fi

rm -r $host_tmp

echo -e "#| GitHub Host Start\n" >>$host_tmp
echo "#| Please Star : https://github.com/Rexexe/git_hosts" >>$host_tmp
echo -e "#| Update at: $(date "+%Y-%m-%d %H:%M:%S")\n" >>$host_tmp

# gist.github.com
gist=(192.30.255.119 192.30.255.118 203.98.7.65 59.24.3.173 8.7.198.45 52.74.223.119 13.229.188.59 140.82.114.20 192.30.253.119 140.82.113.19 13.250.177.223 192.30.253.118)

# api.github.com
api=(54.169.195.247 13.250.94.254 13.250.168.23 192.30.255.116 192.30.255.117 140.82.113.5 140.82.114.6 140.82.118.6 140.82.118.5 52.69.239.207 54.180.75.25 140.82.113.6 192.30.253.116 140.82.114.5 192.30.253.117 13.234.168.60 13.209.163.61 18.179.245.253 13.230.158.120 18.229.199.252 18.229.119.202)

# github.com
github=(52.74.223.119 140.82.121.4 13.250.177.223 13.229.188.59 140.82.121.3 52.78.231.108 15.164.81.167 13.234.176.102 140.82.114.4 192.30.255.112 140.82.114.3 140.82.113.3 52.69.186.44 140.82.112.3 140.82.112.4 13.114.40.48 52.192.72.89 13.237.44.5 52.64.108.95 13.234.210.38 192.30.253.112 140.82.118.3 140.82.118.4 13.236.229.21 140.82.113.4 192.30.253.113 192.30.255.113 18.228.67.229)

# raw.github.com
# raw.githubusercontent.com
# camo.githubusercontent.com
# cloud.githubusercontent.com
# avatars.githubusercontent.com
# avatars0.githubusercontent.com
# avatars1.githubusercontent.com
# avatars2.githubusercontent.com
# avatars3.githubusercontent.com
# user-images.githubusercontent.com
raw=(151.101.108.133 151.101.196.133 151.101.24.133 151.101.228.133 151.101.40.133 151.101.128.133 151.101.192.133 151.101.0.133 151.101.64.133 151.101.76.133 151.101.8.133 199.232.36.133 151.101.120.133 151.101.84.133 151.101.36.133 151.101.28.133 151.101.112.133 151.101.140.133 151.101.88.133 151.101.164.133 151.101.220.133)

# codeload.github.com
codeload=(13.250.162.133 54.251.140.56 13.229.189.0 192.30.255.120 192.30.253.121 140.82.113.9 52.68.31.213 140.82.114.9 13.250.162.133 140.82.114.10 13.127.152.42 140.82.113.10 3.105.64.153 13.112.159.149 52.193.111.178 192.30.253.120 13.124.75.135 13.124.243.66)

# github-production-release-asset-2e65be.s3.amazonaws.com
# github-production-user-asset-6210df.s3.amazonaws.com
# github-cloud.s3.amazonaws.com
# github-com.s3.amazonaws.com
# github-production-repository-file-5c1aeb.s3.amazonaws.com
amazonaws=(52.216.145.179 52.217.38.60 52.216.24.92 52.216.25.124 52.216.86.123 52.216.225.80 52.217.42.36 52.216.139.179 52.216.104.99 54.231.98.96 52.216.142.228 52.216.165.219 52.216.112.243 52.216.106.140 52.216.170.139 52.216.142.28 52.216.129.19 52.216.134.99 52.216.130.3 52.216.98.211 52.216.107.124 52.216.238.171 52.217.41.100 52.216.104.235 52.216.108.19 52.216.227.88 52.216.142.76 52.217.41.124 52.216.144.204 52.216.83.0 52.216.184.235 52.216.177.11 52.217.40.52 52.216.8.131 52.216.237.59 52.216.114.11 52.217.38.172 52.216.109.35 52.217.32.124 52.216.112.115 52.216.185.187 52.217.4.28 52.216.163.11 52.216.101.219 52.216.133.27 52.217.47.44 52.216.229.163 52.216.239.171 52.216.65.0 52.216.162.43 52.216.230.75 52.217.42.140 52.216.105.115 52.217.38.76 52.216.232.179 52.216.177.219 52.216.177.19 52.217.41.172 52.216.26.244 52.216.165.155 52.216.131.19 52.216.99.147 52.217.10.116 52.217.37.172 52.216.146.211 52.216.106.180 52.217.10.20 52.216.168.3 52.216.106.228 52.216.107.92 52.216.19.56 52.216.184.75 52.216.144.3 52.216.184.179 52.216.114.163 52.216.145.43 52.216.27.132 52.217.41.28 52.216.136.83 52.216.141.140 52.216.24.140 52.216.128.211 52.216.176.35 52.216.84.227 52.216.8.251 52.216.114.51 52.216.112.43 52.216.65.216 52.216.186.155 52.216.160.35 52.216.171.147 52.216.237.35 52.217.8.244 52.216.88.243 52.216.82.0 54.231.121.91 52.216.24.252 52.216.102.51 52.217.32.252 52.217.40.244 52.216.133.107 52.216.140.236 52.216.145.27 52.216.147.59 52.216.113.139 54.231.40.123 52.217.4.4 52.216.106.19 52.216.230.155 52.216.242.20 52.216.200.139 52.216.225.56 52.217.0.212 52.216.140.228 52.216.24.84 52.217.47.12 52.216.107.164 52.217.42.20 52.216.136.59 52.216.109.179 52.216.162.107 52.216.32.136 52.216.177.179 52.216.99.59 52.216.179.27 52.217.45.108 52.217.42.164 52.217.46.220 52.216.108.3 52.217.8.52 52.217.40.20 52.216.227.176 52.216.147.124 52.216.115.83 52.216.226.152 52.216.106.27 52.216.128.187 52.216.146.123 52.217.11.20 52.216.142.108 54.231.98.128 52.216.162.203 52.216.108.115 52.216.230.27 52.216.12.116 52.216.100.155 52.216.139.115 52.216.145.187 52.216.106.124 52.216.185.179 52.216.81.184 52.216.106.196 52.216.237.27 52.217.41.108 52.216.177.123 52.216.239.147 52.216.237.3 52.216.141.60 52.216.132.67 52.216.205.139 52.216.94.171 52.217.8.60 52.216.24.156 52.216.82.24 52.216.230.131 52.216.108.123 52.216.134.235 52.216.97.19 52.217.38.196 52.216.99.91 52.217.1.12 52.217.32.52 52.216.138.171 52.216.187.35 52.216.176.163 52.216.92.35 52.216.112.67 52.216.144.219 52.216.24.36 54.231.114.146 52.217.46.172 52.216.236.227)

testIP() {
    #测速ip
    ips=$1

    ips=($(echo ${ips[*]} | tr ' ' '\n' | sort -u | while read x; do echo $x $(ping -c 3 $x | grep 'min/avg/max/mdev' | awk -F / '{print $5}') & done | sort -n -k 2 | awk '$2!="" {print $1}'))

    setHosts $ips $2
}

setHosts() {
    #设置hosts
    hosts=()
    case $2 in
    gist)
        hosts=('gist.github.com')
        ;;
    api)
        hosts=('api.github.com')
        ;;
    github)
        hosts=('github.com')
        ;;
    codeload)
        hosts=('codeload.github.com')
        ;;
    amazonaws)
        hosts=('github-production-release-asset-2e65be.s3.amazonaws.com' 'github-production-user-asset-6210df.s3.amazonaws.com' 'github-cloud.s3.amazonaws.com' 'github-com.s3.amazonaws.com' 'github-production-repository-file-5c1aeb.s3.amazonaws.com')
        ;;
    raw)
        hosts=('raw.github.com' 'raw.githubusercontent.com' 'camo.githubusercontent.com' 'cloud.githubusercontent.com' 'avatars.githubusercontent.com' 'avatars0.githubusercontent.com' 'avatars1.githubusercontent.com' 'avatars2.githubusercontent.com' 'avatars3.githubusercontent.com' 'user-images.githubusercontent.com')
        ;;
    esac

    for host in ${hosts[*]}; do
        printf "%-16s%-58s#github\n" $1 $host >>$host_tmp #格式化输出
    done
}

testIP "${gist[*]}" gist
testIP "${api[*]}" api
testIP "${github[*]}" github
testIP "${codeload[*]}" codeload
testIP "${amazonaws[*]}" amazonaws
testIP "${raw[*]}" raw




echo -e "\n#| GitHub Host End" >>$host_tmp

/bin/cp -rf $host_tmp $ref_host #替换原hosts
rm -r $host_tmp

echo "hosts更新完成"