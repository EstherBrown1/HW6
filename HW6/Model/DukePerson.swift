//
//  DukePerson.swift
//  ECE564_HOMEWORK
//
//  Created by Trevor Stevenson on 9/12/19.
//  Copyright © 2019 ece564. All rights reserved.
//

import UIKit

/// The role of a Duke person
enum DukeRole: String, CaseIterable {
    case Professor
    case TA
    case Student
}

/// A degree a Duke person can hold
enum DukeDegree: String, CaseIterable {
    case bachelors = "Bachelors"
    case masters = "Masters"
    case phd = "PhD"
}

/// A class representing a person from Duke
final class DukePerson: Person {
    /// A list of hobbies
    var dukeHobbies: [String]

    /// A list of best programming languages
    var programmingLanguages: [String]

    /// Student, professor, or TA
    var dukeRole: DukeRole

    /// Optional degree obtained
    var dukeDegree: DukeDegree?

    /// Optional team
    var team: String?

    /// Avatar image
    var avatar: UIImage

    /// Has animated hobby
    let hasAnimatedHobby: Bool

    init(
        firstName: String = "",
        lastName: String = "",
        whereFrom: String = "",
        gender: Gender = .Male,
        hobbies: [String] = [],
        programmingLanguages: [String] = [],
        role: DukeRole = .Professor,
        dukeDegree: DukeDegree? = nil,
        team: String? = nil,
        avatar: UIImage = UIImage(),
        hasAnimatedHobby: Bool = false
    ) {
        dukeHobbies = hobbies
        self.programmingLanguages = programmingLanguages
        dukeRole = role
        self.dukeDegree = dukeDegree
        self.team = team
        self.avatar = avatar
        self.hasAnimatedHobby = hasAnimatedHobby

        super.init()

        self.firstName = firstName
        self.lastName = lastName
        self.whereFrom = whereFrom
        self.gender = gender
    }

    /// Gives the pronoun for the person's gender
    private func getPronoun() -> String {
        switch gender {
        case .Male:
            return "He"
        case .Female:
            return "She"
        }
    }

    /// Converts a list into a comma separated string
    private func enumeratedString(_ list: [String]) -> String {
        // If 0 or 1 elements, no commas or and
        if list.count <= 1 {
            return list.joined()
        }

        // If 2 elements, include and but no commas
        if list.count == 2 {
            return list.joined(separator: " and ")
        }

        var result = ""

        for i in 0 ..< list.count - 1 {
            result += list[i] + ", "
        }

        result += "and \(list[list.count - 1])"

        return result
    }
}

extension DukePerson: BlueDevil {
    var hobbies: [String] {
        return dukeHobbies
    }

    var hobbiesDescription: String {
        return enumeratedString(hobbies)
    }

    var languages: [String] {
        return programmingLanguages
    }

    var languagesDescription: String {
        return enumeratedString(programmingLanguages)
    }

    var role: DukeRole {
        return dukeRole
    }

    var degree: DukeDegree? {
        return dukeDegree
    }

    var picture: UIImage {
        return avatar
    }
}

extension DukePerson: CustomStringConvertible {
    var description: String {
        return "\(firstName) \(lastName) is from \(whereFrom) and is a \(dukeRole.rawValue). \(getPronoun()) is proficient in \(enumeratedString(programmingLanguages)). When not in class, \(firstName) enjoys \(enumeratedString(hobbies))."
    }
}

extension DukePerson {
    struct CodingData: Codable {
        let firstName: String
        let lastName: String
        let whereFrom: String
        let gender: String
        let hobbies: [String]
        let programmingLangues: [String]
        let role: String
        let degree: String
        let team: String
        let encodedImage: String
        let hasAnimatedHobby: Int
    }

    var codingData: CodingData {
        return CodingData(
            firstName: firstName,
            lastName: lastName,
            whereFrom: whereFrom,
            gender: gender.rawValue,
            hobbies: hobbies,
            programmingLangues: programmingLanguages,
            role: role.rawValue,
            degree: degree?.rawValue ?? "None",
            team: team ?? "",
            encodedImage: avatar.pngData()?.base64EncodedString() ?? "",
            hasAnimatedHobby: hasAnimatedHobby.intValue
        )
    }
}

extension DukePerson.CodingData {
    var person: DukePerson {
        return DukePerson(
            firstName: firstName,
            lastName: lastName,
            whereFrom: whereFrom,
            gender: Gender(rawValue: gender) ?? .Male,
            hobbies: hobbies,
            programmingLanguages: programmingLangues,
            role: DukeRole(rawValue: role) ?? .Professor,
            dukeDegree: DukeDegree(rawValue: degree),
            team: team == "" ? nil : team,
            avatar: UIImage(data: Data(base64Encoded: encodedImage) ?? Data()) ?? UIImage(),
            hasAnimatedHobby: hasAnimatedHobby.boolValue
        )
    }
}

extension DukePerson: Equatable {
    static func == (lhs: DukePerson, rhs: DukePerson) -> Bool {
        return
            lhs.firstName == rhs.firstName &&
            lhs.lastName == rhs.lastName &&
            lhs.whereFrom == rhs.whereFrom &&
            lhs.gender == rhs.gender &&
            lhs.hobbies == rhs.hobbies &&
            lhs.programmingLanguages == rhs.programmingLanguages &&
            lhs.role == rhs.role &&
            lhs.dukeDegree == rhs.dukeDegree &&
            lhs.team == rhs.team &&
            lhs.avatar == rhs.avatar &&
            lhs.hasAnimatedHobby == rhs.hasAnimatedHobby
    }
}
