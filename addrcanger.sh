#/bin/bash
CFGIT=/etc/nginx/conf.d/gitlab_http.conf
CFJEN=/etc/nginx/conf.d/jenkins_http.conf
CFBAMBOO=/etc/nginx/conf.d/bambo_http.conf
#
BAMBOO=`docker inspect -f='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' bamboo`
GIT=`docker inspect -f='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' git`
JEN=`docker inspect -f='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' jenkins`
#echo "for jenkins"
sed -i -- 's/172.*.*.*/'"${BAMBOO}"':8085;/g' $CFBAMBOO

#echo "for git"
sed -i -- 's/172.*.*.*/'"${GIT}"':80;/g' $CFGIT

#echo "for jenkins"
sed -i -- 's/172.*.*.*/'"${JEN}"':8080;/g' $CFJEN
#grep proxy_pass {$CFBAMBOO,$CFGIT,$CFJEN,}
systemctl reload-or-restart nginx

#[root@doc jenkins]# docker inspect -f='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' jenkins

#[root@doc jenkins]# docker inspect -f='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' git

#[root@doc jenkins]# docker inspect -f='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' bamboo


