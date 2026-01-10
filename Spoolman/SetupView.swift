//
//  SetupView.swift
//  Spoolman
//
//  Created by Henry Krieger on 09.01.26.
//

import SwiftUI
import SwiftData

struct SetupView: View {
  @Environment(\.modelContext) private var modelContext
  @Environment(\.dismiss) private var dismiss
  @Query private var servers: [Server]
  
  @State var serverName: String = ""
  @State var serverAddress: String = ""
  @State var serverPort: String = ""
  
  func save() {
    let newServer = Server(
      id: UUID(),
      name: serverName,
      address: serverAddress,
      port: serverPort,
      active: true
    )
    
    modelContext.insert(newServer)
    dismiss()
  }
  
  var body: some View {
    NavigationView {
      List {
        Text("Welcome to Spoolbuddy. We have to start with a quick setup for everything to work.")
        
        Section {
          Text("Please enter your Spoolman server address.")
          TextField("http:// server.example.com", text: $serverAddress)
            .keyboardType(.URL)
            .textContentType(.URL)
            .autocorrectionDisabled(true)
            .autocapitalization(.none)
        }
        
        Section {
          Text("And we also need the port that spoolman listens to on your server.")
          TextField("7912", text: $serverPort)
            .keyboardType(.numberPad)
            .autocorrectionDisabled(true)
            .autocapitalization(.none)
        }
        
        Section {
          Text("Last but not least: Your server needs a name :)")
          TextField("Spooly", text: $serverName)
            .keyboardType(.alphabet)
            .autocorrectionDisabled()
            .autocapitalization(.words)
        }
      }
      .navigationTitle("Spoolbuddy - Setup")
      .toolbar {
        Button(action: save) {
          Text("Save")
        }
        .buttonStyle(BorderedProminentButtonStyle())
        .disabled(serverAddress.isEmpty || serverPort.isEmpty || serverName.isEmpty)
      }
    }
  }
}

#Preview {
    SetupView()
}
