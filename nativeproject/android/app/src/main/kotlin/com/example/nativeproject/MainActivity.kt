package com.example.nativeproject

import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import kotlin.random.Random

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val channel = "flutter_channel"

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler { call, result ->
            when (call.method) {
                "getRandomNumber" -> {
                    // val number = getRandomNumber(this)
                    result.success(Random.nextInt())
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    // private fun getRandomNumber(context: Context): Int {
    //     return ;
    // }
}
