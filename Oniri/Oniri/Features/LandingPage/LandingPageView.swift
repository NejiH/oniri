import SwiftUI
import AVFoundation

// MARK: - Constellation State Manager (inchangé)
class ConstellationState: ObservableObject {
    @Published var selectedStarId: Int? = nil
    @Published var isTransitioning: Bool = false
    
    func selectStar(_ starId: Int) {
        let newStarId = selectedStarId == starId ? nil : starId
        
        if (selectedStarId == nil) != (newStarId == nil) {
            self.isTransitioning = true
            
            withAnimation(.easeInOut(duration: 0.3)) {
                selectedStarId = newStarId
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                self.isTransitioning = false
            }
        } else {
            withAnimation(.easeInOut(duration: 0.3)) {
                selectedStarId = newStarId
            }
        }
    }
    
    func isStarSelected(_ starId: Int) -> Bool {
        return selectedStarId == starId
    }
}

// MARK: - Data Models (inchangés)
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
    let name: String
}

// MARK: - Main Landing Page View (MODIFIÉE - SOLUTION 1)
struct LandingPageView: View {
    @State private var stars: [Star] = []
    @StateObject private var constellationState = ConstellationState()
    @State private var showCardCollection = false
    @State var collectionVM = LandingPageViewModel()
    @State private var musicLandingPage: AVAudioPlayer?
    
    @State private var animationsReady = false
    
    // MARK: Constellation en Trapèze
    private let constellationStars: [ConstellationStar] = [
        ConstellationStar(id: 1, x: 0.22, y: 0.7, size: 24, name: "Les Brèches\nd'Élior"),
        ConstellationStar(id: 2, x: 0.78, y: 0.7, size: 24, name: "L'Exploratrice des Brumes"),
        ConstellationStar(id: 3, x: 0.27, y: 0.90, size: 24, name: "Entre Silence et Tempete"),
        ConstellationStar(id: 4, x: 0.85, y: 0.85, size: 24, name: "Au Bord du Réveil")
    ]
    
    var body: some View {
        NavigationStack {
            if !collectionVM.isCollection {
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
                            StarViewDelayed(star: star, screenSize: geometry.size, animationsReady: animationsReady)
                        }
                        
                        // MARK: Ciel Étoilé - Étoiles Brillantes avec Halo
                        ForEach(0..<20, id: \.self) { index in
                            BrightStarViewDelayed(
                                screenSize: geometry.size,
                                randomSeed: index,
                                animationsReady: animationsReady
                            )
                        }
                        
                        // MARK: Océan - Surface Animée
                        OceanViewDelayed(screenSize: geometry.size, animationsReady: animationsReady)
                        
                        // MARK: Reflets Constellation sur Océan
                        ForEach(constellationStars, id: \.id) { star in
                            ConstellationReflectionViewDelayed(
                                star: star,
                                screenSize: geometry.size,
                                animationsReady: animationsReady
                            )
                        }
                        
                        // MARK: Lignes de Constellation
                        ConstellationLinesViewDelayed(
                            stars: constellationStars,
                            screenSize: geometry.size,
                            animationsReady: animationsReady,
                            constellationState: constellationState
                        )
                        
                        // MARK: Constellation - 4 Étoiles en Trapèze
                        ForEach(constellationStars, id: \.id) { star in
                            ConstellationStarViewDelayed(
                                star: star,
                                screenSize: geometry.size,
                                constellationState: constellationState,
                                animationsReady: animationsReady
                            )
                        }
                        
                        // MARK: Portail - États Inactif/Actif/Transition
                        if constellationState.isTransitioning {
                            TransitionPortalView(
                                screenSize: geometry.size,
                                fromInactive: constellationState.selectedStarId != nil
                            )
                            .environmentObject(constellationState)
                        } else if constellationState.selectedStarId == nil {
                            InactivePortalViewDelayed(screenSize: geometry.size, animationsReady: animationsReady)
                        } else {
                            ActivePortalViewDelayed(screenSize: geometry.size, animationsReady: animationsReady)
                                .environmentObject(constellationState)
                        }
                        
                        // MARK: Bouton Circle superposé sur le portail actif
                        if !constellationState.isTransitioning && constellationState.selectedStarId != nil {
                            NavigationLink(destination: {
                                DreamLaunchView(successVM: successVM)
                            }) {
                                Circle()
                                    .fill(Color.clear)
                                    .frame(width: 370, height: 370)
                            }
                            .simultaneousGesture(TapGesture().onEnded({
                                musicLandingPage?.stop()
                            }))
                            .position(
                                x: geometry.size.width / 2,
                                y: geometry.size.height * 0.3
                            )
                        }
                        
                        // MARK: Bouton Collection (Haut Droite)
                        Button {
                            collectionVM.goCollection()
                            print(collectionVM.goCollection())
                        } label: {
                            Image("bouton-collection")
                                .resizable()
                                .frame(width: 44, height: 44)
                        }
                        .offset(x: 170, y: -360)
                    }
                }
                .onAppear {
                    print("LandingPageView onAppear - Début setup")
                    setupLandingPageWithDelay()
                }
                .sheet(isPresented: $showCardCollection) {
                    CardCollectionView()
                }
            } else {
                CardCollectionView()
            }
        }
    }
    
    // Setup avec délai pour NavigationStack
    private func setupLandingPageWithDelay() {
        // Setup immédiat (non bloquant)
        generateStars()
        setupMusic()
        
        // Délai pour laisser NavigationStack se stabiliser avant les animations
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            print(" Déclenchement des animations après délai NavigationStack")
            animationsReady = true
        }
    }
    
    // MARK: - Star Generation (inchangée)
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
        print("⭐ Étoiles générées: \(numberOfStars)")
    }
    
    // MARK: - Music Setup (inchangée)
    private func setupMusic() {
        guard let url = Bundle.main.url(forResource: "SoundPortal", withExtension: "mp3") else {
            print("Fichier audio introuvable.")
            return
        }

        do {
            musicLandingPage = try AVAudioPlayer(contentsOf: url)
            musicLandingPage?.play()
            print("Musique lancée")
        } catch {
            print("Impossible de lire le fichier audio")
        }
    }
}

