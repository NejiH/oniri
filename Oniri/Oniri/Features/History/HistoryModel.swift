//
//  HistoryModel.swift
//  Oniri
//
//  Created by Arnaud Hayon on 15/07/2025.
//

import Foundation

struct History {
    var id: Int
    var maintitle: String?
    var title: String
    var subtitle: String
    var narrative: [String]
    var image: [String: String]?
    var questions: String?
    var answer: [String]?
    
    init(id: Int, title: String, subtitle: String, narrative: [String], image: [String : String], questions: String, answer: [String]) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.narrative = narrative
        self.image = image
        self.questions = questions
        self.answer = answer

    }
    
    init(id: Int, title: String, subtitle: String, narrative: [String], questions: String, answer: [String]) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.narrative = narrative
        self.questions = questions
        self.answer = answer
    }
    
    init(id: Int, title: String, subtitle: String, narrative: [String], image: [String: String]) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.narrative = narrative
        self.image = image
    }
    
    init(id: Int, maintitle: String?, title: String, subtitle: String, narrative: [String], image: [String : String], questions: String, answer: [String]) {
        self.id = id
        self.maintitle = maintitle
        self.title = title
        self.subtitle = subtitle
        self.narrative = narrative
        self.image = image
        self.questions = questions
        self.answer = answer }
}


