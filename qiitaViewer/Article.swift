//
//  Article.swift
//  qiitaViewer
//
//  Created by Atsushi KONISHI on 2017/12/07.
//  Copyright © 2017年 小西篤志. All rights reserved.
//

import Foundation

class Article {
    let title: String
    let qiitaID: String
    let createdAt: Date
    let url: URL
    let tags: [String]
    
    init(title: String, id: String, created: Date, url: URL, tags: [String]) {
        self.title = title
        self.qiitaID = id
        self.createdAt = created
        self.url = url
        self.tags = tags
    }
    
    func returnURL() -> URL{
        return self.url
    }
}
