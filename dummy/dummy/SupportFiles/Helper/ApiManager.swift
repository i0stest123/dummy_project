//
//  ApiManager.swift
//  Elevator
//
//  Created by InovantSolutions on 01/11/22.
//

import Foundation
import Alamofire

class ApiManager {
    
    private init() {}
    public static let shared = ApiManager()
    
    
    func getDataFromServer(_ url: String,completion: @escaping (NSDictionary?,String) -> Void) {
        
        print("#URL >>",url)
        AF.request(url, encoding: JSONEncoding.default, headers: Globals.returnHeadersForRequestWithToken()).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.value)")
            
            if let json = response.value as? NSDictionary {
                
                print("Data recieved is : \(json)")
                completion(json,"SUCCESS")
            }
            else{
                completion(nil,"ERROR")
                print("Error getting data from server:")
            }
            
        }
        
    }
    
    
    func sendDataToServer(_ url: String,parameters:Parameters,completion: @escaping (NSDictionary?,String) -> Void) {
        
        print("#URL >>",url)
        print("#Parameters >>",parameters)
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Globals.returnHeadersForRequestWithToken()).responseJSON { response in
            
            
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.value)")
            print("#Parameter:",parameters)
            
            if let json = response.value as? NSDictionary {
                print("Data recieved is : \(json)")
                completion(json,"SUCCESS")
            }
            else{
                completion(nil,"ERROR")
                print("Error getting data from server:")
            }
            
        }
        
    }
    
}

