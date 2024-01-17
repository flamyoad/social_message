package com.flamyoad.socialmessage.social_message

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

private const val CHANNEL = "com.flamyoad.sharemessage"

private const val METHOD_SHARE_MESSAGE = "method_share_message"
private const val ARG_MESSAGE = "arg_message"

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == METHOD_SHARE_MESSAGE) {
                runCatching {
                    val message = call.argument<String?>(ARG_MESSAGE)
                    shareMessageViaIntent(message ?: "")
                }.getOrElse { e ->
                    result.error("FAIL_ERROR_CODE", "Failed to send message", e)
                }
            }
        }
    }

    private fun shareMessageViaIntent(message: String) {
        val intent = Intent().apply {
            action = Intent.ACTION_SEND
            type = "text/plain"
            putExtra(Intent.EXTRA_TEXT, message)
        }
        startActivity(intent)
    }

}
