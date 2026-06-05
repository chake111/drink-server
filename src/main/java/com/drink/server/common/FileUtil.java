package com.drink.server.common;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Set;
import java.util.UUID;

/**
 * 文件上传工具类
 */
public class FileUtil {

    /** 允许的图片扩展名（小写） */
    private static final Set<String> ALLOWED_EXTENSIONS = Set.of(".jpg", ".jpeg", ".png", ".webp");

    /** 最大文件大小：2MB */
    private static final long MAX_FILE_SIZE = 2 * 1024 * 1024;

    /**
     * 校验文件格式和大小
     *
     * @param file 上传的文件
     * @throws BusinessException 格式不符或超出大小限制时抛出
     */
    public static void validate(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            throw new BusinessException("上传文件不能为空");
        }

        // 校验大小
        if (file.getSize() > MAX_FILE_SIZE) {
            throw new BusinessException("文件大小不能超过2MB");
        }

        // 校验格式
        String extension = getExtension(file.getOriginalFilename());
        if (!ALLOWED_EXTENSIONS.contains(extension)) {
            throw new BusinessException("仅支持JPG、PNG、WEBP格式");
        }
    }

    /**
     * 生成唯一文件名（UUID + 原始扩展名）
     *
     * @param originalFilename 原始文件名
     * @return 唯一文件名
     */
    public static String generateUniqueFileName(String originalFilename) {
        String extension = getExtension(originalFilename);
        return UUID.randomUUID().toString() + extension;
    }

    /**
     * 保存文件到指定目录
     *
     * @param file     上传的文件
     * @param destPath 目标文件完整路径（含文件名）
     * @throws BusinessException 保存失败时抛出
     */
    public static void saveFile(MultipartFile file, String destPath) {
        File dest = new File(destPath);
        if (!dest.getParentFile().exists()) {
            dest.getParentFile().mkdirs();
        }
        try {
            file.transferTo(dest);
        } catch (IOException e) {
            throw new BusinessException("文件保存失败");
        }
    }

    /**
     * 获取文件扩展名（小写，含点号），无扩展名时返回空字符串
     */
    private static String getExtension(String filename) {
        if (filename == null || !filename.contains(".")) {
            return "";
        }
        return filename.substring(filename.lastIndexOf(".")).toLowerCase();
    }
}
