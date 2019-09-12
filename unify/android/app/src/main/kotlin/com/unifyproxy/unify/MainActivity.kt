package com.unifyproxy.unify

import android.os.Bundle
import android.os.Looper.loop
import android.provider.ContactsContract
import android.util.Log

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import java.io.File
import java.io.FileOutputStream
import java.lang.Exception

import kotlin.io.*
import android.os.Build
import android.os.Environment
import java.nio.charset.Charset

class MainActivity : FlutterActivity() {

    val TUN2SOCKS_PATH by lazy {
       "${dataDir.absolutePath}/tun2socks"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)


        try {
            InitAssets()
            val p = Runtime.getRuntime().exec(TUN2SOCKS_PATH)
            Log.e("output------------", String(p.inputStream.readBytes(), charset= Charset.defaultCharset()))
        } catch (e: Exception) {
            Log.e("eeeeeee", e.toString())
        }

        Log.e("files dir", dataDir.absolutePath)
    }

    fun InitAssets() {
        val defaultABI = Build.SUPPORTED_ABIS[0]

//        Log.e("DEFAULT ABI: ", defaultABI)
        val output = File(TUN2SOCKS_PATH)

        if(!output.exists()) {
            val file = assets.open("exes/${defaultABI}/tun2socks")
            file.copyTo(output.outputStream(), 1024)
        }

        if (!output.canExecute()) {
            output.setExecutable(true)
        }
    }

}