// MARK: - VERSIONS DÉLAYÉES DES COMPOSANTS (inchangées)

// MARK: Étoile Individuelle (VERSION DÉLAYÉE)
struct StarViewDelayed: View {
    let star: Star
    let screenSize: CGSize
    let animationsReady: Bool
    
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
            .onChange(of: animationsReady) { ready in
                if ready {
                    // Délai aléatoire pour éviter que toutes les étoiles s'animent en même temps
                    let randomDelay = Double.random(in: 0...1.0)
                    DispatchQueue.main.asyncAfter(deadline: .now() + randomDelay) {
                        print("⭐ Animation étoile démarrée avec délai \(randomDelay)s")
                        startStarAnimations()
                    }
                }
            }
    }
    
    private func startStarAnimations() {
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

// MARK: Étoile Brillante avec Halo (VERSION DÉLAYÉE)
struct BrightStarViewDelayed: View {
    let screenSize: CGSize
    let randomSeed: Int
    let animationsReady: Bool
    
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
            .onChange(of: animationsReady) { ready in
                if ready {
                    let delay = Double(randomSeed) * 0.1
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        startBrightStarAnimations()
                    }
                }
            }
    }
    
    private func startBrightStarAnimations() {
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
        print("Étoile brillante \(randomSeed) animée")
    }
}

// MARK: Océan (VERSION DÉLAYÉE)
struct OceanViewDelayed: View {
    let screenSize: CGSize
    let animationsReady: Bool
    
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
                                Color("dark-green").opacity(0.9),
                                Color("mid-green").opacity(0.7),
                                Color("dark-green").opacity(0.8)
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
                                Color("mid-green").opacity(0.3),
                                Color(.sofGreen).opacity(0.4),
                                Color("mid-green").opacity(0.5)
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
                                Color(.sofGreen).opacity(0.3),
                                Color(.sofGreen).opacity(0.5)
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
                                Color(.sofGreen).opacity(1),
                                Color("mid-green").opacity(0.7),
                                Color("dark-green").opacity(0.9)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            }
            .frame(height: screenSize.height / 2)
            .rotation3DEffect(
                .degrees(12),
                axis: (x: 1, y: 0, z: 0),
                anchor: .bottom,
                perspective: 0.1
            )
            .clipped()
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .onChange(of: animationsReady) { ready in
            if ready {
                // Délai spécifique pour l'océan
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    print("🌊 Animations océan démarrées")
                    startOceanAnimations()
                }
            }
        }
    }
    
    private func startOceanAnimations() {
        // MARK: Animations Océan (identiques à l'original)
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
            .repeatForever(autoreverses: true)
        ) {
            waveOffset3 = screenSize.width * 1.5
        }
    }
}

