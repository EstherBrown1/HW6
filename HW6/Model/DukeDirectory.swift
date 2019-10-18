//
//  DukeDirectory.swift
//  ECE564_HOMEWORK
//
//  Created by Trevor Stevenson on 9/12/19.
//  Copyright © 2019 ece564. All rights reserved.
//

import UIKit

/// Structure to store records
struct DukeDirectory {
    private var directory: [String: DukePerson] = [:]

    /// Add a new person to the directory
    mutating func add(_ person: DukePerson) {
        directory["\(person.firstName) \(person.lastName)"] = person
    }

    /// Add multiple people to the directory
    mutating func addAll(_ people: [DukePerson]) {
        for person in people {
            add(person)
        }
    }

    /// Get the person object for a given name
    func get(_ name: String) -> DukePerson? {
        return directory[name]
    }

    /// Get all people
    func getAll() -> [DukePerson] {
        return Array(directory.values)
    }

    /// Gets the description for the given person
    func getDescription(for name: String) -> String {
        if let person = directory[name] {
            return person.description
        }

        return "Person not found."
    }

    /// Gets the description for all people that match the given regex
    func getDescription(with regex: String) -> String {
        var result = ""

        for name in directory.keys where name.matches(regex: regex) {
            result += getDescription(for: name) + "\n"
        }

        if result.count == 0 {
            return "Person not found.\n"
        }

        return result
    }

    /// Get the person's degree
    func getDegree(for name: String) -> String {
        guard let person = directory[name] else {
            return "Person not found."
        }

        if let degree = person.degree {
            return degree.rawValue
        }

        return "Person's degree is not known."
    }

    /// Get all people in the directory that match the given predicate
    func query(by predicate: (DukePerson) -> Bool) -> String {
        var result = ""

        for (name, person) in directory {
            if predicate(person) {
                result += getDescription(for: name) + "\n"
            }
        }

        return result
    }

    /// Remove person
    mutating func remove(_ name: String) {
        directory.removeValue(forKey: name)
    }
}

var baseDirectory: DukeDirectory = {
    var directory = DukeDirectory()
    directory.addAll(
        [
            DukePerson(
                firstName: "Trevor",
                lastName: "Stevenson",
                whereFrom: "Davidson, NC",
                gender: .Male,
                hobbies: ["Soccer"],
                programmingLanguages: ["Swift", "Python", "Objective-C", "Haskell", "C", "C++"],
                role: .Student,
                dukeDegree: .bachelors,
                team: "Community Service",
                avatar: UIImage(named: "trevor_avatar") ?? UIImage(),
                hasAnimatedHobby: true
            ),
            DukePerson(
                firstName: "Esther",
                lastName: "Brown",
                whereFrom: "Houston, TX",
                gender: .Female,
                hobbies: ["Watching Movies"],
                programmingLanguages: ["Java", "Python", "Objective-C"],
                role: .Student,
                dukeDegree: .bachelors,
                team: "Community Service",
                avatar: UIImage(named: "Esth") ?? UIImage(),
                hasAnimatedHobby: true
            ),
            DukePerson(
                firstName: "Ric",
                lastName: "Telford",
                whereFrom: "Chatham County, NC",
                gender: .Male,
                hobbies: ["golf", "swimming", "reading"],
                programmingLanguages: ["Swift", "C", "C++"],
                role: .Professor,
                dukeDegree: .bachelors,
                avatar: UIImage(named: "telford") ?? UIImage()
            ),
            DukePerson(
                firstName: "Ting",
                lastName: "Chen",
                whereFrom: "Beijing, China",
                gender: .Male,
                hobbies: ["road cycling", "swimming", "reading"],
                programmingLanguages: ["Swift", "Python", "C++", "MATLAB"],
                role: .TA,
                dukeDegree: .masters,
                avatar: UIImage(named: "avatar3") ?? UIImage()
            ),
            DukePerson(
                firstName: "Haohong",
                lastName: "Zhao",
                whereFrom: "Hebei, China",
                gender: .Male,
                hobbies: ["reading", "jogging"],
                programmingLanguages: ["Swift", "Python"],
                role: .TA,
                dukeDegree: .masters,
                avatar: UIImage(named: "avatar4") ?? UIImage()
            ),
        ]
    )

    return directory
}()
