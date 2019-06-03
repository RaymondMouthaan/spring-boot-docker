package org.mouthaan.springbootdocker.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api/public")
public class PublicRestController {

    @GetMapping("greeting")
    public String sayHello() {
        return "Hello Spring Boot!!!";
    }
}
