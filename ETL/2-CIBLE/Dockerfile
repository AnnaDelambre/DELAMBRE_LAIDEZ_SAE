FROM rundeck/rundeck:latest

USER root

# Install dependencies
RUN apt-get update && apt-get install -y wget unzip && rm -rf /var/lib/apt/lists/*

# Install Apache Hop
WORKDIR /opt
RUN wget https://downloads.apache.org/hop/2.8.0/apache-hop-client-2.8.0.zip &&     unzip apache-hop-client-2.8.0.zip &&     mv apache-hop-client-2.8.0 hop &&     rm apache-hop-client-2.8.0.zip

# Set permissions
RUN chown -R rundeck:rundeck /opt/hop

USER rundeck

# Expose Rundeck port
EXPOSE 4440
