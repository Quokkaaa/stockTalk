//
//  KakaoAuthViewModel.swift
//  StockTalk
//
//  Created by LIMGAUI on 2022/08/23.
//

import Foundation
import Combine
import KakaoSDKAuth
import KakaoSDKUser

final class KakaoAuthService: ObservableObject {
  @Published var isLoggedIn: Bool = false
  
  lazy var loginStatusInfo: AnyPublisher<String?, Never> = $isLoggedIn
    .compactMap { $0 ? "로그인 상태" : "로그아웃 상태" }.eraseToAnyPublisher()
  
  // 카카오 앱으로 로그인 인증
  private func handleKakaoLoginWithApp() async -> Bool {
    await withCheckedContinuation({ continuation in
      UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
        if let error = error {
          print(error)
          continuation.resume(returning: false)
        } else {
          print("loginWithKakaoTalk() success.")
          
          //do something
          _ = oauthToken
          continuation.resume(returning: true)
        }
      }
    })
  }
  
  private func handleKakaoLoginWithAccount() async -> Bool {
    await withCheckedContinuation({ continuation in
      UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
        if let error = error {
          print(error)
          continuation.resume(returning: false)
        } else {
          print("loginWithKakaoAccount() success.")
          
          //do something
          _ = oauthToken
          continuation.resume(returning: true)
        }
      }
    })
  }
  
  @MainActor
  func KakaoLogin() {
    print("KakaoLogin() called")
    Task {
      // 카카오톡 설치 여부 확인
      // 카톡이 설치되 있다면 ??? -> loginWithKakaoTalk() 메서드 호출
      if (UserApi.isKakaoTalkLoginAvailable()) {
        // await상태가 할당이된다.
        isLoggedIn = await handleKakaoLoginWithApp()
      } else { // 카톡이 설치가 안되있다면 ??? -> loginWithKakaoAccount() 메서드 호출
        isLoggedIn = await handleKakaoLoginWithAccount()
      }
    }
  }
  
  @MainActor
  func kakaoLogout() {
    print("kakaoLogout() called")
    Task {
      if await handleKakaoLogout() {
        self.isLoggedIn = false
      }
    }
  }
  
  private func handleKakaoLogout() async -> Bool {
    await withCheckedContinuation({ continuation in
      UserApi.shared.logout {(error) in
        if let error = error {
          print(error)
          continuation.resume(returning: false)
        } else {
          print("logout() success.")
          continuation.resume(returning: true)
        }
      }
    })
  }
}
