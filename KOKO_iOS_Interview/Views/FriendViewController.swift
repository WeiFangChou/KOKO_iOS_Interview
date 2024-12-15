//
//  FriendViewController.swift
//  KOKO_iOS_Interview
//
//  Created by WeiFangChou on 2024/12/9.
//

import UIKit

class FriendViewController: UIViewController {
	private var userViewModel = UserViewModel()
	private var friendViewModel = FriendViewModel()

	var friendHeaderViewConstraint: NSLayoutConstraint?
	var invitationsListViewHeightConstraint: NSLayoutConstraint?

	lazy var userProfileView: UserProfileView = {
		let view = UserProfileView()
		return view
	}()

	lazy var inviteListView: InvitationsListView = {
		let view = InvitationsListView()
		view.addGestureRecognizer(expandCollapseGesture)
		return view
	}()

	lazy var expandCollapseGesture: UITapGestureRecognizer = {
		let gesture = UITapGestureRecognizer(target: self, action: #selector(handlerInvitationExpend))
		return gesture
	}()

	lazy var friendTabCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
		layout.sectionInset = .init(top: 0, left: 30, bottom: 0, right: 0)
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
		view.backgroundColor = .clear
		view.register(FriendTabCollectionViewCell.self, forCellWithReuseIdentifier: FriendTabCollectionViewCell.Identifier)
		view.delegate = self
		view.dataSource = self
		return view
	}()

