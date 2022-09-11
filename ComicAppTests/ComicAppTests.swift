//
//  ComicAppTests.swift
//  ComicAppTests
//
//  Created by Anitha Selvarajan on 9/11/22.
//

import XCTest
@testable import ComicApp

class ComicAppTests: XCTestCase {
    
    func test_ComicValidRequest(){
        let json = """
            {
            "results": [
                {
            "id":200,
            title : "Silver Surfer (2003) #5",
            "description":"COMMUNION PART 5 The truth that drives the Surfer's actions comes to light, as does the horrifying fate that awaits all mankind!",
            }
            ],
            "thumbnail":
            {
            "path":"http://i.annihil.us/u/prod/marvel/i/mg/9/70/5c813f1dd926b",
            "extension":"jpg"
            },
            }
            """
        
        let jsonData = json.data(using: .utf8)!
        do {
            
            let res = try JSONDecoder().decode(Comic.self, from: jsonData)
            XCTAssertEqual(200, res.code)
            let temp = (res.data?.results)!
            
            for item in temp {
                XCTAssertEqual(200, item.id)
                XCTAssertEqual("COMMUNION PART 5 The truth that drives the Surfer's actions comes to light, as does the horrifying fate that awaits all mankind!", item.resultDescription)
            }
        }
        
        catch
        {
            print(error)
        }
    }
    
}
