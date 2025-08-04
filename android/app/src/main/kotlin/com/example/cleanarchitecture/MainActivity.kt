package com.flutter.structure

import android.os.Bundle
import android.os.Build
import android.provider.Settings
import android.content.pm.PackageManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterFragmentActivity
import com.scottyab.rootbeer.RootBeer
import kotlinx.coroutines.*
import java.io.*
import java.net.*
import java.util.*

class MainActivity : FlutterFragmentActivity() {
    private val CHANNEL = "security_channel"
    private val coroutineScope = CoroutineScope(Dispatchers.Main + SupervisorJob())

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (RootBeer(this).isRooted) finish()
    }

    override fun onDestroy() {
        super.onDestroy()
        coroutineScope.cancel()
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "isDeviceRooted" -> result.success(isRooted())
                "isUsingVPN" -> result.success(isVPNActive())
                "isUsingProxy" -> result.success(isProxyUsed())
                "isAppInstalled" -> result.success(isAppInstalled())
                "isAdbEnabled" -> result.success(isAdbEnabled())
                "doesWhichWork" -> result.success(doesWhichWork())
                "stopApp" -> result.success(stopApp())

                "checkFrida" -> coroutineScope.launch {
                    result.success(checkFridaSuspending())
                }

                else -> result.notImplemented()
            }
        }
    }

    private fun isVPNActive(): Boolean {
        return try {
            NetworkInterface.getNetworkInterfaces().toList().any {
                it.name.contains("tun", ignoreCase = true) || it.name.contains("ppp", ignoreCase = true)
            }
        } catch (e: Exception) {
            false
        }
    }

    private fun isProxyUsed(): Boolean {
        val host = System.getProperty("http.proxyHost")
        val port = System.getProperty("http.proxyPort")
        return !host.isNullOrEmpty() && port != null
    }

    private fun isRooted(): Boolean {
        return RootBeer(this).isRooted || checkRootIndicators()
    }

    private fun checkRootIndicators(): Boolean {
        val paths = listOf(
            "/system/app/Superuser.apk", "/sbin/su", "/system/bin/su", "/system/xbin/su",
            "/data/local/xbin/su", "/data/local/bin/su"
        )
        return paths.any { File(it).exists() }
    }

    private fun isAppInstalled(): Boolean {
        val suspiciousPackages = listOf("com.kingroot.kinguser", "com.kingo.root", "com.topjohnwu.magisk")
        return suspiciousPackages.any {
            try {
                packageManager.getPackageInfo(it, 0); true
            } catch (e: PackageManager.NameNotFoundException) {
                false
            }
        }
    }

    private fun isAdbEnabled(): Boolean {
        return try {
            Settings.Global.getInt(contentResolver, Settings.Global.ADB_ENABLED, 0) == 1
        } catch (e: Settings.SettingNotFoundException) {
            false
        }
    }

    private fun doesWhichWork(): Boolean {
        return try {
            Runtime.getRuntime().exec(arrayOf("which", "su")).inputStream.bufferedReader().readLine() != null
        } catch (e: IOException) {
            false
        }
    }

    private suspend fun checkFridaSuspending(): Boolean = withContext(Dispatchers.IO) {
        return@withContext detectFridaProcesses() ||
                detectFridaLibraries() ||
                detectFridaPorts() ||
                detectXposed()
    }

    private fun detectFridaProcesses(): Boolean {
        val processes = listOf("frida-server", "frida", "frida-agent")
        return try {
            Runtime.getRuntime().exec("ps").inputStream.bufferedReader().useLines { lines ->
                lines.any { line -> processes.any { process -> line.contains(process) } }
            }
        } catch (e: IOException) {
            false
        }
    }

    private fun detectFridaLibraries(): Boolean {
        val libraries = listOf("libfrida-gadget.so", "substrate", "xposed", "xposedbridge.jar")
        val libDir = File("/data/data/$packageName/lib")
        return libDir.listFiles()?.any { file -> libraries.any { file.name.contains(it) } } ?: false
    }

    private fun detectFridaPorts(): Boolean {
        val ports = listOf(27042, 27043, 27044)
        return ports.any {
            try {
                Socket("127.0.0.1", it).close(); true
            } catch (_: IOException) {
                false
            }
        }
    }

    private fun detectXposed(): Boolean {
        return try {
            throw Exception("Xposed Test")
        } catch (e: Exception) {
            e.stackTrace.any { it.className.contains("de.robv.android.xposed") }
        }
    }

    private fun stopApp(): Boolean {
        val isTestKeys = Build.TAGS?.contains("test-keys") == true
        val paths = listOf(
            "/system/app/Superuser.apk", "/data/data/com.topjohnwu.magisk",
            "/sbin/su", "/system/bin/su", "/system/xbin/su"
        )
        return isTestKeys || paths.any { File(it).exists() }
    }
}
