package nl.knmi.quotesapp;

import java.util.ArrayList;
import java.util.List;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class QuotesApplication implements ApplicationRunner {

    public QuotesApplication(QuotesRepository quotesRepository) {
        this.quotesRepository = quotesRepository;
    }

    public static void main(String[] args) {
        SpringApplication.run(QuotesApplication.class, args);
    }

    private final QuotesRepository quotesRepository;
    @Override
    public void run(ApplicationArguments args) throws Exception {
        List<Quote> quotes = new ArrayList<>();
        quotes.add(new Quote(null, "What we have to do is to be forever curiously testing new opinions and courting new impressions."));
        quotes.add(new Quote(null, "Live neither in the past nor in the future, but let each day's work absorb your entire energies, and satisfy your widest ambition."));
        quotes.add(new Quote(null, "Security is mostly a superstition. It does not exist in nature.... Life is either a daring adventure or nothing."));
        quotes.add(new Quote(null, "Our greatest pretenses are built up not to hide the evil and the ugly in us, but our emptiness. The hardest thing to hide is something that is not there."));
        quotes.add(new Quote(null, "Disconnecting from change does not recapture the past. It loses the future."));
        quotes.add(new Quote(null, "My favorite animal is steak."));
        quotesRepository.saveAll(quotes)
            .doOnError(Throwable::printStackTrace)
            .subscribe();
    }
}
