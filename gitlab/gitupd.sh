#/bin/bash
docker exec -t git gitlab-rake gitlab:backup:create
docker exec -t git /bin/sh -c 'umask 0077; tar cfz /var/opt/gitlab/backups/$(date "+etc-gitlab-\%s.tgz") -C / etc/gitlab'
docker pull gitlab/gitlab-ce:latest
cd /root/compose/gitlab
#docker-compose stop git.playtagon.com
#docker-compose kill git.playtagon.com
docker-compose up -d --no-deps --build git.playtagon.com
docker start git
