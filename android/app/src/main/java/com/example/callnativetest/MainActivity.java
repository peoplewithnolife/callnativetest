package com.example.callnativetest;

//import io.flutter.embedding.android.FlutterActivity;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL_ONE = "samples.flutter.dev/testola";
    private static final String CHANNEL_TWO = "samples.flutter.dev/testolatwo";
    private int dork;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        dork = 0;
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL_ONE)
                .setMethodCallHandler(
                        (call, result) -> {
                            // Note: this method is invoked on the main thread.
                            if (call.method.equals("getChannelOne")) {
                                int channelOne = getChannelOne();

                                if (channelOne != -1) {
                                    result.success(channelOne);
                                } else {
                                    result.error("UNAVAILABLE", "Battery level not available.", null);
                                }
                            } else {
                                result.notImplemented();
                            }
                        }
                );
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL_TWO)
                .setMethodCallHandler(
                        (call, result) -> {
                            // Note: this method is invoked on the main thread.
                            if (call.method.equals("getChannelTwo")) {
                                String channelTwo = getChannelTwo();

                                if (channelTwo != "") {
                                    result.success(channelTwo);
                                } else {
                                    result.error("UNAVAILABLE", "Battery level not available.", null);
                                }
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

    private int getChannelOne() {
        dork ++;
        return dork;
    }

    private String getChannelTwo() {
        dork ++;
        if (dork <10) {
            return "Android 2";
        }
        else {
            dork = 0;
            return "";
        }
    }
}
