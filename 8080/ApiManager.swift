//
//  ApiManager.swift
//
//  Created by ShahidMohd on 19/05/19.
//  Copyright © 2017 Innotical. All rights reserved.
//

import Foundation
import Alamofire

let api_manager = ApiManager.sharedInstance

class ApiManager {
    static let sharedInstance = ApiManager.init()
    
    func POSTApi(_ url: String, param: [String: Any]?, header : [String : String]?,  completion:@escaping (_ jsonData:DataResponse<Any>? , _ error:Error?, _ statuscode : Int? )->()) {
        var paramToSend:[String:Any] = [:]
        if param != nil{
            paramToSend = param!

        }
        if UserDefaults.standard.string(forKey: "grapeToken") != nil{
            paramToSend["user_token"] = UserDefaults.standard.string(forKey: "grapeToken")!

        }
        print("paramToSend------>>>>>",paramToSend ?? "")

        print("Header------>>>>>",header ?? "")
        _ =  Alamofire.request(url, method: .post, parameters: paramToSend , encoding: JSONEncoding.default, headers: header).responseJSON{ (dataResponse) in
            
            debugPrint(dataResponse.result.value)
            guard dataResponse.result.isSuccess else {
                let error = dataResponse.result.error!
                print("POSTApi Error : ",error )
                completion(nil , error , nil)
                return
            }
            if dataResponse.result.value != nil{
//                let json = JSON.init(dataResponse.result.value!)
                DispatchQueue.main.async {
                    
                }
                completion(dataResponse , nil, dataResponse.response?.statusCode)
            }else{
                DispatchQueue.main.async {
                    
                }
                completion(nil , nil,dataResponse.response?.statusCode)
            }
            print("POSTApi statuscode : ",dataResponse.response?.statusCode ?? "")
        }
    }
    
    func GETApi(_ url: String , param: [String: Any]?, header : [String : String]? , completion:@escaping (_ jsonData:DataResponse<Any>? , _ error:Error?, _ statuscode : Int?)->()){
        Alamofire.request(url, method: .get, parameters: param, encoding:JSONEncoding.default, headers: header)
            .responseJSON { (dataResponse) in
                debugPrint(dataResponse.timeline)
                guard dataResponse.result.isSuccess else {
                    let error = dataResponse.result.error!
                    print("GETApi Error : ",error )
                    completion(nil , error, dataResponse.response?.statusCode)
                    return
                }
                if dataResponse.result.value != nil{
//                    let json = JSON.init(dataResponse.result.value!)
                    DispatchQueue.main.async {
                        
                    }
                    completion(dataResponse , nil,dataResponse.response?.statusCode)
                }else{
                    DispatchQueue.main.async {
                        
                    }
                    completion(nil , nil,dataResponse.response?.statusCode)
                }
                print("GETApi statuscode : ",dataResponse.response?.statusCode ?? "")
        }
      }
   
    
    func PUTApi(_ url: String , param: [String: Any]?, header : [String : String]? , completion:@escaping (_ jsonData:DataResponse<Any>? , _ error:Error?, _ statuscode : Int?)->()){
        Alamofire.request(url, method: .put, parameters: param, encoding:JSONEncoding.default, headers: header)
            .responseJSON { (dataResponse) in
                debugPrint(dataResponse.timeline)
                guard dataResponse.result.isSuccess else {
                    let error = dataResponse.result.error!
                    print("PUTApi Error : ",error )
                    DispatchQueue.main.async {
                        
                    }
                    completion(nil , error, dataResponse.response?.statusCode)
                    return
                }
                if dataResponse.result.value != nil{
//                    let json = JSON.init(dataResponse.result.value!)
                    DispatchQueue.main.async {
                        
                    }
                    completion(dataResponse , nil,dataResponse.response?.statusCode)
                }else{
                    DispatchQueue.main.async {
                        
                    }
                    completion(nil , nil,dataResponse.response?.statusCode)
                }
                print("GETApi statuscode : ",dataResponse.response?.statusCode ?? "")
        }
    }
    
