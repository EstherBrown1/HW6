//  Person.swift
//  ECE564_HOMEWORK
//
//  Created by Trevor Stevenson on 9/12/19.
//  Copyright © 2019 ece564. All rights reserved.
//

import Foundation

enum Gender: String, CaseIterable {
    case Male
    case Female
}

class Person {
    var firstName = "First"
    var lastName = "Last"
    var whereFrom = "Anywhere" // this is just a free String - can be city, state, both, etc.
    var gender: Gender = .Male
}
