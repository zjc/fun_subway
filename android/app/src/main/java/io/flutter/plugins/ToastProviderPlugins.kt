package io.flutter.plugins

import android.content.Context
import android.widget.Toast
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

object ToastProviderPlugins {
    private const val ChannelName = "com.fun.framework.plugins/toast"
    
    fun register(context: Context, messenger: BinaryMessenger) = MethodChannel(messenger, ChannelName).setMethodCallHandler { methodCall, result ->
        when (methodCall.method) {
            "showShortToast" -> showToast(context, methodCall.argument("message"), Toast.LENGTH_SHORT)
            "showLongToast" -> showToast(context, methodCall.argument("message"), Toast.LENGTH_LONG)
            "showToast" -> showToast(context, methodCall.argument("message"), methodCall.argument("duration"))
        }
        result.success(null) //没有返回值，所以直接返回为null
    }

    private fun showToast(context: Context, message: String, duration: Int) = Toast.makeText(context, message, duration).show()



}