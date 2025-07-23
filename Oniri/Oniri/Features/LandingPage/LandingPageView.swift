import SwiftUI

// MARK: - Constellation State Manager (AMÉLIORÉ)
class ConstellationState: ObservableObject {
    @Published var selectedStarId: Int? = nil
    
    func selectStar(_ starId: Int) {
        withAnimation(.easeInOut(duration: 0.3)) {
            selectedStarId = selectedStarId == starId ? nil : starId
        }
    }
    
    func isStarSelected(_ starId: Int) -> Bool {
        return selectedStarId == starId
    }
    
    func deselectAll() {
        withAnimation(.easeInOut(duration: 0.3)) {
            selectedStarId = nil
        }
    }
    
    func hasSelection() -> Bool {
        return selectedStarId != nil
    }
    
    func getSelectedStarId() -> Int? {
        return selectedStarId
    }
    
    func forceSelectStar(_ starId: Int) {
        withAnimation(.easeInOut(duration: 0.3)) {
            selectedStarId = starId
        }
    }
}
//
// MARK: - Data Models
struct Star {
    let id = UUID()
    let x: Double
    let y: Double
    let size: Double
    let opacity: Double
    let twinkleDuration: Double
    let driftSpeed: Double
}

struct ConstellationStar {
    let id: Int
    let x: Double
    let y: Double
    let size: Double
}

// MARK: - Main Landing Page View
struct LandingPageView: View {
    @State private var stars: [Star] = []
    @StateObject private var constellationState = ConstellationState()
    
    // MARK: Constellation en Trapèze (positionnée sur l'océan)
    private let constellationStars: [ConstellationStar] = [
        ConstellationStar(id: 1, x: 0.22, y: 0.7, size: 24),    // Haut gauche
        ConstellationStar(id: 2, x: 0.78, y: 0.7, size: 24),    // Haut droite
        ConstellationStar(id: 3, x: 0.15, y: 0.85, size: 24),   // Bas gauche
        ConstellationStar(id: 4, x: 0.85, y: 0.85, size: 24)    // Bas droite
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // MARK: Ciel Étoilé - Fond Gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color("dream-black"),
                        Color("dream-black").opacity(0.8),
                        Color("dream-black").opacity(0.9)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea(.all)
                
                // MARK: Ciel Étoilé - Étoiles Scintillantes
                ForEach(stars, id: \.id) { star in
                    StarView(star: star, screenSize: geometry.size)
                }
                
                // MARK: Ciel Étoilé - Étoiles Brillantes avec Halo
                ForEach(0..<20, id: \.self) { index in
                    BrightStarView(
                        screenSize: geometry.size,
                        randomSeed: index
                    )
                }
                
                // MARK: Océan - Surface Animée
                OceanView(screenSize: geometry.size)
                
                // MARK: Reflets Constellation sur Océan (PAR-DESSUS OCÉAN)
                ForEach(constellationStars, id: \.id) { star in
                    ConstellationReflectionView(
                        star: star,
                        screenSize: geometry.size
                    )
                }
                
                // MARK: Lignes de Constellation (style astrologique)
                ConstellationLinesView(
                    stars: constellationStars,
                    screenSize: geometry.size
                )
                
                // MARK: Constellation - 4 Étoiles en Trapèze (TOUT AU-DESSUS)
                ForEach(constellationStars, id: \.id) { star in
                    ConstellationStarView(
                        star: star,
                        screenSize: geometry.size,
                        constellationState: constellationState
                    )
                }
                

            
            }
        }
        .onAppear {
            generateStars()
        }
    }
    
    // MARK: - Star Generation
    private func generateStars() {
        var newStars: [Star] = []
        let numberOfStars = 150
        
        for _ in 0..<numberOfStars {
            let star = Star(
                x: Double.random(in: 0...1),
                y: Double.random(in: 0...1),
                size: Double.random(in: 1...4),
                opacity: Double.random(in: 0.2...1.0),
                twinkleDuration: Double.random(in: 2...5),
                driftSpeed: Double.random(in: 10...30)
            )
            newStars.append(star)
        }
        stars = newStars
    }
}

// MARK: - Ciel Étoilé Components

// MARK: Étoile Individuelle
struct StarView: View {
    let star: Star
    let screenSize: CGSize
    @State private var isAnimating = false
    @State private var driftOffset: CGPoint = .zero
    
