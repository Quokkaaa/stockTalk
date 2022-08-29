//
//  AppleAuthService.swift
//  StockTalk
//
//  Created by LIMGAUI on 2022/08/27.
//

import Foundation
import Combine
import AuthenticationServices

final class AppleAuthService: SocialLoginable {
  static let shared = AppleAuthService()
  
  @Published var isLoggedIn: Bool = false
  
  lazy var loginStatusInfo: AnyPublisher<String?, Never> = $isLoggedIn
    .compactMap { $0 ? "로그인 상태" : "로그아웃 상태" }.eraseToAnyPublisher()
  
  func login() {
      let provider = ASAuthorizationAppleIDProvider()
      let request = provider.createRequest()
      request.requestedScopes = [.email, .fullName]
      
      let controller = ASAuthorizationController(authorizationRequests: [request])
//      controller.delegate = self
//      controller.presentationContextProvider = self
      controller.performRequests()
  }
  
  func logout() {
    //
  }
}
