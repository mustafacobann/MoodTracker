//
//  ColorSelectionScreen.swift
//  MoodTracker
//
//  Created by Mustafa on 3.08.2023.
//

import SwiftUI
import WidgetKit

struct ColorSelectionScreen: View {

    let colors: [Color] = [
        .orange,
        .yellow,
        .green,
        .red,
        .purple,
        .cyan,
        .indigo,
        .mint
    ]

    @AppStorage("appColor") var appColor: Color = .orange    

    var body: some View {
        HStack {
            Spacer()

            ScrollView {
                VStack(spacing: 0) {
                    ForEach(colors, id: \.self) { color in
                        ColorCircle(color: color)
                            .padding(.vertical, 6)
                            .onTapGesture {
                                appColor = color
                                WidgetCenter.shared.reloadAllTimelines()
                            }
                    }
                }
                .padding()
                .background(.thinMaterial)
            }
        }
        .clipped()
    }
}

struct ColorCircle: View {
    let color: Color

    var body: some View {
        color
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }
}

struct ColorSelectionScreen_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelectionScreen()
    }
}
