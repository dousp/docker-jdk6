FROM douspeng/docker-ali-centos

LABEL maintainer="douspeng@sina.cn" provider="douspeng"

ENV JAVA_HOME=/usr/local/java/jdk1.6.0_45 \
    JDK_NAME="jdk-6u45-linux-x64.bin" \
	JDK_PARENT_HOME=/usr/local/java/ \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_ALL="en_US.UTF-8" \
    ANT_VERSION=1.9.9 \
    ANT_HOME=/opt/ant

RUN mkdir -p ${JDK_PARENT_HOME}
WORKDIR ${JDK_PARENT_HOME}
COPY resource ${JDK_PARENT_HOME}

#刷新包缓存 并且 安装wget工具
RUN yum update -y \
 && \cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
 && yum provides '*/applydeltarpm' \
 && yum install -y zip unzip tar curl wget deltarpm \
 && chmod a+x ${JDK_NAME} \
 && ${JDK_PARENT_HOME}${JDK_NAME} \
 && rm -rf ${JDK_NAME}

# 配置环境变量
ENV JAVA_HOME ${JAVA_HOME}
ENV JRE_HOME $JAVA_HOME/jre
ENV CLASSPATH .:$JAVA_HOME/lib:$JRE_HOME/lib
ENV PATH $PATH:$JAVA_HOME/bin

RUN yum clean all

WORKDIR /root


