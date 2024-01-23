//
//  Authentication.swift
//  KeyChain
//
//  Created by WEMA on 22/01/2024.
//

import Foundation
struct AuthData: Codable {
    let accessToken: String
    let refreshToken: String
}
