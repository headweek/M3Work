//
//  FileManager.swift
//  m3hw
//
//  Created by Salman Abdullayev on 15.01.24.
//

import Foundation

class StorageManager {
    
    func addPath () -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func saveImg (imageData: Data) {
        var pathUrl = addPath()
        
        pathUrl.append(path: "salman/2")
        
        try? FileManager.default.createDirectory(at: pathUrl, withIntermediateDirectories: true)
        
        pathUrl.append(path: "salman.jpg")
        do {
            try imageData.write(to: pathUrl)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
