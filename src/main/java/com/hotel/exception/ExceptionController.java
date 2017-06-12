package com.hotel.exception;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

/**
 * Created by Wong on 2017/6/12.
 */
@ControllerAdvice
public class ExceptionController {
    @ExceptionHandler(PageException.class)
    private String pageNoFound() {
        return "404";
    }
}
