//
//  AuthResponse.swift
//  DashboardPototype
//
//  Created by Nutcha Jirum on 28/6/2562 BE.
//  Copyright © 2562 Supanat Wanroj. All rights reserved.
//

import Foundation
// MARK: - AuthResponse
struct AuthResponse: Codable {
    let status: Status
    let data: DataClass
}

// MARK: - DataClass
struct DataClassAuth: Codable {
    let token: String
}

// MARK: - Status
struct StatusAuth: Codable {
    let code, statusDescription: String
    
    enum CodingKeys: String, CodingKey {
        case code
        case statusDescription = "description"
    }
}
