package com.byy.byyclientsdk.model;

import lombok.Data;

import java.util.Date;

/**
 * 用户
 */
@Data
public class Sentences {
    private Long id;
    private String content;
    private Boolean isActive;
    private Date created_at;
    private Date updated_at;
}
