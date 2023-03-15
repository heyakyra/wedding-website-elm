module Main exposing (..)

import Browser exposing (Document)
import Calendar
import Data exposing (..)
import Date
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Entity as Entity
import Task
import Time exposing (Posix, Zone, here, millisToPosix, now, utc)
import Time.Extra as Time



---- MODEL ----


type alias Model =
    { here : Zone
    , now : Posix
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model utc (millisToPosix 0)
    , Task.perform Initialize hereAndNow
    )


hereAndNow : Task.Task Never { here : Zone, now : Posix }
hereAndNow =
    Task.map2 (\z t -> { here = z, now = t }) here now



---- UPDATE ----


type Msg
    = Initialize { here : Zone, now : Posix }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        Initialize newModel ->
            ( newModel, Cmd.none )



---- VIEW ----


navbar : Html Msg
navbar =
    nav [ class "dark" ]
        [ ul []
            [ li [] [ a [ href "#home" ] [ text "Home" ] ]
            , li [] [ a [ href "#rsvp" ] [ text "RSVP" ] ]
            , li [] [ a [ href "#agenda" ] [ text "Agenda" ] ]
            , li [] [ a [ href "#attend" ] [ text "Travel" ] ]
            , li [] [ a [ href "#questions" ] [ text "questions" ] ]
            ]
        ]


heroButtons : Html Msg
heroButtons =
    ul []
        [ li []
            [ a [ href "#rsvp" ]
                [ button []
                    [ text "Invitation"
                    , div [ class "button__horizontal" ] []
                    , div [ class "button__vertical" ] []
                    ]
                ]
            ]
        , li []
            [ a [ href "#agenda" ]
                [ button []
                    [ text "Agenda"
                    , div [ class "button__horizontal" ] []
                    , div [ class "button__vertical" ] []
                    ]
                ]
            ]
        , li []
            [ a [ href "#attend" ]
                [ button []
                    [ text "Travel"
                    , div [ class "button__horizontal" ] []
                    , div [ class "button__vertical" ] []
                    ]
                ]
            ]
        , li []
            [ a [ href "#questions" ]
                [ button []
                    [ text "Questions"
                    , div [ class "button__horizontal" ] []
                    , div [ class "button__vertical" ] []
                    ]
                ]
            ]
        ]


insertLink : String -> String -> String -> List (Html Msg)
insertLink linkText linkTarget string =
    List.intersperse
        (a [ href linkTarget ] [ text linkText ])
        (List.map text (String.split linkText string))


hero : Html Msg
hero =
    header [ id "home", class "dark" ]
        [ h1 [ class "title" ]
            [ span [ class "first" ] [ text siteInfo.partner1 ]
            , span [ class "ampersand" ] [ text " & " ]
            , span [ class "second" ] [ text siteInfo.partner2 ]
            ]
        , p [] [ text siteInfo.tagline ]
        , heroButtons
        ]


aboutSection : Html Msg
aboutSection =
    section [ id "about", class "dark" ]
        [ h2 [] [ text "You're invited..." ]
        , img [ src aboutInfo.imgSrc, alt aboutInfo.imgAlt ] []
        , p [] [ text aboutInfo.whenHeading ]
        , p [ class "when" ] [ text aboutInfo.when ]
        , p [] [ text "for a union of family and friends, a celebration of partnership, and an expression of lifelong unity." ]
        ]


rsvpSection : Html Msg
rsvpSection =
    section [ id "rsvp" ]
        [ h2 [] [ text "Invitation" ]
        , p [] [ text "Please let us know if you can attend." ]
        , p [] [ text "If there is anything we can do to make it easier for you to attend, please reach out by text message or email. Hit the button below to send your reply." ]
        , a [ href aboutInfo.rsvpUrl ]
            [ button []
                [ text "RSVP"
                , div [ class "button__horizontal" ] []
                , div [ class "button__vertical" ] []
                ]
            ]
        ]


stanza : List String -> Html Msg
stanza lines =
    p []
        (List.map
            (\line ->
                span [] [ text line ]
            )
            lines
        )


type alias Countdown =
    { months : Int
    , weeks : Int
    , days : Int
    , hours : Int
    , minutes : Int
    }


bigDayToPosix : DateTime -> Zone -> Posix
bigDayToPosix bigDay tz =
    Time.partsToPosix
        tz
        (Time.Parts bigDay.year (Date.numberToMonth bigDay.month) bigDay.day bigDay.hour bigDay.minute 0 0)


monthsRemaining : DateTime -> Posix -> Zone -> Int
monthsRemaining bigDay currentTime tz =
    Time.diff Time.Month tz currentTime (bigDayToPosix bigDay tz)


