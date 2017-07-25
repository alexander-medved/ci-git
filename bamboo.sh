#!/bin/bash
sudo docker run -d -h bambo.playtagon.com -p 8085:8085 -p 54663:54663 --name bamboo --restart always --volume /root/compose/bamboo:/var/atlassian/bamboo:Z --volume /root/compose/bamboo/logs:/opt/atlassian/bamboo/logs:Z cptactionhank/atlassian-bamboo:latest;
