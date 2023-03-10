package com.byy.byyclientsdk.client;

import cn.hutool.core.util.RandomUtil;

import cn.hutool.http.HttpRequest;
import cn.hutool.http.HttpResponse;
import cn.hutool.json.JSONUtil;
import com.byy.byyclientsdk.model.Sentences;


import java.util.HashMap;
import java.util.Map;

import static com.byy.byyclientsdk.utils.SignUtils.genSign;


/**
 * 调用第三方接口的客户端
 *
 * @author byy
 */
public class ByyClient {
    private static final String GATEWAY_HOST = "http://localhost:8090";

    private String accessKey;

    private String secretKey;

    public ByyClient(String accessKey, String secretKey) {
        this.accessKey = accessKey;
        this.secretKey = secretKey;
    }

    private Map<String, String> getHeaderMap(String body) {
        Map<String, String> hashMap = new HashMap<>();
        hashMap.put("accessKey", accessKey);
        // 一定不能直接发送
//        hashMap.put("secretKey", secretKey);
        hashMap.put("nonce", RandomUtil.randomNumbers(4));
        hashMap.put("body", body);
        hashMap.put("timestamp", String.valueOf(System.currentTimeMillis() / 1000));
        hashMap.put("sign", genSign(body, secretKey));
        return hashMap;
    }


    public String getSentences(Sentences sentences) {
        String json = JSONUtil.toJsonStr(sentences);
        HttpResponse httpResponse = HttpRequest.post(GATEWAY_HOST + "/api/sentences/get")
                .addHeaders(getHeaderMap(json))
                .body(json)
                .execute();
        System.out.println(httpResponse.getStatus());
        String result = httpResponse.body();
        System.out.println(result);
        return result;
    }
}