    var body: some View {
        Circle()
            .fill(Color.white)
            .frame(width: star.size, height: star.size)
            .opacity(isAnimating ? 0.2 : star.opacity)
            .shadow(color: .white.opacity(0.3), radius: star.size)
            .position(
                x: star.x * screenSize.width + driftOffset.x,
                y: star.y * screenSize.height + driftOffset.y
            )
            .onAppear {
                // Animation de scintillement
                withAnimation(
                    .easeInOut(duration: star.twinkleDuration)
                    .repeatForever(autoreverses: true)
                ) {
                    isAnimating.toggle()
                }
                
                // Animation de dérive subtile
                withAnimation(
                    .linear(duration: star.driftSpeed)
                    .repeatForever(autoreverses: true)
                ) {
                    driftOffset = CGPoint(x: 5, y: -3)
                }
            }
    }
}

// MARK: Étoile Brillante avec Halo
struct BrightStarView: View {
    let screenSize: CGSize
    let randomSeed: Int
    @State private var isPulsing = false
    @State private var randomPosition: CGPoint = .zero
    
    var body: some View {
        Circle()
            .fill(Color(.sRGB, red: 0.9, green: 0.95, blue: 1.0))
            .frame(width: 2, height: 2)
            .scaleEffect(isPulsing ? 1.3 : 1.0)
            .opacity(isPulsing ? 1.0 : 0.7)
            .shadow(
                color: Color(.sRGB, red: 0.6, green: 0.8, blue: 1.0),
                radius: 8
            )
            .shadow(
                color: Color(.sRGB, red: 0.6, green: 0.8, blue: 1.0).opacity(0.3),
                radius: 16
            )
            .position(randomPosition)
            .onAppear {
                // Position aléatoire déterministe basée sur randomSeed
                let seedDouble = Double(randomSeed)
                randomPosition = CGPoint(
                    x: (seedDouble * 17.0).truncatingRemainder(dividingBy: 1.0) * screenSize.width,
                    y: ((seedDouble * 23.0).truncatingRemainder(dividingBy: 1.0)) * screenSize.height
                )
                
                // Animation de pulsation
                let duration = 2.0 + (seedDouble * 13.0).truncatingRemainder(dividingBy: 2.0)
                withAnimation(
                    .easeInOut(duration: duration)
                    .repeatForever(autoreverses: true)
                ) {
                    isPulsing.toggle()
                }
            }
    }
}

// MARK: - Constellation Shapes

// MARK: Forme d'Étoile à 4 Branches
struct StarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outerRadius = min(rect.width, rect.height) / 2
        let innerRadius = outerRadius * 0.4
        
        // Créer une étoile à 4 branches
        for i in 0..<8 {
            let angle = (Double(i) * .pi / 4) - .pi / 2 // Commencer en haut
            let radius = i % 2 == 0 ? outerRadius : innerRadius
            
            let x = center.x + cos(angle) * radius
            let y = center.y + sin(angle) * radius
            
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        path.closeSubpath()
        return path
    }
}

// MARK: - Constellation Components

// MARK: Lignes reliant les Étoiles (style astrologique)
struct ConstellationLinesView: View {
    let stars: [ConstellationStar]
    let screenSize: CGSize
    @State private var animationProgress: CGFloat = 0
    
    var body: some View {
        Path { path in
            // Convertir les positions relatives en coordonnées écran
            let positions = stars.map { star in
                CGPoint(
                    x: star.x * screenSize.width,
                    y: star.y * screenSize.height
                )
            }
            
            // Animation séquentielle : 4→1, puis 1→2, puis 1→3
            // Ligne 1 : Étoile 4 → Étoile 1
            path.move(to: positions[3]) // Étoile 4 (index 3)
            path.addLine(to: positions[0]) // Étoile 1 (index 0)
            
            // Ligne 2 : Étoile 1 → Étoile 2
            path.move(to: positions[0]) // Étoile 1
            path.addLine(to: positions[1]) // Étoile 2 (index 1)
            
            // Ligne 3 : Étoile 1 → Étoile 3
            path.move(to: positions[0]) // Étoile 1
            path.addLine(to: positions[2]) // Étoile 3 (index 2)
        }
        .trim(from: 0, to: animationProgress)
        .stroke(
            Color("mid-beige").opacity(0.6),
            style: StrokeStyle(
                lineWidth: 1.5,
                lineCap: .round,
                lineJoin: .round
            )
        )
        .shadow(color: Color("mid-beige").opacity(0.3), radius: 2)
        .onAppear {
            withAnimation(.easeInOut(duration: 3.0)) {
                animationProgress = 1.0
            }
        }
    }
}

