package com.microservice.training.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RefreshScope
public class EventController {

    @Value("${database.url}")
    String dbUrl;

    @Value("${database.username}")
    String dbUser;

    @Value("${database.password}")
    String dbPass;

    @RequestMapping("/")
    String index() {
        return "DB access by dbUrl:" + dbUrl + " - dbUser:" + dbUser + " - dbPass:" + dbPass;
    }
}
