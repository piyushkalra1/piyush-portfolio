import 'package:portfolio/models/project_model.dart';

class AppStrings {
  // Profile / Hero
  static const String devName = "Piyush Kalra";
  static const String devRole = "Lead Flutter Engineer & Mobile Consultant";
  static const String devLocation = "Jaipur, India (Open to Remote & Relocation)";
  static const String devAboutShort = "Senior Flutter Developer with 4+ years of production experience specializing in high-performance Android, iOS, and Web applications using Clean Architecture, Hardware/IoT (NFC/RFID), in-app subscriptions, and high-converting MVPs.";
  static const String devAboutLong = "I am a Lead Flutter Developer & Mobile Consultant with 4+ years of production experience (since October 2022) architecting scalable Android and iOS applications. Delivered 15+ production applications published on the Google Play Store and Apple App Store with 100K+ combined downloads. Proven track record leading Flutter development teams, working directly with global clients (US, Europe, Middle East), integrating hardware/IoT devices (NFC/RFID tag scanners), building in-app subscription engines, and shipping enterprise-grade code that drives real business revenue.";

  // Social Links
  static const String githubUrl = "https://github.com/piyush-kalra";
  static const String linkedinUrl = "https://linkedin.com/in/piyush-kumar-kalra";
  static const String emailAddress = "piyush.kumar.kalra@gmail.com";
  static const String phoneNumber = "+91 8949581867";

  // Categories & Skills List
  static const Map<String, List<Map<String, dynamic>>> skillsData = {
    "Languages": [
      {"name": "Dart", "tag": "Core Driver", "icon": "code", "level": 0.98},
      {"name": "Kotlin", "tag": "Native Android", "icon": "android", "level": 0.85},
      {"name": "Swift", "tag": "Native iOS", "icon": "apple", "level": 0.78},
      {"name": "Java", "tag": "Enterprise Core", "icon": "terminal", "level": 0.80},
    ],
    "Frameworks & SDKs": [
      {"name": "Flutter (Android, iOS & Web)", "tag": "4+ Years Lead", "icon": "flutter", "level": 0.98},
      {"name": "NFC & RFID Tag Integration", "tag": "Hardware IoT", "icon": "nfc", "level": 0.94},
      {"name": "RESTful APIs & WebSockets", "tag": "Real-Time Comms", "icon": "sync", "level": 0.96},
      {"name": "Google Maps & Deep Linking", "tag": "Geo & Navigation", "icon": "map", "level": 0.92},
      {"name": "Agora Video/Voice Calling", "tag": "RTC Audio/Video", "icon": "video", "level": 0.88},
    ],
    "Backend & Cloud Services": [
      {"name": "Firebase Suite (Auth, Firestore, DB)", "tag": "Cloud Native", "icon": "fire", "level": 0.95},
      {"name": "Push Notifications (FCM & PushKit)", "tag": "Targeted Push", "icon": "notifications", "level": 0.95},
      {"name": "Supabase & PostgreSQL", "tag": "Relational DB", "icon": "database", "level": 0.88},
      {"name": "Crashlytics & App Performance", "tag": "99.8% Stability", "icon": "speed", "level": 0.94},
    ],
    "State Management": [
      {"name": "BLoC / Cubit", "tag": "Enterprise Reactive", "icon": "tree", "level": 0.94},
      {"name": "Provider", "tag": "Production Tested", "icon": "layers", "level": 0.96},
      {"name": "GetX", "tag": "High Velocity", "icon": "bolt", "level": 0.94},
      {"name": "Riverpod", "tag": "Modern Reactive", "icon": "waves", "level": 0.88},
    ],
    "Architecture & Security": [
      {"name": "Clean Architecture & MVVM", "tag": "Enterprise Standard", "icon": "architecture", "level": 0.96},
      {"name": "SOLID Principles & Repository Pattern", "tag": "Decoupled Code", "icon": "shield", "level": 0.94},
      {"name": "Kiosk Mode & App Pinning", "tag": "Hardware Lock", "icon": "lock", "level": 0.90},
      {"name": "SQLite, Hive & Secure Storage", "tag": "Encrypted DB", "icon": "security", "level": 0.92},
    ],
    "Payments, Subscriptions & Release": [
      {"name": "In-App Purchases & Subscriptions", "tag": "StoreKit & Play Billing", "icon": "payments", "level": 0.94},
      {"name": "Razorpay, Stripe & CCAvenue", "tag": "Multi-Gateway", "icon": "credit_card", "level": 0.95},
      {"name": "Google Play Console Publishing", "tag": "15+ Live Releases", "icon": "play_arrow", "level": 0.96},
      {"name": "Apple App Store Connect & TestFlight", "tag": "Production Tested", "icon": "app_store", "level": 0.94},
    ],
  };

