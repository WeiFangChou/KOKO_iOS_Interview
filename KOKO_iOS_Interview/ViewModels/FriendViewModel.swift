//
//  FriendViewModel.swift
//  KOKO_iOS_Interview
//
//  Created by WeiFangChou on 2024/12/11.
//
import Foundation

class FriendViewModel {
	var situation: Observable<FriendSituation> = Observable(.noFriend)
	
	var friends: Observable<[FriendProfile]> = Observable([])
	var filitedFriends: Observable<[FriendProfile]> = Observable([])
	
	var invitedFriends: Observable<[FriendProfile]> = Observable([])
	
	var searchText: Observable<String> = Observable("")
	
	var friendTabs: [FriendTab] = [FriendTab(title: "好友", isSelected: true, badgeCount: 3), FriendTab(title: "聊天", badgeCount: 100)]
	
	private let apiService = APIService.shared
	
	func loadData(for situation: FriendSituation) async {
		print("loading Data \(situation)")
		let dispatchGroup = DispatchGroup()
		switch situation {
			case .noFriend:
				friends.value = []
				filitedFriends.value = []
				apiService.getUserFriends(apiEndPoint: .friendsListWithoutInvite) { result in
					switch result {
						case .success(let value):
							self.friends.value = value
						case .failure:
							break
					}
				}
				return
			case .onlyFriends:
				friends.value = []
				filitedFriends.value = []
				var friends1: [FriendProfile] = []
				var friends2: [FriendProfile] = []
				dispatchGroup.enter()
				apiService.getUserFriends(apiEndPoint: .friendsList1) { result in
					switch result {
						case .success(let value):
							friends1 = value
							dispatchGroup.leave()
						case .failure:
							break
					}
				}
				dispatchGroup.enter()
				apiService.getUserFriends(apiEndPoint: .friendsList2) { result in
					switch result {
						case .success(let value):
							friends2 = value
							dispatchGroup.leave()
						case .failure:
							break
					}
				}
				dispatchGroup.notify(queue: .main) {
					let merged = self.mergeFriends(friendsL: friends1, friendsR: friends2)
					
					self.friends.value = merged.filter { $0.status == .accepted }
				}
				return
			case .friendWithInvitiation:
				friends.value = []
				filitedFriends.value = []
				apiService.getUserFriends(apiEndPoint: .friendsListWithInvite) { result in
					switch result {
						case .success(let value):
							self.friends.value = value
							self.invitedFriends.value = value.filter { $0.status == .inviting }
						case .failure:
							break
					}
				}
				return
		}
	}
	
	init() {}
	
	func unifyDate() {}
	
	private func mergeFriends(friendsL: [FriendProfile] = [], friendsR: [FriendProfile] = []) -> [FriendProfile] {
		var friendDict = [String: FriendProfile]()
		let combinedFriends = friendsL + friendsR
		
		for friend in combinedFriends {
			if let existingFriend = friendDict[friend.fid] {
				if existingFriend.updateDate >= friend.updateDate {
					continue
				}
			}
			friendDict[friend.fid] = friend
		}
		return Array(friendDict.values)
	}
	
	func filiterSearchResult() {
		if let searchText = searchText.value, !searchText.isEmpty {
			filitedFriends.value = friends.value?.filter { $0.name.contains(searchText) }
		}
	}
}
