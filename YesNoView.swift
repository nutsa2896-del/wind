import SwiftUI

struct YesNoView: View {
    @State private var result = "Tap to decide"
    @State private var isAnimating = false
    @State private var showResult = false
    @State private var rotationAngle = 0.0
    
    var body: some View {
        ZStack {
            // Background based on state
            if showResult && !isAnimating {
                // Show YES/NO image background
                Image(result == "YES" ? "yes-image" : "no-image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .opacity(showResult ? 1.0 : 0.0)
                    .animation(.easeIn(duration: 0.5), value: showResult)
                
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
            } else {
                // Default lavender background
                Color(red: 0.9, green: 0.9, blue: 1.0)
                    .ignoresSafeArea()
            }
            
            VStack(spacing: showResult ? 10 : 50) {
                if !showResult {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .font(.title)
                        Text("YES / NO")
                            .font(.custom("Clarendon", size: 34))
                            .fontWeight(.bold)
                            .foregroundColor(showResult ? .white : .black)
                            .shadow(radius: showResult ? 5 : 0)
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red)
                            .font(.title)
                    }
                }
                
                Spacer()
                
                VStack(spacing: 10) {
                    Button(action: {
                        showResult = false
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isAnimating = true
                            rotationAngle += 360
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            let isYes = Bool.random()
                            result = isYes ? "YES" : "NO"
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                showResult = true
                                isAnimating = false
                            }
                        }
                    }) {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: showResult ? 
                                            (result == "YES" ? [.green.opacity(0.4), .mint.opacity(0.4)] : [.red.opacity(0.4), .pink.opacity(0.4)]) : 
                                            [.blue.opacity(0.7), .purple.opacity(0.7)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: showResult ? 120 : 180, height: showResult ? 120 : 180)
                                .scaleEffect(isAnimating ? 1.2 : 1.0)
                                .rotationEffect(.degrees(rotationAngle))
                                .shadow(radius: 10)
                            
                            if isAnimating {
                                Image(systemName: "arrow.triangle.2.circlepath")
                                    .font(.system(size: showResult ? 25 : 40))
                                    .foregroundColor(.white)
                                    .rotationEffect(.degrees(rotationAngle * 2))
                            } else {
                                Text(result)
                                    .font(.custom("Clarendon", size: showResult ? 22 : 28))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .opacity(isAnimating ? 0.3 : 1.0)
                                    .scaleEffect(showResult ? 1.0 : 0.8)
                            }
                        }
                    }
                    .disabled(isAnimating)
                    
                    if showResult {
                        Text(result == "YES" ? "This is gonna be legen.. wait for it dary!!!" : "I dont think so !!!")
                            .font(.system(size: 18))
                            .italic()
                            .foregroundColor(.white)
                            .shadow(radius: 3)
                            .opacity(showResult ? 1.0 : 0.0)
                            .animation(.easeIn(duration: 0.3).delay(0.3), value: showResult)
                    }
                }
                .padding(.bottom, 80)
            }
            .padding()
            
            // Big question mark in center (show initially and when not showing result)
            if !showResult {
                Text("?")
                    .font(.system(size: 300))
                    .fontWeight(.bold)
                    .foregroundColor(.black.opacity(0.3))
                    .offset(y: -80)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // Reset state when page appears
            showResult = false
            isAnimating = false
            result = "Tap to decide"
        }
    }
}
