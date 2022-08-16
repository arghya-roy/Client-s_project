[Unit]
Description=Solr Container
After=docker.service
Requires=docker.service

[Service]
TimeoutStartSec=0
Restart=always
ExecStartPre=-/usr/bin/docker stop %n
ExecStartPre=-/usr/bin/docker rm %n
ExecStartPre=/usr/bin/docker pull solr:5.5
ExecStart=/usr/bin/docker run --name %n \
	-v /opt/solrdata/data/fewsnet_live:/opt/solr/server/solr/fewsnet_live \
	--log-driver=awslogs \
	--log-opt awslogs-region=us-east-2 \
	--log-opt awslogs-group=web-prod-solr-log-group	\
	-p 8983:8983 solr:5.5
[Install]
WantedBy=multi-user.target