  // Experience Timeline
  static const List<Map<String, dynamic>> experienceList = [
    {
      "role": "Flutter Developer (Lead)",
      "company": "Inventco Software Pvt. Ltd., Jaipur",
      "location": "Jaipur, India",
      "duration": "Aug 2024 - Present",
      "description": "Leading Flutter architecture and development for enterprise and hardware/IoT applications from concept to store release.",
      "responsibilities": [
        "Spearheaded development of BLB Librarian (Better Letter Book) connecting physical books via NFC/RFID tag scanning with parental safety Kiosk mode.",
        "Managed a team of Flutter developers, established CI/CD pipelines, conducted rigorous code reviews, and mentored junior engineers.",
        "Handled direct client meetings with international stakeholders, sprint planning, and system architecture design.",
        "Built scalable apps using Clean Architecture, BLoC/Provider, Firebase, REST APIs, and native platform channels."
      ]
    },
    {
      "role": "Flutter Developer",
      "company": "Solvebee IT Services Pvt. Ltd.",
      "location": "Jaipur, India",
      "duration": "Feb 2023 - Aug 2024",
      "description": "Developed and maintained multiple high-traffic production applications across healthcare, fintech, insurance, and hospitality domains.",
      "responsibilities": [
        "Engineered production Flutter applications including Probus Insurance and Govt RAS Club with 100K+ cumulative reach.",
        "Integrated multi-gateway payment checkouts (Stripe, Razorpay, CCAvenue) with encrypted session caching.",
        "Published and maintained Android and iOS applications on Google Play Store and Apple App Store.",
        "Improved application performance, reduced app launch times by 35%, and eliminated memory leaks."
      ]
    },
    {
      "role": "Flutter Intern",
      "company": "Aimerse Technology",
      "location": "Jaipur / Remote",
      "duration": "Oct 2022 - Dec 2022",
      "description": "Hands-on engineering with Flutter architecture, responsive cross-platform UI, and REST API integration.",
      "responsibilities": [
        "Developed responsive Flutter UI widgets and integrated REST APIs using Provider state management.",
        "Collaborated with senior engineers on feature implementation, automated unit testing, and bug fixing.",
        "Gained deep foundation in Flutter framework internals and mobile lifecycle management."
      ]
    }
  ];

