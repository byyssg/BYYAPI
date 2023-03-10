package com.byy.byyclientsdk;


import com.byy.byyclientsdk.client.ByyClient;
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties("byy.client")
@Data
@ComponentScan
public class byyClientConfig {
    private String accessKey;

    private String secretKey;

    @Bean
    public ByyClient byyClient(){
        return new ByyClient(accessKey, secretKey);
    }
}
