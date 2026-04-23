//
//  Character.swift
//  UnaPieza
//
//  Created by Fede Garcia on 22/04/2026.
//

import Foundation

struct Character: Identifiable, Codable {
    var id: Int
    var name: String
    var size: String?
    var age: String?
    var bounty: String?
    var status: String?
    var job: String?
    var fruit: DevilFruit?
    var crew: Crew?
   
}

struct Crew: Identifiable, Codable {
    var id: Int
    var name: String
    var status: String?
    var number: String?
    var romanName: String?
    var totalPrime: String?
    var isYonko: Bool?
}

struct CardImage: Codable {
    var cardImage: String?
}
