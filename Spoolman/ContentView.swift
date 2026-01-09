//
//  ContentView.swift
//  Spoolman
//
//  Created by Henry Krieger on 09.01.26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  @Environment(\.modelContext) private var modelContext
  @Query var servers: [Server]
  
  @State private var spools: [Spool] = []
  @State private var filaments: [Filament] = []
  @State private var vendors: [Vendor] = []
  
  enum SheetType: Identifiable {
    case settings
    
    var id: Int {
      self.hashValue
    }
  }
  @State private var selectedSheet: SheetType? = nil

  var body: some View {
    if servers.isEmpty {
      SetupView()
    } else {
      NavigationStack {
        List {
          
          Section(header: Text("Spools")) {
            ForEach(spools) { spool in
              HStack {
                Circle()
                  .frame(width: 20, height: 20)
                  .foregroundStyle(Color(hex: spool.filament.colorHex)!)
                  .overlay {
                    Circle()
                      .stroke(.secondary, style: StrokeStyle(lineWidth: 1))
                  }
                Text(spool.filament.name)
              }
            }
          }
          
          Section(header: Text("Filaments")) {
            ForEach(filaments) { filament in
              Text(filament.name)
            }
          }
          
          Section(header: Text("Vendors")) {
            ForEach(vendors) { vendor in
              Text(vendor.name)
            }
          }
        }
        .onAppear {
          Task {
            print("fetching data")
            let server = servers.first!
            let url = "\(server.address):\(server.port)/api/v1"
            do {
              spools = try await NetworkManager.shared
                .request(url: URL(string: "\(url)/spool")!, method: .GET)
            } catch {
              print(error.localizedDescription)
            }
            do {
              filaments = try await NetworkManager.shared.request(url: URL(string: "\(url)/filament")!, method: .GET)
            } catch {
              print(error.localizedDescription)
            }
            do {
              vendors = try await NetworkManager.shared.request(url: URL(string: "\(url)/vendor")!, method: .GET)
            } catch {
              print(error.localizedDescription)
            }
            print("data fetched")
          }
        }
        .navigationTitle("Spoolbuddy")
        .toolbar {
          ToolbarItem {
            Button {
              selectedSheet = .settings
            } label: {
              Image(systemName: "gear")
            }
          }
        }
        .sheet(item: $selectedSheet) { sheet in
          switch sheet {
          case .settings:
            SettingsView()
          }
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
