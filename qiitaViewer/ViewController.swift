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
        articleTable.dataSource = self
        articleTable.delegate = self
        // http request
        let url = "https://qiita.com/api/v2/items?"
        Article.getArticles(url: url, completion: { [weak self] (items) in
            DispatchQueue.main.async {
                self!.articles = items
                self!.articleTable.reloadData()
            }
        })
//        print(articles.count)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = articleTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! customCell
        cell.setCell(article: articles[indexPath.row])
        return cell
    }

}

