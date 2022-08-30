//
//  GoogleAuthService.swift
//  StockTalk
//
//  Created by LIMGAUI on 2022/08/29.
//

import Foundation
import Combine
import GoogleSignIn

final class GoogleAuthService: SocialLoginable {
  static let shared = GoogleAuthService()
  
  @Published var isLoggedIn: Bool = false
  
  lazy var loginStatusInfo: AnyPublisher<String?, Never> = $isLoggedIn
    .compactMap { $0 ? "로그인 상태" : "로그아웃 상태" }.eraseToAnyPublisher()
  
  func login() {}
  
  func logout() {
    GIDSignIn.sharedInstance.signOut()
  }
}
