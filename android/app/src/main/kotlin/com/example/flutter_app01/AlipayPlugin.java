package com.example.flutter_app01;

import android.content.Intent;
import android.util.Log;
import androidx.annotation.NonNull;
import java.net.URISyntaxException;
import java.util.Map;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class AlipayPlugin implements FlutterPlugin {

    private static final String TAG = "AlipayPlugin";
    private static final String CHANNEL = "com.example.yourapp/alipay";

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        MethodChannel channel = new MethodChannel(binding.getBinaryMessenger(), CHANNEL);
        channel.setMethodCallHandler(this::onMethodCall);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    }

    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if (call.method.equals("openAlipay")) {
            Map<String, String> args = (Map<String, String>) call.arguments;
            String url = args.get("url");
            Log.d(TAG, url);
            try {
                Intent intent = null;
                if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.DONUT) {
                    intent = Intent.parseUri(url,Intent.URI_INTENT_SCHEME);
                }
                intent.addCategory("android.intent.category.BROWSABLE");
                intent.setComponent(null);
                MyApplication.getCurrentActivity().startActivity(intent);
            } catch (URISyntaxException e) {
                throw new RuntimeException(e);
            }
            result.success(android.os.Build.VERSION.RELEASE);
        } else {
            result.notImplemented();
        }
    }
}
