package com.mks.connect.demo;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import java.util.function.Function;

@SpringBootApplication
@Slf4j
public class MksDemoApplication {
    public static void main(String[] args) {
        SpringApplication.run(MksDemoApplication.class, args);
    }

    @Bean("mks-demo")
    public Function<String,String> consumer(){
        return s -> "**** "+s+" ***** ";
    }
}