package nl.knmi.quotesapp;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Flux;

@RestController
public class QuotesEndpoint {

    private final QuotesRepository quotesRepository;

    public QuotesEndpoint(QuotesRepository quotesRepository) {
        this.quotesRepository = quotesRepository;
    }

    @GetMapping("/quotes")
    public Flux<Quote> getQuote() {
        return quotesRepository.findAll();
    }
}
