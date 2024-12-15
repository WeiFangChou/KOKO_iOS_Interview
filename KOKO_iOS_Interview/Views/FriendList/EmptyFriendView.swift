//
//  EmptyFriendListView.swift
//  KOKO_iOS_Interview
//
//  Created by WeiFangChou on 2024/12/10.
//

import UIKit

class EmptyFriendView: UIView {
	lazy var emptyImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = .imgFriendsEmpty
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		return imageView
	}()

	lazy var emptyTitleLabel: UILabel = {
		let label = UILabel()
		label.text = "就從加好友開始吧: )"
		label.textAlignment = .center
		label.font = .systemFont(ofSize: 21, weight: .medium)
		return label
	}()

	lazy var emptyDescLabel: UILabel = {
		let label = UILabel()
		label.text = "與好友們一起用 KOKO 聊起來！\n還能互相收付款、發紅包喔:)"
		label.numberOfLines = 2
		label.textAlignment = .center
		label.font = .systemFont(ofSize: 14, weight: .regular)
		label.textColor = .lightGrey
		return label
	}()

	lazy var addFriendButton: AddFriendButton = {
		let btn = AddFriendButton()
		btn.setTitle("加好友", for: .normal)
		btn.setTitleColor(.white, for: .normal)
		btn.layer.cornerRadius = 20
		btn.tintColor = .frogGreen
		let gradientLayer = CAGradientLayer()
		gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.systemPurple.cgColor]
		gradientLayer.locations = [0, 1]
		gradientLayer.frame = btn.bounds
		gradientLayer.cornerRadius = btn.layer.cornerRadius
		btn.layer.insertSublayer(gradientLayer, at: 0)
		return btn
	}()

	lazy var helpSettingIDLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.font = .systemFont(ofSize: 13, weight: .regular)
		label.textColor = .lightGray
		label.addGestureRecognizer(tapRecognizer)
		let helpFindText = "幫助好友更快找到你？ 設定 KOKO ID"
		let settingIDText = "設定 KOKO ID"
		let settingIDTextRange = (helpFindText as NSString).range(of: settingIDText)
		let attributedText = NSMutableAttributedString(string: helpFindText)
		attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: settingIDTextRange)
		attributedText.addAttribute(.foregroundColor, value: UIColor.hotPink, range: settingIDTextRange)
		label.attributedText = attributedText
		return label
	}()

	lazy var tapRecognizer: UITapGestureRecognizer = {
		let tap = UITapGestureRecognizer(target: self, action: #selector(handlerSettingID))
		return tap
	}()

	func setupUI() {
		addSubview(emptyImageView)
		addSubview(emptyTitleLabel)
		addSubview(emptyDescLabel)
		addSubview(addFriendButton)
		addSubview(helpSettingIDLabel)
		emptyImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: emptyTitleLabel.topAnchor, trailing: trailingAnchor,
		                      topPadding: 60, leadingPadding: 64, bottomPadding: 8, trailingPadding: 64, width: 0, height: 170)
		emptyTitleLabel.anchor(top: emptyImageView.bottomAnchor, leading: leadingAnchor, bottom: emptyDescLabel.topAnchor, trailing: trailingAnchor,
		                       topPadding: 41, leadingPadding: 64, bottomPadding: 8, trailingPadding: 64, width: 0, height: 30)
		emptyDescLabel.anchor(top: emptyTitleLabel.bottomAnchor, leading: leadingAnchor, bottom: addFriendButton.topAnchor, trailing: trailingAnchor,
		                      topPadding: 8, leadingPadding: 68, bottomPadding: 37, trailingPadding: 68, width: 0, height: 40)
		addFriendButton.anchor(top: emptyDescLabel.bottomAnchor, leading: leadingAnchor, bottom: helpSettingIDLabel.topAnchor, trailing: trailingAnchor,
		                       topPadding: 0, leadingPadding: 92, bottomPadding: 37, trailingPadding: 92, width: 0, height: 40)
		helpSettingIDLabel.anchor(top: addFriendButton.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,
		                          topPadding: 0, leadingPadding: 64, bottomPadding: 8, trailingPadding: 64, width: 0, height: 20)
	}

	init() {
		super.init(frame: .zero)
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("Failed to init using from storyboards")
	}

	@objc func handlerSettingID() {
		// TODO: Setting KOKOID
		#if DEBUG
			print("Setting KOKO ID")
		#endif
	}
}

@available(iOS 17, *)
#Preview {
	EmptyFriendView()
}
