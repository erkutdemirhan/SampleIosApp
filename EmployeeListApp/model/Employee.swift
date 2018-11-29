//
//  Employee.swift
//  EmployeeListApp
//
//  Created by Erkut Demirhan on 21/11/2018.
//  Copyright © 2018 Erkut Demirhan. All rights reserved.
//

import Foundation

struct Coordinates {
    let latitude: Double
    let longitude: Double
}

extension Coordinates: Equatable {}

func ==(lhs: Coordinates, rhs: Coordinates) -> Bool {
    return (String(lhs.latitude) == String(rhs.latitude)) &&
    (String(lhs.longitude) == String(rhs.longitude))
}

struct Employee: Decodable {
    
    enum EyeColor: String {
        case blue, black, brown, green
    }
    
    let avatarUrl: String?
    let company: String?
    let about: String?
    let email: String
    let phone: String
    let name: String
    let eyeColor: EyeColor?
    let coordinates: Coordinates
    
    private enum CodingKeys: String, CodingKey {
        case avatarURL = "picture"
        case name
        case company
        case email
        case phone
        case about
        case eyeColor
        case latitude
        case longitude
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        email = try values.decode(String.self, forKey: .email)
        phone = try values.decode(String.self, forKey: .phone)
        about = try values.decodeIfPresent(String.self, forKey: .about)
        company = try values.decodeIfPresent(String.self, forKey: .company)
        avatarUrl = try values.decodeIfPresent(String.self, forKey: .avatarURL)
        let eyeColorStr = try values.decodeIfPresent(String.self, forKey: .eyeColor) ?? ""
        eyeColor = EyeColor(rawValue: eyeColorStr)
        
        let latitude = try values.decodeIfPresent(Double.self, forKey: .latitude) ?? 0.0
        let longitude = try values.decodeIfPresent(Double.self, forKey: .longitude) ?? 0.0
        coordinates = Coordinates(latitude: latitude, longitude: longitude)
    }
}
