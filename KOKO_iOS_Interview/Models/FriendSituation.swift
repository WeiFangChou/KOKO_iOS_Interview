//
//  FriendSituation.swift
//  KOKO_iOS_Interview
//
//  Created by WeiFangChou on 2024/12/11.
//

enum FriendSituation {
	case noFriend
	case onlyFriends
	case friendWithInvitiation

	var title: String {
		switch self {
			case .noFriend: return "無好友畫面"
			case .onlyFriends: return "只有好友列表"
			case .friendWithInvitiation: return "好友列表含邀請"
		}
	}
}