weeksRemaining : DateTime -> Posix -> Int -> Zone -> Int
weeksRemaining bigDay currentTime monthsLeft tz =
    Time.diff
        Time.Week
        tz
        currentTime
        (bigDayToPosix { bigDay | month = bigDay.month - monthsLeft } tz)


daysRemaining : DateTime -> Posix -> Int -> Int -> Zone -> Int
daysRemaining bigDay currentTime monthsLeft weeksLeft tz =
    let
        subtractedDays =
            weeksLeft * 7

        startingMonthNumber =
            bigDay.month - monthsLeft

        startingMonth =
            Date.numberToMonth startingMonthNumber

        startingMonthDate =
            Calendar.fromRawParts { year = bigDay.year, month = startingMonth, day = 15 }

        lastDayOfMonth =
            case startingMonthDate of
                Just date ->
                    Calendar.lastDayOf date

                Nothing ->
                    31

        month =
            if subtractedDays > bigDay.day then
                startingMonth

            else
                Date.numberToMonth (startingMonthNumber - 1)

        day =
            if subtractedDays > bigDay.day then
                lastDayOfMonth - (subtractedDays - bigDay.day)

            else
                subtractedDays - bigDay.day
    in
    Time.diff
        Time.Day
        tz
        currentTime
        (bigDayToPosix
            { bigDay | month = bigDay.month - monthsLeft, day = bigDay.day - weeksLeft * 7 }
            tz
        )


timeLeft : DateTime -> Posix -> Zone -> Countdown
timeLeft bigDay currentTime tz =
    let
        monthsLeft =
            monthsRemaining bigDay currentTime tz

        weeksLeft =
            weeksRemaining bigDay currentTime monthsLeft tz

        daysLeft =
            daysRemaining bigDay currentTime monthsLeft weeksLeft tz
    in
    Countdown
        monthsLeft
        weeksLeft
        daysLeft
        0
        0


countdownSection : Model -> Html Msg
countdownSection model =
    let
        countdown =
            timeLeft aboutInfo.dateTime model.now model.here
    in
    section [ id "countdown" ]
        [ h2 [] [ text "Countdown" ]
        , ul []
           [ li [] [ span [] [ text (String.fromInt countdown.months) ], text "Months" ]
           , li [] [ span [] [ text (String.fromInt countdown.weeks) ], text "Weeks" ]
           , li [] [ span [] [ text (String.fromInt countdown.days) ], text "Days" ]
           ]
        ]


logistics : List { q : String, a : List (Html Msg) }
logistics =
    [ { q = "When is the RSVP deadline?"
      , a = [ p [] [ text "Please get back to us by April 10ᵗʰ, or just give a heads up that you need some extra time. We're doing our best to get everything in place for July 15ᵗʰ!" ] ]
      }
    , { q = "Is this indoors or outdoors?"
      , a =
            [ p []
                [ text "The ceremony will be outside, but everything else will be indoors."
                ]
            ]
      }
    , { q = "Is the location wheelchair accessible?"
      , a =
            [ p []
                [ text "Yes, both the park and the building are accessible, but there is a different entrance for elevator access."
                ]
            , p [] [ text "There are 2 accessible parking spots outside of the lobby entrance on Second Street. The elevator goes from the ground floor (lobby level) to the first floor (theater level)." ]
            , p [] [ text "For Centanni Way Park, there is a ramp from the lower end of the park (accessible from the Second Street sidewalk) up to the circular performance/ceremony area. To get inside the Multicultural Arts Center from Centanni Way Park, it is necessary to return to the Lobby entrance via Second Street." ]
            ]
      }
    , { q = "What is the dress code?"
      , a =
            [ p [] [ text "Wear whatever you feel comfortable in, but anywhere from dressy casual to cocktail attire will blend in just fine. There's even an optional color palatte if it suits you:" ]
            , p []
               [ a []
                   [ span [ class "color color1" ] [ text "████████████████" ]
                   , text Entity.zeroWidthSpace
                   , span [ class "color color2" ] [ text "████████████████" ]
                   , text Entity.zeroWidthSpace
                   , span [ class "color color3" ] [ text "████████████████" ]
                   , text Entity.zeroWidthSpace
                   , span [ class "color color4" ] [ text "████████████████" ]
                   , text Entity.zeroWidthSpace
                   , span [ class "color color5" ] [ text "████████████████" ]
                   , text Entity.zeroWidthSpace
                   , span [ class "color color6" ] [ text "████████████████" ]
                   , text Entity.zeroWidthSpace
                   , span [ class "color color7" ] [ text "████████████████" ]
                   , text Entity.zeroWidthSpace
                   , span [ class "color color8" ] [ text "████████████████" ]
                   , text Entity.zeroWidthSpace
                   , span [ class "color color9" ] [ text "████████████████" ]
                   ]
               ]
            ]
      }
    , { q = "What kind of gifts do you like?"
      , a =
            [ p [] [ text "With friends and family, we are blessed with everything we could ever ask for. Your presence is more than enough of a gift to us. No gifts! If you really insist, we've put together a list to make it easier:" ]
            , p []
                [ a [ href "https://www.usworker.coop/shopcoop/" ] [ text "Click here" ]
                , text " to go to the registry, or go to "
                , a [ href "https://www.usworker.coop/shopcoop/" ] [ text "https://www.usworker.coop/shopcoop/" ]
                ]
            ]
      }
    , { q = "Whom should I contact with questions?"
      , a =
            [ p []
                [ text "Please either email "
                , text aboutInfo.contactEmail
                , text " or alternatively, call/text our dedicated officiant, Namrata, at +1"
                , text Entity.nonBreakingSpace
                , text "(555)"
                , text Entity.nonBreakingSpace
                , text "123-6789"
                ]
            ]
      }
    ]


