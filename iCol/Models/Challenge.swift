//
//  Challenge.swift
//  iCol
//
//  Created by Wendy Kurniawan on 14/10/20.
//

import Foundation

enum Type {
    case increase
    case decrease
}

struct Challenge {
    let name: String
    let image: String
    let type: Type
}