  // Projects Configuration List
  static final List<ProjectModel> projectsList = [
    ProjectModel(
      id: "blb_librarian",
      name: "BLB Librarian (Better Letter Book)",
      shortDescription: "IoT smart learning app connecting physical books via NFC/RFID with child safety kiosk mode.",
      description: "BLB Librarian (Better Letter Book) is a pioneering EdTech and Hardware/IoT mobile ecosystem bridging tactile physical books with rich digital multimedia. Parents scan physical books via instant NFC/RFID tag scanning, manage multiple child profiles ('Little Ones'), and activate a secure Child Safety Kiosk Mode restricting access strictly to parent-assigned content. Features real-time media quota tracking, device licensing, and flexible in-app tiered billing (Free, Family, Premium).",
      technologies: ["Flutter", "NFC / RFID Scanning", "Child Safety / Kiosk Mode", "In-App Subscriptions", "Clean Architecture", "Media Caching", "REST APIs", "Device Quotas"],
      playStoreUrl: "https://play.google.com/store/apps/details?id=com.blb.librarian",
      features: [
        "NFC & RFID Tag Scanning: Instant book pairing by simply tapping physical books to the smartphone",
        "Parental Child Profiles: Add & manage multiple 'Little Ones' with individual book access permissions",
        "Child Safety Kiosk Mode: App-pinning safety lock ensuring children only experience parent-curated content",
        "Rich Multimedia Synchronisation: Associating physical books with stories, audio phonics, videos, and flashcards",
        "Device & Quota Monitoring: Real-time visualization of media storage consumption and connected device count",
        "Multi-Tier In-App Subscriptions: Flexible monthly and yearly subscription plans (Free, Family, Premium)"
      ],
      screenshots: [
        "assets/screenshots/blb_librarian/blb1.png",
        "assets/screenshots/blb_librarian/blb2.png",
        "assets/screenshots/blb_librarian/blb3.png",
        "assets/screenshots/blb_librarian/blb4.png",
        "assets/screenshots/blb_librarian/blb5.png",
      ],
      responsibilities: [
        "Engineered native NFC/RFID reader interfaces and protocol parsing for instant book tag resolution.",
        "Implemented secure Kiosk / Safety Mode preventing unauthorized app escape during children's reading sessions.",
        "Designed and architected the parental Little Ones multi-profile access delegation system.",
        "Integrated in-app billing subscriptions and dynamic media storage quota calculations.",
        "Crafted high-fidelity custom UI with interactive audio playback and smooth asset caching."
      ],
      accentHue: 195.0, // Vibrant Cyan-Blue Theme matching the BLB interface
      category: "IoT & Hardware",
      highlightBadge: "IoT & NFC / RFID Flagship",
    ),
    ProjectModel(
      id: "dunnit",
      name: "Dunnit",
      shortDescription: "Challenge-based social platform with Daily Check-ins, chat and in-app purchases.",
      description: "Dunnit is one of my most advanced Flutter projects built completely from scratch. It is a challenge-based social platform where users create and participate in habits, tasks, or community challenges. Users upload daily completions, chat, buy premium features, and see animated notifications.",
      technologies: ["Flutter", "Firebase", "REST API", "In-App Purchases", "Notifications", "Dynamic Links"],
      playStoreUrl: "https://play.google.com/store/apps/details?id=com.app.dunnnit.challenge.android",
      features: [
        "Create public/private challenges with friends and global communities",
        "Daily check-in verification system with photo uploads",
        "Real-Time Chat groups and direct messaging",
        "Push notifications and deep-linking via Firebase Dynamic Links",
        "In-App Purchases for premium subscriptions and special tokens",
        "Fluid custom canvas UI transitions and animations"
      ],
      screenshots: [
        "assets/screenshots/dunnit/dunnit1.png",
        "assets/screenshots/dunnit/dunnit2.png",
        "assets/screenshots/dunnit/dunnit3.png",
        "assets/screenshots/dunnit/dunnit4.png",
        "assets/screenshots/dunnit/dunnit5.png",
      ],
      responsibilities: [
        "Architected code structure using clean MVVM with Provider state management.",
        "Implemented REST API integrations for challenges feed and user actions.",
        "Integrated StoreKit and Google Play Billing for In-App Purchases.",
        "Set up real-time WebSockets/Firestore notifications and group chat system."
      ],
      accentHue: 270.0, // Violet-Purple Theme
      category: "Social & Habits",
      highlightBadge: "Clutch 5.0 Rated ★",
    ),
    ProjectModel(
      id: "probus",
      name: "Probus Insurance",
      shortDescription: "Secure insurance platform supporting car, health, home, and marine policy checkout.",
      description: "Probus Insurance is a full-featured enterprise insurance platform. It enables clients to browse, filter, compare, and instantly purchase various insurance policies (car, bike, health, home, marine). It incorporates biometric authentication, local databases, and razor-sharp payment gateway checkout.",
      technologies: ["Flutter", "Firebase", "REST API", "Payments", "Local Storage", "FCM Notifications"],
      playStoreUrl: "https://play.google.com/store/apps/details?id=in.probusinsurance.app",
      features: [
        "Secure biometric login and user session validation",
        "Interactive comparison portal for various insurance providers",
        "Instant digital receipt and policy generation",
        "Push notifications with custom images using FCM",
        "Offline policy caching using Hive local storage",
        "Integration of Stripe and Razorpay checkout portals"
      ],
      screenshots: [
        "assets/screenshots/probus/prrobus1.png",
        "assets/screenshots/probus/prrobus2.png",
        "assets/screenshots/probus/prrobus3.png",
        "assets/screenshots/probus/prrobus4.png",
      ],
      responsibilities: [
        "Built the client checkout UI from scratch using responsive styling rules.",
        "Secured critical APIs and managed session tokens in encrypted local storage.",
        "Managed CCAvenue, Stripe, and Razorpay payment gateway callbacks.",
        "Ensured seamless deployment to Apple App Store and Google Play Store."
      ],
      accentHue: 210.0, // Indigo-Blue Theme
      category: "Fintech & Enterprise",
      highlightBadge: "Enterprise Fintech",
    ),
    ProjectModel(
      id: "govt_ras",
      name: "Govt RAS (RAS Club)",
      shortDescription: "Examination preparation learning platform and room booking dashboard for government officials.",
      description: "Govt RAS (RAS Club) is a multipurpose platform. First, it acts as a structured e-learning platform for civil servants prepping for Rajasthan Government examination courses. Second, it serves as a booking dashboard for RAS officers to reserve club rooms, halls, and banquets.",
      technologies: ["Flutter", "Firebase", "REST API", "Payments (Razorpay)", "Session Management"],
      playStoreUrl: "https://play.google.com/store/apps/details?id=in.solvebee.rasclub",
      features: [
        "Government course curriculum, syllabus sheets, and mock tests",
        "Real-time availability indicator for rooms and conference halls",
        "Secured official session tracking and credentials storage",
        "Razorpay payment system for banquet halls and room bookings",
        "PDF view integration for study material downloads",
        "Interactive calendar schedules for officer bookings"
      ],
      screenshots: [
        "assets/screenshots/govt_ras/ras1.png",
        "assets/screenshots/govt_ras/ras2.png",
        "assets/screenshots/govt_ras/ras3.png",
        "assets/screenshots/govt_ras/ras4.png",
        "assets/screenshots/govt_ras/ras5.png",
      ],
      responsibilities: [
        "Designed the complex calendar scheduling widget for room booking.",
        "Connected the Razorpay SDK and set up instant refund/booking callbacks.",
        "Configured secure local caching for study PDF packages.",
        "Collaborated with government IT representatives to ensure compliance."
      ],
      accentHue: 30.0, // Orange-Bronze Theme
      category: "Fintech & Enterprise",
      highlightBadge: "Govt. Platform",
    ),
    ProjectModel(
      id: "splenderwijs",
      name: "Splenderwijs",
      shortDescription: "Premium interactive e-learning and educational dashboard app.",
      description: "Splenderwijs is an innovative educational application designed to enhance student learning through interactive quizzes, lesson charts, and personalized progression reports. It supports offline progress caching and visually engaging progress graphs.",
      technologies: ["Flutter", "Firebase", "Local Caching", "Progress Tracking", "Animations"],
      playStoreUrl: "https://play.google.com/store/apps/details?id=com.tim.splenderwijs",
      features: [
        "Adaptive quizzes that adjust difficulty based on student scores",
        "Interactive lesson cards and gamified visual indicators",
        "Offline caching for progression records using SQLite",
        "Beautiful animated charts displaying performance statistics",
        "Parent-teacher communication channels and dashboard views"
      ],
      screenshots: [
        "assets/screenshots/splenderwijs/spelender1.png",
        "assets/screenshots/splenderwijs/spelender2.png",
        "assets/screenshots/splenderwijs/spelender3.png",
        "assets/screenshots/splenderwijs/spelender4.png",
        "assets/screenshots/splenderwijs/spelender5.png",
      ],
      responsibilities: [
        "Developed custom canvas progress charts and badge reward animations.",
        "Coded local database sync to upload scores when internet becomes available.",
        "Implemented clean Material 3 theme configurations throughout the app.",
        "Built responsive grid layouts compatible with tablets and chromebooks."
      ],
      accentHue: 150.0, // Teal-Emerald Theme
      category: "E-Learning",
      highlightBadge: "Client Verified ↗",
    ),
    ProjectModel(
      id: "nawi",
      name: "Nawi",
      shortDescription: "Modern event planning app with mobile contact sync and invitation sharing.",
      description: "Nawi is a premium event scheduling and planning application. It allows hosts to easily create events, synchronize phone contact lists, select invitees, and generate customized invite links that can be shared dynamically across social media.",
      technologies: ["Flutter", "REST API", "Contact Integration", "Dynamic Links", "Push Notifications"],
      playStoreUrl: "https://play.google.com/store/apps/details?id=com.vga.nawi",
      features: [
        "Import and auto-resolve phone contacts within seconds",
        "Create detailed event templates with maps, times, and RSVP states",
        "Share invites instantly using dynamic routing links",
        "FCM notification system for invite updates and comments",
        "Host and guest chat groups for event planning discussion"
      ],
      screenshots: [
        "assets/screenshots/nawi/nawi1.png",
        "assets/screenshots/nawi/nawi2.png",
        "assets/screenshots/nawi/nawi3.png",
        "assets/screenshots/nawi/nawi4.png",
      ],
      responsibilities: [
        "Developed the native platform bridges (Swift/Kotlin) for importing phone contact lists.",
        "Configured push notifications and deep links to instantly open specific invitation details.",
        "Optimized image compression for uploading banner flyers.",
        "Polished UI micro-interactions using custom animators."
      ],
      accentHue: 330.0, // Magenta-Pink Theme
      category: "Social & Habits",
      highlightBadge: "Event Tech",
    ),
    ProjectModel(
      id: "planit",
      name: "Planit",
      shortDescription: "A productivity tool for providers to manage schedules, clients, and earnings.",
      description: "Planit is a complete provider management application. It acts as an ERP panel for service professionals (contractors, stylists, trainers) to manage appointments, schedule rosters, check client reviews, track monthly earnings, and chat with clients.",
      technologies: ["Flutter", "REST API", "Local Storage (Hive)", "Push Notifications", "Charts"],
      playStoreUrl: "https://play.google.com/store/apps/details?id=com.planit.provider",
      features: [
        "Intuitive calendar layout showing appointments and open time-slots",
        "Client profiling with transaction and booking history logs",
        "Analytics panel showing weekly, monthly, and yearly income graphs",
        "Push notifications for appointment requests, updates, or cancellations",
        "Settings dashboard for configuring pricing, services, and working hours"
      ],
      screenshots: [
        "assets/screenshots/planit/screenshot1.png",
        "assets/screenshots/planit/screenshot2.png",
        "assets/screenshots/planit/screenshot3.png",
      ],
      responsibilities: [
        "Integrated analytical charts showing revenue breakdowns and predictions.",
        "Configured SQLite schema and local repositories for offline scheduling capability.",
        "Ensured smooth responsiveness on mobile, tablet, and web dashboard layouts.",
        "Implemented real-time client booking alerts using socket-based messaging."
      ],
      accentHue: 0.0, // Rose-Red Theme
      category: "Productivity",
      highlightBadge: "SaaS Tool",
    ),
  ];

