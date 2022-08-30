//
//  MyProfileViewModel.swift
//  StockTalk
//
//  Created by LIMGAUI on 2022/08/29.
//

import Foundation

final class LoginViewModel {
  // 사용자 타입이 생성되야하는 상황 - 게시글작성, 또는 내 정보에서 로그인버튼 누를때
  var user: User?
  var loginService: SocialLoginable?
  
  // MARK: - Input
  func kakaoLoginButtonDidTap() {
    kakaoLoginOn()
    loginService?.login()
  }
  
  func appleLoginButtonDidTap() {
    appleLoginOn()
    loginService?.login()
  }
  
  func googleLoginButtonDidTap() {
    googleLoginOn()
    loginService?.login()
  }
  
  private func kakaoLoginOn() {
    loginService = KakaoAuthService.shared
  }
  
  private func appleLoginOn() {
    loginService = AppleAuthService.shared
  }
  
  private func googleLoginOn() {
    loginService = GoogleAuthService.shared
  }
  
  private func createKakaoUser() {
    user = User(id: UUID().uuidString, nickName: "", signedInType: .kakao, isLogin: true, postCount: 0, follower: 0, following: 0)
  }
  
  private func createAppleUser() {
    user = User(id: UUID().uuidString, nickName: "", signedInType: .apple, isLogin: true, postCount: 0, follower: 0, following: 0)
  }
  
  // MARK: - Output
}
