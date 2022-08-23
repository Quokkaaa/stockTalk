//
//  User.swift
//  StockTalk
//
//  Created by LIMGAUI on 2022/08/23.
//

import Foundation

struct User {
  private let id: UUID
  private let nickName: String
  private let loginType: SNSLogin
  private var isLogin: Bool
  private var postCount: Int
  private var follower: Int
  private var following: Int
}
