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
    [ [ "I believe in living."
      , "I believe in the spectrum"
      , "of Beta days and Gamma people."
      , "I believe in sunshine."
      , "In windmills and waterfalls,"
      , "tricycles and rocking chairs."
      , "And i believe that seeds grow into sprouts."
      , "And sprouts grow into trees."
      , "I believe in the magic of the hands."
      , "And in the wisdom of the eyes."
      , "I believe in rain and tears."
      , "And in the blood of infinity."
      ]
    , [ "I believe in life."
      , "And i have seen the death parade"
      , "march through the torso of the earth,"
      , "sculpting mud bodies in its path."
      , "I have seen the destruction of the daylight,"
      , "and seen bloodthirsty maggots"
      , "prayed to and saluted."
      ]
    , [ "I have seen the kind become the blind"
      , "and the blind become the bind"
      , "in one easy lesson."
      , "I have walked on cut glass."
      , "I have eaten crow and blunder bread"
      , "and breathed the stench of indifference."
      ]
    , [ "I have been locked by the lawless."
      , "Handcuffed by the haters."
      , "Gagged by the greedy."
      , "And, if i know anything at all,"
      , "it's that a wall is just a wall"
      , "and nothing more at all."
      , "It can be broken down."
      ]
    , [ "I believe in living."
      , "I believe in birth."
      , "I believe in the sweat of love"
      , "and in the fire of truth."
      ]
    , [ "And i believe that a lost ship,"
      , "steered by tired, seasick sailors,"
      , "can still be guided home"
      , "to port."
      ]
    ]


affirmation : { quote : String, author : String }
affirmation =
    { quote =
        "“You meet a new person, you go with him,” Kid mused, “and "
            ++ "suddenly you get a whole new city.” He'd offered it as a "
            ++ "small and oblique compliment. Pepper only glanced at him, "
            ++ "curiously. “You go down new streets, you see houses you "
            ++ "never saw before, pass places you didn't even know were "
            ++ "there. Everything changes.”"
    , author = "Samuel R. Delany, Dhalgren"
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
