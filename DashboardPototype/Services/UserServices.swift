//
//  Services.swift
//  DashboardPototype
//
//  Created by Supanat Wanroj on 26/6/2562 BE.
//  Copyright © 2562 Supanat Wanroj. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class UserServices: UIViewController {
    
    func getUserProfileService(completion: @escaping ([ProfileResponse]) -> Void) {
        
        var dataArray: [ProfileResponse] = []
        let url = Constants.profileServiceUrl
        let headers: HTTPHeaders = [
            "accessToken" : "Bearer \(UserDefaults.standard.string(forKey: "access_token").unsafelyUnwrapped)"
        ]
        AF.request(url, method: .get, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    let result = try JSONDecoder().decode(ProfileResponse.self, from: response.data!)
                    dataArray = [result]
                }
                catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print("Network error: \(error.localizedDescription)")
                
            }
            completion(dataArray)
        }

    }
    
    func getLastLoginService(completion: @escaping (String) -> Void) {
        
        var lastLogin:String = ""
        let url = Constants.lastLoginUrl
        let headers: HTTPHeaders = ["id": "5"]
        AF.request(url, method: .get, headers: headers).responseJSON { response in
            print("🥨\(response)")
            switch response.result {
            case .success:
                do {
                    let result = try JSONDecoder().decode(LastLoginResponse.self, from: response.data!)
                    lastLogin = result.data.loginTime
                }
                catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print("Network error: \(error.localizedDescription)")
                
            }
            completion(lastLogin)
        }
        
    }
   
}
