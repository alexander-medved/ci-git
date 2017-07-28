#/bin/bash
CFGIT=/etc/nginx/conf.d/gitlab_http.conf
CFJEN=/etc/nginx/conf.d/jenkins_http.conf
CFBAMBOO=/etc/nginx/conf.d/bambo_http.conf
#
BAMBOO=`docker inspect -f='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' bamboo`
GIT=`docker inspect -f='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' git`
JEN=`docker inspect -f='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' jenkins`

# Condition for BAMBOO
if [ -z "$BAMBOO" ]
then
  echo "$BAMBOO is null."
else
  sed -i -- 's/172.*.*.*/'"${BAMBOO}"':8085;/g' $CFBAMBOO
fi
# check for GIT
if [ -z "$GIT" ]
then
  echo "$GIT is null."
else
  sed -i -- 's/172.*.*.*/'"${GIT}"':8085;/g' $CFGIT
fi
# Condition for Jenkins
if [ -z "$JEN" ]
then
  echo "$JEN is null."
else
  sed -i -- 's/172.*.*.*/'"${JEN}"':8085;/g' $CFJEN
fi
#grep proxy_pass {$CFBAMBOO,$CFGIT,$CFJEN,}
systemctl reload-or-restart nginx
