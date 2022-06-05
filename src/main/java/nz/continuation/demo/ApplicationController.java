package nz.continuation.demo;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class ApplicationController {

    @Value("${info.build.version}")
    private String version;

    @GetMapping("/")
    public String home() {
        return String.format("This is a Spring Boot app on Docker - version %s ", version );
    }

    public static void main(String[] args) {
        SpringApplication.run(ApplicationController.class, args);
    }

}