  // Statistics
  static const List<Map<String, dynamic>> statsData = [
    {"value": "4+", "label": "Years Experience"},
    {"value": "15+", "label": "Apps Delivered"},
    {"value": "100K+", "label": "Downloads Reach"},
    {"value": "100%", "label": "Client Satisfaction"},
  ];

  // Services
  static const List<Map<String, dynamic>> servicesData = [
    {
      "title": "MVP to Store in 4-6 Weeks",
      "description": "Rapid turnaround for startups & founders. Architecting complete, production-ready MVPs with payment gateways, auth, and store publishing.",
      "iconName": "rocket_launch"
    },
    {
      "title": "Hardware & IoT Mobile Integration",
      "description": "Connecting Flutter mobile apps with physical hardware using NFC tag scanning, RFID readers, Bluetooth Low Energy (BLE), and Kiosk safety mode.",
      "iconName": "nfc"
    },
    {
      "title": "Enterprise Flutter Architecture",
      "description": "Scalable cross-platform Android & iOS codebases following Clean Architecture, BLoC/Provider, SOLID principles, and high test coverage.",
      "iconName": "phone_iphone"
    },
    {
      "title": "In-App Purchases & Subscriptions",
      "description": "End-to-end integration of Apple StoreKit & Google Play Billing, tiered subscriptions, dynamic paywalls, and quota management.",
      "iconName": "payments"
    },
    {
      "title": "Performance Tuning & UI Overhauls",
      "description": "Eliminating jank for buttery 60/120 FPS rendering, profiling memory leaks, optimizing startup times, and revamping legacy mobile UI.",
      "iconName": "speed"
    },
    {
      "title": "Store Publishing & App Store SEO",
      "description": "Full release management on Apple App Store and Google Play Console, metadata optimization, privacy policy compliance, and approval guidance.",
      "iconName": "publish"
    },
  ];

