package com.exemple;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import com.exemple.model.ThemeParkRide;
import com.exemple.repository.ThemeParkRideRepository;

@SpringBootApplication
public class ThemeParkRideGradleApplication {

	public static void main(String[] args) {
		SpringApplication.run(ThemeParkRideGradleApplication.class, args);
	}


	@Bean
	public CommandLineRunner sampleData(ThemeParkRideRepository repository) {
		return (args) -> {
			repository.save(new ThemeParkRide("Test CI/CD", "C'est du direct!", 2, 5));
			repository.save(new ThemeParkRide("Log flume", "Boat ride with plenty of splashes.", 3, 2));
			repository.save(new ThemeParkRide("Teacups", "Spinning ride in a giant tea-cup.", 2, 4));
		};
	}
}
