//
//  SpoolView.swift
//  Spoolman
//
//  Created by Henry Krieger on 10.01.26.
//

import SwiftUI
import SwiftData

struct SpoolView: View {
  @Environment(\.modelContext) private var modelContext
  @Query var servers: [Server]
  
  @State private var spools: [Spool] = []
  /*@State private var filaments: [Filament] = []
  @State private var vendors: [Vendor] = []*/
  
  var body: some View {
    let groupedByMaterial = Dictionary(grouping: spools) { $0.filament.material }
    let sections = groupedByMaterial
        .map { (material: $0.key, spools: $0.value) }
        .sorted { $0.material.localizedCaseInsensitiveCompare($1.material) == .orderedAscending }
    
    NavigationView {
      List {
        ForEach(sections, id: \.material) { section in
          Section(header: Text(section.material)) {
            ForEach(section.spools) { spool in
              NavigationLink {
                SpoolDetailView(spool: spool)
              } label: {
                HStack {
                  Circle()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color(hex: spool.filament.colorHex)!)
                    .overlay {
                      Circle()
                        .stroke(.secondary, style: StrokeStyle(lineWidth: 1))
                    }
                    .padding(.trailing, 5)
                  VStack(alignment: .leading) {
                    Text(spool.filament.name)
                      .bold()
                    Text(spool.filament.vendor.name)
                      .foregroundStyle(.secondary)
                      .font(.caption2)
                  }
                }
                .badge(String(format: "%.0f%%", (spool.remainingWeight / spool.initialWeight) * 100))
              }
            }
          }
        }
      }
      .onAppear {
        Task {
          print("fetching data")
          let server = servers.filter({$0.active}).first!
          let url = "\(server.address):\(server.port)/api/v1"
          do {
            spools = try await NetworkManager.shared
              .request(url: URL(string: "\(url)/spool")!, method: .GET)
          } catch {
            print(error.localizedDescription)
          }
          print("data fetched")
        }
      }
      .navigationTitle("Spools")
    }
  }
}

#Preview {
    SpoolView()
}
