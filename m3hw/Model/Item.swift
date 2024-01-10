//
//  Item.swift
//  m3hw
//
//  Created by Salman Abdullayev on 10.01.24.
//

import Foundation

struct Item: Decodable {
    let width: Int?
    let height: Int?
    let urls: Urls
}
struct Urls: Decodable {
    let regular: String?
}
