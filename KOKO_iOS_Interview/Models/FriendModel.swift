//
//  FriendProfile.swift
//  KOKO_iOS_Interview
//
//  Created by WeiFangChou on 2024/12/9.
//

import Foundation

/*
 {
 "name": "黃靖僑",
 "status": 0,
 "isTop": "0",
 "fid": "001",
 "updateDate": "20190801" | "XXXX/XX/XX"
 }
 */

struct FriendModel: Decodable {
	var response: [FriendProfile]
}

/// 好友Profile
struct FriendProfile: Codable {
	/// 姓名
	var name: String
	///	邀請狀態
	var status: InviteStatus
	/// 是否出現星星
	var isTop: String
	/// 好有Id
	var fid: String
	/// 資料更新時間
	var updateDate: Date
}

/// 邀請狀態
enum InviteStatus: Int, Codable {
	/// 邀請送出
	case pending = 0
	/// 已完成
	case accepted = 1
	/// 邀請中
	case inviting = 2
}