// MARK: Étoile de Constellation (4 branches) - MODIFIÉ
struct ConstellationStarView: View {
    let star: ConstellationStar
    let screenSize: CGSize
    @ObservedObject var constellationState: ConstellationState
    @State private var isGlowing = false
    
    // Computed property pour vérifier si cette étoile est sélectionnée
    private var isSelected: Bool {
        constellationState.isStarSelected(star.id)
    }
    
    var body: some View {
        let starColor = Color("mid-beige")
        let starSize = star.size
        let starPosition = CGPoint(
            x: star.x * screenSize.width,
            y: star.y * screenSize.height
        )
        
        Button(action: {
            constellationState.selectStar(star.id)
            print("Étoile \(star.id) tapée - Sélectionnée: \(isSelected)")
        }) {
            StarShape()
                .fill(starColor)
                .stroke(starColor.opacity(0.9), lineWidth: 2)
                .frame(width: starSize, height: starSize)
                .scaleEffect(
                    // Combiner l'effet de glow et de sélection
                    (isGlowing ? 1.1 : 1.0) * (isSelected ? 2.5 : 1.0)
                )
                .opacity(1.0)
                .shadow(color: Color.black.opacity(0.6), radius: 4)
                .shadow(color: starColor.opacity(1.0), radius: isGlowing ? 15 : 10)
                .shadow(color: starColor.opacity(0.8), radius: isGlowing ? 25 : 20)
                // Shadow plus forte si sélectionnée
                .shadow(
                    color: starColor.opacity(isSelected ? 1.0 : 0.0),
                    radius: isSelected ? 40 : 0
                )
        }
        .buttonStyle(PlainButtonStyle())
        .position(starPosition)
        .onAppear {
            // Animation de lueur
            withAnimation(
                .easeInOut(duration: 3.0)
                .repeatForever(autoreverses: true)
            ) {
                isGlowing.toggle()
            }
        }
    }
}

// MARK: Reflet de Constellation sur Océan
struct ConstellationReflectionView: View {
    let star: ConstellationStar
    let screenSize: CGSize
    @State private var waveDistortion: CGFloat = 0
    
    var body: some View {
        let reflectionColor = Color("mid-beige")
        let reflectionSize = star.size * 0.8
        let reflectionPosition = CGPoint(
            x: star.x * screenSize.width,
            y: screenSize.height * 0.75 + (star.y - 0.25) * 100
        )
        
        StarShape()
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [
                        reflectionColor.opacity(0.6),
                        reflectionColor.opacity(0.3),
                        reflectionColor.opacity(0.1)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(width: reflectionSize, height: reflectionSize)
            .scaleEffect(y: -1) // Effet miroir vertical
            .opacity(0.6)
            .offset(x: waveDistortion, y: 0)
            .position(reflectionPosition)
            .onAppear {
                // Animation de distorsion par les vagues
                withAnimation(
                    .easeInOut(duration: 4.0)
                    .repeatForever(autoreverses: true)
                ) {
                    waveDistortion = 8
                }
            }
    }
}

// MARK: - Océan Components

// MARK: Vue Principale Océan
struct OceanView: View {
    let screenSize: CGSize
    @State private var waveOffset: CGFloat = 0
    @State private var waveOffset2: CGFloat = 0
    @State private var waveOffset3: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            ZStack {
                // MARK: Océan - Couche 1 (Vagues Principales)
                WaveShape(offset: waveOffset, amplitude: 20, frequency: 1.5, startHeight: 0)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color("dark-green").opacity(0.9),  // Plus sombre à l'horizon
                                Color("mid-green").opacity(0.7),
                                Color("dark-green").opacity(0.8)   // Plus sombre au premier plan
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                
                // MARK: Océan - Couche 2 (Vagues Subtiles)
                WaveShape(offset: waveOffset2, amplitude: 15, frequency: 2.0, startHeight: 0.04)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color("mid-green").opacity(0.3),   // Plus subtil à l'horizon
                                Color(.sofGreen).opacity(0.4),
                                Color("mid-green").opacity(0.5)    // Plus visible au premier plan
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                
                // MARK: Océan - Couche 3 (Reflets Surface)
                WaveShape(offset: -waveOffset, amplitude: 10, frequency: 3.0, startHeight: 0.08)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(.sofGreen).opacity(0.3),  // Très subtil à l'horizon
                                Color(.sofGreen).opacity(0.5)   // Plus visible au premier plan
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                
                // MARK: Océan - Couche 4 (Grandes Vagues Premier Plan)
                LargeWaveShape(offset: waveOffset3, amplitude: 50, frequency: 1, startHeight: 0.2)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(.sofGreen).opacity(1),  // Visible dès le début
                                Color("mid-green").opacity(0.7),   // Plus fort au milieu
                                Color("dark-green").opacity(0.9)   // Très visible au premier plan
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            }
            .frame(height: screenSize.height / 2)
            // MARK: Transformation 3D pour la perspective
            .rotation3DEffect(
                .degrees(12),
                axis: (x: 1, y: 0, z: 0),
                anchor: .bottom,
                perspective: 0.1
            )
            .clipped()
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .onAppear {
            // MARK: Animations Océan
            withAnimation(
                .linear(duration: 4.0)
                .repeatForever(autoreverses: true)
            ) {
                waveOffset = screenSize.width
            }
            
            withAnimation(
                .linear(duration: 6.0)
                .repeatForever(autoreverses: true)
            ) {
                waveOffset2 = -screenSize.width
            }
            
            withAnimation(
                .easeInOut(duration: 10)
//                grosse vague ta vue l'animation
                .repeatForever(autoreverses: true)
                
            ) {
                waveOffset3 = screenSize.width * 1.5
            }
        }
    }
}

