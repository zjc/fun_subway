package com.mark.funsubway

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugins.ToastProviderPlugins
import io.flutter.plugins.NetProviderPlugins
import io.flutter.plugins.webview.FlutterWebviewPlugin

class MainActivity(): FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    ToastProviderPlugins.register(this,flutterView)
    NetProviderPlugins.register(this,flutterView)
    FlutterWebviewPlugin.register(this,flutterView)
  }
}
