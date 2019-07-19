// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let profileResponse = try? newJSONDecoder().decode(ProfileResponse.self, from: jsonData)

import Foundation

// MARK: - ProfileResponse
struct ProfileResponse: Codable {
    let status: ProfileStatus
    let data: ProfileDataClass
}

// MARK: - DataClass
struct ProfileDataClass: Codable {
    let userID: Int
    let lastNameTh, firstNameTh, address, position: String
    let profilePhotoPath: String?
    let birthDate, registerDate, mobileNo, emailNotificationFlag: String
    let lastNameEn, firstNameEn, nationality, religion: String
    let email: String
    
    var dictionary: [String: Any?] {
        return ["last_name_th": lastNameTh,
                "first_name_th": firstNameTh,
                "address": address,
                "position": position,
                "profile_photo_path": profilePhotoPath,
                "birth_date": birthDate,
                "register_date": registerDate,
                "mobile_no": mobileNo,
                "email_notification_flag": emailNotificationFlag,
                "last_name_en": lastNameEn,
                "first_name_en": firstNameEn,
                "nationality": nationality,
                "religion": religion,
                "email": email,
                "user_id": userID]
    }
    
    var nsDictionary: NSDictionary {
        return dictionary as NSDictionary
    }
    
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case lastNameTh = "last_name_th"
        case firstNameTh = "first_name_th"
        case address, position
        case profilePhotoPath = "profile_photo_path"
        case birthDate = "birth_date"
        case registerDate = "register_date"
        case mobileNo = "mobile_no"
        case emailNotificationFlag = "email_notification_flag"
        case lastNameEn = "last_name_en"
        case firstNameEn = "first_name_en"
        case nationality, religion, email
    }
}

// MARK: - Status
struct ProfileStatus: Codable {
    let code: Int
    let message: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


