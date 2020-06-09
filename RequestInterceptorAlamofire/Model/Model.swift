//
//  RequestInterceptorManager.swift
//  AlamofireRequestInterceptor
//
//  Created by Hajji Anwer on 6/9/20.


import Foundation
import ObjectMapper


class NewsModel: Mappable{
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        image <- map["image"]
        content <- map["content"]
        createdAt <- map["createdAt"]
    }
    
    required init() {
        
    }
    
    var id, title: String?
    var image: String?
    var content, createdAt: String?
    
    init(id: String, title: String, image: String, content: String, createdAt: String) {
        self.id = id
        self.title = title
        self.image = image
        self.content = content
        self.createdAt = createdAt
    }
}



class ServerResponseMolel<T: Mappable>: Mappable {
    required init?(map: Map) {
        StatusCode = nil
    }
    
    func mapping(map: Map) {
        Data <- map["data"]
        Error <- map["error"]
        Message <- map["message"]
        DataList <- map["data"]
    }
    init(){}
    var Data : T?
    var DataList: [T]?
    var Error: String?
    var Message: String?
    var StatusCode: Int?
    
    var window: UIWindow? = nil
    
    init(data: T?,message:String?,error:String?,dataList: [T]?,statusCode : Int?) {
        DataList = dataList
        Data = data
        Error = error
        Message = message
        StatusCode = statusCode
    }
    
    public var error: String?
    public var message: String?
    
}
