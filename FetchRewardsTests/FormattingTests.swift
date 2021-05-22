//
//  FormattingTests.swift
//  FetchRewardsTests
//
//  Created by James Sedlacek on 5/22/21.
//

@testable import FetchRewards
import XCTest

class FormattingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_is_valid_dateTime() throws {
        let dateTime = "2012-10-01T09:45:00"
        XCTAssertNoThrow(try Formatting.formatDate(from: dateTime))
        XCTAssertNoThrow(try Formatting.formatTime(from: dateTime))
    }
    
    func test_invalid_dateTime() throws {
        let expectedError = K.ValidationError.invalidDateTime
        var error: K.ValidationError?
        
        let invalidDateTime = "10October2012"
        
        XCTAssertThrowsError(try Formatting.formatDate(from: invalidDateTime)) {
            thrownError in
            error = thrownError as? K.ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
    }
    
    func test_formatting_date_output() throws {
        let expectedOutput = "Monday, 01 Oct 2012"
        let dateTime = "2012-10-01T09:45:00"
        let output = try Formatting.formatDate(from: dateTime)
        
        XCTAssertEqual(output, expectedOutput)
    }
    
    func test_formatting_time_output() throws {
        let expectedOutput = "09:45 AM"
        let dateTime = "2012-10-01T09:45:00"
        let output = try Formatting.formatTime(from: dateTime)
        
        XCTAssertEqual(output, expectedOutput)
    }
}
