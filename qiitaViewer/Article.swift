//
//  Article.swift
//  qiitaViewer
//
//  Created by Atsushi KONISHI on 2017/12/07.
//  Copyright © 2017年 小西篤志. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

class Article {
    let title: String
    let qiitaID: String
//    let createdAt: Date
    let url: URL?
    let tags: [String]
    
    static var delegate: articleDelegate?
    
    init(title: String, id: String, url: String, tags: [String]) {
        self.title = title
        self.qiitaID = id
//        self.createdAt = created
        self.url = URL(string: url)!
        self.tags = tags
    }

    class func getArticles(url: String, completion: @escaping ([Article]) -> Void) {
        
        // setup URLrequest
        guard let url = URL(string: url) else {
            print("Error: can not create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // setup Session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var items: [Article] = []
        let task = session.dataTask(with: urlRequest){ (data, response, error) in
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
                // Do something you want
                let item = Article(title: subJson["title"].stringValue, id: subJson["user"]["id"].stringValue, url: subJson["url"].stringValue, tags: subJson["tags"].arrayValue.map({ $0["name"].stringValue }))
                items.append(item)
            }
            completion(items)
        }
        task.resume()
    }
    
    // Delegateでもやってみた
//    class func getArticlesByDelegate(url: String, vc: ViewController) {
//        // setup URLrequest
//        guard let url = URL(string: url) else {
//            print("Error: can not create URL")
//            return
//        }
//        let urlRequest = URLRequest(url: url)
//
//        // setup Session
//        let config = URLSessionConfiguration.default
//        let session = URLSession(configuration: config)
//        var items: [Article] = []
//        let task = session.dataTask(with: urlRequest){ (data, response, error) in
//            guard error == nil else {
//                print("error calling")
//                return
//            }
//            guard let responseData = data else {
//                print("Error: did not receive data")
//                return
//            }
//            let json = JSON(responseData)
//            for (_,subJson):(String, JSON) in json {
//                // Do something you want
//                let item = Article(title: subJson["title"].stringValue, id: subJson["user"]["id"].stringValue, url: subJson["url"].stringValue, tags: subJson["tags"].arrayValue.map({ $0["name"].stringValue }))
//                items.append(item)
//            }
//            vc.insertArticles(items: items)
//        }
//        task.resume()
//    }

}


