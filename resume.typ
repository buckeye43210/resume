#import "@preview/rustycure:0.2.0": qr-code

#set page(
  paper: "us-letter",
  margin: (top: 0.3in, bottom: 0.3in, left: 0.2in, right: 0.2in),
  numbering: none
)
#set text(font: "New Computer Modern", size: 10pt)
#set heading(numbering: none)
#set par(leading: 0.3em, justify: true)
#set list(marker: "-")
// Variables from YAML
#let title = "Holbert Resume"
#let author = "Richard L Holbert"
#let firstname = "Richard L"
#let lastname = "Holbert"
#let email = "rholbert@gmail.com"
#let mailto = link("mailto:" + email)[Richard L Holbert]
#let phone = "+1-614-582-7891"
#let street = "1254 Bensbrooke Dr"
#let citystate = "Wesley Chapel, FL 33543"
#let border = true
#let qrcode = true
#show link: it => {
  set text(blue)
  if type(it.dest) != str {
    it
  }
  else {
    underline(it)
  }
}
// Wrap all content in a rounded box for border
#box(
  fill: none,
  stroke: 0.5pt + gray,
  radius: 10pt,
  inset: (x: 0.2in, y: 0.2in),
  width: 100%,
  height: 100%,
  clip: true,
)[
  // Header
  #align(center)[
    #link("rholbert@gmail.com")[*Richard L. Holbert*] ⋄ #phone ⋄ #street, #citystate
    #v(0.3em)
  ]
  // Summary
  #heading(level: 1)[Summary]
  Senior Sys Admin and Cyber Security professional with over 30 years of experience in software and cyber engineering. Expert in Ansible, Python, and Linux system management, with a proven track record in vulnerability assessments, automation, and open-source contributions. Skilled in leading teams to achieve security objectives in high-stakes environments.
  #v(0.4em)
  // Education
  #heading(level: 1)[Education]
  B.S. in Engineering, United States Air Force Academy, Colorado Springs, CO
  
  Additional Coursework: Cryptography, Software Engineering, Data Structures, Database Design, Computational Linguistics.
  #v(0.4em)
  // Special Skills
  #heading(level: 1)[Special Skills]
  - *DevOps/Agile*: Ansible, Jira, GitHub, Bitbucket, Scrum, Kanban, Decision Trees, Mind Maps
  - *Programming Languages*: Python3, Bash, Ansible, Java, C/C++, PHP, Ada
  - *Operating Systems*: Linux, FreeBSD, Solaris, Windows, BeOS/Haiku
  - *Protocols*: DNS, LDAP, SSH, HTTP/HTTPS, SMTP, IMAP, GEMINI
  - *Assembly Languages*: Sparc, MIPS, 80x86, Z80, 6502
  #v(0.4em)
  // Experience
  #heading(level: 1)[Experience]
  *Infrastructure Engineer III* ⋄ *JPMorgan Chase* ⋄ Tampa, FL ⋄ (Apr 2025 – Present)
  - Reimplemented PERM Decsion Tree Builder in Python.
  - Supported Critical Financial infrastructure.
  *Cyber Security Engineer III* ⋄ *JPMorgan Chase* ⋄ Columbus, OH ⋄ (Sep 2018 – Mar 2025)
  - Developed Ansible playbooks as recognized SME, automating Cyber Security tool deployments.
  - Managed Tenable Nessus, ensuring system hygiene and vendor coordination.
  - Conducted vulnerability assessments on millions of network assets.
  - Contributed Markdown support to text-to-freemind open-source project.
  - Awarded AutoM8 Champion Badge for firm-wide community participation.
  *Linux System Manager* ⋄ *The Ohio State University* ⋄ Columbus, OH ⋄ (Mar 2001 – Aug 2018)
  - Administered 100+ Linux servers (Oracle, Tomcat, Zimbra, Apache).
  - Automated NIST/CIS security baselines using Puppet and Ansible.
  - Developed Python scripts to migrate 100K+ email accounts to IMAP.
  - Supported national surveys for Census Bureau and Bureau of Labor Statistics.
  *Lead Unix System Administrator* ⋄ *TEAM America Inc.* ⋄ Columbus, OH ⋄ (Oct 1998 – Mar 2001)
  - Migrated corporate Windows websites to Linux/Apache, improving performance and reducing costs.
  - Implemented multi-zone DNS and dynamic PHP/Oracle web pages.
  - Automated Oracle form/report replication using Rsync and Samba.
  *Assistant Manager, Network Operations* ⋄ *Ameritech Cellular* ⋄ Columbus, OH ⋄ (Jul 1997 – Oct 1998)
  - Upgraded cellular network to CDMA, while maintaining 25+ cell sites.
  - Managed T-1 lines, microwave links, and RF equipment.
  *Staff Engineer* ⋄ *International Consultants, Inc. (ICI)* ⋄ Dayton, OH (Jan 1997 – Jul 1997)
  - Designed hypertext Decision Support System for Air Force hazardous chemical usage.
  - Implemented Analytical Hierarchy Process (AHP) using decision trees, eliminating complex mathematics.
  *Staff Engineer* ⋄ *Aeronautical Radio, Inc. (ARINC)* ⋄ Dayton, OH (Jan 1995 – Nov 1996)
  - Advised on Public Key Infrastructure (PKI) as RSA Public Key Cryptography SME.
  - Developed GPS vehicle locator and differential GPS correction systems.
  *Embedded Software Engineer* ⋄ *HQ Air Force Materiel Command* ⋄ Wright-Patterson AFB, OH (Feb 1983 – Dec 1994)
  - Chaired Software Engineering Education Working Group for Joint Logistics Commanders.
  - Managed Air Force Ozone Depleting Chemical (ODC) policy systems.
  - IEEE POSIX standards committee representative.
  - Identified T-46 Trainer Aircraft flight handling deficiencies, confirmed by Edwards AFB test pilots.
  #v(0.4em)
  // Projects and Publications
  #heading(level: 1)[Projects and Publications]
  - “pyPERM-DecistionTree Decision Tree Builder,” Open-Source Project (Apr 2025)
  - “Configuring Perdition Proxy Using an Existing LDAP Server,” Mail Retrieval Proxy (May 2003)
  - “Using Perm Decision Tree Builder,” O’Reilly Open-Source Software Convention (Jul 2001)
  - “Micro Publishing,” O’Reilly Open-Source Software Convention (Jul 2001)  
    #h(0.4em)
	#align(bottom + right)[
      #qr-code(
	    "MECARD:N:Holbert,Richard L.;TEL:+1-614-582-7891;EMAIL:rholbert@gmail.com;URL:github.com/buckeye43210;ADR:1254 Bensbrooke Dr, Wesley Chapel, FL 33543;",
		 width: 3cm,
		 dark-color: blue,
		 light-color: white,
		 fit: "contain"
	  )
	]
]