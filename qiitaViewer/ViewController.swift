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

protocol articleDelegate {
    func insertArticles(items: [Article])
}

class ViewController: UIViewController, articleDelegate {
    
    @IBOutlet weak var articleTable: UITableView!
    var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articleTable.dataSource = self
        articleTable.delegate = self
        Article.delegate = self
        
        let reloadItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: self, action: #selector(onClickRefreshButton))
        self.navigationItem.setRightBarButton(reloadItem, animated: true)
        
        // http request
        let url = "https://qiita.com/api/v2/items?page=1&per_page=100"
        Article.getArticles(url: url, completion: { [weak self] (items) in
            DispatchQueue.main.async {
                self!.articles = items
                self!.articleTable.reloadData()
            }
        })
        
        // Delegate でもやってみた
//        Article.getArticlesByDelegate(url: url, vc: self)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func insertArticles(items: [Article]) {
        DispatchQueue.main.async {
            self.articles = items
            self.articleTable.reloadData()
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        articleTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func onClickRefreshButton() {
        let url = "https://qiita.com/api/v2/items?page=1&per_page=100"
        Article.getArticles(url: url, completion: { (items) in
            DispatchQueue.main.async {
                self.articles = items
                self.articleTable.reloadData()
            }
        })
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb: UIStoryboard = self.storyboard!
        let webView = sb.instantiateViewController(withIdentifier: "webView") as! WebViewController
        if let url = articles[indexPath.row].url {
            webView.url = url
        } else {
            print("not found url")
        }
    self.navigationController?.pushViewController(webView, animated: true)
    }
}

