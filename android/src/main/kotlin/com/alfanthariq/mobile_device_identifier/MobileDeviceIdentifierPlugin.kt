package com.alfanthariq.mobile_device_identifier

import android.annotation.SuppressLint
import android.content.Context
import android.provider.Settings
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.UUID
import androidx.core.content.edit
import io.flutter.Log

class MobileDeviceIdentifierPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var appContext: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "mobile_device_identifier")
        channel.setMethodCallHandler(this)
        appContext = flutterPluginBinding.applicationContext
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "getDeviceId" -> {
                val deviceId = getDeviceId(appContext)
                Log.i("device_id",deviceId);
                result.success(deviceId)
            }
            else -> result.notImplemented()
        }
    }

    @SuppressLint("HardwareIds")
    private fun getDeviceId(context: Context): String {   return try {
        val androidId = Settings.Secure.getString(context.contentResolver,Settings.Secure.ANDROID_ID)
        Log.i("device_id from setting secure",androidId);
        return androidId.ifEmpty {
            getPersistentDeviceId(context)
        }
    } catch (e: Exception) {
        // Log.e("MobileDeviceIdentifier", "Error fetching ANDROID_ID", e)
        getPersistentDeviceId(context)
    }
    }

    private fun getPersistentDeviceId(context: Context): String {    return try {
        val sharedPref = context.getSharedPreferences("device_prefs", Context.MODE_PRIVATE)
        var deviceId = sharedPref.getString("persistent_device_id", null)

        if (deviceId == null) {
            deviceId = UUID.randomUUID().toString()
            sharedPref.edit { putString("persistent_device_id", deviceId) }
        }

        return deviceId
    }catch (e: Exception) {
        // Log.e("MobileDeviceIdentifier", "Error generating persistent ID", e)
        // As a last resort fallback
        UUID.randomUUID().toString()
    }
    }
}