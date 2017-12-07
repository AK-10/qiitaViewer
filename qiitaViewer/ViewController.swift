//
//  ViewController.swift
//  qiitaViewer
//
//  Created by Atsushi KONISHI on 2017/12/05.
//  Copyright © 2017年 小西篤志. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var articleTable: UITableView!
    var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // http request
        let url = "https://qiita.com/api/v2/items?"
        articles = getArticles(url: url)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getArticles(url: String) -> [Article] {
        // setup URLrequest
        guard let url = URL(string: url) else {
            print("Error: can not create URL")
            return []
        }
        let urlRequest = URLRequest(url: url)
        
        // setup Session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var items: [Article] = []
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print("error calling")
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            let json = JSON(responseData)
            for (_,subJson):(String, JSON) in json {
////                // Do something you want
                let item = Article(title: subJson["title"].stringValue, id: subJson["user"]["id"].stringValue, url: subJson["url"].stringValue, tags: subJson["tags"].arrayValue.map({ $0["name"].stringValue }))
                items.append(item)
            }
            for i in items {
                print(i.title)
            }
//            print(json[0]["tags"].arrayValue.map({ $0["name"].stringValue }))
        }
        
        task.resume()
        return items
    }

}

//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return articles.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    }
//
//}

