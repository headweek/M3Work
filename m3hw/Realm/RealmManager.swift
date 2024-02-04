//
//  RealmManager.swift
//  m3hw
//
//  Created by Salman Abdullayev on 30.01.24.
//

import Foundation
import RealmSwift

class RealmManager {
    var images: [ImageItem] = []
    let realm = try! Realm()
    
    init(){
        fetchResults()
    }
    
    func writeToRealm(photoName: String) {
        let imageItem = ImageItem()
        imageItem.imageName = photoName
    
        do {
            try realm.write({
                realm.add(imageItem)
            })
        } catch {
            print(error.localizedDescription)
        }
        
        fetchResults()
    }
    
    func fetchResults(){
        let items = realm.objects(ImageItem.self)
        self.images = Array(items)
    }
}