let histories: [History] = [
    History(id: 0, maintitle: "Les Brêches d'Élior", title: "Le Jardin Fracturé", subtitle: "Sommeil Léger", narrative: ["L’air est saturé d’un parfum étrange, à mi-chemin entre l’herbe mouillée et la cendre froide. Nara pose le pied sur un sol couvert de pétales figés dans le temps, comme suspendus dans leur chute. \n\nAutour d’elle, des arbres nus aux branches noueuses forment un dôme oppressant, comme si le ciel lui-même avait décidé de se refermer sur ce fragment d’esprit. Des statues d’enfants figés dans des poses de jeu peuplent l’espace, mais leurs visages sont effacés, remplacés par une surface lisse et glacée qui reflète les émotions de Nara. \n\nAu loin, une voix tremblante brise le silence : celle d’un Élior enfant, qui semble appeler à l’aide depuis un dédale d’ombres mouvantes. La voix devient plus pressante, presque paniquée, résonnant contre les murs invisibles du rêve. \n\nNara comprend qu’elle doit agir vite, mais prudemment. Le rêve est instable, et une erreur pourrait réveiller Élior trop tôt. Chaque vibration du sol, chaque frémissement des feuilles, semble être relié à son état mental. \n\nElle sait que le moindre faux pas pourrait déstabiliser son hôte, ou pire, l’enfermer dans un cauchemar dont il ne reviendrait pas. Deux voies s’ouvrent à elle : l’une sinueuse, bordée de lumière douce, l’autre sombre et directe, une faille béante dans le paysage."], image: ["start": "card-empathie"], questions: "Que fais-tu ?", answer: ["Je suis la voix doucement, en chuchotant tout rassurer l'enfant", "Je cours dans le labyrinthe, bravant les ombres sans réfléchir"]),
    History(id: 1, title: "La Chambre des Échos", subtitle: "Sommeil Profond", narrative: ["Nara arrive dans une pièce circulaire, semblable à un grenier où le temps se serait arrêté. Les murs sont tapissés d’objets anciens : un avion en bois brisé, une peluche aux coutures fatiguées, un carnet de dessins d’enfant. Chaque objet pulse d’une énergie subtile, comme s’il renfermait une mémoire, un écho d’émotion figée dans l’oubli. Lorsqu’elle s’approche d’un ours en peluche à l’œil arraché, une voix douce murmure une phrase à peine audible : « Ne me laisse pas seul… » Ces objets sont autant de fragments du passé d’Élior, saturés de tristesse, de solitude, et de peur. Une lumière vacille doucement derrière une porte entrouverte, comme un battement de cœur hésitant. Nara sent que cette pièce est un test : un rappel de tout ce qu’Élior a voulu fuir. Elle pourrait tenter de comprendre en écoutant, en apaisant ces souvenirs blessés. Mais le temps presse, et le rêve n’attendra pas éternellement. La lumière derrière la porte devient plus instable, presque violente, comme un orage contenu. Elle doit choisir : écouter le passé ou ouvrir la porte vers l’inconnu."], questions: "Comment réagis-tu ?", answer: ["Je prends le temps d’écouter un objet, apaisant son souvenir.", "Tu ignores les murmures et ouvres la porte à toute volée."]),
    History(id: 2, title: "Le Torrent Mental", subtitle: "Sommeil Profond", narrative: ["À peine a-t-elle pénétré dans le labyrinthe que les ombres s’animent, formant des murs mouvants et sinueux. Nara court sans réfléchir, portée par l’urgence de la voix, mais à chaque tournant, les chemins changent, se replient, se referment sur elle. Le sol devient liquide sous ses pieds, et elle glisse soudain dans un gouffre qui l’avale tout entière. Elle atterrit brutalement au bord d’un fleuve d’encre, où les courants semblent faits de pensées brisées, de cris muets, de souvenirs tourbillonnants. Sur l’autre rive, Élior adulte la fixe, debout dans une clarté irréelle. Son regard est dur, presque hostile, mais profondément perdu. Le torrent mental hurle comme une tempête intérieure. Des visages apparaissent brièvement dans les flots : des versions distordues d’Élior, criant, riant, pleurant. Nara comprend qu’elle est au cœur d’un conflit intérieur, un endroit dangereux pour elle comme pour lui. Elle sent que la frontière entre rêve et réalité s’amincit ici. Chaque seconde compte. Elle peut essayer d’entrer en connexion avec lui malgré la distance… ou se jeter dans les flots pour le rejoindre sans attendre, risquant de se perdre dans le tumulte."], questions: "Que fais-tu ?", answer: ["Tu tends la main vers Élior et tentes de communiquer par le regard.","Tu plonges dans le torrent, décidée à le traverser à tout prix."]),
    History(id: 3, title: "La Fôret du Reflet", subtitle: "Sommeil Paradoxal", narrative: ["La porte franchie, Nara se retrouve dans une forêt éthérée, baignée d’une lumière argentée qui ne semble venir de nulle part. Les arbres n’ont ni feuilles ni racines : ce sont des miroirs dressés à la verticale, s’étendant à perte de vue. Chacun reflète une peur, une honte ou une blessure d’Élior. Certains miroirs montrent son visage d’enfant, tremblant sous les cris d’un adulte invisible ; d’autres le montrent adulte, seul, recroquevillé dans une pièce vide. Les reflets ne sont pas fixes : ils réagissent à la présence de Nara, captant ses mouvements, ses émotions, son hésitation. Au centre de cette forêt, un miroir plus grand que les autres semble battre comme un cœur. Il reflète Nara elle-même, mais avec les traits d’Élior, comme si leurs esprits se confondaient. Elle comprend que c’est ici que tout se joue : accepter les peurs d’Élior, ou les affronter de front. Si elle brise les miroirs, elle risque de détruire les structures mentales encore fragiles de son hôte. Mais si elle reste là, vulnérable, et les contemple sans jugement, elle peut l’aider à guérir. Le silence est absolu, pesant, comme suspendu à sa prochaine décision."], questions: "Que fais-tu ?", answer: ["Je regarde les miroirs en silence, acceptant ses peurs.","Je brise un miroir pour passer en force."]),
    History(id: 4, title: "Le Coeur Battant", subtitle: "Sommeil Paradoxal", narrative: ["La lumière derrière la porte explose lorsque Nara l’ouvre d’un coup sec. Elle se retrouve propulsée dans une vaste salle circulaire, dont le sol est couvert d’un liquide translucide, chaud et pulsant, semblable à du sang cristallin. Suspendu au centre de la pièce, un cœur géant bat violemment, irradiant des éclairs d’émotions brutes à chaque pulsation. À chaque battement, des souvenirs épars sont projetés dans la pièce : un premier amour perdu, un départ précipité, un cri resté coincé dans la gorge d’Élior pendant des années. Nara est submergée. C’est une chambre de douleur vivante.\nLe cœur s’accélère, devient instable. S’il explose, le rêve s’effondrera. Tout en elle la pousse à intervenir. Elle peut essayer de le calmer, de l’apaiser avec une présence douce, en l’acceptant tel qu’il est. Mais une autre voix intérieure, plus instinctive, hurle de le saisir à pleines mains, de le forcer à ralentir, à se taire, à se soumettre à sa volonté. Le sol tremble sous ses pieds. Il ne reste que quelques secondes avant que le cœur n’atteigne un point de non-retour."], questions: "Que fais-tu ?", answer: ["Je poses la main dessus avec douceur.", "J'essaie de le stabiliser par la force."]),
    History(id: 5, title: "Le Temple Inversé", subtitle: "Sommeil Paradoxal", narrative: ["Nara réussit à créer un lien silencieux avec Élior. Le courant du torrent ralentit, permettant à un pont fragile de se former sous ses pieds. Elle traverse avec précaution et se retrouve dans un temple renversé, où le plafond est le sol et où les lois de la gravité semblent dictées par les émotions. Des piliers s'effondrent un à un, menaçant de faire chuter tout l’édifice onirique. Sur les murs, des fresques apparaissent et disparaissent : elles racontent des épisodes d’Élior jamais exprimés, jamais compris.\nDans cette structure instable, chaque geste peut provoquer l’effondrement. Nara comprend que ce temple représente l’image qu’Élior se fait de lui-même, et qu’il vacille entre dégoût de soi et culpabilité. Elle peut tenter de soutenir les piliers les plus faibles, redonnant au lieu une stabilité fragile. Ou bien courir vers une arche lumineuse au fond du temple, la sortie — potentielle, mais incertaine — de cette partie du rêve. Derrière elle, des pierres se détachent déjà. Elle n’a que quelques secondes pour décider."], questions: "Que fais0tu ?", answer: ["Je soutiens les piliers un à un.", "Je fonce vers la sortie avant que tout ne s'effondre."]),
    History(id: 6, maintitle: "",title: "Le Cri Silencieux", subtitle: "Sommeil Paradoxal", narrative: ["Nara émerge du torrent en haletant, les bras griffés d’images mentales tourbillonnantes. Elle parvient à grimper sur une plate-forme instable, flottant dans un espace vide d’étoiles. Devant elle, Élior flotte en lévitation, le visage tordu de souffrance. Il hurle, mais aucun son ne sort de sa bouche. Le rêve entier tremble sous la pression de ce cri muet. Chaque seconde, des failles s’ouvrent dans le sol, laissant apparaître le néant. Nara sent son propre esprit se fissurer sous la pression du silence assourdissant.\nCe n’est plus un rêve : c’est un cri de l’âme, brut, brutalisé, sauvage. Elle pourrait s’approcher de lui, tenter de l’enlacer, d’absorber ce hurlement avec sa propre tendresse, sa présence humaine. Mais son instinct hurle de répondre à sa manière : en criant à son tour, en libérant sa propre voix, pour briser l’emprise du silence. C’est une dernière tentative, désespérée, pour réveiller quelque chose en lui… ou le faire céder entièrement."], image: ["start": "Pouet", "end": "success"], questions: "Que fais-tu ? ", answer: ["Je m’approche et l’enlace.", "Je crie en retour pour te faire entendre."]),
    History(id: 7, title: "Réveil apaisé", subtitle: "Fin", narrative: ["Nara reste immobile, contemplant les miroirs avec une compassion profonde. Les reflets d'Élior commencent à trembler, puis à se dissoudre, remplacés par des images de sérénité et de paix. La forêt se transforme en un jardin lumineux, où les miroirs deviennent des fenêtres ouvertes sur un ciel infini. Élior apparaît, soulagé, et murmure un merci. Le rêve se dissout doucement, laissant place à un réveil apaisé."],image: ["end": "success"]),
    History(id: 8, title: "La Chute des Illusions", subtitle: "Fin", narrative: ["Le miroir se brise en mille éclats, et la forêt tout entière tremble. Les reflets se déforment, devenant des monstres grotesques. Élior apparaît, paniqué, et se met à crier. Le rêve se transforme en cauchemar, et Nara se retrouve expulsée brutalement, laissant Élior seul avec ses démons."],image: ["end": "success"]),
    History(id: 9, title: "Le Calme du Cœur", subtitle: "Fin", narrative: ["Nara pose sa main sur le cœur battant, et une lumière apaisante se diffuse dans la pièce. Le cœur ralentit, et les souvenirs projetés deviennent des images de bonheur et de paix. Élior apparaît, soulagé, et sourit. Le rêve se dissout doucement, laissant place à un réveil apaisé."],image: ["end": "success"]),
    History(id: 10, title: "L'Explosion des Émotions", subtitle: "Fin", narrative: ["Nara saisit le cœur à pleines mains, mais il explose en mille éclats. La pièce est inondée d'une lumière aveuglante, et Élior apparaît, en colère et confus. Le rêve s'effondre, et Nara se retrouve expulsée brutalement, laissant Élior seul avec ses émotions tumultueuses."],image: ["end": "success"]),
    History(id: 11, title: "La Stabilité Retrouvée", subtitle: "Fin", narrative: ["Nara soutient les piliers avec soin, et le temple se stabilise. Les fresques sur les murs deviennent des images de bonheur et de paix. Élior apparaît, soulagé, et sourit. Le rêve se dissout doucement, laissant place à un réveil apaisé."],image: ["end": "success"]),
    History(id: 12, title: "La Fuite Éperdue", subtitle: "Fin", narrative: ["Nara court vers la sortie, mais le temple s'effondre derrière elle. Elle se retrouve propulsée dans un vide sombre, et Élior apparaît, paniqué et confus. Le rêve s'effondre, et Nara se retrouve expulsée brutalement, laissant Élior seul avec ses démons."],image: ["end": "success"]),
    History(id: 13, title: "L'Étreinte Apaisante", subtitle: "Fin", narrative: ["Nara s'approche d'Élior et l'enlace tendrement. Le cri silencieux s'arrête, et Élior se calme. Le rêve se transforme en un jardin lumineux, où ils se retrouvent ensemble, apaisés. Le rêve se dissout doucement, laissant place à un réveil apaisé."],image: ["end": "success"]),
    History(id: 14, title: "Le Chaos des Cris", subtitle: "Fin", narrative: ["Nara crie à son tour, et le rêve entier tremble. Élior apparaît, en colère et confus. Le rêve s'effondre, et Nara se retrouve expulsée brutalement, laissant Élior seul avec ses émotions tumultueuses."],image: ["end": "success"])
]




