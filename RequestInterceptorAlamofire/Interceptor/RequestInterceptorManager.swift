//
//  RequestInterceptorManager.swift
//  AlamofireRequestInterceptor
//
//  Created by Hajji Anwer on 6/9/20.

import Foundation
import Alamofire

class RequestInterceptorManager : RequestAdapter,RequestRetrier {
    
    private var accessToken : String = ""
    
    init(accessToken : String) {
        self.accessToken = accessToken
    }
    init(){
        
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix("https://dev.tryspare.com") {
            urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            print("URLHeader::\(urlRequest.allHTTPHeaderFields?.debugDescription ?? "")")
        }
        return urlRequest
    }
    
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        if request.retryCount < 5{
            guard let statusCode = request.response?.statusCode else {
                completion(false,0.0)
                return
            }
            switch statusCode {
            case 401:
                var refreshToken : String = "12345"
                self.accessToken = refreshToken
                completion(true,1.0)
                print("\(request.retryCount) retry")
                print("statusCode::\(statusCode)")
            default:
                completion(false,0.0)
            }
        }
    }
}
    
class NetworkManager {
        static let accessToken = "ewogICJhbGciOiAiUlMyNTYiLAogICJraWQiOiAiMDgzRUJFQjg0NTg4NDIyMEQ1MjBGQjlERjI1M0NFNzRGQjREQkMzRCIsCiAgInR5cCI6ICJhdCtqd3QiLAogICJ4NXQiOiAiQ0Q2LXVFV0lRaURWSVB1ZDhsUE9kUHROdkQwIgp9.ewogICJuYmYiOiAxNTkxNjk3NDI2LAogICJleHAiOiAxNTkxNzgzODI2LAogICJpc3MiOiAiaHR0cDovL2NsdXN0ZXItaXM0LWlwOjUxMDAiLAogICJhdWQiOiBbCiAgICAiQXV0aCIsCiAgICAiQ2F0ZWdvcnkiLAogICAgIk5vdGlmaWNhdGlvbiIsCiAgICAiUHJvZmlsZSIsCiAgICAiU29ja2V0IiwKICAgICJUcmFuc2FjdGlvbnMiLAogICAgIlVzZXIiCiAgXSwKICAiY2xpZW50X2lkIjogIk1PQklMRSIsCiAgInN1YiI6ICI3YTBlODU5OS05N2VhLTQ0MzctOWFiZi0wOWI5YjM5ZTg1ODUiLAogICJhdXRoX3RpbWUiOiAxNTkxNjk3NDI2LAogICJpZHAiOiAibG9jYWwiLAogICJSb2xlIjogIlVTRVIiLAogICJzY29wZSI6IFsKICAgICJBdXRoIiwKICAgICJDYXRlZ29yeSIsCiAgICAiTm90aWZpY2F0aW9uIiwKICAgICJQcm9maWxlIiwKICAgICJTb2NrZXQiLAogICAgIlRyYW5zYWN0aW9ucyIsCiAgICAiVXNlciIsCiAgICAib2ZmbGluZV9hY2Nlc3MiCiAgXSwKICAiYW1yIjogWwogICAgInB3ZCIKICBdCn0.ykNmyCaOhn1q9Vw8HxXyhpHlcedlWZSpuvcpSiA9kqx7hNWf-l7IlSw0hzVA1OgORSH77puchbBGpPaGs6PZm6hYabKdjGePloHlRl0vGqbHZa5CLxsyfXkoa3r8zFfc0H4OYxaUg-2X62YdncxhlaYLuZvTWZ49yQvlXGqTNlWQBromnpH5_JTT21M4CNK8sDA4nuFMe_bYp7YV93nnTFI0BsjmRj1NRC1erkID170nbuOSwfMrjgc6rOITM9ShhkyWKrV2RgSu39mDf9cqn3AyC4SKems5UqqTXwTLrw5jn4B-CtAfFgMVYoIUxwqgRwVMa4ektffpBv2UNAM2"
        static let session = SessionManager()
        static var getSession : SessionManager{
            get{
                session.adapter = RequestInterceptorManager.init(accessToken: accessToken)
                session.retrier = RequestInterceptorManager()
                return session
            }
        }
}
