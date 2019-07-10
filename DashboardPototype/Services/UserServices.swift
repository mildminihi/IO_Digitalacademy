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
    
    func getUserProfileService(completion: @escaping ([UserDataClass]) -> Void) {
        
        var dataArray: [UserDataClass] = []
        let url = Constants.userServiceUrl
        AF.request(url, method: .get).responseJSON { response in
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
