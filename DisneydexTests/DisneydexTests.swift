//
//  DisneydexTests.swift
//  DisneydexTests
//
//  Created by Miguel Diaz on 2/5/23.
//

import XCTest
@testable import Disneydex

class DisneydexTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_CharacterListViewModel_nextUrl_returns_initialUrl_when_lastGetCharactersApiResponse_isNil() {
        let viewModel = CharacterListViewModel()
        XCTAssertEqual("https://api.disneyapi.dev/characters", viewModel.nextUrl?.absoluteString)
    }
    
    func test_CharacterListViewModel_nextUrl_returns_urlFromLastResponse_when_lastGetCharactersApiResponse_isNotNil() {
        var viewModel = CharacterListViewModel()
        viewModel.lastGetCharactersApiResponse = GetCharactersApiResponse(data: [], count: -1, totalPages: -1, nextPage: URL(string: "https://api.disneyapi.dev/characters/2"))
        XCTAssertEqual("https://api.disneyapi.dev/characters/2", viewModel.nextUrl?.absoluteString)
    }
    
    func test_CharacterListViewModel_nextUrl_returns_nil_when_lastGetCharactersApiResponse_nextPage_isNil() {
        var viewModel = CharacterListViewModel()
        viewModel.lastGetCharactersApiResponse = GetCharactersApiResponse(data: [], count: -1, totalPages: -1, nextPage: nil)
        XCTAssertNil(viewModel.nextUrl?.absoluteString)
    }

}
