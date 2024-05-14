//
//  AppDelegate.swift
//  Rider
//
//  Copyright © 2018 minimalistic apps. All rights reserved.
//

import UIKit
import Stripe
import Firebase
import Kingfisher
import Braintree
import SocketIO
import FirebaseAuthUI
import BraintreeDropIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate,MessagingDelegate {
    static var info : [String:Any] {
        get {
            let path = Bundle.main.path(forResource: "Info", ofType: "plist")!
            return NSDictionary(contentsOfFile: path) as! [String: Any]
        }
    }
//    static var singlePointMode : Bool {
//        get {
//            return AppDelegate.info["SinglePointMode"] as! Bool
//        }
//    }
//    static var maximumDestinations : Int {
//        get {
//            return AppDelegate.info["MaximumDestinations"] as! Int
//        }
//    }
    var window: UIWindow?
    var launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    

    
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//
//        FUIAuth.defaultAuthUI()?.auth?.setAPNSToken(deviceToken, type: AuthAPNSTokenType.unknown)
//    }
    
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        FUIAuth.defaultAuthUI()?.auth?.canHandleNotification(userInfo)
//    }
//

    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification notification: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if Auth.auth().canHandleNotification(notification) {
            completionHandler(.noData)
            return
        }
    }

    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        if url.scheme?.localizedCaseInsensitiveCompare(Bundle.main.bundleIdentifier! + ".payments") == .orderedSame {
//            return BTAppSwitch.handleOpen(url, options: options)
//        }
      // return (FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: nil))!
        
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // FirebaseApp.configure()
        
//        RazorpayCheckout.setKey("YOUR_RAZORPAY_API_KEY")
      //  let razorpay = RazorpayCheckout.initWithKey("YOUR_RAZORPAY_KEY", andDelegate: self)

//
//        let payUConfiguration = PayUConfiguration.self
//        PayUSDK.initialize(apiKey: payUConfiguration.apiKey, apiSecretKey: payUConfiguration.apiSecretKey, merchantId: payUConfiguration.merchantId, environment: payUConfiguration.environment)
//
//
//        GMSPlacesClient.provideAPIKey("AIzaSyBn5gHHZP-V3517BQ163GxfuGZFckbefq8")
//
//        GMSServices.provideAPIKey("AIzaSyBn5gHHZP-V3517BQ163GxfuGZFckbefq8")
//
        UserDefaults.standard.set("eDAt9YjlnkR3o7JhslF_Fw:APA91bFEyMZXsB8JWTzrvVaz9xGXFIo-ctTHPS1qdYmUpgJI4t29dzz6VjSQKnxDFFZ6bn6tPbOtXNolpef0f8-s2t14mP-FSfvLSXfGTOR00V5PYj0BYcrRvAYUkUdOh4eHN7yPeqIx", forKey: "devicetoken")
        FirebaseApp .configure()
        Messaging.messaging().delegate = self
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        
   
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            application.registerForRemoteNotifications()
            
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound],
                                       categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        Messaging.messaging().delegate = self
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        }
        else {
            // Fallback on earlier versions
        }
        
        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")
        UserDefaults.standard.set(token, forKey: "devicetoken")
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        }
        else {
            
            // Fallback on earlier versions
        }
//    return true
        
       // razorpay = RazorpayCheckout.initWithKey("rzp_test_5TvihLaAB5Cw3l", andDelegate: self)

   
     //   Stripe.setDefaultPublishableKey("pk_test_51NgLDISE7jTLonNSqrc5nylSHJcp0ijO0qd9R2VDQw3w37uif2yASpc8dJU3LwBGdaQJsNTz7rwFh4kylzAy56nE00kiCrsIcP")
        return true
        
    }
    func messaging(
        _ messaging: Messaging,
        didReceiveRegistrationToken fcmToken: String?
    ) {
        let tokenDict = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: NSNotification.Name("FCMToken"),
            object: nil,
            userInfo: tokenDict)
        print("Firebase registration token: \(fcmToken ?? "")")

      //  UserDefaults.standard.set(fcmToken, forKey: "devicetoken")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        LoadingOverlay.shared.hideOverlayView()
        SocketNetworkDispatcher.instance.disconnect()
    }
    
//    func applicationWillEnterForeground(_ application: UIApplication) {
//        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//        guard let jwt = UserDefaultsConfig.jwtToken else {
//            return
//        }
//        // LoadingOverlay.shared.showOverlay(view: self.window?.rootViewController?.presentedViewController?.view)
//        if let presented = self.window?.rootViewController?.presentedViewController {
//            LoadingOverlay.shared.showOverlay(view: presented.view)
//        } else {
//            LoadingOverlay.shared.showOverlay(view: self.window?.rootViewController?.view)
//        }
//        Messaging.messaging().token() { token, error in
//
//        }
//        Messaging.messaging().token() { (fcmToken, error) in
//            print("fcmToken%@",fcmToken as Any)
//            print("fcmTokenerror%@",error as Any)
//
//            SocketNetworkDispatcher.instance.connect(namespace: .Rider, token: jwt, notificationId: fcmToken ?? "") { result in
//                LoadingOverlay.shared.hideOverlayView()
//                switch result {
//                case .success(_):
//                    NotificationCenter.default.post(name: .connectedAfterForeground, object: nil)
//
//                case .failure(_):
//                    break
//                }
//            }
//        }
//    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        
        FUIAuth.defaultAuthUI()?.auth?.setAPNSToken(deviceToken, type: AuthAPNSTokenType.unknown)

        let firebaseAuth = Auth.auth()
        
        firebaseAuth.setAPNSToken(deviceToken, type: AuthAPNSTokenType.sandbox)
        
        //   Auth.auth().setAPNSToken(deviceToken, type: .prod)
       
        var token = ""
        Messaging.messaging().apnsToken = deviceToken
        
        for i in 0..<deviceToken.count {
            token += String(format: "%02.2hhx", arguments: [deviceToken[i]])
        }
        //  userDefault.set(token, forKey: "deviceToken")
        print("Registration succeeded!")
        print("Token: ", token)
        UserDefaults.standard.set(token, forKey: "devicetoken")
    }
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
}

extension UIColor {
    static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else { return light }
        return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
    }
}

