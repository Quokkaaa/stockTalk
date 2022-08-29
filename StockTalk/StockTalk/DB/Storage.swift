//
//  Storage.swift
//  StockTalk
//
//  Created by LIMGAUI on 2022/08/29.
//

import Foundation
import Combine

protocol StorageType {
  func create<T>(_ item: T)
  func read<T>() -> AnyPublisher<[T], Never>
  func update<T>(_ item: T)
  func delete<T>(_ item: T)
}
