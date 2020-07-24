//
//  DataSourceModel.swift
//  SegmentedControlPageDemo
//
//  Created by mbp13 on 2020/7/24.
//  Copyright © 2020 Anglemiku. All rights reserved.
//

import Foundation
import SwiftUI

struct Item: Hashable, Codable, Identifiable {
  var id: Int = 0
  var title: String = ""
}

struct Model: Hashable, Codable, Identifiable {
  var id: Int = 0
  var title: String = ""
  var list:[Item] = [Item(id: 0, title: "one"),
                     Item(id: 1, title: "two"),
                     Item(id: 2, title: "three"),
                     Item(id: 3, title: "four"),
                     Item(id: 4, title: "five"),
                     Item(id: 5, title: "six"),
                     Item(id: 6, title: "seven"),
                     Item(id: 7, title: "eight"),
                     Item(id: 8, title: "nine")]
  
}

final class DataModel: ObservableObject {
  
  @Published var sections:[Model] = [Model(id: 0, title: "one"),
                                     Model(id: 1, title: "two"),
                                     Model(id: 2, title: "three"),
                                     Model(id: 3, title: "four"),
                                     Model(id: 4, title: "five"),
                                     Model(id: 5, title: "six"),
                                     Model(id: 6, title: "seven"),
                                     Model(id: 7, title: "eight"),
                                     Model(id: 8, title: "nine")]
  
  
}

let APPWidth = UIScreen.main.bounds.width
