package com.drink.server.entity;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * 用户实体（微信端）
 */
@Data
public class User {
    private Long id;
    private String openid;
    private String nickname;
    private String avatar;
    private String phone;
    private LocalDateTime createTime;
}
