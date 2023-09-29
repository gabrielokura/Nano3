//
//  ContentView.swift
//  MyCollection
//
//  Created by Gabriel Motelevicz Okura on 26/09/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var collectionViewModel = CollectionViewModel()
    @StateObject var dresserViewModel = DresserViewModel()
    
    var body: some View {
        NavigationStack {
            DresserView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(collectionViewModel)
        .environmentObject(dresserViewModel)
    }
}

#Preview {
    ContentView()
}
