//
//  Model.swift
//  m3hw
//
//  Created by Salman Abdullayev on 06.01.24.
//

import Foundation

class Service {
    
    func getNews (q: String, count: Int, completion: @escaping ([NewsItem]) -> ()) {
    //https://newsapi.org/v2/everything?q=bitcoin&apiKey=02d00ce5975d4f2ebf0f246dc58842f1
        //https://newsapi.org/v2/everything?q=tesla&from=2023-12-06&sortBy=publishedAt&apiKey=02d00ce5975d4f2ebf0f246dc58842f1
        var urlComponents = URLComponents()
        urlComponents.host = "https"
        urlComponents.host = "newsapi.org"
        urlComponents.path = "/v2/everything"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "count", value: "\(count)"),
            URLQueryItem(name: "apiKey", value: "02d00ce5975d4f2ebf0f246dc58842f1"),
            URLQueryItem(name: "language", value: "ru")
        ]
        guard let url = urlComponents.url else {return}
        let urlReq = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlReq) {data , _ , err in
            guard
                err == nil,
                let resData = data
            else {
                print(err!.localizedDescription)
                return
            }
            do {
                let result = try JSONDecoder().decode(News.self, from: resData)
                completion(result.articles)
            }catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}


struct News: Decodable {
    let totalResults: Int
    let articles: [NewsItem]
}

struct NewsItem: Decodable {
    let source: [SourceItem]
    let author: String?
    let title: String?
    let description: String?
}

struct SourceItem: Decodable {
    let name: String?
}
