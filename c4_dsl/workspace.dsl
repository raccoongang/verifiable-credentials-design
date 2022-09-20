workspace "Sharing Verifiable Credentials" "https://openedx.atlassian.net/wiki/spaces/OEPM/pages/3478093831/Credentials+Sharing+Verified+Credential+Initiative" {

  model {
      siteAdmin = person "Site Admin" "A person who is configuring the issuer provider"
      learner = person "Learner" "A subject and holder of the VC"
      verifier = person "Verifier" "External verifier, e.g., employer or university"

      digitalWallet = softwareSystem "Digital Wallet" "Any digital wallet compatible with VC"
      digitalBadgePlatform = softwareSystem "Digital Badge and certificate platform" "Badgr, Accredible, Credly..."

      # email_system = softwareSystem "Email system"
      openedX = softwareSystem "Open edX" "" {
          edxPlatform = container "edx-platform" "" "Python/JS"
          signAndVerify = container "Sign&Verify" "VC signing service" "JS API"
          credentialsService = container "edX Credentials" "Open edX credentials service that stores all user completions (credentials)" {
            credentialsCore = component "edX Credentials Core" "Manages program and Course certificates" "Django"
            digitalBadgesIssuer = component "Digital Badges Issuer" "Notifies external platforms about user's edX accomplishments." ""
            verifiedCerdentialsIssuer = component "Verified Credentials Issuer" "Issues verified credentials that can be synchronized with digital credentials wallets." "Django"
            VCIssuerMFE = component "VC Issuer MFE" "MFE for issuing verifiable credentials, is a part of existant MFE (credentials)." "ReactJS"
          }
          mySQL = container "MySQL" "RDBMS" "" "Database"
          mongoDB = container "MongoDB" "" "" "Database"

      }


      # data storage
      credentialsCore -> mySQL "Reads from and writes to Credentials Database" "DajngoORM"
      digitalBadgesIssuer -> mySQL "Reads from and writes to" "DajngoORM"
      verifiedCerdentialsIssuer -> mySQL "Reads from and writes to" "DajngoORM"
      edxPlatform -> mySQL "Reads from and writes to" "DajngoORM"
      edxPlatform -> mongoDB "Reads from and writes to" "Modulestore"
      signAndVerify -> mongoDB "Reads from and writes to" "mongodb"

      # software systems
      # users
        siteAdmin -> credentialsCore "Configure VC issuing"
        learner -> VCIssuerMFE "Requests verifiable credential"
        learner -> edxPlatform "Complete assignments"
        verifier -> credentialsService "Get Public Key for issuer verification"

      # services
        credentialsService -> edxPlatform "Get completions data"
        verifiedCerdentialsIssuer -> signAndVerify "Sign Verifiable Credential"



      # relationships to / from containers

      # services
      digitalWallet -> verifiedCerdentialsIssuer "Requests VC"
      verifiedCerdentialsIssuer -> digitalWallet "Sends VC"

      digitalBadgesIssuer -> digitalBadgePlatform "REST API"
      credentialsCore -> digitalBadgesIssuer "Certificate generation signal"


      # FE
      VCIssuerMFE -> verifiedCerdentialsIssuer "Get list of completions to issue VC"


    # deployment

  }

    views {
        systemContext openedX "SystemContext" {
          include *
        }
        container openedX "OpenedX" {
            include *
        }
        component credentialsService "Credentials" {
            include *
            animation {
                signAndVerify
            }
        }



    #theme "https://static.structurizr.com/themes/amazon-web-services-2022.04.30/theme.json"


    styles {
      element "Person" {
        color  "#ffffff"
        fontSize 22
        shape Person
      }
      element "Customer" {
        background  "#08427b"
      }
      element "Bank Staff" {
        background  "#999999"
      }
      element "Software System" {
        background  "#1168bd"
        color  "#ffffff"
      }
      element "Existing System" {
        background  "#999999"
        color  "#ffffff"
      }
      element "Container" {
        background  "#438dd5"
        color  "#ffffff"
      }
      element "Web Browser" {
        shape WebBrowser
      }
      element "Mobile App" {
        shape MobileDeviceLandscape
      }
      element "Database" {
        shape Cylinder
      }
      element "Cloud Storage" {
        shape Cylinder
      }
      element "s3Storage" {
        shape Cylinder
      }
      element "Component" {
        background  "#85bbf0"
        color  "#000000"
      }
      element "Failover" {
        opacity 25
      }
    }
  }

}
