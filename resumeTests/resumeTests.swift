//
//  resumeTests.swift
//  resumeTests
//
//  Created by horo on 5/20/22.
//

import XCTest
@testable import resume

class resumeTests: XCTestCase {

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
    
    func testImageSaveLoad() async throws {
        let image = UIImage(named: "noimage_png")
        let imageData = image!.size
        let handler = ImageSLHandler()
        
        await handler.saveTo("test.png", with: image!)
        let loadImage = await handler.loadFrom("test.png")
        XCTAssertEqual(imageData, loadImage!.size)
        let failed = await handler.loadFrom("fail.png")
        XCTAssertNil(failed)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
