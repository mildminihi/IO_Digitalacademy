//
//  Constants.swift
//  DashboardPototype
//
//  Created by Supanat Wanroj on 10/7/2562 BE.
//  Copyright © 2562 Supanat Wanroj. All rights reserved.
//

import Foundation

class Constants {
    static let userServiceUrl = "http://192.168.110.136:9999/user/profileInfo"
    static let mostDoExamServiceUrl = "http://192.168.110.136:9999/exam/exam_most"
    static let recentExamServiceUrl = "http://192.168.110.136:9999/exam/last_exam"
    static let historyServiceUrl = "http://192.168.110.136:9999/exam/history"
    static let loginServiceUrl = "http://192.168.110.136:9999/auth"
    static let refreshTokenServiceUrl = "http://192.168.110.136:9999/auth/regen"
//    static let profileServiceUrl = "http://192.168.109.195:1001/api/user/profileInfo"
//    static let profileServiceUrl = "http://localhost:1001/api/user/profileInfo"
    static let profileServiceUrl = "http://192.168.110.136:9999/user/profileInfo"
    static let editProfileServiceUrl = "http://ec2-52-221-195-185.ap-southeast-1.compute.amazonaws.com:8089/api/user/editProfile"
    static let kpiServiceUrl = "http://localhost:8081/kpi/user/latest"
    static let lastLoginUrl = "http://ec2-52-221-195-185.ap-southeast-1.compute.amazonaws.com:8089/api/user/history"

}

//real
//http://192.168.109.2:8085/api/exam/exam_most
//http://192.168.109.2:8085/api/exam/last_exam


//mock
//"http://localhost:9000/api/exam/exam_most"
//"http://localhost:9000/api/exam/last_exam/1"
