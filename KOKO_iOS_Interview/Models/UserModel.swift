//
//  UserProfile.swift
//  KOKO_iOS_Interview
//
//  Created by WeiFangChou on 2024/12/9.
//

import Foundation

struct UserModel: Decodable {
	var response: [UserProfile]
}

/*
 {
 "name": "蔡國泰",
 "kokoid": "Mike"
 }
 */
/// 使用者Profile
struct UserProfile: Codable {
	var name: String
	var kokoid: String
}
