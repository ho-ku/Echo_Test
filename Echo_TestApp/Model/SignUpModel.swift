//
//  SignUpModel.swift
//  Echo_TestApp
//
//  Created by Денис Андриевский on 18.10.2020.
//

import Foundation

struct SignUpModel: Decodable {
    var data: DataModel
}

struct DataModel: Decodable {
    var access_token: String
    var name: String
}
