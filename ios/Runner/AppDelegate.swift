import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel: FlutterMethodChannel = FlutterMethodChannel(
            name: "com.flamyoad.sharemessage",
            binaryMessenger: controller.binaryMessenger
        )
        
        channel.setMethodCallHandler({ [weak self]
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            switch call.method {
            case "method_share_message":
                if let message = (call.arguments as? NSDictionary)?["arg_message"] as? String {
                    self?.shareMessage(message)
                }
                break
            default:
                result(FlutterMethodNotImplemented)
                return
            }
        })
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func shareMessage(_ message: String) {
        let vc: UIActivityViewController = UIActivityViewController(
            activityItems: [message],
            applicationActivities: nil
        )
        UIApplication.shared.windows.first?.rootViewController?.present(vc, animated: true)
    }
}
