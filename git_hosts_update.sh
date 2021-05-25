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

ipAddressFooter=ipaddress.com
githubUrls=(
    github.githubassets.com
    central.github.com
    desktop.githubusercontent.com
    assets-cdn.github.com
    camo.githubusercontent.com
    github.map.fastly.net
    github.global.ssl.fastly.net
    gist.github.com
    github.io
    github.com
    api.github.com
    raw.githubusercontent.com
    user-images.githubusercontent.com
    favicons.githubusercontent.com
    avatars5.githubusercontent.com
    avatars4.githubusercontent.com
    avatars3.githubusercontent.com
    avatars2.githubusercontent.com
    avatars1.githubusercontent.com
    avatars0.githubusercontent.com
    avatars.githubusercontent.com
    codeload.github.com
    github-cloud.s3.amazonaws.com
    github-com.s3.amazonaws.com
    github-production-release-asset-2e65be.s3.amazonaws.com
    github-production-user-asset-6210df.s3.amazonaws.com
    github-production-repository-file-5c1aeb.s3.amazonaws.com
    githubstatus.com
    github.community
    media.githubusercontent.com
)

resolveUrl() {
    #获取目标网址
    urlBody=($(echo $1 | tr '.' ' ')) #以.分割
    length=${#urlBody[@]}

    if [ $length -gt 2 ]; then
        echo https://${urlBody[$length - 2]}.${urlBody[$length - 1]}.$ipAddressFooter/$1
    else
        echo https://$1.$ipAddressFooter
    fi
}

findIp() {
    #获取目标ip
    url=$(resolveUrl $1)
    ips=($(curl -s $url | grep -o -E 'https://www\.ipaddress\.com/ipv4/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'))

    if [ ${#ips[@]} == 0 ]; then
        echo "$i is failed"
    else
        # github actions 不支持ping，取消测速
        # ips=($(echo ${ips[*]} | tr ' ' '\n' | sort -u | while read x ; do echo $x `ping -c 3 $x | grep 'min/avg/max/mdev' | awk -F / '{print $5}'` & done | sort -n -k 2 | awk '$2!="" {print $1}'))
        ips=($( echo ${ips[*]} | tr ' ' '\n' | sort -u ))

        setHosts "${ips[*]}" $1
    fi
}

setHosts(){
    #设置hosts
    arr=$1
    for ip in ${arr[*]}; do
        printf "%-16s%-58s#github\n" $ip $2 >>$host_tmp #格式化输出
    done
}

index=0
for url in ${githubUrls[@]}; do
    let index++

    echo "$index/${#githubUrls[@]}:$url"
    findIp $url
done

echo -e "\n#| GitHub Host End" >>$host_tmp

/bin/cp -rf $host_tmp $ref_host #替换原hosts
rm -r $host_tmp

echo "hosts更新完成"