  // Achievements
  static const List<Map<String, dynamic>> achievementsList = [
    {
      "title": "Flutter Development Bootcamp",
      "description": "Thorough certification in Dart foundations, OOP structures, and state management practices.",
      "source": "Aimerse Tech & Bootcamp Providers"
    },
    {
      "title": "Professional Insurance POSP Certification",
      "description": "Certified point of sales person for insurance platforms. Acquired domain expertise in insurance logic.",
      "source": "Probus Insurance Brokerage"
    },
    {
      "title": "Govt Approved RSCIT Certification",
      "description": "Official computer information technology qualification approved by Rajasthan Government.",
      "source": "Rajasthan State Government"
    },
    {
      "title": "6+ Live Projects Released",
      "description": "Successfully published, updated, and maintained half a dozen consumer applications on official stores.",
      "source": "App Store & Play Store"
    }
  ];

  // Testimonials & Client Reviews
  static const List<Map<String, dynamic>> testimonialsList = [
    {
      "headline": "Special thanks to Piyush for technical knowledge & practical solutions",
      "quote": "A special thanks to Piyush for his technical knowledge, quick responses and great collaboration. He thought continuously and knew how to translate our wishes into practical solutions. The team successfully deployed the app on iOS and Android platforms.",
      "client": "Branko Radovic",
      "role": "CEO, Dunnnit",
      "company": "Dunnnit • Abu Dhabi, UAE",
      "rating": 5.0,
      "source": "Clutch.co Verified Review",
      "sourceBadge": "Verified 5.0 ★ on Clutch",
      "sourceUrl": "https://clutch.co/profile/inventcolabs",
      "sourceIcon": "clutch",
      "project": "Dunnnit Wellness Platform (iOS & Android)",
    },
    {
      "headline": "The team worked with us, not just for us",
      "quote": "The team worked with us, not just for us. It wasn't just about building an app — it was about refining ideas, revisiting decisions, testing possibilities, and continuously improving the product together. Heartfelt appreciation to Piyush and the team for making this collaboration a success.",
      "client": "Tim van den Berg",
      "role": "Founder & Product Owner",
      "company": "Spelenderwijs Verbeteren • Netherlands",
      "rating": 5.0,
      "source": "Instagram Video Reel",
      "sourceBadge": "Watch Video Feedback ↗",
      "sourceUrl": "https://www.instagram.com/reel/Daerh8kAkdn/?stkn=MTJpbXo0aDd2bHNqag==",
      "sourceIcon": "instagram",
      "project": "Korfball Training & Management Platform",
    },
    {
      "headline": "Clean architecture, seamless payment & production stability",
      "quote": "Piyush architected and delivered our multi-policy insurance application for Android & iOS with modular clean code, robust session management, and smooth payment gateway checkout with Razorpay and Stripe.",
      "client": "Senior Product Team",
      "role": "Project Leadership",
      "company": "Probus Insurance Brokerage • Mumbai",
      "rating": 5.0,
      "source": "Enterprise Client Feedback",
      "sourceBadge": "Enterprise Production Review",
      "sourceUrl": "",
      "sourceIcon": "verified",
      "project": "Probus Insurance Android & iOS",
    }
  ];
}
