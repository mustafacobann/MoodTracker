//
//  LottieView.swift
//  MoodTracker
//
//  Created by Mustafa on 27.07.2023.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let name: String
    let loopMode: LottieLoopMode
    var speed: CGFloat = 1

    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: name)
        animationView.loopMode = loopMode
        animationView.animationSpeed = speed
        animationView.play { isComplete in
            if isComplete {
                animationView.removeFromSuperview()
            }
        }
        return animationView
        
    }
    
    func updateUIView(_ uiView: Lottie.LottieAnimationView, context: Context) {}
}
