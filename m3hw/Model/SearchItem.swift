//
//  SearchItem.swift
//  m3hw
//
//  Created by Salman Abdullayev on 11.01.24.
//

import Foundation

struct SearchItem: Decodable {
    let results: [Items]
}
struct Items: Decodable {
    let urls: UrlsItem
}
struct UrlsItem: Decodable {
    let regular: String?
}
