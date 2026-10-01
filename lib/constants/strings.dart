import 'package:portfolio/models/project_model.dart';

class AppStrings {
  // Profile / Hero
  static const String devName = "Piyush Kalra";
  static const String devRole = "Senior Flutter Developer";
  static const String devLocation = "Jaipur, India";
  static const String devAboutShort = "Senior Flutter Developer with 4+ years of experience specializing in high-performance Android, iOS, and Web applications using Clean Architecture, robust state management, and modern design systems.";
  static const String devAboutLong = "I am a passionate Flutter Developer with 4 years of production experience (since October 2022) building scalable Android and iOS applications using Flutter and Dart. Delivered 15+ production applications published on the Google Play Store and Apple App Store with a combined reach of 100K+ downloads. Experienced in leading development teams, mentoring Flutter developers, handling direct client communication, gathering requirements, and delivering end-to-end mobile solutions from architecture to deployment.";

  // Social Links
  static const String githubUrl = "https://github.com/piyush-kalra";
  static const String linkedinUrl = "https://linkedin.com/in/piyush-kumar-kalra";
  static const String emailAddress = "piyush.kumar.kalra@gmail.com";
  static const String phoneNumber = "+91 8949581867";

  // Categories & Skills List
  static const Map<String, List<Map<String, dynamic>>> skillsData = {
    "Languages": [
      {"name": "Dart", "level": 0.98},
      {"name": "Java", "level": 0.80},
      {"name": "Kotlin", "level": 0.85},
      {"name": "Swift", "level": 0.75},
    ],
    "Frameworks & SDKs": [
      {"name": "Flutter (Android & iOS)", "level": 0.98},
      {"name": "RESTful APIs", "level": 0.95},
      {"name": "Google Maps & Deep Linking", "level": 0.90},
      {"name": "Agora Video/Voice Calling", "level": 0.88},
    ],
    "Backend & Services": [
      {"name": "Firebase Suite (Auth, Firestore, DB)", "level": 0.95},
      {"name": "Push Notifications (FCM & PushKit)", "level": 0.95},
      {"name": "Supabase", "level": 0.88},
      {"name": "Crashlytics & Dynamic Links", "level": 0.92},
    ],
    "State Management": [
      {"name": "BLoC / Cubit", "level": 0.92},
      {"name": "Provider", "level": 0.96},
      {"name": "GetX", "level": 0.94},
      {"name": "Riverpod", "level": 0.88},
    ],
    "Architecture & Storage": [
      {"name": "Clean Architecture & MVVM", "level": 0.96},
      {"name": "SOLID Principles & Repository", "level": 0.92},
      {"name": "SQLite, Hive & SharedPreferences", "level": 0.90},
      {"name": "Flutter Secure Storage", "level": 0.92},
    ],
    "Payment & Publishing": [
      {"name": "Razorpay, Stripe & CCAvenue", "level": 0.94},
      {"name": "Google Pay, Apple Pay & Mollie", "level": 0.90},
      {"name": "Google Play Console Publishing", "level": 0.95},
      {"name": "Apple App Store Connect Release", "level": 0.92},
    ],
  };

  // Experience Timeline
  static const List<Map<String, dynamic>> experienceList = [
    {
      "role": "Flutter Developer (Lead)",
      "company": "Inventco Software Pvt. Ltd., Jaipur",
      "location": "Jaipur, India",
      "duration": "Aug 2024 - Present",
      "description": "Led Flutter development for Android and iOS applications from development to production release.",
      "responsibilities": [
        "Led Flutter development for Android and iOS applications from development to production.",
        "Managed a team of Flutter developers, conducted code reviews, and mentored junior engineers.",
        "Handled direct client meetings, requirement gathering, sprint planning, and solution discussions.",
        "Built scalable applications using Flutter, MVVM, Clean Architecture, Firebase, REST APIs, and Bloc/GetX."
      ]
    },
    {
      "role": "Flutter Developer",
      "company": "Solvebee IT Services Pvt. Ltd.",
      "location": "Jaipur, India",
      "duration": "Feb 2023 - Aug 2024",
      "description": "Developed and maintained multiple production applications across healthcare, insurance, and hospitality domains.",
      "responsibilities": [
        "Developed and maintained multiple production Flutter applications across healthcare, insurance, and hospitality domains.",
        "Improved application performance, fixed production issues, and delivered new features in Agile sprints.",
        "Published and maintained Android and iOS applications on the Play Store and App Store.",
        "Integrated REST APIs, payment gateways (Razorpay, Stripe, CCAvenue), and local database storage."
      ]
    },
    {
      "role": "Flutter Intern",
      "company": "Aimerse Technology",
      "location": "Jaipur / Remote",
      "duration": "Oct 2022 - Dec 2022",
      "description": "Gained hands-on experience with Flutter architecture, responsive UI development, and API integration.",
      "responsibilities": [
        "Developed responsive Flutter UI and integrated REST APIs using Provider.",
        "Collaborated with senior developers on feature implementation, testing, and bug fixing.",
        "Gained hands-on experience with Flutter architecture and production app development."
      ]
    }
  ];

