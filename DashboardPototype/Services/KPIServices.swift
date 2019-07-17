//
//  KPIServices.swift
//  DashboardPototype
//
//  Created by Supanat Wanroj on 17/7/2562 BE.
//  Copyright © 2562 Supanat Wanroj. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class KPIServices: UIViewController {
    
    func getKPIServices(completion: @escaping ([KPIResponse]) -> Void) {
        
        var kpiArray:[KPIResponse] = []
        let url = Constants.kpiServiceUrl
        let headers: HTTPHeaders = [
            "id" : "1"
        ]
        AF.request(url, method: .get, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    let result = try JSONDecoder().decode(KPIResponse.self, from: response.data!)
                    kpiArray = [result]
                    print(result)
                }
                catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print("Network error: \(error.localizedDescription)")
            }
            completion(kpiArray)
        }
        
    }
    
}
