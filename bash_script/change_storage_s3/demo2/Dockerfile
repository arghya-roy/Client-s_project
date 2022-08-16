FROM public.ecr.aws/lambda/provided:al2
USER root

# RUN mkdir /tmp
# COPY main.sh .
# RUN chmod +x main.sh
# WORKDIR /tmp/
# RUN touch /tmp/file_path_final.txt
# RUN touch /tmp/file_path_initial.txt
# RUN touch /tmp/output_final.json
# RUN touch /tmp/output_initial.json
# RUN chmod 777 /tmp/file_path_final.txt
# RUN chmod 777 /tmp/file_path_initial.txt
# RUN chmod 777 /tmp/output_final.json
# RUN chmod 777 /tmp/output_initial.json

RUN yum install jq -y

RUN yum update -y
RUN yum install jq -y
RUN yum install curl -y
RUN yum install unzip -y 
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install
RUN mkdir ~/.aws
RUN touch ~/.aws/config
# COPY config ~/.aws/config
RUN cat /dev/null > ~/.aws/config
RUN echo "[default]" >> ~/.aws/config
RUN echo "aws_access_key_id=AKIAS5TZESGVMMYVJW4O" >> ~/.aws/config
RUN echo "aws_secret_access_key=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" >> ~/.aws/config
RUN echo "region=ap-south-1" >> ~/.aws/config

COPY main.sh ./
RUN chmod +x main.sh
# WORKDIR /tmp/
RUN touch /tmp/file_path_final.txt
RUN touch /tmp/file_path_initial.txt
RUN touch /tmp/output_final.json
RUN touch /tmp/output_initial.json
RUN chmod 777 /tmp/file_path_final.txt
RUN chmod 777 /tmp/file_path_initial.txt
RUN chmod 777 /tmp/output_final.json
RUN chmod 777 /tmp/output_initial.json
# ENTRYPOINT ["/bin/sh"]
ENTRYPOINT ["/bin/sh", "-c" , "ls && ./main.sh"]

# FROM amazon/aws-cli
# USER root
# ENV AWS_ACCESS_KEY_ID ${AWS_ACCESS_KEY_ID}
# ENV AWS_SECRET_ACCESS_KEY ${AWS_SECRET_ACCESS_KEY}
# ENV AWS_DEFAULT_REGION ap-south-1
# RUN yum -y install curl
# RUN curl -sL https://rpm.nodesource.com/setup_14.x | bash -
# RUN yum install -y nodejs
# RUN yum -y install gcc-c++ make
# RUN curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo
# RUN yum -y install yarn
# RUN npm install pm2 -g

# COPY index.js ./
# # COPY main.sh ./
# # RUN chmod 777 $PWD
# # RUN chmod 777 main.sh
# RUN npm install
# CMD [ "index.handler" ]



# FROM public.ecr.aws/lambda/provided:latest

# #
# # versions
# #

# ARG AWSCLI_VERSION=1.18.198

# USER root
# RUN mkdir -p /opt
# WORKDIR /tmp

# #
# # tools
# #

# RUN yum update -y \
#     && yum install -y zip unzip wget tar gzip

# #
# # aws cli
# #

# RUN curl https://s3.amazonaws.com/aws-cli/awscli-bundle-${AWSCLI_VERSION}.zip -o awscli-bundle.zip
# RUN unzip awscli-bundle.zip
# RUN ./awscli-bundle/install -i /opt/awscli -b /opt/awscli/aws

# # organize for self-contained usage
# RUN mv /opt/awscli                                    /opt/awscli.tmp
# RUN mv /opt/awscli.tmp/lib/python2.7/site-packages    /opt/awscli
# RUN mv /opt/awscli.tmp/bin                            /opt/awscli/bin
# RUN mv /opt/awscli/bin/aws                            /opt/awscli

# # cleanup
# RUN rm -fr /opt/awscli.tmp
# RUN rm -rf \
#     /opt/awscli/pip* \
#     /opt/awscli/setuptools* \
#     /opt/awscli/awscli/examples

# #
# # create the bundle
# #

# RUN cd /opt \
#     && zip --symlinks -r ../layer.zip * \
#     && echo "/layer.zip is ready" \
#     && ls -alh /layer.zip;

# COPY main.sh /tmp/main.sh
# RUN cd /tmp
# RUN chmod 777 main.sh

# WORKDIR /tmp
# ENTRYPOINT ./main.sh ; /bin/bash