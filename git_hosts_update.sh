#!/bin/bash

host_new=/tmp/host_new$$ #临时文件
ref_host=/etc/hosts      #目标hosts

if [ ! $1 ]; then
    sed '/#github/d' $ref_host >$host_new #删除目标hosts中标记的host，并复制到临时文件
else
    host_new=./hosts
    ref_host=./hosts
    echo "" > $ref_host
fi

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
    ip=$(curl -s $url | grep -o -E 'https://www\.ipaddress\.com/ipv4/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' -m 1)
    echo $ip
}

index=0
for i in ${githubUrls[@]}; do
    let index++

    echo "$index/${#githubUrls[@]}:$i"

    ip=$(findIp $i)
    if [ ! $ip ]; then
        echo "$i is failed"
    else
        printf "%-16s%-58s#github\n" $ip $i >>$host_new #格式化输出
    fi
done

/bin/cp -rf $host_new $ref_host #替换原hosts
