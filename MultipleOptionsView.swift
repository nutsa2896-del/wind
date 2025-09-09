import SwiftUI

struct Heart: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: width * 0.5, y: height * 0.9))
        
        path.addCurve(to: CGPoint(x: width * 0.1, y: height * 0.3),
                      control1: CGPoint(x: width * 0.5, y: height * 0.7),
                      control2: CGPoint(x: width * 0.1, y: height * 0.5))
        
        path.addArc(center: CGPoint(x: width * 0.25, y: height * 0.25),
                    radius: width * 0.15,
                    startAngle: Angle(degrees: 180),
                    endAngle: Angle(degrees: 0),
                    clockwise: false)
        
        path.addArc(center: CGPoint(x: width * 0.75, y: height * 0.25),
                    radius: width * 0.15,
                    startAngle: Angle(degrees: 180),
                    endAngle: Angle(degrees: 0),
                    clockwise: false)
        
        path.addCurve(to: CGPoint(x: width * 0.5, y: height * 0.9),
                      control1: CGPoint(x: width * 0.9, y: height * 0.5),
                      control2: CGPoint(x: width * 0.5, y: height * 0.7))
        
        return path
    }
}

struct MultipleOptionsView: View {
    @State private var selectedCount = 2
    @State private var result = "Tap to choose"
    @State private var isAnimating = false
    @State private var showResult = false
    @State private var rotationAngle = 0.0
    @State private var showNumberSelection = true
    
    var body: some View {
        ZStack {
            // Background based on result
            if showResult && !isAnimating {
                Image("option\(result)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .opacity(showResult ? 1.0 : 0.0)
                    .animation(.easeIn(duration: 0.5), value: showResult)
                
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
            } else {
                // Light blue background
                Color(red: 0.8, green: 0.9, blue: 1.0)
                    .ignoresSafeArea()
            }
            
            if showNumberSelection {
                VStack(spacing: 30) {
                    Text("Choose number of options")
                        .font(.custom("Papyrus", size: 32))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    // Full screen grid of numbers
                    VStack(spacing: 40) {
                        // First row: 2 and 3
                        HStack(spacing: 40) {
                            ForEach(2...3, id: \.self) { number in
                                Button(action: {
                                    selectedCount = number
                                    showNumberSelection = false
                                }) {
                                    Text("\(number)")
                                        .font(.custom("Clarendon", size: 50))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .frame(width: 130, height: 130)
                                        .background(
                                            LinearGradient(
                                                colors: [.pink.opacity(0.3), .purple],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .clipShape(Heart())
                                        .shadow(radius: 10)
                                }
                            }
                        }
                        
                        // Second row: 4 and 5
                        HStack(spacing: 40) {
                            ForEach(4...5, id: \.self) { number in
                                Button(action: {
                                    selectedCount = number
                                    showNumberSelection = false
                                }) {
                                    Text("\(number)")
                                        .font(.custom("Clarendon", size: 50))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .frame(width: 130, height: 130)
                                        .background(
                                            LinearGradient(
                                                colors: [.pink.opacity(0.3), .purple],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .clipShape(Heart())
                                        .shadow(radius: 10)
                                }
                            }
                        }
                        
                        // Third row: 6 centered
                        Button(action: {
                            selectedCount = 6
                            showNumberSelection = false
                        }) {
                            Text("6")
                                .font(.custom("Clarendon", size: 50))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: 130, height: 130)
                                .background(
                                    LinearGradient(
                                        colors: [.pink.opacity(0.3), .purple],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .clipShape(Heart())
                                .shadow(radius: 10)
                        }
                    }
                    .padding(.horizontal, 30)
                }
            } else {
                VStack(spacing: 30) {
                    Text("Options: 1 to \(selectedCount)")
                        .font(.custom("Clarendon", size: 22))
                        .fontWeight(.semibold)
                        .foregroundColor(showResult ? .white : .black)
                        .shadow(radius: showResult ? 5 : 0)
                    
                    Spacer()
                    
                    Button(action: {
                        showResult = false
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isAnimating = true
                            rotationAngle += 360
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            let randomNumber = Int.random(in: 1...selectedCount)
                            result = "\(randomNumber)"
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                                showResult = true
                                isAnimating = false
                            }
                        }
                    }) {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [.blue.opacity(0.4), .cyan.opacity(0.4)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 150, height: 150)
                                .scaleEffect(isAnimating ? 1.2 : 1.0)
                                .rotationEffect(.degrees(rotationAngle))
                                .shadow(radius: 10)
                            
                            if isAnimating {
                                VStack {
                                    Image(systemName: "arrow.triangle.2.circlepath")
                                        .font(.system(size: 30))
                                        .foregroundColor(.white)
                                        .rotationEffect(.degrees(rotationAngle * 2))
                                    
                                    Text("Choosing...")
                                        .font(.system(size: 14))
                                        .italic()
                                        .foregroundColor(.white.opacity(0.8))
                                }
                            } else {
                                Text(result)
                                    .font(.custom("Clarendon", size: 24))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .opacity(isAnimating ? 0.3 : 1.0)
                                    .scaleEffect(showResult ? 1.0 : 0.8)
                            }
                        }
                    }
                    .disabled(isAnimating)
                    
                    Button(action: {
                        showNumberSelection = true
                        showResult = false
                        result = "Tap to choose"
                    }) {
                        Text("Choose Different Number")
                            .font(.system(size: 16))
                            .italic()
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 50)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
