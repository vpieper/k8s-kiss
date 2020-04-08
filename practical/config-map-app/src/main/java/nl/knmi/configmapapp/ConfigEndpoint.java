package nl.knmi.configmapapp;

import org.springframework.cloud.client.discovery.DiscoveryClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@RestController
public class ConfigEndpoint {

    private final DiscoveryClient discoveryClient;
    private final ApplicationProps applicationProps;

    public ConfigEndpoint(DiscoveryClient discoveryClient, ApplicationProps applicationProps) {
        this.discoveryClient = discoveryClient;
        this.applicationProps = applicationProps;
    }

    @GetMapping("/message")
    public Mono<String> getMessageFromConfiguration() {
        return Mono.just(applicationProps.getMessage());
    }

    @GetMapping("/services")
    public Flux<String> getDiscoveredServices() {
        return Flux.fromIterable(discoveryClient.getServices());
    }


}