	lazy var friendHeaderView: UIView = {
		let view = UIView(frame: .init(x: 0, y: 0, width: 0, height: 140))
		view.backgroundColor = .whiteThree

		let underLineView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		underLineView.backgroundColor = .veryLightPink

		view.addSubview(userProfileView)
		view.addSubview(inviteListView)
		view.addSubview(friendTabCollectionView)
		view.addSubview(underLineView)
		userProfileView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: inviteListView.topAnchor, trailing: view.trailingAnchor,
		                       topPadding: 32, leadingPadding: 0, bottomPadding: 10, trailingPadding: 0, width: 0, height: 0)
		inviteListView.anchor(top: userProfileView.bottomAnchor, leading: view.leadingAnchor, bottom: friendTabCollectionView.topAnchor, trailing: view.trailingAnchor,
		                      topPadding: 0, leadingPadding: 30, bottomPadding: 20, trailingPadding: 30, width: 0, height: 0)
		friendTabCollectionView.anchor(top: inviteListView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor,
		                               topPadding: 0, leadingPadding: 0, bottomPadding: 1, trailingPadding: 0, width: 0, height: 35)
		underLineView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor,
		                     topPadding: 0, leadingPadding: 0, bottomPadding: 0, trailingPadding: 0, width: 0, height: 1)
		return view
	}()

	lazy var emptyFriendView: EmptyFriendView = {
		let view = EmptyFriendView()
		return view
	}()

	lazy var friendRefreshControl: UIRefreshControl = {
		let control = UIRefreshControl()
		control.addTarget(self, action: #selector(handlerRefresh), for: .primaryActionTriggered)
		return control
	}()

	lazy var friendSearchBar: UISearchBar = {
		let bar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
		bar.delegate = self
		bar.placeholder = "想轉一筆給誰呢？"
		bar.backgroundImage = .init()
		return bar
	}()

	lazy var addFriendsButton: UIButton = {
		let btn = UIButton()
		btn.setImage(.icBtnAddFriends.withTintColor(.hotPink), for: .normal)
		btn.tintColor = .hotPink

		return btn
	}()

	lazy var searchBarView: UIView = {
		let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 60))
		view.addSubview(friendSearchBar)
		view.addSubview(addFriendsButton)
		friendSearchBar.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: addFriendsButton.leadingAnchor, topPadding: 0, leadingPadding: 0, bottomPadding: 0, trailingPadding: 0, width: 0, height: 0)
		addFriendsButton.anchor(top: view.topAnchor, leading: friendSearchBar.trailingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, topPadding: 0, leadingPadding: 0, bottomPadding: 0, trailingPadding: 0, width: 30, height: 30)
		return view
	}()

	lazy var friendTableView: UITableView = {
		let tableView = UITableView()
		tableView.register(FriendTableViewCell.self, forCellReuseIdentifier: FriendTableViewCell.Identifier)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.tableHeaderView = searchBarView
		tableView.backgroundView = emptyFriendView
		tableView.refreshControl = friendRefreshControl

		return tableView
	}()

	init() {
		super.init(nibName: nil, bundle: nil)
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("Failed to init using from storyboards")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupDataBinding()
		setupKeyboardGesture()
		loadDatas()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		showFriendSituation()
		showUserProfileViewVisible()
	}

	func setupUI() {
		view.backgroundColor = .systemBackground
		view.addSubview(friendHeaderView)
		view.addSubview(friendTableView)

		friendHeaderView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: friendTableView.topAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor,
		                        topPadding: 0, leadingPadding: 0, bottomPadding: 0, trailingPadding: 0, width: 0, height: 0)
		friendHeaderViewConstraint = friendHeaderView.heightAnchor.constraint(equalToConstant: 140)
		friendHeaderViewConstraint?.isActive = true
		invitationsListViewHeightConstraint = inviteListView.heightAnchor.constraint(equalToConstant: 0)
		invitationsListViewHeightConstraint?.isActive = true
		friendTableView.anchor(top: friendHeaderView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor,
		                       topPadding: 0, leadingPadding: 20, bottomPadding: 0, trailingPadding: 20, width: 0, height: 0)
	}

	func setupDataBinding() {
		userViewModel.userProfile.bind { [weak self] userProfile in
			guard let userProfile, let self else { return }
			DispatchQueue.main.async {
				self.userProfileView.configure(with: userProfile)
			}
		}

		friendViewModel.situation.bind { [weak self] sigaction in
			guard let sigaction, let self else { return }
			switch sigaction {
				case .noFriend:
					Task {
						await self.friendViewModel.loadData(for: .noFriend)
					}
				case .onlyFriends:
					Task {
						await self.friendViewModel.loadData(for: .onlyFriends)
					}
				case .friendWithInvitiation:
					Task {
						await self.friendViewModel.loadData(for: .friendWithInvitiation)
					}
			}
		}

		friendViewModel.friends.bind { [weak self] friends in
			guard let friends, let self else { return }
			DispatchQueue.main.async {
				self.updateFriendBadgeCount()
				self.friendTableView.reloadData()
				self.setupInvitationVisible(false)
				if friends.contains(where: { $0.status == .inviting }) {
					self.setupInvitationVisible(true)
					self.inviteListView.configure(friends.filter { $0.status == .pending })
					self.view.layoutIfNeeded()
					return
				}
				self.inviteListView.configure([])
			}
		}

		friendViewModel.searchText.bind { [weak self] searchText in
			guard let searchText, let self else { return }
			DispatchQueue.main.async {
				self.friendSearchBar.text = searchText
				self.friendViewModel.filiterSearchResult()
				self.friendTableView.reloadData()
			}
		}
	}

	func loadDatas() {
		Task {
			await userViewModel.fetchUserProfile()
		}
	}

	func setupKeyboardGesture() {
		let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handlerCloseKeyboard))
		view.addGestureRecognizer(tapRecognizer)
	}

	func setupInvitationGesture() {
		let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handlerInvitationExpend))
		inviteListView.addGestureRecognizer(tapRecognizer)
	}
}

// MARK: Alert Controller

extension FriendViewController {
	func showFriendSituation() {
		let situationAlertController = UIAlertController(title: "請選擇情境", message: "", preferredStyle: .actionSheet)
		let noFriendsAction = UIAlertAction(title: "無好友畫面", style: .default) { _ in
			self.friendViewModel.situation.value = .noFriend
		}
		let onlyFriendsAction = UIAlertAction(title: "只有好友列表", style: .default) { _ in
			self.friendViewModel.situation.value = .onlyFriends
		}
		let friendsWithInvitesAction = UIAlertAction(title: "好友列表含邀請", style: .default) { _ in
			self.friendViewModel.situation.value = .friendWithInvitiation
		}
		let cancelAction = UIAlertAction(title: "取消", style: .cancel)
		situationAlertController.addAction(noFriendsAction)
		situationAlertController.addAction(onlyFriendsAction)
		situationAlertController.addAction(friendsWithInvitesAction)
		situationAlertController.addAction(cancelAction)
		present(situationAlertController, animated: true)
	}
}

