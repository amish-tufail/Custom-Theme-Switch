//
//  ThemeChangeView.swift
//  CustomThemeSwitch
//
//  Created by Amish Tufail on 02/02/2024.
//

import SwiftUI

struct ThemeChangeView: View {
//    @Environment(\.colorScheme) var scheme // This was causing an issue that this view sheet was not changing theme
    var scheme: ColorScheme // So, created this and passing from other view
    @AppStorage("userTheme") var userTheme: Theme = .systemDefault
    // For Sliding Effect
    @Namespace var animation
    // For Moon Effect
    @State private var circleOffset: CGSize = .zero
    
    // Custom INIT
    // This is for moon effect also but when first intialized
    // We were alreading sending scheme in default init, but in custom we check for dark mode and then set offset for circle
    init(scheme: ColorScheme) {
        self.scheme = scheme
        let isDark = scheme == .dark
        self._circleOffset = .init(initialValue: CGSize(width: isDark ? 30 : 150, height: isDark ? -25 : 150))
    }
    
    var body: some View {
        VStack(spacing: 15.0) {
            Circle()
                .fill(userTheme.color(scheme).gradient)
                .frame(width: 150.0, height: 150.0)
                .mask {
                    Rectangle()
                        .overlay {
                            Circle()
                                .offset(circleOffset)
                                .blendMode(.destinationOut)
                        }
                }
            
            Text("Choose a style.")
                .font(.title2.bold())
                .padding(.top, 25.0)
            
            Text("Pop or subtle, Day or night.\nCustomize your interface.")
                .multilineTextAlignment(.center)
            
            HStack(spacing: 0.0) {
                ForEach(Theme.allCases, id: \.rawValue) { theme in
                    Text(theme.rawValue)
                        .padding(.vertical, 10.0)
                        .frame(width: 100.0)
                        .background {
                            ZStack {
                                if theme == userTheme {
                                    Capsule()
                                        .fill(Color(.BG))
                                        .matchedGeometryEffect(id: "ActiveTab", in: animation)
                                }
                            }
                            .animation(.snappy, value: userTheme)
                        }
                        .contentShape(.rect)
                        .onTapGesture {
                            userTheme = theme
                        }
                }
            }
            .padding(3.0)
            .background(.primary.opacity(0.06), in: .capsule)
            .padding(.top, 20.0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(height: 410.0)
        .background(Color(.BG))
        .clipShape(.rect(cornerRadius: 30.0))
        .padding(.horizontal, 15.0)
        .environment(\.colorScheme, scheme)
        .onChange(of: scheme) { _, newValue in
            let isDark = newValue == .dark
            withAnimation(.bouncy) {
                circleOffset = CGSize(width: isDark ? 30 : 150, height: isDark ? -25 : 150)
            }
        }
    }
}

#Preview {
    ThemeChangeView(scheme: .light)
}

enum Theme: String, CaseIterable {
    case systemDefault = "Default"
    case light = "Light"
    case dark = "Dark"
    
    func color(_ scheme: ColorScheme) -> Color {
        switch self {
        case .systemDefault:
            scheme == .dark ? Color.indigo : Color.orange
        case .light:
            Color.orange
        case .dark:
            Color.indigo
        }
    }
    
    var colorScheme: ColorScheme? {
        switch self {
        case .systemDefault:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
