//
//  OccuranceCounter.swift
//  Echo_TestApp
//
//  Created by Денис Андриевский on 18.10.2020.
//

import Foundation

final class OccurrenceCounter {
    
    static func countOccurrences(in text: String) -> [Occurrence] {
        let counts = zip(text, repeatElement(1, count: Int.max))
        let frequencies = Dictionary(counts, uniquingKeysWith: +)
        var occurrences: [Occurrence] = []
        for (key, value) in frequencies {
            occurrences.append(Occurrence(character: key, count: value))
        }
        return occurrences
    }
    
}
