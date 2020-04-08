package nl.knmi.quotesapp;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.ReactiveMongoRepository;

public interface QuotesRepository extends ReactiveMongoRepository<Quote, String> {

}