// MARK: Forme des Vagues avec Perspective
struct WaveShape: Shape {
    var offset: CGFloat
    var amplitude: CGFloat
    var frequency: CGFloat
    var startHeight: CGFloat  // Position Y de départ (0.0 = haut, 1.0 = bas)
    
    var animatableData: CGFloat {
        get { offset }
        set { offset = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        let midHeight = height * startHeight  // Position Y personnalisable
        
        path.move(to: CGPoint(x: 0, y: midHeight))
        
        // Créer la courbe de vagues avec perspective graduelle
        for x in stride(from: 0, through: width, by: 1) {
            let relativeX = x / width
            let sine = sin((relativeX * frequency * 2 * .pi) + (offset / width * 2 * .pi))
            
            // MARK: Perspective - Amplitude graduelle selon Y
            // Plus petite à l'horizon (haut), plus grande au premier plan (bas)
            let perspectiveY = (midHeight + sine * amplitude) / height
            let perspectiveAmplitude = amplitude * (0.3 + perspectiveY * 0.7) // Varie de 30% à 100%
            
            let y = midHeight + sine * perspectiveAmplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        // Fermer la forme pour remplir l'océan
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        
        return path
    }
}

// MARK: Grandes Vagues Premier Plan
struct LargeWaveShape: Shape {
    var offset: CGFloat
    var amplitude: CGFloat
    var frequency: CGFloat
    var startHeight: CGFloat  // Position Y de départ (0.0 = haut, 1.0 = bas)
    
    var animatableData: CGFloat {
        get { offset }
        set { offset = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        let midHeight = height * startHeight  // Position Y personnalisable
        
        path.move(to: CGPoint(x: 0, y: midHeight))
        
        // Créer les grandes vagues avec effet dramatique SIMPLIFIÉ
        for x in stride(from: 0, through: width, by: 2) {
            let relativeX = x / width
            let sine = sin((relativeX * frequency * 2 * .pi) + (offset / width * 2 * .pi))
            
            // MARK: Perspective simplifiée - Plus visible dès le début
            let yPosition = (x / width) // Position relative dans l'écran (0 à 1)
            let perspectiveFactor: CGFloat
            
            if yPosition < 0.4 {
                // Premier 40% : petites vagues mais visibles
                perspectiveFactor = 0.3
            } else {
                // 60% restants : croissance forte
                let growthProgress = (yPosition - 0.4) / 0.6 // Normalisé 0 à 1
                perspectiveFactor = 0.3 + growthProgress * 1.2 // De 30% à 150%
            }
            
            let finalAmplitude = amplitude * perspectiveFactor
            let y = midHeight + sine * finalAmplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        // Fermer la forme
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    LandingPageView()
}