// MARK: Reflet de Constellation sur Océan (VERSION DÉLAYÉE)
struct ConstellationReflectionViewDelayed: View {
    let star: ConstellationStar
    let screenSize: CGSize
    let animationsReady: Bool
    
    @State private var waveDistortion: CGFloat = 0
    
    var body: some View {
        let reflectionColor = Color("soft-beige")
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
            .scaleEffect(y: -1)
            .opacity(0.6)
            .offset(x: waveDistortion, y: 0)
            .position(reflectionPosition)
            .onChange(of: animationsReady) { ready in
                if ready {
                    let delay = Double(star.id) * 0.2
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        startReflectionAnimation()
                    }
                }
            }
    }
    
    private func startReflectionAnimation() {
        withAnimation(
            .easeInOut(duration: 4.0)
            .repeatForever(autoreverses: true)
        ) {
            waveDistortion = 8
        }
        print("💧 Reflet constellation \(star.id) animé")
    }
}

// MARK: Lignes de Constellation (VERSION DÉLAYÉE)
struct ConstellationLinesViewDelayed: View {
    let stars: [ConstellationStar]
    let screenSize: CGSize
    let animationsReady: Bool
    @ObservedObject var constellationState: ConstellationState
    
    @State private var animationProgress: CGFloat = 0
    
    var body: some View {
        Path { path in
            let positions = stars.map { star in
                let basePosition = CGPoint(
                    x: star.x * screenSize.width,
                    y: star.y * screenSize.height
                )
                
                let isSelected = constellationState.isStarSelected(star.id)
                let textHeight: CGFloat = 30 // Hauteur approximative du texte (2 lignes)
                let spacing: CGFloat = isSelected ? 20 : 8 // Spacing du VStack selon l'état
                let starCenterOffset: CGFloat = -(textHeight + spacing) / 2
                
                return CGPoint(
                    x: basePosition.x,
                    y: basePosition.y + starCenterOffset
                )
            }
            
            // Ligne 1 : Étoile 4 → Étoile 1
            path.move(to: positions[3])
            path.addLine(to: positions[0])
            
            // Ligne 2 : Étoile 1 → Étoile 2
            path.move(to: positions[0])
            path.addLine(to: positions[1])
            
            // Ligne 3 : Étoile 1 → Étoile 3
            path.move(to: positions[0])
            path.addLine(to: positions[2])
        }
        .trim(from: 0, to: animationProgress)
        .stroke(
            Color("soft-beige").opacity(1),
            style: StrokeStyle(
                lineWidth: 1.5,
                lineCap: .round,
                lineJoin: .round
            )
        )
        .shadow(color: Color("soft-beige").opacity(0.3), radius: 2)
        .onChange(of: animationsReady) { ready in
            if ready {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    print("Lignes constellation animées (centrées sur étoiles)")
                    startLinesAnimation()
                }
            }
        }
    }
    
    private func startLinesAnimation() {
        withAnimation(.easeInOut(duration: 3.0)) {
            animationProgress = 1.0
        }
    }
}

// MARK: Étoile de Constellation (VERSION DÉLAYÉE)
struct ConstellationStarViewDelayed: View {
    let star: ConstellationStar
    let screenSize: CGSize
    @ObservedObject var constellationState: ConstellationState
    let animationsReady: Bool
    
    @State private var isGlowing = false
    @State private var isPulsing = false
    @State private var pulseOpacity: Double = 1.0
    @State private var pulseScale: CGFloat = 1.0
    
    private var isSelected: Bool {
        constellationState.isStarSelected(star.id)
    }
    
