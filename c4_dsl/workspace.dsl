workspace {

  model {
      siteAdmin = person "Site Admin" "A person who is configuring the issuer provider"
      learner = person "Learner" "A subject and holder of the VC"
      verifier = person "Verifier" "External verifier, e.g., employer or university"

      digitalWallet = softwareSystem "Digital Wallet" "Any digital wallet compatible with VC"

      # email_system = softwareSystem "Email system"
      group "Open edX" {
          edxPlatform = softwareSystem "edx-platform" "" "Python/JS"

          credentialsService = softwareSystem "edX Credentials" "Open edX credentials service that stores all user completions (credentials)" {
            verifiedCerdentialsIssuer = container "Verified Credentials Issuer" "Issues verified credentials that can be synchronized with digital credentials wallets." "A part of edX Credentials"
            VCIssuerMFE = container "VC Issuer MFE" "MFE for issuing verifiable credentials." "ReactJS"


              #  examProctoringiPlugin = container "Plugin for Exam proctoring provider" "Provides specific overrides for edx-proctoring module" "Python/JS"
              #  }



              #group "WebRTC" {
              # media servers
              #  webRTCserver = container "Web RTC Media Server" "Processes media stream and streams media to clients" "Kurento | Mediasoup"
              #webRTCAPIserver = container "Web RTC API Server" "Uses Media Server API to communicate between Media Server and Web Server" "Node.js / Rust / Java"
              #  }
              # frontend
              #  proctorSPA = container "Proctor Cabinet" "Provides interface for proctor to watch recordings/streams and report incidents" "React.js"
              #committeeSPA = container "Committee Cabinet" "Provides interface for committee member to watch recordings and review incidents reports" "React.js"
              #  electronAPP = container "Electron JS Application" "Streams media to a server. Report applications running in background." "React.js"
              #  applicantSPA = container "Applicant interaface SPA" "Provides identity validation and incedent notifications to applicant." "React.js"


              # group "backend" {
              #
              #     # backend
              #     # loadBalancer = container "Load Balancer Proxy Server" "" "Traefik"
              #     webApplication = container "Web Application" "Provides Proctoring functionality via JSON/HTTPS API." "Django"
              #     dramatiq = container "Dramatiq" "Background queues" "Python"
              #     rabbitMQ = container "Rabbit MQ" "A message broker for queues and services" "RabbitMQ"
              #     elasticSearch = container "Elastic Search" "A search implementation for proctors and Committee members" "ES8"
              #     s3Storage = container "Cloud Storage" "A storage for media files and reports" "S3"
              #     database = container "Database" "Stores user information, hashed authentication credentials, video recordings links, proctors' comments, etc." "PostreSQL" "Database"
              #     }

              # ml
              #group "ML microservices" {
              #  mlServiceIdentity = container "ML Service for Identity Verification" "Checks user's identity using ML" "Python"
              #  mlServiceVideo = container "ML Service for Computer Vision" "Monitors video for incidents" "Python"
              #}

              }
          }


      # relationships between people and software systems
      # users
      verifiedCerdentialsIssuer -> learner "Controls and notifies"
      siteAdmin -> verifiedCerdentialsIssuer "Watches recordings and streams, comments upon incidents"
      learner -> verifiedCerdentialsIssuer "Watches recordings, reads incidents reports"
      verifier -> verifiedCerdentialsIssuer "Get Public Key for verification"
      # services
      verifiedCerdentialsIssuer -> digitalWallet "Sends VC"
      # verifiedCerdentialsIssuer -> credentialsService "Gets user data"
      credentialsService -> edxPlatform "Sends completions data"
      # verifiedCerdentialsIssuer -> examEDXLMS "Monitors exam status and proctoring results"
      # verifiedCerdentialsIssuer -> email_system "Sends notification about incidents reports"



      #     # relationships to / from containers
      #     # users
      #     siteAdmin -> proctorSPA "Visits proctors cabinet to watch stream/recordings and reports incidents"
      #     learner -> committeeSPA "Inspects incidents reports and exam session recordings"
      #     userApplicant -> applicantSPA "Submits user data"
      #     userApplicant -> examEDXLMS "Passes exam"
      #     electronAPP -> userApplicant "Controls and notifies"
      #
      #
      #     # services
      #     electronAPP -> webRTCAPIserver "Sends media stream"
      #     webRTCAPIserver -> webRTCserver "Forwards media stream"
      #     webRTCAPIserver -> rabbitMQ "Publishes info about recorded videos"
      #     webRTCserver -> s3Storage "Stores media file"
      #
      #
      #     electronAPP -> webApplication "Notifies about exam's state"
      #     applicantSPA -> webApplication "Makes API Calls to" "HTTP/JSON"
      #     committeeSPA -> webApplication "Makes API Calls to" "HTTP/JSON"
      #     proctorSPA -> webApplication "Report incidents"
      #     # loadBalancer -> webApplication "Load balance the requests"
      #     webApplication -> s3Storage "Stores media"
      #     webApplication -> rabbitMQ "Sends background tasks and get recorded videos data"
      #     webApplication -> database "Reads from and writes to"
      #     webApplication -> elasticSearch "Searches and filters recordings"
      #     elasticSearch -> database "Indexes DB"
      #
      #     rabbitMQ -> dramatiq "Reads background tasks"
      #     dramatiq -> database "Reads from and writes to"
      #     dramatiq -> s3Storage "Stores reports"
      #
      #     #v2
      #     #webRTCserver -> proctorSPA "Streams media"
      #     #webRTCserver -> mlServiceVideo "Streams media"
      #     #webApplication -> mlServiceIdentity "Send user identity details"
      #     #v3
      #     #mlServiceIdentity -> rabbitMQ "Publishes results"
      #     #mlServiceVideo -> rabbitMQ "Publishes results"
      #
      #     # deployment
      #     # Dev
      #     deploymentEnvironment "Development" {
      #         deploymentNode "Developer Laptop" "" "Microsoft Windows 10, Ubuntu Linux, Apple macOS" {
      #             deploymentNode "Electron APP" "Desktop Application" "Electron.JS" {
      #                 developerElectronApplicationInstance = containerInstance electronAPP
      #                 }
      #             deploymentNode "Docker Container - Web Server" "" "Docker" {
      #                 deploymentNode "Django" "Web Application" "Django" {
      #                     developerWebApplicationInstance = containerInstance webApplication
      #                     }
      #                 }
      #             deploymentNode "Docker Container - Database Server" "" "Docker" {
      #                 deploymentNode "Database Server" "" "PostgreSQL" {
      #                     developerDatabaseInstance = containerInstance database
      #                     }
      #                 }
      #             deploymentNode "Docker Container - Storage Server" "" "Docker" {
      #                 deploymentNode "Cloud Storage" "A storage for media files and reports" "Minio" {
      #                     developerStorageInstance = containerInstance s3Storage
      #                     }
      #                 }
      #             deploymentNode "Docker Container - Media Server" "" "Docker" {
      #                 deploymentNode "Web RTC Media Server" "" "Kurento" {
      #                     developerMediaServerInstance = containerInstance webRTCserver
      #                     }
      #                 }
      #             deploymentNode "Docker Container - Media API Server" "" "Docker" {
      #                 deploymentNode "Web RTC API Media Server" "" "Node.js" {
      #                     developerAPIMediaServerInstance = containerInstance webRTCAPIserver
      #                     }
      #                 }
      #             }
      #
      #         }
      #
  }

    views {
        systemContext credentialsService "SystemContext" {
          include *
        }
        container credentialsService "Credentials" {
            include *
        }

    # animation {
    #   userApplicant
    #   siteAdmin
    #   learner
    #   verifiedCerdentialsIssuer
    #   registerSystem
    # }



    theme "https://static.structurizr.com/themes/amazon-web-services-2022.04.30/theme.json"


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
