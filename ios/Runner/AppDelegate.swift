import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let channelOne = FlutterMethodChannel(name: "samples.flutter.dev/testola", binaryMessenger: controller.binaryMessenger)
      let channelTwo = FlutterMethodChannel(name: "samples.flutter.dev/testolatwo", binaryMessenger: controller.binaryMessenger)

      channelOne.setMethodCallHandler({
                (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                guard call.method == "getChannelOne" else {
                    result(FlutterMethodNotImplemented)
                    return
                }
                self.runChannelOne(result: result)
            })
      channelTwo.setMethodCallHandler({
                (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                guard call.method == "getChannelTwo" else {
                    result(FlutterMethodNotImplemented)
                    return
                }
                self.runChannelTwo(result: result)
            })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func runChannelOne(result: FlutterResult) {
        result(12)
    }

    private func runChannelTwo(result: FlutterResult) {
        result("Its Channel Two")
    }
}
