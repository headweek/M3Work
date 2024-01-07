//
//  ViewController.swift
//  m3hw
//
//  Created by Salman Abdullayev on 03.01.24.
//

import UIKit

class ViewController: UIViewController {
    
    let service = Service()
    
    lazy var table: UITableView = {
        $0.register(UITableViewCell.self, forHeaderFooterViewReuseIdentifier: "cell")
        $0.dataSource = self
        return $0
    }(UITableView(frame: view.frame))
    
    var news: [NewsItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(table)
        service.getNews(q: "salman", count: 20) { news in
            self.news = news
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = news[indexPath.row].author
        return cell
    }
}
