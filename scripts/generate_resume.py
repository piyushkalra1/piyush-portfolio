import os
import sys
from reportlab.lib.pagesizes import letter
from reportlab.lib import colors
from reportlab.platypus import (
    SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle, HRFlowable, KeepTogether, PageBreak
)
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.pdfgen import canvas

class NumberedCanvas(canvas.Canvas):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._saved_page_states = []

    def showPage(self):
        self._saved_page_states.append(dict(self.__dict__))
        self._startPage()

    def save(self):
        num_pages = len(self._saved_page_states)
        for state in self._saved_page_states:
            self.__dict__.update(state)
            self.draw_page_number(num_pages)
            canvas.Canvas.showPage(self)
        canvas.Canvas.save(self)

    def draw_page_number(self, page_count):
        self.saveState()
        self.setFont("Helvetica", 8)
        self.setFillColor(colors.HexColor("#64748B"))
        # Top right header
        self.drawString(32, 762, "Piyush Kalra — Lead Flutter Engineer & Mobile Consultant")
        self.drawRightString(580, 762, "piyush.kumar.kalra@gmail.com | +91 8949581867")
        self.setStrokeColor(colors.HexColor("#CBD5E1"))
        self.setLineWidth(0.5)
        self.line(32, 756, 580, 756)
        
        # Bottom footer
        page_text = f"Page {self._pageNumber} of {page_count}"
        self.drawRightString(580, 20, page_text)
        self.drawString(32, 20, "Confidential • Available for High-Impact Senior Roles & High-Ticket Freelance / MVP Contracts")
        self.line(32, 28, 580, 28)
        self.restoreState()


