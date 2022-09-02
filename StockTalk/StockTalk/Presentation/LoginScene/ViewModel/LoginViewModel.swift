//
//  MyProfileViewModel.swift
//  StockTalk
//
//  Created by LIMGAUI on 2022/08/29.
//

import Foundation

final class LoginViewModel {
  // 사용자 타입이 생성되야하는 상황 - 게시글작성, 또는 내 정보에서 로그인버튼 누를때
  var socialLoginType: SNSLogin?
  var loginService: SocialLoginable?
  
  // MARK: - Input
  
  func kakaoLoginButtonDidTap() {
    setAuthServiceOn(to: .kakao)
    loginService?.login()
    createSNSLoginType(.kakao)
  }
  
  func appleLoginButtonDidTap() {
    setAuthServiceOn(to: .apple)
    loginService?.login()
    createSNSLoginType(.apple)
  }
  
  func googleLoginButtonDidTap() {
    setAuthServiceOn(to: .google)
    loginService?.login()
    createSNSLoginType(.google)
  }
  
  private func setAuthServiceOn(to snsType: SNSLogin) {
    if snsType == .kakao {
      loginService = KakaoAuthService.shared
    }
    
    if snsType == .apple {
      loginService = AppleAuthService.shared
    }
    
    if snsType == .google {
      loginService = GoogleAuthService.shared
    }
  }
  
  private func createSNSLoginType(_ snsType: SNSLogin) {
    socialLoginType = snsType
  }
  
  // MARK: - Output
}
