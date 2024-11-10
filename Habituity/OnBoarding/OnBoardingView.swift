//
//  OnBoardingView.swift
//  Habituity
//
//  Created by Luis Cardenas on 11/10/24.
//

import Foundation
import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    
    // Onboarding data
    let onboardingData = [
        OnboardingPage(
            title: "Welcome to Habituity",
            description: "Discover your potential today!",
            imageName: "star"
        ),
        OnboardingPage(
            title: "Stay Organized",
            description: "Organize your tasks efficiently with our powerful tools.",
            imageName: "calendar"
        ),
        OnboardingPage(
            title: "Get Started",
            description: "Let’s set up your account to begin the journey!",
            imageName: "gear"
        )
    ]
    
    var body: some View {
        VStack {
            // TabView without PageTabViewStyle (not available on macOS)
            TabView(selection: $currentPage) {
                ForEach(0..<onboardingData.count, id: \.self) { index in
                    OnboardingPageView(page: onboardingData[index])
                        .tag(index)
                }
            }
            .frame(height: 300)
            
            // Navigation buttons for macOS
            HStack {
                if currentPage > 0 {
                    Button("Previous") {
                        currentPage -= 1
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
                
                Button(currentPage < onboardingData.count - 1 ? "Next" : "Get Started") {
                    if currentPage < onboardingData.count - 1 {
                        currentPage += 1
                    } else {
                        print("Onboarding complete!")
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding()
    }
}

struct OnboardingPage {
    let title: String
    let description: String
    let imageName: String
}

struct OnboardingPageView: View {
    var page: OnboardingPage
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: page.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            
            Text(page.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text(page.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
