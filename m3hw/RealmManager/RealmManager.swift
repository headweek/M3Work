//
//  RealmManager.swift
//  m3hw
//
//  Created by Salman Abdullayev on 12.01.24.
//

import Foundation
import RealmSwift

class Photo: Object {
    @objc var imagePath: String = ""
    @objc var imageName: String = ""
}

class RealmManager {
    static let shared = RealmManager()
    private let realm: Realm

    private init() {
        // Инициализация Realm
        do {
            realm = try Realm()
        } catch {
            fatalError("Ошибка инициализации Realm: \(error)")
        }
    }

    // Метод для сохранения фотографии в базе данных Realm
    func savePhoto(imagePath: String, imageName: String) {
        do {
            try realm.write {
                let newPhoto = Photo()
                newPhoto.imagePath = imagePath
                newPhoto.imageName = imageName
                realm.add(newPhoto)
            }
        } catch {
            print("Ошибка сохранения в Realm: \(error)")
        }
    }

    // Метод для получения всех фотографий из базы данных Realm
    func getAllPhotos() -> Results<Photo> {
        return realm.objects(Photo.self)
    }
}

    
    
//    func addNote (note: Note) {
//        try! realm.write {
//            realm.add(note)
//        }
//        readNote()
//    }
    
    
    
    
    
    
        
        // Сохранение пути и имени изображения в Realm
        
    
    
//    func deleteNote(id: String){
//        guard let note = realm.object(ofType: Note.self, forPrimaryKey: id) else { return }
//        
//        try! realm.write{
//            realm.delete(note)
//        }
//        
//        readNote()
//    }