questionsSection : Html Msg
questionsSection =
    section [ id "questions" ]
        [ h2 [] [ text "Questions & Answers" ]
        , ul []
            (List.map
                (\item ->
                    li []
                        [ strong []
                            [ text item.q ]
                        , p
                            []
                            item.a
                        ]
                )
                logistics
            )
        ]


quoteSection : Html Msg
quoteSection =
    section [ id "quote", class "dark" ]
        [ div [ class "prose" ] (List.map stanza quoteText) ]


streetAddress : List (Html Msg)
streetAddress =
    List.intersperse (br [] []) (List.map text geoLocation.address)


attendSection : Html Msg
attendSection =
    section [ id "attend", class "dark" ]
        [ h2 [] [ text "Travel" ]
        , h3 [] [ text "Location & Directions" ]
        , address [] [ a [ href geoLocation.geoUri ] streetAddress ]
        , p [] [ em [] [ text "This is an accessible space." ] ]
        , h3 [] [ text "Public Transit" ]
        , p []
            [ strong [] [ text "Lechmere MBTA Station (Green Line)" ]
            , text "Take the green line and get off at the Lechmere stop. The location is only two blocks (0.1 miles) from the station, just head right exiting the station and take your first left onto Second Street. The building will be just one block away on your right. "
            , a [ href "https://www.multiculturalartscenter.org/contact/directions/" ] [ text "More options" ]
            , text " on the MCAC website."
            ]
        , h3 [] [ text "Parking" ]
        , p []
            [ text "The "
            , strong [] [ text "East Cambridge Parking Garage " ]
            , text "is entered off Spring Street, between First & Second Streets, one block away from us, and open 24/7."
            ]
        , h3 [] [ text "Hotel" ]
        , p []
            [ text "The "
            , strong [] [ text "Royal Sonesta Boston" ]
            , text " is less than 10 minutes away walking along the water. They are  offering a discount for guest; please click RSVP above and indicate you would like to book a room through us."
            ]
        , a [ href geoLocation.mapUrl ] [ img [ src "images/map.png" ] [] ]
        ]


footerSection : Html Msg
footerSection =
    footer [ id "end", class "dark" ] [ navbar ]


agendaSession : Session -> Html Msg
agendaSession session =
    li []
        ([ h3 [] [ text session.title ]
         , text session.sessionDescription
         , em [] [ text session.sessionLocation ]
               ]
        )


agendaSlot : AgendaSlot -> Html Msg
agendaSlot slot =
    li []
        [ p []
            [ time [] [ text slot.slotTime ]
            , strong [] [ text slot.slotType ]
            , ul [] (List.map agendaSession slot.sessions)
            ]
        ]


agendaDay : { day : String, slots : List AgendaSlot } -> List (Html Msg)
agendaDay daySchedule =
    [ h3 [] [ text daySchedule.day ]
    , ul [] (List.map agendaSlot daySchedule.slots)
    ]


agendaSection : Html Msg
agendaSection =
    section [ id "agenda", class "dark" ]
        ([ h2 [] [ text "Schedule" ]
         , p []
            [ strong [] [ text "Excited to see you all! " ] ]
         ]
            ++ List.concat (List.map agendaDay agenda)
        )


view : Model -> Document Msg
view model =
    { title = siteInfo.partner1 ++ " & " ++ siteInfo.partner2
    , body =
        [ hero
        , navbar
        , main_ []
            [ aboutSection
            , rsvpSection
            , agendaSection
            , countdownSection model
            , attendSection
            , quoteSection
            , questionsSection
            ]
        , footerSection
        ]
    }



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.document
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }