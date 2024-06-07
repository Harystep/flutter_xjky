import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      let messager:FlutterBinaryMessenger = window.rootViewController as! FlutterBinaryMessenger
      testPlugin(messenger: messager)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
   func testPlugin(messenger: FlutterBinaryMessenger) {
       let channel = FlutterMethodChannel(name: "plugin_apple", binaryMessenger: messenger)
       channel.setMethodCallHandler { (call:FlutterMethodCall, result:@escaping FlutterResult) in
           
           if (call.method == "apple_one") {            
               print(call.arguments)                          
               result(["result":"success","code":200]);
           }
           
           if (call.method == "apple_two") {
               result(["result":"success","code":404]);
           }
    
       }
   }
    
}
