package com.aston.kafka;

import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class KafkaConsumer {

    @KafkaListener(topics = "test", groupId = "my_consumer")
    public void listen(String message){
        log.info("Получено сообщение: {}", message);
    }
}
