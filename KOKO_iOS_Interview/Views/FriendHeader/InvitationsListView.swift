//
//  Inviteview.swift
//  KOKO_iOS_Interview
//
//  Created by WeiFangChou on 2024/12/10.
//

import UIKit

class InvitationsListView: UIView {
	private var inviteListView: [UIView] = []

	var isExpanded: Bool = false
	var invitationsViewHeight: NSLayoutConstraint?
	var invitationsViewTopConstraint: [NSLayoutConstraint] = []
	var invitationsViewLeadingConstraint: [NSLayoutConstraint] = []
	var invitationsViewTrailingConstraint: [NSLayoutConstraint] = []

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
		if friends.isEmpty {
			subviews.forEach { $0.removeFromSuperview() }
			invitationsViewTopConstraint.removeAll()
			invitationsViewLeadingConstraint.removeAll()
			invitationsViewTrailingConstraint.removeAll()
			return
		}
		for (index, friend) in friends.enumerated() {
			let view = FriendInvitationView()
			if index == 0 {
				addSubview(view)
			} else {
				insertSubview(view, belowSubview: subviews[0])
			}
			view.translatesAutoresizingMaskIntoConstraints = false
			let topAnchorConstraint = view.topAnchor.constraint(equalTo: topAnchor, constant: index == 0 ? 0 : 10)
			let leadingAnchorConstraint = view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: index == 0 ? 0 : 10)
			let trainingAnchorConstraint = view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: index == 0 ? 0 : -10)
			topAnchorConstraint.isActive = true
			leadingAnchorConstraint.isActive = true
			trainingAnchorConstraint.isActive = true
			invitationsViewTopConstraint.append(topAnchorConstraint)
			invitationsViewLeadingConstraint.append(leadingAnchorConstraint)
			invitationsViewTrailingConstraint.append(trainingAnchorConstraint)

			view.configure(friendInvite: friend)
		}
	}

	func configureView(_ friendProfile: FriendProfile) -> FriendInvitationView {
		let view = FriendInvitationView()
		view.configure(friendInvite: friendProfile)
		return view
	}
}

extension InvitationsListView {
	func setViewExpand(_ value: Bool) {
		isExpanded = value

		for index in 1 ..< subviews.count {
			invitationsViewTopConstraint[index].constant = isExpanded ? CGFloat(90 * index) : 10
			invitationsViewLeadingConstraint[index].constant = isExpanded ? 0 : 10
			invitationsViewTrailingConstraint[index].constant = isExpanded ? 0 : -10
		}
	}
}

@available(iOS 17, *)
#Preview {
	let view = InvitationsListView()

	view.configure([FriendProfile(name: "001", status: .pending, isTop: "1", fid: "001", updateDate: .now), FriendProfile(name: "001", status: .pending, isTop: "1", fid: "001", updateDate: .now)])
	return view
}
