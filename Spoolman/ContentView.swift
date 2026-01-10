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
  @Query private var servers: [Server]
  
  enum Tabs: Identifiable {
    case home
    case spools
    case filaments
    case vendors
    case settings
    case search
    
    var id: Int {
      self.hashValue
    }
  }
  @State private var defaultTab: Tabs = .spools

  var body: some View {
    if servers.isEmpty {
      SetupView()
    } else {
      TabView(selection: $defaultTab) {
        Tab(value: .spools, role: .none) {
          SpoolView()
        } label: {
          Label("Spools", systemImage: "document")
        }
        Tab(value: .settings, role: .none) {
          SettingsView()
        } label: {
          Label("Settings", systemImage: "gear")
        }
        /*Tab(value: .filaments, role: .none) {
          Text("filament view")
        } label: {
          Label("Filaments", systemImage: "paintbrush.pointed")
        }
        Tab(value: .vendors, role: .none) {
          Text("brand view")
        } label: {
          Label("Brands", systemImage: "person")
        }*/
        
        Tab(value: .search, role: .search) {
          Text("search coming soon")
        } label: {
          Label("Search", systemImage: "magnifyingglass")
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
