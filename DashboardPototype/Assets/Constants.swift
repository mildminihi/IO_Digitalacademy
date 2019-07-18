//
//  Constants.swift
//  DashboardPototype
//
//  Created by Supanat Wanroj on 10/7/2562 BE.
//  Copyright © 2562 Supanat Wanroj. All rights reserved.
//

import Foundation

class Constants {
    static let userServiceUrl = "http://localhost:9000/api/user/profileInfo"
    static let mostDoExamServiceUrl = "http://localhost:9000/api/exam/exam_most"
    static let recentExamServiceUrl = "http://localhost:9000/api/exam/last_exam/1"
    static let historyServiceUrl = "http://localhost:9000/e-xam/api/exam/history"
    static let loginServiceUrl = "http://192.168.109.207:9999/auth"
//    static let profileServiceUrl = "http://localhost:1001/api/user/profileInfo"
    static let profileServiceUrl = "http://ec2-52-221-195-185.ap-southeast-1.compute.amazonaws.com:8089/api/user/profileInfo"
    static let editProfileServiceUrl = "http://ec2-52-221-195-185.ap-southeast-1.compute.amazonaws.com:8089/api/user/editProfile"
//    static let editProfileServiceUrl = "http://localhost:8080/json"
}
