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
    var items: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // http request
//        let url = URL(string: "https://qiita.com/api/v2/items?")
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getArticles(url: String) {
        // setup URLrequest
        guard let url = URL(string: url) else {
            print("Error: can not create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // setup Session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
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
                
        }
        task.resume()
    }

}
//
//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//    
//
//}

