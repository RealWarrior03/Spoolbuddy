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
            // Create a binding to this server's `active` property
            let isActiveBinding = Binding<Bool>(
              get: { server.active },
              set: { newValue in
                // Because `Server` is a SwiftData model reference, mutating it directly updates the model
                server.active = newValue
              }
            )

            Toggle(isOn: isActiveBinding) {
              VStack(alignment: .leading) {
                Text(server.name)
                  .bold()
                Text("\(server.address):\(server.port)")
              }
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
