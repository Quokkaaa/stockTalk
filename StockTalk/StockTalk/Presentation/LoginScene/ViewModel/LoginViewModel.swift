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
  let localDB: StorageType
  
  init(localDB: StorageType = CoreDataService.shared) {
    self.localDB = localDB
  }
  
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
    user = User(id: UUID().uuidString, nickName: "", socialLoginType: .kakao, createdAt: Date.now, isLogin: true, postCount: 0, followerCount: 0, followingCount: 0)
  }
  
  private func createAppleUser() {
    user = User(id: UUID().uuidString, nickName: "", socialLoginType: .apple, createdAt: Date.now, isLogin: true, postCount: 0, followerCount: 0, followingCount: 0)
  }
  
  // MARK: - Output
}
