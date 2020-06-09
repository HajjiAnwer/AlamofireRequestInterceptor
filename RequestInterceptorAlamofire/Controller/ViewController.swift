//
//  ViewController.swift
//  AlamofireRequestInterceptor
//
//  Created by Hajji Anwer on 6/9/20.

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class ViewController: UIViewController {
    
    
    var news = [NewsModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func sendRequest(_ sender: UIButton) {
        Service.shared.connectToServer { (response) in
            if response.Error == nil && response.StatusCode == 200
            {
                print(response.DataList?.count ?? 0)
                self.news = response.DataList ?? [NewsModel]()
                print(self.news[1].title ?? "")
            } else {
                print("Error::\(response.Error?.description ?? "")")
                print("statusCode:: \(response.StatusCode)")
            }
        }
    }
}

