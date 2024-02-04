//
//  StorageManager.swift
//  m3hw
//
//  Created by Salman Abdullayev on 01.02.24.
//

import Foundation

class StorageManager{
    
    private func fileManagerPatch() -> URL{
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    //save
    
    func saveImage(imageName: String, imageData: Data){
        var path = fileManagerPatch()
        path.append(path: imageName)
        
        do {
            try imageData.write(to: path)
        } catch {
            print(error.localizedDescription)
        }
        
    }

    func loadImage(imageName: String) -> Data{
        var path = fileManagerPatch()
        path.append(path: imageName)
        
        guard let imageData = try? Data(contentsOf: path) else { return Data()}
        
        return imageData
    }
}
