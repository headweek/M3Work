//
//  ImageItem.swift
//  m3hw
//
//  Created by Salman Abdullayev on 31.01.24.
//

import Foundation
import RealmSwift

class ImageItem: Object{
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var imageName: String = ""
    @Persisted var date: Date = Date()
}
