// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let authUnResponse = try? newJSONDecoder().decode(AuthUnResponse.self, from: jsonData)

import Foundation

// MARK: - AuthUnResponse
struct AuthUnResponse: Codable {
    let status: AuthStatus
}

// MARK: - Status
struct AuthStatus: Codable {
    let code, message: String
}

