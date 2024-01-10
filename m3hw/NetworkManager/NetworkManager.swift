//
//  NetworkManager.swift
//  m3hw
//
//  Created by Salman Abdullayev on 10.01.24.
//

import Foundation
import Alamofire

class NetworkManager {
    
    func getImagesFromUnsplash ( completion: @escaping ([Item]?) -> ()) {
        let param: Parameters = [
            "per_page": 15,
            "order_by": "latest",
            "client_id": "qj6Vpe3-vJs5wTpjvLKvPcsN1QiC08n5_wyFNWDhi4c"
        ]
        AF.request( "https://api.unsplash.com/photos" , method: .get, parameters: param).response { res in
            guard
                res.error == nil,
                let data = res.data
            else {
                print(res.error!.localizedDescription)
                return
            }
            print(data)
            let images = try? JSONDecoder().decode([Item].self, from: data)
            completion(images)
        }
        
    }
    
    func searchItem (completion: @escaping (SearchItem?) -> ()) {
        let paramSearch: Parameters = [
            "query": "",
            "client_id": "qj6Vpe3-vJs5wTpjvLKvPcsN1QiC08n5_wyFNWDhi4c"
        ]
        
        AF.request("https://api.unsplash.com/search/photos", method: .get, parameters: paramSearch).response { res in
            guard
                res.error == nil,
                let data = res.data
            else {
                return
            }
            let images = try? JSONDecoder().decode(SearchItem.self, from: data)
            completion(images)
        }
    }
}
