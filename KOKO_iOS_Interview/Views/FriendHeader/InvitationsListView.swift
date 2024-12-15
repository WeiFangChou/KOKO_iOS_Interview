//
//  Inviteview.swift
//  KOKO_iOS_Interview
//
//  Created by WeiFangChou on 2024/12/10.
//

import UIKit

class InviteListView: UIView {
	private var inviteListView: [UIView] = []

	override func layoutSubviews() {
		super.layoutSubviews()
	}

	init() {
		super.init(frame: .zero)
	}

	required init?(coder: NSCoder) {
		fatalError("Failed to init using from storyboards")
	}

	func configure(_ friends: [FriendProfile]) {
		inviteListView.removeAll()
		for friend in friends {
			let friendInviteView = FriendInviteView()
			friendInviteView.anchor(height: 70)
			friendInviteView.configure(friendInvite: friend)
			inviteListView.append(friendInviteView)
		}
		
	}
}

@available(iOS 17, *)
#Preview {
	let view = InviteListView()
	view.configure([FriendProfile(name: "001", status: .pending, isTop: "1", fid: "001", updateDate: .now)])
	return view
}
