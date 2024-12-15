//
//  APIService.swift
//  KOKO_iOS_Interview
//
//  Created by WeiFangChou on 2024/12/11.
//

import Foundation

class APIService {
	static let shared = APIService()
	
	static let baseUrl = "https://dimanyen.github.io"
	
	let jsonDecode = JSONDecoder()
	
	func getUserProfile() async throws -> UserProfile? {
		guard let url = URL(string: APIEndpoint.userProfile.fullPath) else {
			return nil
		}
		
		let (data, _) = try await URLSession.shared.data(from: url)
		let userModel = try jsonDecode.decode(UserModel.self, from: data)
		guard let user = userModel.response.first else {
			return nil
		}
		return user
	}
	
	func getUserFriends(apiEndPoint: APIEndpoint, complection: @escaping (Result<[FriendProfile], Error>) -> Void) {
		guard let url = URL(string: apiEndPoint.fullPath) else {
			complection(.failure(APIError.invalidUrl))
			return
		}

		URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
			if let error {
				complection(.failure(error))
				return
			}
			if let data {
				do {
					self.jsonDecode.dateDecodingStrategyFormatters = [.yearMonthDay, .yearMonthDayWithSlash]
					let result = try self.jsonDecode.decode(FriendModel.self, from: data)
					
					complection(.success(result.response.sorted(by: { $0.status.rawValue > $1.status.rawValue })))
					return
				} catch {
					#if DEBUG
					print(error)
					#endif
					complection(.failure(error))
				}
			}
		}.resume()
	}
	
	enum APIEndpoint: String {
		case userProfile = "/man.json"
		case friendsList1 = "/friend1.json"
		case friendsList2 = "/friend2.json"
		case friendsListWithInvite = "/friend3.json"
		case friendsListWithoutInvite = "/friend4.json"
		
		var fullPath: String {
			return "\(baseUrl)\(rawValue)"
		}
	}
	
	enum APIError: Error {
		case invalidUrl
		case invalidResponse
		case invalidData
	}
}
