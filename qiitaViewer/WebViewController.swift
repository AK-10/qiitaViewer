//
//  WebViewController.swift
//  qiitaViewer
//
//  Created by Atsushi KONISHI on 2017/12/09.
//  Copyright © 2017年 小西篤志. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var url: URL!
    
    override func loadView() {
        super.loadView()
//        let webConfiguration = WKWebViewConfiguration()
        webView.uiDelegate = self as? WKUIDelegate
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
