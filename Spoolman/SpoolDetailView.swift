//
//  SpoolDetailView.swift
//  Spoolman
//
//  Created by Henry Krieger on 10.01.26.
//

import SwiftUI

struct SpoolDetailView: View {
  let spool: Spool
  
  func dateToString(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy HH:mm"
    return formatter.string(from: date)
  }
  
  var body: some View {
    List {
      Section {
        HStack {
          Circle()
            .frame(width: 50, height: 50)
            .foregroundStyle(Color(hex: spool.filament.colorHex)!)
            .overlay {
              Circle()
                .stroke(.secondary, style: StrokeStyle(lineWidth: 1))
            }
            .padding(.trailing, 5)
          VStack(alignment: .leading) {
            Text(spool.filament.name)
              .bold()
              .font(.title)
            Text(spool.filament.vendor.name)
              .foregroundStyle(.secondary)
              .font(.caption)
          }
        }
      }
      
      Section(header: Text("Weight")) {
        VStack(alignment: .leading) {
          HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 6) {
              Text("REMAINING")
                .font(.caption.weight(.semibold))
                .foregroundColor(.gray)
                .textCase(.uppercase)
              
              Text("\(String(format: "%.0f%", spool.remainingWeight))g")
                .font(.largeTitle.weight(.bold))
            }
            
            Spacer()
            
            Text("\(String(format: "%.0f%%", (spool.remainingWeight / spool.initialWeight) * 100))")
              .font(.headline.weight(.semibold))
              .padding(.horizontal, 14)
              .padding(.vertical, 8)
              .foregroundStyle(.green.opacity(0.8))
              .background(
                RoundedRectangle(cornerRadius: 20)
                  .fill(.green.opacity(0.1)) // hellgrüner Hintergrund
              )
          }
          
          ProgressView(value: (spool.remainingWeight / spool.initialWeight))
            .accentColor(.green)
            .scaleEffect(x: 1, y: 2, anchor: .center)
            .tint(.green)
            .padding(.bottom, 10)
          
          HStack(spacing: 12) {
            smallInfoCard(title: "USED", value: String(format: "%.0f%", spool.usedWeight), leadingIcon: "minus.circle.fill", iconColor: .gray)
            smallInfoCard(title: "TOTAL", value: String(format: "%.0f%", spool.initialWeight), leadingIcon: "circle.fill", iconColor: .gray)
          }
          
          HStack {
            Label("Empty spool", systemImage: "scalemass")
              .foregroundStyle(.secondary)
              .font(.subheadline)
            
            Spacer()
            
            Text("\(String(format: "%.0f%", spool.filament.spoolWeight))g")
              .font(.subheadline.weight(.semibold))
          }.padding(.top, 10)
        }
      }
      
      Section(header: Text("Information")) {
        ListSplitText(title: "Brand", value: spool.filament.vendor.name)
        ListSplitText(title: "Registered", value: dateToString(date: spool.registered))
        ListSplitText(title: "First use", value: spool.firstUsed != nil ? dateToString(date: spool.firstUsed!) : "-")
        ListSplitText(title: "Last use", value: spool.lastUsed != nil ? dateToString(date: spool.lastUsed!) : "-")
        ListSplitText(title: "Location", value: spool.location)
        ListSplitText(title: "Price", value: "\(spool.price.formatted())€")
        ListSplitText(title: "Diameter", value: "\(spool.filament.diameter.formatted())mm")
        ListSplitText(title: "Density", value: "\(spool.filament.density.formatted())g/cm^3")
      }
    }
    .navigationTitle("Spool details")
    .navigationBarTitleDisplayMode(.inline)
  }
  
  @ViewBuilder
  private func smallInfoCard(title: String, value: String, leadingIcon: String, iconColor: Color) -> some View {
    HStack {
      Image(systemName: leadingIcon)
        .font(.system(size: 18))
        .foregroundStyle(iconColor)
      
      VStack(alignment: .leading) {
        Text(title)
          .font(.caption.weight(.semibold))
          .foregroundStyle(.secondary)
          .textCase(.uppercase)
        Text(value)
          .font(.title3.weight(.bold))
      }
      
      Spacer()
    }
    .padding()
    .frame(maxWidth: .infinity)
    .background(
      RoundedRectangle(cornerRadius: 12)
        .fill(Color(.systemGray6))
    )
  }
}

#Preview {
  SpoolDetailView(
    spool: Spool(
      id: 0,
      registered: Date(),
      firstUsed: Date(),
      lastUsed: Date(),
      filament: Filament(
        id: 0,
        registered: Date(),
        name: "",
        vendor: Vendor(id: 0, registered: Date(), name: "", emptySpoolWeight: 0.0, extra: [:]),
        material: "",
        price: 0.0,
        density: 0.0,
        diameter: 0.0,
        weight: 0.0,
        spoolWeight: 0.0,
        settingsExtruderTemp: 220,
        settingsBedTemp: 60,
        colorHex: "ffffff",
        extra: [:]
      ),
      price: 9.99,
      remainingWeight: 600.0,
      initialWeight: 1000.0,
      spoolWeight: 250.0,
      usedWeight: 400.0,
      remainingLength: 0.0,
      usedLength: 0.0,
      location: "",
      archived: false,
      extra: [:]
    )
  )
}
