import UIKit
import Flutter
import GoogleMaps
import flutter_local_notifications
import Firebase
import YandexMapsMobile

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      YMKMapKit.setApiKey("b00283f6-30a9-406b-89fe-0c16bf88728c")
          GMSServices.provideAPIKey("AIzaSyAb8apYhSa_wvkAtHgQPhGr7o4JRmPA3Yw")
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
