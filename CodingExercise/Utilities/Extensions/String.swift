//
//  String.swift
//  CodingExercise
//
//  Created by Suslov Babu on 28/09/17.
//  Copyright © 2017 Suslov Babu. All rights reserved.
//

import Foundation

public extension String {
    
    /**
     * Simplify localization call
     */
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
}
