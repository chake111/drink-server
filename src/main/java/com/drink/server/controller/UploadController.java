package com.drink.server.controller;

import com.drink.server.common.FileUtil;
import com.drink.server.common.Result;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

/**
 * 文件上传控制器
 */
@RestController
@RequestMapping("/api")
public class UploadController {

    @Value("${drink.upload.path}")
    private String uploadPath;

    @Value("${drink.upload.url-prefix:/upload/}")
    private String urlPrefix;

    /**
     * 图片上传接口
     * 校验格式（JPG/PNG/WEBP）和大小（<=2MB），保存到本地，返回可访问URL
     */
    @PostMapping("/upload")
    public Result<String> upload(@RequestParam("file") MultipartFile file) {
        // 校验文件格式和大小
        FileUtil.validate(file);

        // 生成唯一文件名并保存
        String fileName = FileUtil.generateUniqueFileName(file.getOriginalFilename());
        FileUtil.saveFile(file, uploadPath + fileName);

        // 返回可访问的URL
        return Result.success(urlPrefix + fileName);
    }
}
