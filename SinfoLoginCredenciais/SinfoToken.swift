//
//  SinfoToken.swift
//  autenticador
//
//  Created by Dennis da Silva Nunes on 29/09/2017.
//  Copyright © 2017 Sinfo. All rights reserved.
//

import UIKit

struct SinfoToken:Codable {
    let accessToken:String
    let expiresIn:Double
    let refreshToken:String?
    let scope:String
    let tokenType:String
   
    enum CodingKeys : String,CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case scope
        case tokenType = "token_type"
    }
}
