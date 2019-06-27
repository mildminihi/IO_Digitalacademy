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
    
    func getUserProfileService(completion: @escaping ([DataClass]) -> Void) {
        
        var dataArray:[DataClass] = []
        let url = "http://localhost:1150/api/user/profileInfo"
        AF.request(url, method: .get).responseJSON { response in
//            print("Request: \(String(describing: response.request))")   // original url request
//            print("Response: \(String(describing: response.response))") // http url response
//            print("Result: \(response.result)")                         // response serialization result
            switch response.result {
            case .success:
                do {
                    let result = try JSONDecoder().decode(UserResponse.self, from: response.data!)
                    dataArray = [result.data]
                }
                catch {
                }
            case .failure(let error):
                print("Network error: \(error.localizedDescription)")
                
            }
            completion(dataArray)
        }

    }
   
}
