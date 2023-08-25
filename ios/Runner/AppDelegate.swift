import UIKit
import Flutter
import GoogleMaps
import flutter_local_notifications
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyDV_Jpvgc5O_-kYqqLu5GVMPIj2Kv2Xrq8")
             FirebaseApp.configure() //add this before the code below
             GeneratedPluginRegistrant.register(with: self)
         if #available(iOS 10.0, *) {
               UNUserNotificationCenter.current().delegate = self
             }
               FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
                   GeneratedPluginRegistrant.register(with: registry)
                }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
