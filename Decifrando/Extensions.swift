//
//  Extension.swift
//  Decifrando
//
//  Created by Ana Luiza Ferrer on 04/11/16.
//
//

import Foundation

//SHUFFLE: Shuffles elements in an array.

extension MutableCollection where Indices.Iterator.Element == Index {

    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (unshuffledCount, firstUnshuffled) in zip(stride(from: c, to: 1, by: -1), indices) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}
