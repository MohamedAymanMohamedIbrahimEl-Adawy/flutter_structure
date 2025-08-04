import UIKit
import IOSSecuritySuite
import Flutter
import Firebase
import BackgroundTasks

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let schemeName = Bundle.main.infoDictionary!["CURRENT_SCHEME_NAME"] as! String
    print("ℹ️ CURRENT_SCHEME_NAME: \(schemeName)")
    // if schemeName != "dev" {
    //   IOSSecuritySuite.denyDebugger()
    //   self.checkSecurity()
    // }

    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)

    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self
    }

    setExcludeFromiCloudBackup(isExcluded: true)

    if #available(iOS 13.0, *) {
      registerBackgroundTask()
    }


    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "vpn_proxy_channel", binaryMessenger: controller.binaryMessenger)

    channel.setMethodCallHandler { (call, result) in
        if call.method == "isUsingVPN" {
            result(self.isVPNConnected())
        } else if call.method == "isUsingProxy" {
            result(self.isProxyEnabled())
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  private func isVPNConnected() -> Bool {
      var addresses = [String]()

      var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
      if getifaddrs(&ifaddr) == 0 {
          var ptr = ifaddr
          while ptr != nil {
              let name = String(cString: ptr!.pointee.ifa_name)
              if name.contains("utun") || name.contains("ppp") {
                  return true
              }
              ptr = ptr!.pointee.ifa_next
          }
          freeifaddrs(ifaddr)
      }
      return false
  }

  private func isProxyEnabled() -> Bool {
      guard let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any] else {
          return false
      }
      if let httpEnable = proxySettings["HTTPEnable"] as? Int, httpEnable == 1 {
          return true
      }
      if let httpsEnable = proxySettings["HTTPSEnable"] as? Int, httpsEnable == 1 {
          return true
      }
      return false
  }

  private func setExcludeFromiCloudBackup(isExcluded: Bool) {
    do {
      let fileOrDirectoryURL = try FileManager.default.url(
        for: .documentDirectory,
        in: .userDomainMask,
        appropriateFor: nil,
        create: true
      )

      var values = URLResourceValues()
      values.isExcludedFromBackup = isExcluded
      var mutableURL = fileOrDirectoryURL
      try mutableURL.setResourceValues(values)

      #if DEBUG
      print("📦 iCloud Backup Exclusion set to \(isExcluded) for path: \(mutableURL.path)")
      #endif
    } catch {
      #if DEBUG
      print("❌ Failed to set iCloud Backup exclusion: \(error)")
      #endif
    }
  }

  func registerBackgroundTask() {
    if #available(iOS 13.0, *) {
      BGTaskScheduler.shared.register(
        forTaskWithIdentifier: "com.flutter.structure.backgroundtask",
        using: nil
      ) { task in
        task.setTaskCompleted(success: true)
      }
    } else {
      #if DEBUG
      print("⚠️ BGTaskScheduler is not available below iOS 13.")
      #endif
    }
  }
  func checkSecurity() {
    let reasons: [String: Bool] = [
      "🔓 Reverse Engineering Detected": runReversedEngineeringCheck(),
      "📱 Jailbreak Detected": runIntegrityCheck(),
      "🕹️ Emulator or Debugging Detected": runDebugCheck(),
      "🌍 Proxy Detected": runProxyCheck(),
      "🧬 Frida Detected": runFridaCheck(),
      "📦 DYLD Hooking Detected": runDYLDCheck()
    ]

    for (reason, detected) in reasons {
      if detected {
        print("❌ Security threat detected: \(reason)")

        // ❗️ ONLY exit in production
        #if !DEBUG
        let schemeName = Bundle.main.infoDictionary?["CURRENT_SCHEME_NAME"] as? String ?? ""
        if schemeName != "dev" {
          exit(0)
        }
        #endif
      }
    }

    #if DEBUG
    print("✅ Device passed all security checks (DEBUG build).")
    #endif
  }

  private func runIntegrityCheck() -> Bool {
    return SecurityHandler.checkJailbroken()
  }

  private func runDebugCheck() -> Bool {
    return SecurityHandler.checkRunInEmulator() || SecurityHandler.checkDebugged()
  }

  private func runProxyCheck() -> Bool {
    return SecurityHandler.checkProxied()
  }

  private func runReversedEngineeringCheck() -> Bool {
    return SecurityHandler.checkReverseEngineering()
  }

  private func runFridaCheck() -> Bool {
    return SecurityHandler.isFridaRunning()
  }

  private func runDYLDCheck() -> Bool {
    return SecurityHandler.checkDYLD()
  }
}

class RuntimeClass {
  @objc dynamic func runtimeModifiedFunction() -> Int {
    return 1
  }
}

class SecurityHandler {
  static func checkJailbroken() -> Bool {
    return IOSSecuritySuite.amIJailbroken()
  }

  static func checkRunInEmulator() -> Bool {
    return IOSSecuritySuite.amIRunInEmulator()
  }

  static func checkDebugged() -> Bool {
    return IOSSecuritySuite.amIDebugged()
  }

  static func checkProxied() -> Bool {
    return IOSSecuritySuite.amIProxied()
  }

  static func checkReverseEngineering() -> Bool {
    return IOSSecuritySuite.amIReverseEngineered()
  }

  static func isFridaRunning() -> Bool {
    let ports = [27042, 27043, 27044]
    for port in ports {
      if checkPort(port: in_port_t(port)) {
        return true
      }
    }
    return false
  }

  static func checkPort(port: in_port_t) -> Bool {
    func swapBytesIfNeeded(port: in_port_t) -> in_port_t {
      let littleEndian = Int(OSHostByteOrder()) == OSLittleEndian
      return littleEndian ? _OSSwapInt16(port) : port
    }

    var serverAddress = sockaddr_in()
    serverAddress.sin_family = sa_family_t(AF_INET)
    serverAddress.sin_addr.s_addr = inet_addr("127.0.0.1")
    serverAddress.sin_port = swapBytesIfNeeded(port: port)

    let sock = socket(AF_INET, SOCK_STREAM, 0)
    defer { close(sock) }

    let result = withUnsafePointer(to: &serverAddress) {
      $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
        connect(sock, $0, socklen_t(MemoryLayout<sockaddr_in>.stride))
      }
    }

    return result != -1
  }

  static func checkDYLD() -> Bool {
    let suspiciousLibraries = [
      "FridaGadget",
      "frida",
      "cynject",
      "libcycript"
    ]
    for library in suspiciousLibraries {
      if let handle = dlopen(library, RTLD_NOW | RTLD_NOLOAD) {
        dlclose(handle)
        return true
      }
    }
    return false
  }
}
