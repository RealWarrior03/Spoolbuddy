//
//  SettingsView.swift
//  Spoolman
//
//  Created by Henry Krieger on 09.01.26.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
  @Query private var servers: [Server]
  
  var body: some View {
    NavigationView {
      List {
        Section(header: Text("Servers")) {
          Text("available servers")
            .badge(servers.count)
          ForEach(servers) { server in
            HStack {
              Text("\(server.name)")
              Spacer()
              Text("\(server.address):\(server.port)")
            }
          }
        }
      }
      .navigationTitle("Settings")
    }
  }
}

#Preview {
    SettingsView()
}
