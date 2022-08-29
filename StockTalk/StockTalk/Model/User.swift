//
//  User.swift
//  StockTalk
//
//  Created by LIMGAUI on 2022/08/23.
//

import Foundation

struct User {
  let id: String
  let nickName: String
  let loginType: SNSLogin
  var isLogin: Bool
  var postCount: Int
  var follower: Int
  var following: Int
}
