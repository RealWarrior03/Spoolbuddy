//
//  DataStructs.swift
//  Spoolman
//
//  Created by Henry Krieger on 09.01.26.
//

import Foundation

struct Vendor: Decodable, Identifiable {
  let id: Int
  let registered: Date
  let name: String
  let emptySpoolWeight: Double?
  let extra: [String: AnyCodable]
}

struct Filament: Decodable, Identifiable {
  let id: Int
  let registered: Date
  let name: String
  let vendor: Vendor
  let material: String
  let price: Double
  let density: Double
  let diameter: Double
  let weight: Double
  let spoolWeight: Double
  let settingsExtruderTemp: Int
  let settingsBedTemp: Int
  let colorHex: String
  let extra: [String: AnyCodable]
}

struct Spool: Decodable, Identifiable {
  let id: Int
  let registered: Date
  let firstUsed: Date?
  let lastUsed: Date?
  let filament: Filament
  let price: Double
  let remainingWeight: Double
  let initialWeight: Double
  let spoolWeight: Double
  let usedWeight: Double
  let remainingLength: Double
  let usedLength: Double
  let location: String
  let archived: Bool
  let extra: [String: AnyCodable]
}