// MARK: Searchbar Handler

extension FriendViewController {
	func showUserProfileViewVisible() {
		friendHeaderViewConstraint?.isActive = false
		UIView.animate(withDuration: 0.5) {
			self.view.layoutIfNeeded()
		}
	}

	func hideUserProfileViewVisible() {
		friendHeaderViewConstraint?.constant = 0
		friendHeaderViewConstraint?.isActive = true
		UIView.animate(withDuration: 0.5) {
			self.view.layoutIfNeeded()
		}
	}

	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		hideUserProfileViewVisible()
	}

	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		showUserProfileViewVisible()
	}
}

// MARK: TableView Refresh Control

extension FriendViewController {
	@objc func handlerRefresh() {
		switch friendViewModel.situation.value {
			case .noFriend:
				friendViewModel.situation.value = .noFriend
			case .onlyFriends:
				friendViewModel.situation.value = .onlyFriends
			case .friendWithInvitiation:
				friendViewModel.situation.value = .friendWithInvitiation
			case .none:
				break
		}
		friendRefreshControl.endRefreshing()
	}
}

// MARK: Handler actions

extension FriendViewController {
	@objc func handlerCloseKeyboard() {
		view.endEditing(true)
	}

	@objc func handlerInvitationExpend() {
		if !inviteListView.isExpanded {
			if let invitationFriendsCount = friendViewModel.friends.value?.filter({ $0.status == .inviting }).count {
				invitationsListViewHeightConstraint?.constant = 80.0 * CGFloat(invitationFriendsCount)
				inviteListView.setViewExpand(true)
			}
		} else {
			invitationsListViewHeightConstraint?.constant = 80
			inviteListView.setViewExpand(false)
		}

		UIView.animate(withDuration: 0.3) {
			self.view.layoutIfNeeded()
		}
	}
}

// MARK: Invitation Visible

extension FriendViewController {
	func setupInvitationVisible(_ visible: Bool) {
		print(visible)
		if visible {
			invitationsListViewHeightConstraint?.constant = 80
		} else {
			invitationsListViewHeightConstraint?.constant = 0
		}
		UIView.animate(withDuration: 0.3) {
			self.view.layoutIfNeeded()
		}
	}
}

extension FriendViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		friendViewModel.searchText.value = searchText
	}
}

extension FriendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		friendViewModel.friendTabs.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendTabCollectionViewCell.Identifier, for: indexPath) as? FriendTabCollectionViewCell else { fatalError() }
		cell.configure(with: friendViewModel.friendTabs[indexPath.item])

		return cell
	}

	func updateFriendBadgeCount() {
		let friendBadgeCount = friendViewModel.friends.value?.count(where: { $0.status == .inviting })
		if let friendBadgeCount {
			friendViewModel.friendTabs[0].badgeCount = friendBadgeCount
			friendTabCollectionView.reloadData()
		}
	}
}

extension FriendViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// If SearchText Not Empty
		updateFriendBadgeCount()
		guard let searchText = friendViewModel.searchText.value, let friends = friendViewModel.friends.value, let filitedFriends = friendViewModel.filitedFriends.value else {
			emptyFriendView.isHidden = false
			searchBarView.isHidden = true
			return 0
		}

		if friends.isEmpty {
			emptyFriendView.isHidden = false
			searchBarView.isHidden = true
			return 0
		}
		searchBarView.isHidden = false
		emptyFriendView.isHidden = friends.isEmpty ? false : filitedFriends.isEmpty ? true : false
		return searchText.isEmpty ? friends.count : filitedFriends.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.Identifier, for: indexPath) as? FriendTableViewCell else { fatalError() }
		if let friends = friendViewModel.friends.value {
			cell.configure(friendProfile: friends[indexPath.item])
		}
		return cell
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		friendSearchBar.searchTextField.resignFirstResponder()
	}
}

@available(iOS 17, *)
#Preview {
	FriendViewController()
}
