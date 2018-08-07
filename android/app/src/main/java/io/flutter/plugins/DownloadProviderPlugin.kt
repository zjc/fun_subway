package io.flutter.plugins

import android.app.DownloadManager
import android.content.Context
import android.net.Uri
import android.os.Environment
import android.widget.Toast
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

object DownloadProviderPlugin {
    private const val ChannelName = "com.fun.framework.plugins/download"
    fun register(context: Context, messenger: BinaryMessenger) = MethodChannel(messenger, ChannelName).setMethodCallHandler { methodCall, result ->
        when (methodCall.method) {
            "downloadImage" -> downloadImage(context,methodCall.argument("url"))
        }
        result.success(null) //没有返回值，所以直接返回为null
    }

    fun downloadImage(context:Context,url: String) {
        var request = DownloadManager.Request(Uri.parse(url))
        request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED)
        request.setDestinationInExternalFilesDir(context, Environment.DIRECTORY_DCIM, "")
        request.setTitle("图片")
        request.setDescription("下载完后请点击打开")

        val dm = context.applicationContext.getSystemService(Context.DOWNLOAD_SERVICE) as DownloadManager
        val downloadId = dm.enqueue(request)

    }


}