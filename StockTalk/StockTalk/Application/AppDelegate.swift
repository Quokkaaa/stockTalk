//
//  AppDelegate.swift
//  StockTalk
//
//  Created by LIMGAUI on 2022/08/23.
//

import UIKit
import CoreData
import KakaoSDKCommon
import KakaoSDKAuth

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let nativeAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
    
    KakaoSDK.initSDK(appKey: nativeAppKey as? String ?? "${KAKAO_NATIVE_APP_KEY}")
    
    return true
  }
  
  // MARK: - 카카오 로그인 접근 (WebView)
  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
      if (AuthApi.isKakaoTalkLoginUrl(url)) {
          return AuthController.handleOpenUrl(url: url)
      }

      return false
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}

  // MARK: - Core Data stack

  lazy var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "StockTalk")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
          if let error = error as NSError? {
              fatalError("Unresolved error \(error), \(error.userInfo)")
          }
      })
      return container
  }()

  // MARK: - Core Data Saving support

  func saveContext () {
      let context = persistentContainer.viewContext
      if context.hasChanges {
          do {
              try context.save()
          } catch {
              let nserror = error as NSError
              fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
      }
  }
}

