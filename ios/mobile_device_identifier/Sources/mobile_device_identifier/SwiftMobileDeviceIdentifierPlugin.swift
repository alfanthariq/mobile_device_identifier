import Flutter
import Security
import UIKit

public class SwiftMobileDeviceIdentifierPlugin: NSObject, FlutterPlugin {
  private static let keychainAccount = "com.alfanthariq.mobile_device_identifier/device_id"

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "mobile_device_identifier",
      binaryMessenger: registrar.messenger()
    )
    let instance = SwiftMobileDeviceIdentifierPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getDeviceId":
      result(getOrCreateDeviceId(account: Self.keychainAccount))
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func getOrCreateDeviceId(account: String) -> String {
    if let existing = readKeychainString(account: account) {
      return existing
    }
    let newId = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
    writeKeychainString(newId, account: account)
    return newId
  }

  private func readKeychainString(account: String) -> String? {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: account,
      kSecReturnData as String: true,
      kSecMatchLimit as String: kSecMatchLimitOne,
    ]
    var item: CFTypeRef?
    let status = SecItemCopyMatching(query as CFDictionary, &item)
    guard status == errSecSuccess, let data = item as? Data else {
      return nil
    }
    if let string = String(data: data, encoding: .utf8) {
      return string
    }
    // Legacy JNKeychain entries are NSKeyedArchiver-encoded — decode and rewrite as plain UTF-8.
    if let unarchived = try? NSKeyedUnarchiver.unarchivedObject(
      ofClasses: [NSString.self], from: data) as? String {
      writeKeychainString(unarchived, account: account)
      return unarchived
    }
    return nil
  }

  private func writeKeychainString(_ value: String, account: String) {
    let data = Data(value.utf8)
    let attributes: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: account,
      kSecValueData as String: data,
    ]
    SecItemDelete(attributes as CFDictionary)
    SecItemAdd(attributes as CFDictionary, nil)
  }
}