    var body: some View {
        let starColor = Color("soft-beige")
        let starSize = star.size
        let starPosition = CGPoint(
            x: star.x * screenSize.width,
            y: star.y * screenSize.height
        )
        
        Button(action: {
            print("Étoile \(star.id) cliquée!")
            constellationState.selectStar(star.id)
            print("selectedStarId après clic: \(constellationState.selectedStarId)")
        }) {
            VStack(spacing: isSelected ? 20 : 8) {
                StarShape()
                    .fill(starColor)
                    .stroke(starColor.opacity(0.9), lineWidth: 2)
                    .frame(width: starSize, height: starSize)
                    .scaleEffect(
                        (isGlowing ? 1.1 : 1.0) * (isSelected ? 1.6 : 1.0) * pulseScale
                    )
                    .opacity(isSelected ? 1.0 : pulseOpacity)
                    .shadow(color: Color.black.opacity(0.6), radius: 4)
                    .shadow(color: starColor.opacity(1.0), radius: isGlowing ? 15 : 10)
                    .shadow(color: starColor.opacity(0.8), radius: isGlowing ? 25 : 20)
                    .shadow(
                        color: starColor.opacity(isSelected ? 1.0 : 0.0),
                        radius: isSelected ? 40 : 0
                    )
                    .shadow(
                        color: starColor.opacity(isSelected ? 0.0 : (isPulsing ? 0.6 : 0.3)),
                        radius: isSelected ? 0 : (isPulsing ? 12 : 6)
                    )
                
                Text(star.name)
                    .font(.custom("DelaGothicOne-Regular", size: isSelected ? 16 : 14))
                    .frame(width: 140)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .foregroundColor(starColor)
                    .minimumScaleFactor(0.2)
                    .truncationMode(.tail)
                    .fixedSize(horizontal: false, vertical: true)
                    .opacity(isSelected ? 1.0 : (pulseOpacity * 0.9))
                    .scaleEffect(isSelected ? 1.2 : (1.0 * pulseScale))
                    .shadow(color: Color.black.opacity(0.8), radius: 2)
                    .shadow(color: starColor.opacity(0.3), radius: isSelected ? 8 : 4)
                    .animation(.easeInOut(duration: 0.3), value: isSelected)
                    .offset(y: isSelected ? 15 : 0)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .position(starPosition)
        .onChange(of: animationsReady) { ready in
            if ready {
                let starDelay = Double(star.id) * 0.3
                DispatchQueue.main.asyncAfter(deadline: .now() + starDelay) {
                    print("Constellation étoile \(star.id) animée")
                    startConstellationStarAnimations()
                }
            }
        }
    }
    
    private func startConstellationStarAnimations() {
        // Animation de lueur
        withAnimation(
            .easeInOut(duration: 3.0)
            .repeatForever(autoreverses: true)
        ) {
            isGlowing.toggle()
        }
        
        // Animation de pulsation avec timing unique par étoile
        let pulseDuration = 2.5 + Double(star.id) * 0.3
        let pulseDelay = Double(star.id) * 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + pulseDelay) {
            withAnimation(
                .easeInOut(duration: pulseDuration)
                .repeatForever(autoreverses: true)
            ) {
                isPulsing.toggle()
                pulseOpacity = 0.7
                pulseScale = 1.05
            }
        }
    }
}

// MARK: Portail Inactif (VERSION DÉLAYÉE)
struct InactivePortalViewDelayed: View {
    let screenSize: CGSize
    let animationsReady: Bool
    
    @State private var breathingScale: CGFloat = 1.0
    @State private var breathingOpacity: Double = 0.7
    @State private var undulationRotation: Double = 0
    @State private var verticalFloat: CGFloat = 0
    @State private var glowIntensity: Double = 0.4
    
    var body: some View {
        Image("icon-portal")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 370, height: 370)
            .scaleEffect(breathingScale)
            .opacity(breathingOpacity)
            .rotationEffect(.degrees(undulationRotation))
            .offset(y: verticalFloat)
            .shadow(color: Color("soft-beige").opacity(glowIntensity), radius: 20)
            .shadow(color: Color("soft-beige").opacity(glowIntensity * 0.7), radius: 25)
            .position(
                x: screenSize.width / 2,
                y: screenSize.height * 0.3
            )
            .transition(.opacity.combined(with: .scale))
            .onChange(of: animationsReady) { ready in
                if ready {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        print("Portail inactif animé")
                        startPortalAnimations()
                    }
                }
            }
    }
    
    private func startPortalAnimations() {
        // Animation de respiration principale (4 secondes)
        withAnimation(
            .easeInOut(duration: 4)
            .repeatForever(autoreverses: true)
        ) {
            breathingScale = 1.09
            breathingOpacity = 0.9
            glowIntensity = 0.6
        }
        
        // Animation d'ondulation rotation (7 secondes)
        withAnimation(
            .easeInOut(duration: 7.0)
            .repeatForever(autoreverses: true)
        ) {
            undulationRotation = 2.0
        }
        
        // Animation de flottement vertical (5 secondes)
        withAnimation(
            .easeInOut(duration: 5.0)
            .repeatForever(autoreverses: true)
        ) {
            verticalFloat = -3
        }
    }
}

