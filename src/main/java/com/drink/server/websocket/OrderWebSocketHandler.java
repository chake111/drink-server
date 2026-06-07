package com.drink.server.websocket;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 订单 WebSocket 处理器
 * 维护管理端连接，广播待接单数量
 */
@Slf4j
@Component
public class OrderWebSocketHandler extends TextWebSocketHandler {

    private final Set<WebSocketSession> sessions = ConcurrentHashMap.newKeySet();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) {
        sessions.add(session);
        log.info("WebSocket 连接建立, 当前连接数: {}", sessions.size());
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
        sessions.remove(session);
        log.info("WebSocket 连接关闭, 当前连接数: {}", sessions.size());
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) {
        log.debug("收到 WebSocket 消息: {}", message.getPayload());
    }

    /**
     * 向所有管理端连接广播待接单数量
     */
    public void broadcastPendingCount(long count) {
        String payload = "{\"type\":\"pending\",\"count\":" + count + "}";
        TextMessage message = new TextMessage(payload);
        for (WebSocketSession session : sessions) {
            if (session.isOpen()) {
                try {
                    session.sendMessage(message);
                } catch (IOException e) {
                    log.warn("WebSocket 发送失败: {}", e.getMessage());
                }
            }
        }
    }
}
