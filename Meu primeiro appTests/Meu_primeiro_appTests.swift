//
//  Meu_primeiro_appTests.swift
//  Meu primeiro appTests
//
//  Created by Jonathan on 28/01/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import XCTest
@testable import Meu_primeiro_app

class Meu_primeiro_appTests: XCTestCase {
    //MARK: Meal Class Tests
    // Zero rating
    
    func testMealInitializationSucceeds() {
        let zeroRatingMeal = Bar.init(name: "Zero", photo: nil, rating: 0, cidade:"Qualquer", estado: "qw", bairro: "Qualquer", rua: "Qualquer", numero: 1)
        XCTAssertNotNil(zeroRatingMeal)
        
        // Highest positive rating
        let positiveRatingMeal = Bar.init(name: "Positive", photo: nil, rating: 4, cidade:"Qualquer", estado: "sc", bairro: "Qualquer", rua: "Qualquer", numero: 999999)
        XCTAssertNotNil(positiveRatingMeal)
    }
    
    
    
    func testMealInitializationFails() {
        // Negative rating
        let negativeRatingMeal = Bar.init(name: "Negative", photo:
            nil, rating: -1, cidade:"Negando", estado: "12", bairro: "Negando", rua: "Negando", numero: -1)
        XCTAssertNil(negativeRatingMeal)
        
        // Rating exceeds maximum
        let largeRatingMeal = Bar.init(name: "Large", photo: nil, rating:
            6, cidade:"oasd", estado: "Negando", bairro: "Negando", rua: "Negando", numero: 0)
        XCTAssertNil(largeRatingMeal)
        
        // Empty String
        let emptyStringMeal = Bar.init(name: "", photo: nil, rating: 0, cidade:"", estado: "", bairro: "", rua: "", numero: 0)
        XCTAssertNil(emptyStringMeal)
        
        // Maximo de 2 caracteres no estado
        let testMaxLenghtEstado = Bar.init(name: "", photo: nil, rating: 0, cidade:"", estado: "SCC", bairro: "", rua: "", numero: 0)
        XCTAssertNil(testMaxLenghtEstado)
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
