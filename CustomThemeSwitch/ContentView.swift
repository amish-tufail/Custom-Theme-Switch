//
//  ContentView.swift
//  CustomThemeSwitch
//
//  Created by Amish Tufail on 02/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var changeTheme: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Appearance") {
                    Button {
                        changeTheme.toggle()
                    } label: {
                        Text("Change Theme")
                    }
                }
                
            }
            .navigationTitle("Settings 🎯")
            .sheet(isPresented: $changeTheme, content: {
                ThemeChangeView()
                    .presentationDetents([.height(410.0)])
                    .presentationBackground(.clear)
            })
        }
    }
}

#Preview {
    ContentView()
}
