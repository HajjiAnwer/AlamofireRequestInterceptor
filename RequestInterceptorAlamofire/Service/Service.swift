//
//  Service.swift
//  AlamofireRequestInterceptor
//
//  Created by Hajji Anwer on 6/9/20.

import Foundation
import AlamofireObjectMapper
import Alamofire
import ObjectMapper

class Service {
    
    static let shared = Service()
    let url = "https://dev.tryspare.com/api/v1.0/user/mobile/News/List"
    let url2 = "https://api.tryspare.com/api/v1.0/user/mobile/bankaccounts/AreaList"
    func connectToServer(completionHandler:@escaping (ServerResponseMolel<NewsModel>)->Void){
        NetworkManager.getSession.request(url, encoding: JSONEncoding.default).validate().responseObject { (response: DataResponse<ServerResponseMolel<NewsModel>>) in
            if response.result.error == nil{
                guard response.data != nil else { return }
                response.result.value?.StatusCode = response.response?.statusCode
                completionHandler(response.result.value ?? ServerResponseMolel(data: nil, message: nil, error: "error", dataList: nil, statusCode: response.response?.statusCode))
            } else {
                print(response.result.error.debugDescription )
                response.result.value?.StatusCode = response.response?.statusCode
                completionHandler(response.result.value ?? ServerResponseMolel(data: nil, message: nil, error: "error", dataList: nil, statusCode: response.response?.statusCode))
            }
        }
    }
}
