//
//  ListSplitText.swift
//  Spoolman
//
//  Created by Henry Krieger on 10.01.26.
//

import SwiftUI

struct ListSplitText: View {
  var title: String
  var value: String
  
  var body: some View {
    HStack {
      Text(title)
      Spacer()
      Text(value)
    }
  }
}
