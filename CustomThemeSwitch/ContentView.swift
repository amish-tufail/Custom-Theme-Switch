//
//  ContentView.swift
//  CustomThemeSwitch
//
//  Created by Amish Tufail on 02/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var changeTheme: Bool = false
    @Environment(\.colorScheme) var scheme
    @AppStorage("userTheme") var userTheme: Theme = .systemDefault
    
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
            .preferredColorScheme(userTheme.colorScheme)
            .navigationTitle("Settings 🎯")
            .sheet(isPresented: $changeTheme, content: {
                ThemeChangeView(scheme: scheme)
                    .presentationDetents([.height(410.0)])
                    .presentationBackground(.clear)
                    .shadow(color: .orange.opacity(0.5), radius: 100, y: 330)
            })
        }
    }
}

#Preview {
    ContentView()
}
