package io.flutter.plugins

import android.annotation.SuppressLint
import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkInfo
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

object NetProviderPlugins {
    private const val ChannelName = "com.fun.framework.plugins/net";

    fun register(context: Context, messenger: BinaryMessenger) = MethodChannel(messenger, ChannelName).setMethodCallHandler { methodCall, result ->
        when (methodCall.method) {
            "isNetworkAvailable" -> result.success(isNetworkAvailable(context))
            "isWifi" -> result.success(isWifi(context))
        }
        result.success(false) //没有返回值，所以直接返回为null
    }

    private fun isNetworkAvailable(context: Context):Boolean {
        val connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

        if (connectivityManager == null) {
            return false
        } else {
            val networkInfo = connectivityManager.allNetworkInfo
            if (networkInfo != null && networkInfo.size > 0) {
                for (info in networkInfo) {
                    if (info.state == NetworkInfo.State.CONNECTED) {
                        return true
                    }
                }
            }
        }
        return false
    }

    private fun isWifi(context: Context):Boolean {
        val connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        if (connectivityManager != null) {
            val networkInfo = connectivityManager.allNetworkInfo
            if (networkInfo != null && networkInfo.size > 0) {
                for (info in networkInfo) {
                    val netType = info.type
                    if (netType == ConnectivityManager.TYPE_WIFI) {  //WIFI
                        return info.isConnected
                    }
                }
            }
        }
        return false
    }

}