    func DELETEApi(_ url: String , param: [String: Any]?, header : [String : String]? , completion:@escaping (_ jsonData:DataResponse<Any>? , _ error:Error?, _ statuscode : Int?)->()){
        Alamofire.request(url, method: .delete, parameters: param, encoding:JSONEncoding.default, headers: header)
            .responseJSON { (dataResponse) in
                debugPrint(dataResponse.timeline)
                guard dataResponse.result.isSuccess else {
                    let error = dataResponse.result.error!
                    print("GETApi Error : ",error )
                    DispatchQueue.main.async {
                        
                    }
                    
                    completion(nil , error, dataResponse.response?.statusCode)
                    return
                }
                if dataResponse.result.value != nil{
//                    let json = JSON.init(dataResponse.result.value!)
                    DispatchQueue.main.async {
                        
                    }
                    completion(dataResponse , nil,dataResponse.response?.statusCode)
                }else{
                    DispatchQueue.main.async {
                        
                    }
                    completion(nil , nil,dataResponse.response?.statusCode)
                }
                print("GETApi statuscode : ",dataResponse.response?.statusCode ?? "")
        }
    }
    

    func UploadEventImage(_ url :String , _ data:Data, _ fileName:String , _ event_id:String , header:[String:String]? , completion:@escaping (_ error:Error? , _ responce:Any?,_ statuscode :Int?)->())  {
        Alamofire.upload(multipartFormData:{ multipartFormData in
            multipartFormData.append(data, withName: "image", fileName: fileName, mimeType: "*/*")
            let data = event_id.data(using:.utf8)
            multipartFormData.append(data!, withName: "event_id")
        },
                         usingThreshold:UInt64.init(),
                         to:url,
                         method:.post,
                         headers:header,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON { response in
                                    debugPrint(response)
                                    guard response.result.isSuccess else {
                                        let error = response.result.error
                                        DispatchQueue.main.async {
                                            
                                        }
                                        completion(error , nil,response.response?.statusCode)
                                        return
                                    }
                                    if response.result.value != nil{
//                                        let json = JSON.init(response.result.value!)
                                        DispatchQueue.main.async {
                                            
                                        }
                                        
                                        completion(nil , response,response.response?.statusCode)
                                    }else{
                                        DispatchQueue.main.async {
                                            
                                        }
                                        
                                        completion(nil , nil,response.response?.statusCode)
                                    }
                                }
                            case .failure(let encodingError):
                                print(encodingError)
                                DispatchQueue.main.async {
                                    
                                }
                                completion(encodingError , nil,nil)
                            }
        })
    }

    
    func UPLOADTeamLogo(_ url :String , _ data:Data, _ fileName:String , header:[String:String]? , completion:@escaping (_ error:Error? , _ responce:Any?,_ statuscode :Int?)->())  {
        Alamofire.upload(multipartFormData:{ multipartFormData in
            multipartFormData.append(data, withName: "image", fileName: fileName, mimeType: "*/*")
        },
                         usingThreshold:UInt64.init(),
                         to:url,
                         method:.put,
                         headers:header,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON { response in
                                    debugPrint(response)
                                    guard response.result.isSuccess else {
                                        let error = response.result.error
                                        DispatchQueue.main.async {
                                            
                                        }
                                        completion(error , nil,response.response?.statusCode)
                                        return
                                    }
                                    if response.result.value != nil{
//                                        let json = JSON.init(response.result.value!)
                                        DispatchQueue.main.async {
                                            
                                        }
                                        
                                        completion(nil ,response.result.value ,response.response?.statusCode)
                                    }else{
                                        DispatchQueue.main.async {
                                            
                                        }
                                        
                                        completion(nil , nil,response.response?.statusCode)
                                    }
                                }
                            case .failure(let encodingError):
                                print(encodingError)
                                DispatchQueue.main.async {
                                    
                                }
                                completion(encodingError , nil,nil)
                            }
        })
    }
    
    
    func loadImage(_ url:String)  ->UIImage?{
        var image:UIImage?
        print(url)
        Alamofire.download(url)
            .downloadProgress { progress in
                print("Download Progress: \(progress.fractionCompleted)")
            }
            .responseData { response in
                if let data = response.result.value {
                    image =  UIImage(data: data)
                }
        }
        return image
    }

    
    func local(_ url: String , param: [String: Any]?, header : [String : String]? , completion:@escaping (_ jsonData:DataResponse<Any>? , _ error:Error?, _ statuscode : Int?)->()){
        
        let config = URLSessionConfiguration.default
        
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        if let value = header?["Authorization"] {
            print(value)
            config.httpAdditionalHeaders = ["Authorization" : value]
            request.setValue(value, forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = "GET"
        print(request.value(forHTTPHeaderField: "Authorization") ?? "NiL")
        let session = URLSession.init(configuration: config)
        let tache = session.dataTask(with: request) { (dataaa, response, error) -> Void in
            if let antwort = response as? HTTPURLResponse {
                let code = antwort.statusCode
                print(code)
            }
            if let data = dataaa{
               // let json = JSON.init(data: data)
               // print(json)
            }
        }
        
        tache.resume()
    }
    
}

