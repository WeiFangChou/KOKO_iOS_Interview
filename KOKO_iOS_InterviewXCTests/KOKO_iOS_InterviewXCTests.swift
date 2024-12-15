//
//  KOKO_iOS_InterviewXCTests.swift
//  KOKO_iOS_InterviewXCTests
//
//  Created by WeiFangChou on 2024/12/16.
//

@testable import KOKO_iOS_Interview
import XCTest

final class KOKO_iOS_InterviewXCTests: XCTestCase {
	var vc: ViewController!

	override func setUpWithError() throws {
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDownWithError() throws {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}

	func testUserProfile() {
		let name = "蔡國泰"
		let kokoid = "Mike"
		let userProfile = UserProfile(name: "蔡國泰", kokoid: "Mike")

		XCTAssertEqual(name, userProfile.name)
		XCTAssertEqual(kokoid, userProfile.kokoid)
	}
}
