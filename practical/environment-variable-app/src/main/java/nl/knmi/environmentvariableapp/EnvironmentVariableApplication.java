package nl.knmi.environmentvariableapp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@EnableDiscoveryClient
@SpringBootApplication
public class EnvironmentVariableApplication {

    public static void main(String[] args) {
        SpringApplication.run(EnvironmentVariableApplication.class, args);
    }

}
