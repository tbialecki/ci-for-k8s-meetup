package com.siili.meetup.hello;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloRest {
    @GetMapping(produces = "text/plain", path = "/hello")
    public String helloWorld() {
        return "Hello World";
    }

    @GetMapping(produces = "text/plain", path = "/pi")
    public String pi() {
        return String.valueOf(calculatePi(10000000d));
    }

    private double calculatePi(double n) {
        double pi = 0;
        for (int i = 1; i < n; i++) {
            pi += Math.pow(-1, i + 1) / (2 * i - 1);
        }
        return 4 * pi;
    }
}
