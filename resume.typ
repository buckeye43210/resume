#import "@preview/rustycure:0.2.0": qr-code
#import "@preview/diagraph:0.3.6"

#set text(font: "teX Gyre Pagella", size: 9.75pt)
#set heading(numbering: none)
#set par(leading: 0.3em, justify: true)
#set list(marker: [⋄], indent: 0.4em)
// Variables from YAML

#set document(
  title:    "Holbert – Résumé",
  author:   "Richard L. Holbert",
  keywords: "Cybersecurity, Ansible, Linux, Automation, DevOps, Python",
  date:     auto,
)

#let firstname = "Richard L"
#let lastname = "Holbert"
#let email = "rholbert@gmail.com"
#let mailto = link("mailto:" + email)[Richard L Holbert]
#let phone = "(614) 582-7891"
#let street = "1254 Bensbrooke Dr"
#let citystate = "Wesley Chapel, FL 33543"
#let qrcode = true
#let border = true

#set page(
  paper: "us-letter",
  margin: (top: 0.5in, bottom: 0.25in, left: 0.4in, right: 0.5in),
  numbering: none,
  background: if border [
    #place(
      top + left,
      dx: 0.50em,      // shift right
      dy: 0.25em,      // shift down
    )[
      #image("images/border01.pdf", width: 100%, height: 100%)
    ]
  ]
)


#show link: it => {
  set text(blue)
  if type(it.dest) != str {
    it
  }
  else {
    underline(it)
  }
}
  // Header
  #align(left)[
    #link("rholbert@gmail.com")[*Richard L. Holbert*] ⋄ #phone ⋄ #street, #citystate
  
  #v(0.25em)
  
  // Summary
  #heading(level: 1)[Summary]
  Senior Systems & Cyber Security Engineer with 30+ years leading infrastructure automation,vulnerability management,\
  and secure Linux environments in finance and government.
  Recognized Ansible/Python expert, open-source contributor,\
  and automation evangelist.
    
  // Education
  #heading(level: 1)[Education]
  B.S. in Engineering, **United States Air Force Academy**, Colorado Springs, CO

  Additional Coursework: Cryptography, Software Engineering, Data Structures, Computational Linguistics.

  // Core Technical Skills
  #heading(level: 1)[Core Technical Skills]
  - *DevOps & Automation*: Ansible (SME), Puppet, GitHub, Bitbucket, Jira, Kanban, Scrum
  - *Languages*: Python, Bash, Java, C/C++, Ada, PHP, ALGOL, FORTRAN
  - *Assembly*: x86_64, SPARC, MIPS, Z80, 6502
  - *OS*: Linux (RHEL, Debian, etc.), FreeBSD, Solaris, VMS, Windows
  - *Protocols & Services*: DNS, LDAP, SSH, GEMINI, HTTP, HTTPS, SMTP, POP, IMAP, GEMINI, etc.

  // Experience
  #heading(level: 1)[Professional Experience]
  
  *Infrastructure Engineer III* ⋄ *JPMorgan Chase* ⋄ Tampa, FL ⋄ Apr 2025 – Present
  
  - Reimplemented PERM Decision Tree Builder in Python
  - Mentored team on Documentation-as-Code and advanced Ansible practices
  - Supported critical financial infrastructure
  
  *Cyber Security Engineer III* ⋄ *JPMorgan Chase* ⋄ Columbus, OH ⋄ Sep 2018 – Mar 2025
  
  - Developed enterprise-wide Ansible playbooks as recognized subject-matter expert, automating\
    security-agent deployments
  - Managed Tenable Nessus vulnerability program across millions of assets
  - Contributed Markdown → FreeMind converter to open-source text-to-freemind project
  - Earned firm-wide AutoM8 Champion Badge for automation leadership

  *Linux System Manager* ⋄ *The Ohio State University* ⋄ Columbus, OH ⋄ Mar 2001 – Aug 2018
  
  - Administered 100+ Linux servers (Oracle, Tomcat, Apache, Zimbra Mail Server)
  - Automated NIST/CIS security hardening with Puppet and Ansible
  - Wrote Python tools to migrate 100,000+ email accounts to IMAP
  - Provided Linux support for U.S. Census Bureau and Bureau of Labor Statistics national surveys
  
  *Lead Unix System Administrator* ⋄ *TEAM America Inc.* ⋄ Columbus, OH ⋄ Oct 1998 – Mar 2001
  
  - Migrated corporate Windows web stack to Linux/Apache, cutting costs and boosting performance
  - Implemented multi-zone BIND DNS and dynamic PHP/Oracle web sites
  
  *Assistant Manager, Network Operations* ⋄ *Ameritech Cellular* ⋄ Columbus, OH ⋄ Jul 1997 – Oct 1998
  
  - Led analog-to-CDMA network upgrade while maintaining 25+ legacy cell sites

  *Staff Engineer* ⋄ *International Consultants, Inc. (ICI)* ⋄ Dayton, OH ⋄ Jan 1997 – Jul 1997
  
  - Designed hypertext decision-support system for Air Force hazardous-chemical tracking
  - Replaced Analytical Hierarchy Process (AHP) with decision-tree model, eliminating matrix math

  *Staff Engineer* ⋄ *Aeronautical Radio, Inc. (ARINC)* ⋄ Dayton, OH ⋄ Jan 1995 – Nov 1996
  
  - Served as corporate RSA/PKI subject-matter expert
  - Developed GPS vehicle-tracking and differential-correction systems
  
  *Embedded Software Engineer* ⋄ *HQ AFMC* ⋄ Wright-Patterson AFB, OH ⋄ Feb 1983 – Dec 1994
  
  - Chaired Joint Logistics Commanders Software Engineering Education Working Group
  - Represented Air Force on IEEE POSIX standards committee
  - Identified critical flight-handling deficiency in T-46 Trainer (confirmed by USAF test pilots)
  
  // Projects and Publications
  #heading(level: 1)[Projects and Publications]
  
  - “pyPERM-DecistionTree Decision Tree Builder,” Open-Source Project (Apr 2025)
  - “Configuring Perdition Mail Proxy Using an Existing LDAP Server,” (May 2003)
  - “Using Perm Decision Tree Builder,” O’Reilly Open-Source Software Convention (Jul 2001)
  #h(0.25em)
  #if qrcode [
    #place(
      bottom + right,
      dx: +0.5cm,   // distance from right edge
      dy: -0.5cm,   // distance from bottom edge
    )[
    #qr-code(
       "MECARD:N:Holbert,Richard L.;
		TEL:+1-614-582-7891;
		EMAIL:rholbert@gmail.com;
		URL:github.com/buckeye43210;
		ADR:1254 Bensbrooke Dr, Wesley Chapel, FL 33543;",
   width: 3cm,
   dark-color: navy,
   light-color: white,
   fit: "contain"
  )]
 ]
]