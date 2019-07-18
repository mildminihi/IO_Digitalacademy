import Foundation

// MARK: - AuthLoginResponse
struct AuthLoginResponse: Codable {
    let status: Status
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let accessToken, refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}

// MARK: - Status
struct Status: Codable {
    let code, message: String
}
