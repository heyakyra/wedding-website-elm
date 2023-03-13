module Data exposing (..)

---- HEADING ----


siteInfo : { partner1 : String, partner2 : String, tagline : String, homeLink : String }
siteInfo =
    { partner1 = "Syrah"
    , partner2 = "Riesling"
    , tagline = ""
    , homeLink = "https://gitlab.com/heyakyra/wedding-website-elm"
    }


geoLocation : { address : List String, mapSrc : String, mapUrl : String, geoUri : String }
geoLocation =
    { address = [ "Multicultural Arts Center", "41 Second Street", "Cambridge, MA 02141" ]
    , mapSrc = "https://www.openstreetmap.org/export/embed.html?bbox=-71.08143568038942%2C42.368661211509284%2C-71.07652187347414%2C42.37127103054605&amp;layer=mapnik&amp;marker=42.36996613458209%2C-71.07897877693176"
    , mapUrl = "https://www.openstreetmap.org/node/10617252173"
    , geoUri = "geo:42.3699661,-71.0789734?z=19"
    }



---- MAIN ----


aboutInfo : { whenHeading : String, when : String, imgSrc : String, imgAlt : String, registryUrl : String, rsvpUrl : String, contactEmail : String }
aboutInfo =
    { whenHeading = "We hope you will join us in Cambridge, Massachusetts"
    , when = "July 15ᵗʰ, 2024"
    , imgSrc = "images/aboutBg.jpg"
    , imgAlt = "Multicultural Arts Center Logo"
    , registryUrl = "https://www.usworker.coop/shopcoop/"
    , rsvpUrl = "https://ohmyform.com/"
    , contactEmail = ""
    }


quoteText : List (List String)
quoteText =
    [ [ "in love"
      , "there are no closed doors"
      , "each threshold"
      , "an invitation"
      , "to cross"
      , "take hold"
      , "take heart"
      , "and enter here"
      , "at this point"
      , "where truth"
      , "was once denied"
      ]
    ]


affirmation : { quote : List String, author : String }
affirmation =
    { quote =
        [ "Let this be my summertime"
        , "Of azure sky and rolling sea.."
        ]
    , author = "James Baldwin, Paradise"
    }


type alias Session =
    { title : String
    , sessionDescription : String
    , sessionLocation : String
    }


type alias AgendaSlot =
    { slotTime : String
    , slotType : String
    , sessions : List Session
    }


agenda : List { day : String, slots : List AgendaSlot }
agenda =
    [ { day = "Saturday, July 15"
      , slots =
            [ { slotTime = "4:45 PM"
              , slotType = ""
              , sessions =
                    [ { title = "Arrival"
                      , sessionDescription = ""
                      , sessionLocation = "Bulfinch Square"
                      }
                    ]
              }
            , { slotTime = "5:00 PM"
              , slotType = ""
              , sessions =
                    [ { title = "Ceremony"
                      , sessionDescription = ""
                      , sessionLocation = "Centanni Park"
                      }
                    ]
              }
            , { slotTime = "5:30 PM"
              , slotType = ""
              , sessions =
                    [ { title = "Cocktail Hour"
                      , sessionDescription = "Artwork from NAWA MA"
                      , sessionLocation = "Gallery"
                      }
                    ]
              }
            , { slotTime = "6:15 PM"
              , slotType = ""
              , sessions =
                    [ { title = "Dinner"
                      , sessionDescription = ""
                      , sessionLocation = "Main Hall"
                      }
                    ]
              }
            , { slotTime = "8:00 PM"
              , slotType = ""
              , sessions =
                    [ { title = "Drink & dance"
                      , sessionDescription = ""
                      , sessionLocation = "Main Hall"
                      }
                    ]
              }
            , { slotTime = "11:00 PM"
              , slotType = ""
              , sessions =
                    [ { title = "Doors Close"
                      , sessionDescription = ""
                      , sessionLocation = "Bulfinch Square"
                      }
                    ]
              }
            ]
      }
    ]
