package nl.knmi.environmentvariableapp;

import java.util.Optional;
import org.springframework.cloud.client.discovery.DiscoveryClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@RestController
public class ApplicationEndpoint {

    private final DiscoveryClient discoveryClient;

    public ApplicationEndpoint(DiscoveryClient discoveryClient) {
        this.discoveryClient = discoveryClient;
    }

    @GetMapping("/message")
    public Mono<String> getEnvironmentVariable() {
        Optional<String> optionalEnvironmentVariable = Optional.ofNullable(System.getenv("APP_ENV_VAR"));
        return Mono.just(optionalEnvironmentVariable.orElse("COULD NOT FIND ENV VAR."));
    }

    @GetMapping("/services")
    public Flux<String> getDiscoveredServices() {
        return Flux.fromIterable(discoveryClient.getServices());
    }
}