// MARK: Portail Actif (VERSION DÉLAYÉE)
struct ActivePortalViewDelayed: View {
    let screenSize: CGSize
    let animationsReady: Bool
    
    @State private var heartbeatScale: CGFloat = 1.0
    @State private var glowIntensity: Double = 0.8
    @State private var particleBurstTrigger: Int = 0
    @State private var distortionRotation: Double = 0
    @State private var distortionOffset: CGPoint = .zero
    @State private var distortionScaleX: CGFloat = 1.0
    @State private var currentGlowColorIndex: Int = 0
    @State private var hasStartedAnimations = false
    
    @EnvironmentObject var constellationState: ConstellationState
    
    private var portalAsset: String {
        switch constellationState.selectedStarId {
        case 1: return "Vortex-1"
        case 2: return "Vortex-2"
        case 3: return "Vortex-3"
        case 4: return "Vortex"
        default: return "icon-portal"
        }
    }
    
    private var glowColors: [Color] {
        [
            Color("sof-green"),
            Color("soft-pink"),
            Color("soft-beige")
        ]
    }
    
    private var currentGlowColor: Color {
        glowColors[currentGlowColorIndex]
    }
    
    var body: some View {
        ZStack {
            Image(portalAsset)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 370, height: 370)
                .scaleEffect(x: heartbeatScale * distortionScaleX, y: heartbeatScale)
                .rotationEffect(.degrees(distortionRotation))
                .offset(x: distortionOffset.x, y: distortionOffset.y)
                .shadow(color: currentGlowColor.opacity(glowIntensity), radius: 10)
                .shadow(color: currentGlowColor.opacity(glowIntensity * 0.9), radius: 15)
                .shadow(color: currentGlowColor.opacity(glowIntensity * 0.7), radius: 20)
            
            ForEach(0..<20, id: \.self) { index in
                HeartbeatParticleView(
                    index: index,
                    burstTrigger: particleBurstTrigger,
                    colors: [
                        Color("sof-green").opacity(1),
                        Color("soft-beige").opacity(1),
                        Color("soft-pink").opacity(1)
                    ]
                )
            }
        }
        .position(
            x: screenSize.width / 2,
            y: screenSize.height * 0.3
        )
        .transition(.scale.combined(with: .opacity))
        .onAppear {
            print("ActivePortalViewDelayed onAppear - animationsReady: \(animationsReady)")
            checkAndStartAnimations()
        }
        .onChange(of: animationsReady) { ready in
            print("ActivePortalViewDelayed onChange - animationsReady: \(ready)")
            checkAndStartAnimations()
        }
    }
    
    // Vérifie et lance les animations si prêt
    private func checkAndStartAnimations() {
        guard animationsReady && !hasStartedAnimations else {
            print("Conditions non remplies - animationsReady: \(animationsReady), hasStartedAnimations: \(hasStartedAnimations)")
            return
        }
        
        hasStartedAnimations = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            print("Portail actif - battement de cœur démarré")
            startHeartbeatAnimation()
        }
    }
    
    private func startHeartbeatAnimation() {
        performDoubleHeartbeat()
    }
    
    private func performDoubleHeartbeat() {
        // Premier battement (ba)
        withAnimation(.easeInOut(duration: 0.15)) {
            heartbeatScale = 1.06
            glowIntensity = 1.2
            distortionRotation = 0.8
            distortionOffset = CGPoint(x: 1, y: -0.5)
            distortionScaleX = 1.02
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            withAnimation(.easeInOut(duration: 0.15)) {
                heartbeatScale = 1.0
                glowIntensity = 0.8
                distortionRotation = 0
                distortionOffset = .zero
                distortionScaleX = 1.0
            }
        }
        
        // Second battement plus fort (boum)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation(.easeInOut(duration: 0.2)) {
                heartbeatScale = 1.1
                glowIntensity = 1.5
                particleBurstTrigger += 1
                distortionRotation = -1.2
                distortionOffset = CGPoint(x: -1.5, y: 1)
                distortionScaleX = 0.98
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.easeInOut(duration: 0.2)) {
                    heartbeatScale = 1.0
                    glowIntensity = 0.8
                    distortionRotation = 0
                    distortionOffset = .zero
                    distortionScaleX = 1.0
                }
            }
        }
        
        // Changer de couleur
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.easeInOut(duration: 0.4)) {
                currentGlowColorIndex = (currentGlowColorIndex + 1) % glowColors.count
            }
        }
        
        // Relancer le cycle
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            performDoubleHeartbeat()
        }
    }
}

