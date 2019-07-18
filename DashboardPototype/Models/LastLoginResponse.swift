//
//  LastLoginResponse.swift
//  DashboardPototype
//
//  Created by Supanat Wanroj on 18/7/2562 BE.
//  Copyright © 2562 Supanat Wanroj. All rights reserved.
//

import Foundation

// MARK: - LastLoginResponse
struct LastLoginResponse: Codable {
    let status: LastLoginStatus
    let data: LastLoginDataClass
}

// MARK: - DataClass
struct LastLoginDataClass: Codable {
    let loginTime: String
    
    enum CodingKeys: String, CodingKey {
        case loginTime = "login_time"
    }
}

// MARK: - Status
struct LastLoginStatus: Codable {
    let code: Int
    let message: String
}

