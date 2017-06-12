package com.hotel.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

/**
 * Created by Wong on 2017/6/12.
 */
@ResponseStatus(value = HttpStatus.NOT_FOUND)
public class PageException extends RuntimeException{

}
