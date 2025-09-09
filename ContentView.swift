import SwiftUI

struct ContentView: View {
    @State private var isAnimating = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                // Dark overlay for better text readability
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    VStack(spacing: 25) {
                        Image("sticker")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .offset(y: 10)
                            .scaleEffect(isAnimating ? 1.2 : 1.0)
                            .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isAnimating)
                        
                        Text("WWND")
                            .font(.custom("Clarendon", size: 34))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                    }
                    
                    VStack(spacing: 25) {
                        NavigationLink(destination: YesNoView()) {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.title2)
                                Text("YES / NO")
                                    .font(.custom("Clarendon", size: 22))
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .frame(width: 220, height: 60)
                            .background(
                                LinearGradient(colors: [.blue.opacity(0.8), .cyan.opacity(0.8)], startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(15)
                            .shadow(radius: 10)
                        }
                        
                        NavigationLink(destination: MultipleOptionsView()) {
                            HStack {
                                Image(systemName: "list.number")
                                    .font(.title2)
                                Text("Multiple Options")
                                    .font(.custom("Clarendon", size: 22))
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .frame(width: 220, height: 60)
                            .background(
                                LinearGradient(colors: [.green.opacity(0.8), .mint.opacity(0.8)], startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(15)
                            .shadow(radius: 10)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .offset(y: -80)
            }
            .navigationBarHidden(true)
            .onAppear {
                isAnimating = true
            }
        }
    }
}
