//
//  Server.swift
//  Spoolman
//
//  Created by Henry Krieger on 09.01.26.
//

import Foundation
import SwiftData

@Model
final class Server {
  var id: UUID
  var name: String
  var address: String
  var port: String
  var active: Bool
    
  init(id: UUID = UUID(), name: String, address: String, port: String, active: Bool) {
    self.id = id
    self.name = name
    self.address = address
    self.port = port
    self.active = active
  }
}
