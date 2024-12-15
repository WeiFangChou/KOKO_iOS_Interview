//
//  UserViewModel.swift
//  KOKO_iOS_Interview
//
//  Created by WeiFangChou on 2024/12/11.
//

class UserViewModel {
	var userProfile: Observable<UserProfile> = Observable(nil)
	
	private let apiService = APIService.shared
	
	init() {}
	
	func fetchUserProfile() async {
		do {
			let userProfile = try await apiService.getUserProfile()
			if let userProfile {
				self.userProfile.value = userProfile
			}
		} catch {
			print(error)
		}
	}
}
