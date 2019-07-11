// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let authLoginResponse = try? newJSONDecoder().decode(AuthLoginResponse.self, from: jsonData)

import Foundation

// MARK: - AuthLoginResponse
struct AuthLoginResponse: Codable {
    let status: AuthStatus
    let data: AuthDataClass
}

// MARK: - DataClass
struct AuthDataClass: Codable {
    let accessToken, refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}

// MARK: - Status
struct AuthStatus: Codable {
    let code: Int
    let message: String
}
