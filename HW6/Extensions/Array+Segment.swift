//
//  Array+Segment.swift
//  ECE564_HOMEWORK
//
//  Created by Trevor Stevenson on 9/22/19.
//  Copyright © 2019 ece564. All rights reserved.
//

import Foundation

extension Array {
    /// Segment a single array into multiple buckets based on some condition
    func segment(condition: (Element) -> Int) -> [[Element]] {
        var segmentedArray: [[Element]] = []

        for item in self {
            let index = condition(item)
            while index >= segmentedArray.count {
                segmentedArray.append([])
            }

            segmentedArray[index].append(item)
        }

        return segmentedArray
    }
}

extension Array where Element: Collection {
    typealias InnerElement = Element.Iterator.Element

    /// Place a new element in the correct segment
    func placeIntoSegment(item: InnerElement, condition: (InnerElement) -> Int) -> [[InnerElement]] {
        var segmentedArray: [[InnerElement]] = []
        let index = condition(item)

        while index >= segmentedArray.count {
            segmentedArray.append([InnerElement]())
        }

        for (i, segment) in enumerated() {
            if let segmentCopy = segment as? [InnerElement] {
                if i == index {
                    segmentedArray.append(segmentCopy + [item])
                } else {
                    segmentedArray.append(segmentCopy)
                }
            }
        }

        return segmentedArray
    }
}
