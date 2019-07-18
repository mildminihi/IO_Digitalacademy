//
//  ProfileErrorResponse.swift
//  DashboardPototype
//
//  Created by Ruchapol Sripruetkiat on 15/7/2562 BE.
//  Copyright © 2562 Supanat Wanroj. All rights reserved.
//

import Foundation

// MARK: - ProfileErrorResponse
struct ProfileErrorResponse: Codable {
    let status: ProfileErrorStatus
}

// MARK: - Status
struct ProfileErrorStatus: Codable {
    let code: Int
    let message: String
}
