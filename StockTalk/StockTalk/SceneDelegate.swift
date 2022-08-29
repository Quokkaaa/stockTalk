//
//  SceneDelegate.swift
//  StockTalk
//
//  Created by LIMGAUI on 2022/08/23.
//

import UIKit
import KakaoSDKAuth

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = LoginViewController()
    window?.makeKeyAndVisible()
  }
  
  // MARK: - 카카오 로그인 접근 (WebView) url을 가져와서 url ==. 카카오 schem와 일치하는이 여부를 확인하고 내부로 접근하는 방식으로 보인다.
  func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
      if let url = URLContexts.first?.url {
          if (AuthApi.isKakaoTalkLoginUrl(url)) {
              _ = AuthController.handleOpenUrl(url: url)
          }
      }
  }
  
  func sceneDidDisconnect(_ scene: UIScene) {}
  func sceneDidBecomeActive(_ scene: UIScene) {}
  func sceneWillResignActive(_ scene: UIScene) {}
  func sceneWillEnterForeground(_ scene: UIScene) {}

  func sceneDidEnterBackground(_ scene: UIScene) {
    (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
  }
}