def build_resume(pdf_path):
    doc = SimpleDocTemplate(
        pdf_path,
        pagesize=letter,
        leftMargin=32,
        rightMargin=32,
        topMargin=46,
        bottomMargin=36
    )

    styles = getSampleStyleSheet()

    # Colors
    c_primary = colors.HexColor("#0F172A")    # Deep slate
    c_accent = colors.HexColor("#0284C7")     # Sky / Cyan accent
    c_sub = colors.HexColor("#334155")        # Slate 700
    c_muted = colors.HexColor("#64748B")      # Slate 500
    c_gold = colors.HexColor("#D97706")       # Amber for Clutch review

    # Custom styles
    title_style = ParagraphStyle(
        'DocTitle',
        parent=styles['Normal'],
        fontName='Helvetica-Bold',
        fontSize=20,
        leading=22,
        textColor=c_primary,
        spaceAfter=2
    )

    subtitle_style = ParagraphStyle(
        'DocSubtitle',
        parent=styles['Normal'],
        fontName='Helvetica-Bold',
        fontSize=10,
        leading=13,
        textColor=c_accent,
        spaceAfter=4
    )

    contact_style = ParagraphStyle(
        'ContactText',
        parent=styles['Normal'],
        fontName='Helvetica',
        fontSize=8.2,
        leading=11,
        textColor=c_sub
    )

    section_header_style = ParagraphStyle(
        'SectionHeader',
        parent=styles['Normal'],
        fontName='Helvetica-Bold',
        fontSize=10,
        leading=12,
        textColor=c_primary,
        spaceBefore=7,
        spaceAfter=3,
        keepWithNext=True
    )

    body_style = ParagraphStyle(
        'Body',
        parent=styles['Normal'],
        fontName='Helvetica',
        fontSize=8.2,
        leading=11.2,
        textColor=c_sub
    )

    bullet_style = ParagraphStyle(
        'BulletItem',
        parent=styles['Normal'],
        fontName='Helvetica',
        fontSize=8.1,
        leading=10.8,
        textColor=c_sub,
        leftIndent=10,
        firstLineIndent=-10,
        spaceAfter=2
    )

    role_title_style = ParagraphStyle(
        'RoleTitle',
        parent=styles['Normal'],
        fontName='Helvetica-Bold',
        fontSize=9,
        leading=11.5,
        textColor=c_primary
    )

    role_meta_style = ParagraphStyle(
        'RoleMeta',
        parent=styles['Normal'],
        fontName='Helvetica-Oblique',
        fontSize=8.2,
        leading=11,
        textColor=c_muted,
        alignment=2 # Right align
    )

    company_style = ParagraphStyle(
        'Company',
        parent=styles['Normal'],
        fontName='Helvetica-Bold',
        fontSize=8.5,
        leading=11,
        textColor=c_accent
    )

    story = []

    # ==================== HEADER ====================
    header_data = [
        [
            Paragraph("<b>PIYUSH KALRA</b>", title_style),
            Paragraph("<b>🟢 Available for Senior Roles & Freelance / MVPs</b><br/><font color='#D97706'><b>★ 5.0 Clutch.co Verified Rating</b></font>", role_meta_style)
        ],
        [
            Paragraph("<b>Lead Flutter Engineer & Mobile Consultant</b> | 4+ Years Production Experience (Since Oct 2022)", subtitle_style),
            ""
        ],
        [
            Paragraph("<b>Location:</b> Jaipur, India (Open to Remote / Relocation) &nbsp;|&nbsp; <b>Phone:</b> +91 8949581867 &nbsp;|&nbsp; <b>Email:</b> piyush.kumar.kalra@gmail.com<br/><b>LinkedIn:</b> linkedin.com/in/piyush-kumar-kalra &nbsp;|&nbsp; <b>GitHub:</b> github.com/piyush-kalra &nbsp;|&nbsp; <b>Portfolio:</b> piyushkalra1.github.io/piyush-portfolio", contact_style),
            ""
        ]
    ]

    header_table = Table(header_data, colWidths=[370, 178])
    header_table.setStyle(TableStyle([
        ('VALIGN', (0,0), (-1,-1), 'TOP'),
        ('SPAN', (0,1), (1,1)),
        ('SPAN', (0,2), (1,2)),
        ('LEFTPADDING', (0,0), (-1,-1), 0),
        ('RIGHTPADDING', (0,0), (-1,-1), 0),
        ('TOPPADDING', (0,0), (-1,-1), 0),
        ('BOTTOMPADDING', (0,0), (-1,-1), 1),
    ]))
    story.append(header_table)
    story.append(Spacer(1, 4))
    story.append(HRFlowable(width="100%", thickness=1, color=c_accent, spaceBefore=2, spaceAfter=5))

    # ==================== EXECUTIVE SUMMARY ====================
    story.append(Paragraph("EXECUTIVE SUMMARY (DUAL TARGET: ENTERPRISE LEADERSHIP & SALES/FREELANCE MVP)", section_header_style))
    summary_text = (
        "Accomplished <b>Lead Flutter Engineer & Mobile Consultant</b> with <b>4+ years of production experience</b> (since October 2022) "
        "architecting and deploying scalable Android, iOS, and Web solutions. Delivered <b>15+ applications to production</b> on Google Play Store "
        "and Apple App Store with <b>100K+ combined downloads</b> and 100% 5-star client satisfaction (verified on Clutch.co). "
        "Proven expertise bridging hardware & mobile software—including <b>NFC / RFID tag scanning</b>, Bluetooth Low Energy (BLE), and child safety <b>Kiosk Mode</b>. "
        "Specialized in rapid MVP launches (idea to store in 4–6 weeks), Clean Architecture, BLoC/Provider state management, in-app subscriptions, and payment integrations."
    )
    story.append(Paragraph(summary_text, body_style))
    story.append(Spacer(1, 4))
    story.append(HRFlowable(width="100%", thickness=0.5, color=colors.HexColor("#E2E8F0"), spaceBefore=2, spaceAfter=4))

    # ==================== TECHNICAL SKILLS MATRIX ====================
    story.append(Paragraph("TECHNICAL SKILLS & EXPERTISE MATRIX", section_header_style))
    skills_data = [
        [
            Paragraph("<b>Mobile & IoT Frameworks:</b>", role_title_style),
            Paragraph("Flutter (Android, iOS & Web), Dart, NFC & RFID Tag Hardware Readers, Kiosk Mode / App Pinning, BLE", body_style)
        ],
        [
            Paragraph("<b>Architecture & Practices:</b>", role_title_style),
            Paragraph("Clean Architecture, MVVM, SOLID Principles, Repository Pattern, Multi-Package Modularization, App Profiling", body_style)
        ],
        [
            Paragraph("<b>State Management:</b>", role_title_style),
            Paragraph("BLoC / Cubit, Provider, GetX, Riverpod", body_style)
        ],
        [
            Paragraph("<b>Native Platform & Languages:</b>", role_title_style),
            Paragraph("Kotlin, Swift, Java, MethodChannels, Native EventChannels, CocoaPods, Gradle", body_style)
        ],
        [
            Paragraph("<b>Cloud, Backend & APIs:</b>", role_title_style),
            Paragraph("Firebase (Auth, Firestore, Cloud Functions, Storage, Crashlytics), FCM, PushKit, Supabase, REST APIs, WebSockets", body_style)
        ],
        [
            Paragraph("<b>Payments & Subscriptions:</b>", role_title_style),
            Paragraph("In-App Purchases (Apple StoreKit, Google Play Billing), Razorpay, Stripe, CCAvenue, Mollie, Apple/Google Pay", body_style)
        ],
        [
            Paragraph("<b>Database & Security:</b>", role_title_style),
            Paragraph("SQLite, Hive, Flutter Secure Storage, Biometric Auth (FaceID / Fingerprint), Token Session Encryption", body_style)
        ],
        [
            Paragraph("<b>DevOps & Publishing:</b>", role_title_style),
            Paragraph("Google Play Console, Apple App Store Connect, TestFlight release management, CI/CD, Git, GitHub Actions", body_style)
        ],
    ]
    skills_table = Table(skills_data, colWidths=[155, 393])
    skills_table.setStyle(TableStyle([
        ('VALIGN', (0,0), (-1,-1), 'TOP'),
        ('LEFTPADDING', (0,0), (-1,-1), 0),
        ('RIGHTPADDING', (0,0), (-1,-1), 0),
        ('TOPPADDING', (0,0), (-1,-1), 1),
        ('BOTTOMPADDING', (0,0), (-1,-1), 1),
    ]))
    story.append(skills_table)
    story.append(Spacer(1, 4))
    story.append(HRFlowable(width="100%", thickness=0.5, color=colors.HexColor("#E2E8F0"), spaceBefore=2, spaceAfter=4))

    # ==================== WORK EXPERIENCE ====================
    story.append(Paragraph("PROFESSIONAL WORK EXPERIENCE", section_header_style))

    # Experience 1: Inventco
    exp1_header = [
        [
            Paragraph("<b>Flutter Developer (Lead)</b>", role_title_style),
            Paragraph("<b>Aug 2024 – Present</b> | Jaipur, India", role_meta_style)
        ],
        [
            Paragraph("<b>Inventco Software Pvt. Ltd.</b> — Enterprise & Mobile Product Engineering", company_style),
            ""
        ]
    ]
    t1 = Table(exp1_header, colWidths=[360, 188])
    t1.setStyle(TableStyle([
        ('VALIGN', (0,0), (-1,-1), 'TOP'),
        ('LEFTPADDING', (0,0), (-1,-1), 0),
        ('RIGHTPADDING', (0,0), (-1,-1), 0),
        ('TOPPADDING', (0,0), (-1,-1), 0),
        ('BOTTOMPADDING', (0,0), (-1,-1), 1),
    ]))
    story.append(t1)
    story.append(Spacer(1, 2))
    story.append(Paragraph("• <b>Hardware & IoT Integration:</b> Spearheaded engineering of <i>BLB Librarian (Better Letter Book)</i>, connecting physical children's books via NFC/RFID tag scanning with a parent-controlled Child Safety Kiosk Mode restricting device escape.", bullet_style))
    story.append(Paragraph("• <b>Architecture & Standards:</b> Standardized enterprise Clean Architecture across development pipelines, introducing repository patterns and reducing codebase technical debt across 5 concurrent projects.", bullet_style))
    story.append(Paragraph("• <b>Team Leadership & Code Quality:</b> Directed team of Flutter developers; conducted structured PR reviews, sprint planning, and automated CI/CD builds, achieving 99.8% crash-free sessions on production releases.", bullet_style))
    story.append(Paragraph("• <b>Client Consultation & Discovery:</b> Interfaced directly with founders from USA, Netherlands, and UAE to translate product vision into scalable technical blueprints and rapid milestone deliverables.", bullet_style))
    story.append(Spacer(1, 4))

    # Experience 2: Solvebee
    exp2_header = [
        [
            Paragraph("<b>Flutter Developer</b>", role_title_style),
            Paragraph("<b>Feb 2023 – Aug 2024</b> | Jaipur, India", role_meta_style)
        ],
        [
            Paragraph("<b>Solvebee IT Services Pvt. Ltd.</b> — Full-Cycle Software Solutions", company_style),
            ""
        ]
    ]
    t2 = Table(exp2_header, colWidths=[360, 188])
    t2.setStyle(TableStyle([
        ('VALIGN', (0,0), (-1,-1), 'TOP'),
        ('LEFTPADDING', (0,0), (-1,-1), 0),
        ('RIGHTPADDING', (0,0), (-1,-1), 0),
        ('TOPPADDING', (0,0), (-1,-1), 0),
        ('BOTTOMPADDING', (0,0), (-1,-1), 1),
    ]))
    story.append(t2)
    story.append(Spacer(1, 2))
    story.append(Paragraph("• <b>Production App Delivery:</b> Developed and maintained multiple enterprise mobile applications across fintech, insurance (Probus Insurance), and education (Govt RAS Club, Spelenderwijs) on Android and iOS.", bullet_style))
    story.append(Paragraph("• <b>Payment Gateways:</b> Engineered multi-provider checkout systems (Stripe, Razorpay, CCAvenue) with automatic transaction reconciliation and biometric authentication.", bullet_style))
    story.append(Paragraph("• <b>Performance Optimization:</b> Refactored heavy widget trees and cached network queries, boosting app startup time by 35% and slashing memory leaks.", bullet_style))
    story.append(Paragraph("• <b>Store Publishing:</b> Managed 10+ Google Play Store and Apple App Store deployments, handling compliance, review guidelines, and TestFlight beta releases.", bullet_style))
    story.append(Spacer(1, 4))

    # Experience 3: Aimerse
    exp3_header = [
        [
            Paragraph("<b>Flutter Intern</b>", role_title_style),
            Paragraph("<b>Oct 2022 – Dec 2022</b> | Remote / Jaipur", role_meta_style)
        ],
        [
            Paragraph("<b>Aimerse Technology</b> — Mobile Application Lab", company_style),
            ""
        ]
    ]
    t3 = Table(exp3_header, colWidths=[360, 188])
    t3.setStyle(TableStyle([
        ('VALIGN', (0,0), (-1,-1), 'TOP'),
        ('LEFTPADDING', (0,0), (-1,-1), 0),
        ('RIGHTPADDING', (0,0), (-1,-1), 0),
        ('TOPPADDING', (0,0), (-1,-1), 0),
        ('BOTTOMPADDING', (0,0), (-1,-1), 1),
    ]))
    story.append(t3)
    story.append(Spacer(1, 2))
    story.append(Paragraph("• Built responsive cross-platform UI components and integrated RESTful APIs with Provider state management.", bullet_style))
    story.append(Paragraph("• Implemented automated unit testing, fixed UI bugs, and established fundamental mastery of Flutter framework internals.", bullet_style))

    # ==================== PAGE BREAK TO PAGE 2 ====================
    story.append(PageBreak())

    # ==================== PAGE 2: FLAGSHIP PROJECTS ====================
    story.append(Paragraph("FLAGSHIP PROJECTS & PRODUCTION DELIVERABLES", section_header_style))

    # Project 1: BLB Librarian
    proj1_header = [
        [
            Paragraph("<b>BLB Librarian (Better Letter Book) — IoT & NFC/RFID Smart Learning Platform</b>", role_title_style),
            Paragraph("<b>IoT & EdTech Flagship</b>", role_meta_style)
        ]
    ]
    p1 = Table(proj1_header, colWidths=[410, 138])
    p1.setStyle(TableStyle([
        ('VALIGN', (0,0), (-1,-1), 'TOP'),
        ('LEFTPADDING', (0,0), (-1,-1), 0),
        ('RIGHTPADDING', (0,0), (-1,-1), 0),
        ('TOPPADDING', (0,0), (-1,-1), 0),
        ('BOTTOMPADDING', (0,0), (-1,-1), 1),
    ]))
    story.append(p1)
    story.append(Paragraph("<i>Tech: Flutter, NFC / RFID Tag Scanning, Kiosk Mode / Safety Lock, In-App Subscriptions, Media Storage Quota, Clean Architecture</i>", company_style))
    story.append(Paragraph("• <b>Hardware Tag Pairing:</b> Engineered native NFC/RFID reader interfaces to pair physical book tags with digital lessons upon physical tap.", bullet_style))
    story.append(Paragraph("• <b>Parental Safety Kiosk Mode:</b> Built app-pinning safety lock restricting children solely to parent-curated learning content without app exit.", bullet_style))
    story.append(Paragraph("• <b>Multi-Child Management:</b> Architected 'Little Ones' child profiles with personalized library access, audio phonics, and offline media caching.", bullet_style))
    story.append(Paragraph("• <b>Tiered In-App Subscriptions:</b> Implemented dynamic monthly/yearly billing (Free, Family, Premium) with device limits and real-time cloud storage quota tracking (up to 200 GB tier).", bullet_style))
    story.append(Spacer(1, 4))

    # Project 2: Dunnnit
    proj2_header = [
        [
            Paragraph("<b>Dunnnit — Social Challenge & Habit Tracking Platform</b> (Google Play & App Store)", role_title_style),
            Paragraph("<font color='#D97706'><b>★ 5.0 Clutch Verified Review</b></font>", role_meta_style)
        ]
    ]
    p2 = Table(proj2_header, colWidths=[380, 168])
    p2.setStyle(TableStyle([
        ('VALIGN', (0,0), (-1,-1), 'TOP'),
        ('LEFTPADDING', (0,0), (-1,-1), 0),
        ('RIGHTPADDING', (0,0), (-1,-1), 0),
        ('TOPPADDING', (0,0), (-1,-1), 0),
        ('BOTTOMPADDING', (0,0), (-1,-1), 1),
    ]))
    story.append(p2)
    story.append(Paragraph("<i>Tech: Flutter, Firebase, REST APIs, In-App Purchases (StoreKit/Play Billing), WebSockets, Dynamic Links</i>", company_style))
    story.append(Paragraph("• Architected from scratch using clean MVVM with Provider; built daily check-in verification with photo uploads and social community feeds.", bullet_style))
    story.append(Paragraph("• Integrated Apple StoreKit and Google Play Billing for in-app subscriptions and token purchases; implemented real-time chat and dynamic links.", bullet_style))
    story.append(Paragraph("• <b>Verified Client Impact:</b> Earned 5.0 Clutch review from CEO Branko Radovic praising technical knowledge, fast responses, and practical solutions.", bullet_style))
    story.append(Spacer(1, 4))

    # Project 3: Probus Insurance
    proj3_header = [
        [
            Paragraph("<b>Probus Insurance — Enterprise Policy Comparison & Instant Checkout</b>", role_title_style),
            Paragraph("<b>Enterprise Fintech</b>", role_meta_style)
        ]
    ]
    p3 = Table(proj3_header, colWidths=[410, 138])
    p3.setStyle(TableStyle([
        ('VALIGN', (0,0), (-1,-1), 'TOP'),
        ('LEFTPADDING', (0,0), (-1,-1), 0),
        ('RIGHTPADDING', (0,0), (-1,-1), 0),
        ('TOPPADDING', (0,0), (-1,-1), 0),
        ('BOTTOMPADDING', (0,0), (-1,-1), 1),
    ]))
    story.append(p3)
    story.append(Paragraph("<i>Tech: Flutter, Razorpay, Stripe, CCAvenue, Biometric Auth, Hive Local Storage, REST APIs</i>", company_style))
    story.append(Paragraph("• Engineered multi-tier insurance policy discovery and purchase portal (car, health, marine, property) with instant PDF receipt generation.", bullet_style))
    story.append(Paragraph("• Integrated biometric login, encrypted local storage via Hive, and seamless multi-channel payment gateway callbacks.", bullet_style))
    story.append(Spacer(1, 4))

    # Project 4: Spelenderwijs Verbeteren
    proj4_header = [
        [
            Paragraph("<b>Spelenderwijs Verbeteren — Sports Analytics & Korfball Training Platform</b>", role_title_style),
            Paragraph("<b>Netherlands Client (Video Verified)</b>", role_meta_style)
        ]
    ]
    p4 = Table(proj4_header, colWidths=[380, 168])
    p4.setStyle(TableStyle([
        ('VALIGN', (0,0), (-1,-1), 'TOP'),
        ('LEFTPADDING', (0,0), (-1,-1), 0),
        ('RIGHTPADDING', (0,0), (-1,-1), 0),
        ('TOPPADDING', (0,0), (-1,-1), 0),
        ('BOTTOMPADDING', (0,0), (-1,-1), 1),
    ]))
    story.append(p4)
    story.append(Paragraph("<i>Tech: Flutter, Custom Canvas Charts, SQLite Offline Caching, Video Progress Tracking</i>", company_style))
    story.append(Paragraph("• Built custom animated performance charts, training exercises, and offline SQLite synchronization for Dutch sports teams.", bullet_style))
    story.append(Paragraph("• <b>Verified Client Impact:</b> Founder Tim van den Berg commended collaborative engineering and continuous improvement in public video feedback.", bullet_style))
    story.append(Spacer(1, 4))

    # Project 5: Govt RAS Club
    proj5_header = [
        [
            Paragraph("<b>Govt RAS (RAS Club) — Civil Service E-Learning & Banquet Booking Portal</b>", role_title_style),
            Paragraph("<b>Govt. Compliance Platform</b>", role_meta_style)
        ]
    ]
    p5 = Table(proj5_header, colWidths=[410, 138])
    p5.setStyle(TableStyle([
        ('VALIGN', (0,0), (-1,-1), 'TOP'),
        ('LEFTPADDING', (0,0), (-1,-1), 0),
        ('RIGHTPADDING', (0,0), (-1,-1), 0),
        ('TOPPADDING', (0,0), (-1,-1), 0),
        ('BOTTOMPADDING', (0,0), (-1,-1), 1),
    ]))
    story.append(p5)
    story.append(Paragraph("<i>Tech: Flutter, Razorpay, PDF Viewers, Interactive Calendar Booking Widget, Session Management</i>", company_style))
    story.append(Paragraph("• Multipurpose platform delivering Rajasthan civil service examination prep courses and real-time room/banquet booking for state officers.", bullet_style))
    story.append(Spacer(1, 4))
    story.append(HRFlowable(width="100%", thickness=0.5, color=colors.HexColor("#E2E8F0"), spaceBefore=2, spaceAfter=4))

    # ==================== CLIENT TESTIMONIALS ====================
    story.append(Paragraph("VERIFIED CLIENT TESTIMONIALS & SOCIAL PROOF", section_header_style))

    test1 = (
        "<b>\"Special thanks to Piyush for technical knowledge & practical solutions\"</b><br/>"
        "<i>\"A special thanks to Piyush for his technical knowledge, quick responses, and great collaboration. He thought continuously "
        "and knew how to translate our wishes into practical solutions. The team successfully deployed the app on iOS and Android platforms.\"</i><br/>"
        "— <b>Branko Radovic</b>, CEO, Dunnnit (Abu Dhabi, UAE) • <b>5.0 ★ Verified Clutch.co Review</b>"
    )
    story.append(Paragraph(test1, body_style))
    story.append(Spacer(1, 3))

    test2 = (
        "<b>\"The team worked with us, not just for us\"</b><br/>"
        "<i>\"It wasn't just about building an app — it was about refining ideas, revisiting decisions, testing possibilities, and continuously "
        "improving the product together. Heartfelt appreciation to Piyush and the team for making this collaboration a success.\"</i><br/>"
        "— <b>Tim van den Berg</b>, Founder & Product Owner, Spelenderwijs Verbeteren (Netherlands) • <b>Public Video Reel Review</b>"
    )
    story.append(Paragraph(test2, body_style))
    story.append(Spacer(1, 3))

    test3 = (
        "<b>\"Clean architecture, seamless payment & production stability\"</b><br/>"
        "<i>\"Piyush architected and delivered our multi-policy insurance application for Android & iOS with modular clean code, robust session management, "
        "and smooth payment gateway checkout with Razorpay and Stripe.\"</i><br/>"
        "— <b>Senior Product Leadership</b>, Probus Insurance Brokerage (Mumbai, India)"
    )
    story.append(Paragraph(test3, body_style))
    story.append(Spacer(1, 4))
    story.append(HRFlowable(width="100%", thickness=0.5, color=colors.HexColor("#E2E8F0"), spaceBefore=2, spaceAfter=4))

    # ==================== EDUCATION & CERTIFICATIONS ====================
    story.append(Paragraph("EDUCATION & PROFESSIONAL CREDENTIALS", section_header_style))
    edu_data = [
        [
            Paragraph("<b>Bachelor of Science (B.Sc.)</b>", role_title_style),
            Paragraph("<b>Raj Rishi Bhartrihari Matsya University (RRBMU)</b>, Alwar, India", role_meta_style)
        ],
        [
            Paragraph("<b>Professional Flutter Bootcamp Certification</b>", role_title_style),
            Paragraph("Dart OOP, Clean Architecture, BLoC & Cross-Platform UI Specialization", role_meta_style)
        ],
        [
            Paragraph("<b>POSP Certified Insurance Broker Representative</b>", role_title_style),
            Paragraph("Probus Insurance Brokerage — Financial & Insurance Tech Workflow Specialist", role_meta_style)
        ],
        [
            Paragraph("<b>RSCIT Qualification (Rajasthan Govt. Approved)</b>", role_title_style),
            Paragraph("State Government Computer & IT Qualification", role_meta_style)
        ],
    ]
    edu_table = Table(edu_data, colWidths=[270, 278])
    edu_table.setStyle(TableStyle([
        ('VALIGN', (0,0), (-1,-1), 'TOP'),
        ('LEFTPADDING', (0,0), (-1,-1), 0),
        ('RIGHTPADDING', (0,0), (-1,-1), 0),
        ('TOPPADDING', (0,0), (-1,-1), 1),
        ('BOTTOMPADDING', (0,0), (-1,-1), 1),
    ]))
    story.append(edu_table)

    # Build PDF
    doc.build(story, canvasmaker=NumberedCanvas)
    print(f"Successfully generated: {pdf_path}")

if __name__ == "__main__":
    out_path = os.path.abspath("assets/resume/Piyush_Kalra_Resume.pdf")
    build_resume(out_path)
