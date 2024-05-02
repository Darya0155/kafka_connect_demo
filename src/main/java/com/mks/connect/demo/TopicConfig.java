package com.mks.connect.demo;

import org.apache.kafka.clients.admin.NewTopic;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.kafka.config.TopicBuilder;

@Configuration
public class TopicConfig {

    @Bean
    public NewTopic offsettopic(){
        return TopicBuilder.name("__consumer_offsets").replicas(1).partitions(50).build();
    }
}
