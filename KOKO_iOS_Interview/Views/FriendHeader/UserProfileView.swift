//
//  UserProfileView.swift
//  KOKO_iOS_Interview
//
//  Created by WeiFangChou on 2024/12/10.
//

import UIKit

class UserProfileView: UIView {
	private var userProfile: UserProfile? {
		willSet {
			if let userProfile = newValue {
				DispatchQueue.main.async {
					self.userNameLabel.text = userProfile.name
					self.changeUserID(with: userProfile.kokoid)
					self.userKOKOIDUnsetView.isHidden = !userProfile.kokoid.isEmpty
				}
			}
		}
	}
	
	lazy var userNameLabel: UILabel = {
		let label = UILabel()
		label.text = "使用者"
		label.font = .systemFont(ofSize: 17, weight: .medium)
		return label
	}()
	
	lazy var userKOKOIDLabel: UILabel = {
		let label = UILabel()
		label.text = "設定 KOKO ID"
		label.textColor = .greyishBrown
		return label
	}()
	
	lazy var userKOKOIDArrowImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = .icInfoBackDeepGray
		imageView.contentMode = .scaleAspectFit
		imageView.tintColor = .greyishBrown
		return imageView
	}()
	
	lazy var userKOKOIDUnsetView: UIView = {
		let view = UIView()
		view.backgroundColor = .hotPink
		view.layer.masksToBounds = true
		view.layer.cornerRadius = 6
		view.aspectRatio(equalTo: 1)
		return view
	}()
	
	lazy var userKOKOIDView: UIView = {
		let view = UIView()
		view.addSubview(userKOKOIDLabel)
		view.addSubview(userKOKOIDArrowImageView)
		view.addSubview(userKOKOIDUnsetView)
		
		userKOKOIDLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: userKOKOIDArrowImageView.leadingAnchor,
		                       topPadding: 4, leadingPadding: 0, bottomPadding: 4, trailingPadding: 4, width: 0, height: 0)
		userKOKOIDArrowImageView.anchor(top: view.topAnchor, leading: userKOKOIDLabel.trailingAnchor, bottom: view.bottomAnchor, trailing: userKOKOIDUnsetView.leadingAnchor,
		                                topPadding: 0, leadingPadding: 4, bottomPadding: 0, trailingPadding: 8, width: 20, height: 20)
		userKOKOIDArrowImageView.centerY(in: userKOKOIDLabel)
		userKOKOIDUnsetView.anchor(leading: userKOKOIDArrowImageView.trailingAnchor, width: 10, height: 10)
		userKOKOIDUnsetView.centerY(in: userKOKOIDArrowImageView)
		
		return view
	}()
	
	lazy var userProfileImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = .imgFriendsFemaleDefault
		return imageView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("Failed to init using from storyboards")
	}
	
	func setupUI() {
		addSubview(userNameLabel)
		addSubview(userKOKOIDView)
		addSubview(userProfileImageView)
		userProfileImageView.aspectRatio(equalTo: 1)
		
		userNameLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: userKOKOIDLabel.topAnchor, trailing: userProfileImageView.leadingAnchor,
		                     topPadding: 4, leadingPadding: 30, bottomPadding: 4, trailingPadding: 30, width: 0, height: 25)
		userKOKOIDView.anchor(top: userNameLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: userProfileImageView.leadingAnchor,
		                      topPadding: 4, leadingPadding: 30, bottomPadding: 4, trailingPadding: 30, width: 0, height: 25)
		userProfileImageView.anchor(top: topAnchor, leading: userNameLabel.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
		                            topPadding: 3, leadingPadding: 30, bottomPadding: 3, trailingPadding: 30, width: 52, height: 52)
	}
	
	func configure(with userProfile: UserProfile) {
		self.userProfile = userProfile
	}
	
	func changeUserID(with KOKOID: String? = nil) {
		if let KOKOID {
			DispatchQueue.main.async {
				self.userKOKOIDLabel.text = KOKOID.isEmpty ? "設定 KOKO ID" : "KOKO ID : \(KOKOID)"
			}
		}
	}
}
