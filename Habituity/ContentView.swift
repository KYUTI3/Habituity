//
//  ContentView.swift
//  Habituity
//
//  Created by Luis Cardenas on 11/09/24.
//

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                
                Spacer()
                
                Text("Welcome to Habituity")
                    .font(.largeTitle)
                
                Spacer()
                
                Text("Let's get started")
                    .font(.title2)
                
                Spacer()
                
                NavigationLink(destination: OnboardingView()) {
                    Text("Start Onboarding")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
