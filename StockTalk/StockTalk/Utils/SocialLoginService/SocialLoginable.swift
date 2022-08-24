//
//  SocialLoginable.swift
//  StockTalk
//
//  Created by LIMGAUI on 2022/08/24.
//

import Foundation

protocol SocialLoginable {
  var kakaoService: KakaoAuthViewModel { get set }
  var naverService: String { get set }
  var appleService: String { get set }
}

final class SocialLoginService: SocialLoginable {
  var kakaoService: KakaoAuthViewModel
  var naverService: String
  var appleService: String
  
  init(kakaoService: KakaoAuthViewModel, naverService: String, appleService: String) {
    self.kakaoService = kakaoService
    self.naverService = naverService
    self.appleService = appleService
  }
}