  // Projects Configuration List
  static final List<ProjectModel> projectsList = [
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
        // "assets/screenshots/dunnit/screenshot2.png",
        // "assets/screenshots/dunnit/screenshot3.png",
      ],
      responsibilities: [
        "Architected code structure using clean MVVM with Provider state management.",
        "Implemented REST API integrations for challenges feed and user actions.",
        "Integrated StoreKit and Google Play Billing for In-App Purchases.",
        "Set up real-time WebSockets/Firestore notifications and group chat system."
      ],
      accentHue: 270.0, // Violet-Purple Theme
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
        // "assets/screenshots/probus/screenshot2.png",
        // "assets/screenshots/probus/screenshot3.png",
      ],
      responsibilities: [
        "Built the client checkout UI from scratch using responsive styling rules.",
        "Secured critical APIs and managed session tokens in encrypted local storage.",
        "Managed CCAvenue, Stripe, and Razorpay payment gateway callbacks.",
        "Ensured seamless deployment to Apple App Store and Google Play Store."
      ],
      accentHue: 210.0, // Indigo-Blue Theme
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
        // "assets/screenshots/govt_ras/screenshot2.png",
        // "assets/screenshots/govt_ras/screenshot3.png",
      ],
      responsibilities: [
        "Designed the complex calendar scheduling widget for room booking.",
        "Connected the Razorpay SDK and set up instant refund/booking callbacks.",
        "Configured secure local caching for study PDF packages.",
        "Collaborated with government IT representatives to ensure compliance."
      ],
      accentHue: 30.0, // Orange-Bronze Theme
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
        // "assets/screenshots/splenderwijs/screenshot2.png",
        // "assets/screenshots/splenderwijs/screenshot3.png",
      ],
      responsibilities: [
        "Developed custom canvas progress charts and badge reward animations.",
        "Coded local database sync to upload scores when internet becomes available.",
        "Implemented clean Material 3 theme configurations throughout the app.",
        "Built responsive grid layouts compatible with tablets and chromebooks."
      ],
      accentHue: 150.0, // Teal-Emerald Theme
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
        // "assets/screenshots/nawi/screenshot2.png",
        // "assets/screenshots/nawi/screenshot3.png",
      ],
      responsibilities: [
        "Developed the native platform bridges (Swift/Kotlin) for importing phone contact lists.",
        "Configured push notifications and deep links to instantly open specific invitation details.",
        "Optimized image compression for uploading banner flyers.",
        "Polished UI micro-interactions using custom animators."
      ],
      accentHue: 330.0, // Magenta-Pink Theme
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
      "title": "Flutter App Development",
      "description": "Cross-platform mobile apps for Android and iOS using Clean Architecture and responsive UI design.",
      "iconName": "phone_iphone"
    },
    {
      "title": "Android App Development",
      "description": "Native-caliber Android app structures utilizing Kotlin integrations and performance-optimized layouts.",
      "iconName": "android"
    },
    {
      "title": "iOS App Development",
      "description": "High-fidelity iOS applications with CocoaPods, Apple Pay, PushKit, CallKit, and native Swift components.",
      "iconName": "apple"
    },
    {
      "title": "Firebase Integration",
      "description": "Firestore databases, Cloud Functions, FCM notifications, dynamic links, storage buckets, and auth protocols.",
      "iconName": "local_fire_department"
    },
    {
      "title": "API Integration",
      "description": "Fast and secure REST APIs, WebSockets, payment portals (Razorpay, Stripe, CCAvenue), and local database sync.",
      "iconName": "sync_alt"
    },
    {
      "title": "Bug Fixing & Tuning",
      "description": "Performance profiling, UI rendering optimization, memory leak tracing, and upgrading deprecated plugins.",
      "iconName": "bug_report"
    },
    {
      "title": "App Publishing",
      "description": "Roster management, App Store Connect, Google Play Console release config, testing tracks, and app store SEO.",
      "iconName": "publish"
    },
    {
      "title": "Flutter Consultation",
      "description": "Technical planning, state management comparisons, clean folder architecture guidance, and project audits.",
      "iconName": "forum"
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