// MARK: - COMPOSANTS INCHANGÉS (Shapes, TransitionPortal, etc.)

// MARK: Forme d'Étoile à 4 Branches (inchangée)
struct StarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outerRadius = min(rect.width, rect.height) / 2
        let innerRadius = outerRadius * 0.4
        
        for i in 0..<8 {
            let angle = (Double(i) * .pi / 4) - .pi / 2
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

// MARK: Forme des Vagues avec Perspective (inchangée)
struct WaveShape: Shape {
    var offset: CGFloat
    var amplitude: CGFloat
    var frequency: CGFloat
    var startHeight: CGFloat
    
    var animatableData: CGFloat {
        get { offset }
        set { offset = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        let midHeight = height * startHeight
        
        path.move(to: CGPoint(x: 0, y: midHeight))
        
        for x in stride(from: 0, through: width, by: 1) {
            let relativeX = x / width
            let sine = sin((relativeX * frequency * 2 * .pi) + (offset / width * 2 * .pi))
            
            let perspectiveY = (midHeight + sine * amplitude) / height
            let perspectiveAmplitude = amplitude * (0.3 + perspectiveY * 0.7)
            
            let y = midHeight + sine * perspectiveAmplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        
        return path
    }
}

// MARK: Grandes Vagues Premier Plan (inchangée)
struct LargeWaveShape: Shape {
    var offset: CGFloat
    var amplitude: CGFloat
    var frequency: CGFloat
    var startHeight: CGFloat
    
    var animatableData: CGFloat {
        get { offset }
        set { offset = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        let midHeight = height * startHeight
        
        path.move(to: CGPoint(x: 0, y: midHeight))
        
        for x in stride(from: 0, through: width, by: 2) {
            let relativeX = x / width
            let sine = sin((relativeX * frequency * 2 * .pi) + (offset / width * 2 * .pi))
            
            let yPosition = (x / width)
            let perspectiveFactor: CGFloat
            
            if yPosition < 0.4 {
                perspectiveFactor = 0.3
            } else {
                let growthProgress = (yPosition - 0.4) / 0.6
                perspectiveFactor = 0.3 + growthProgress * 1.2
            }
            
            let finalAmplitude = amplitude * perspectiveFactor
            let y = midHeight + sine * finalAmplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        
        return path
    }
}

// MARK: Particule de Battement de Cœur (inchangée)
struct HeartbeatParticleView: View {
    let index: Int
    let burstTrigger: Int
    let colors: [Color]
    @State private var offset: CGPoint = .zero
    @State private var opacity: Double = 0.0
    @State private var scale: CGFloat = 0.0
    @State private var currentBurst: Int = 0
    
    private var particleColor: Color {
        colors[index % colors.count]
    }
    
    var body: some View {
        Circle()
            .fill(particleColor)
            .frame(width: 6, height: 6)
            .opacity(opacity)
            .scaleEffect(scale)
            .offset(x: offset.x, y: offset.y)
            .shadow(color: particleColor, radius: 8)
            .onChange(of: burstTrigger) { _ in
                triggerParticleBurst()
            }
    }
    
    private func triggerParticleBurst() {
        guard burstTrigger != currentBurst else { return }
        currentBurst = burstTrigger
        
        offset = .zero
        opacity = 1.0
        scale = 1.0
        
        let particleDelay = Double(index) * 0.02
        
        DispatchQueue.main.asyncAfter(deadline: .now() + particleDelay) {
            withAnimation(.easeOut(duration: 2.5)) {
                let baseAngle = (Double(index) / 20.0) * 2 * .pi
                let randomAngleOffset = Double.random(in: -0.6...0.6)
                let finalAngle = baseAngle + randomAngleOffset
                
                let baseDistance: CGFloat = 120
                let randomDistanceMultiplier = CGFloat.random(in: 0.8...1.8)
                let finalDistance = baseDistance * randomDistanceMultiplier
                
                offset = CGPoint(
                    x: cos(finalAngle) * finalDistance,
                    y: sin(finalAngle) * finalDistance
                )
                opacity = 0.0
                scale = 0.1
            }
        }
    }
}

// MARK: Portail de Transition (inchangé)
struct TransitionPortalView: View {
    let screenSize: CGSize
    let fromInactive: Bool
    @EnvironmentObject var constellationState: ConstellationState
    
    @State private var phase: Int = 1
    @State private var intensityScale: CGFloat = 1.0
    @State private var explosionScale: CGFloat = 0.0
    @State private var explosionOpacity: Double = 0.0
    @State private var newPortalScale: CGFloat = 0.0
    @State private var newPortalOpacity: Double = 0.0
    @State private var transitionParticles: Int = 0
    
    private var currentAsset: String {
        if !fromInactive {
            return "icon-portal"
        }
        
        switch constellationState.selectedStarId {
        case 1: return "Vortex-1"
        case 2: return "Vortex-2"
        case 3: return "Vortex-3"
        case 4: return "Vortex"
        default: return "icon-portal"
        }
    }
    
    var body: some View {
        ZStack {
            if phase <= 2 {
                Image(fromInactive ? "icon-portal" : currentAsset)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 370, height: 370)
                    .scaleEffect(intensityScale)
                    .opacity(phase == 1 ? 1.0 : 0.0)
                    .shadow(color: Color("soft-beige").opacity(0.8), radius: 25)
                    .shadow(color: Color("sof-green").opacity(0.6), radius: 35)
            }
            
            if phase == 2 {
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [
                                Color("soft-beige").opacity(0.8),
                                Color("sof-green").opacity(0.4),
                                Color.clear
                            ]),
                            center: .center,
                            startRadius: 10,
                            endRadius: 200
                        )
                    )
                    .scaleEffect(explosionScale)
                    .opacity(explosionOpacity)
                
                ForEach(0..<12, id: \.self) { index in
                    TransitionParticleView(
                        index: index,
                        trigger: transitionParticles
                    )
                }
            }
            
            if phase == 3 {
                Image(currentAsset)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 370, height: 370)
                    .scaleEffect(newPortalScale)
                    .opacity(newPortalOpacity)
                    .shadow(color: Color("sof-green").opacity(0.8), radius: 20)
                    .shadow(color: Color("soft-pink").opacity(0.6), radius: 30)
            }
        }
        .position(
            x: screenSize.width / 2,
            y: screenSize.height * 0.3
        )
        .onAppear {
            startTransitionSequence()
        }
    }
    
    private func startTransitionSequence() {
        withAnimation(.easeInOut(duration: 0.4)) {
            intensityScale = 1.2
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            phase = 2
            transitionParticles += 1
            
            withAnimation(.easeOut(duration: 0.2)) {
                explosionScale = 1.0
                explosionOpacity = 1.0
            }
            
            withAnimation(.easeOut(duration: 0.3).delay(0.1)) {
                explosionOpacity = 0.0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                phase = 3
                
                withAnimation(.easeOut(duration: 0.5)) {
                    newPortalScale = 1.0
                    newPortalOpacity = 1.0
                }
            }
        }
    }
}

// MARK: Particule de Transition (inchangée)
struct TransitionParticleView: View {
    let index: Int
    let trigger: Int
    @State private var offset: CGPoint = .zero
    @State private var opacity: Double = 0.0
    @State private var scale: CGFloat = 0.0
    
    var body: some View {
        Circle()
            .fill(Color("soft-beige"))
            .frame(width: 8, height: 8)
            .scaleEffect(scale)
            .opacity(opacity)
            .offset(x: offset.x, y: offset.y)
            .shadow(color: Color("soft-beige"), radius: 4)
            .onChange(of: trigger) { _ in
                triggerExplosion()
            }
    }
    
    private func triggerExplosion() {
        opacity = 1.0
        scale = 1.0
        
        let angle = (Double(index) / 12.0) * 2 * .pi
        let distance: CGFloat = 150
        
        withAnimation(.easeOut(duration: 0.6)) {
            offset = CGPoint(
                x: cos(angle) * distance,
                y: sin(angle) * distance
            )
            opacity = 0.0
            scale = 0.3
        }
    }
}

#Preview {
    LandingPageView()
}
