Kayn = require 'kayn'
timer = require 'timers'

QUEUES = {
  0: 	'Custom games'
  2:	'(Summoner\'s Rift) 	5v5 Blind Pick'
  4: 	'(Summoner\'s Rift) 	5v5 Ranked Solo'
  6: 	'(Summoner\'s Rift) 	5v5 Ranked Premade'
  7: 	'(Summoner\'s Rift) 	Co-op vs AI'
  8: 	'(Twisted Treeline) 	3v3 Normal'
  9: 	'(Twisted Treeline) 	3v3 Ranked Flex'
  14: 	'(Summoner\'s Rift) 	5v5 Draft Pick'
  16:	'(Crystal Scar) 	5v5 Dominion Blind Pick'
  17: 	'(Crystal Scar) 	5v5 Dominion Draft Pick'
  25: 	'(Crystal Scar) 	Dominion Co-op vs AI'
  31: 	'(Summoner\'s Rift) 	Co-op vs AI Intro Bot'
  32: 	'(Summoner\'s Rift) 	Co-op vs AI Beginner Bot'
  33: 	'(Summoner\'s Rift) 	Co-op vs AI Intermediate Bot'
  41: 	'(Twisted Treeline) 	3v3 Ranked Team'
  42: 	'(Summoner\'s Rift) 	5v5 Ranked Team'
  52: 	'(Twisted Treeline) 	Co-op vs AI'
  61: 	'(Summoner\'s Rift) 	5v5 Team Builder'
  65: 	'(Howling Abyss) 	5v5 ARAM'
  70: 	'(Summoner\'s Rift) 	One for All'
  72: 	'((Howling Abyss) 	1v1 Snowdown Showdown'
  73: 	'(Howling Abyss) 	2v2 Snowdown Showdown'
  75: 	'(Summoner\'s Rift) 	6v6 Hexakill'
  76: 	'(Summoner\'s Rift) 	Ultra Rapid Fire'
  78: 	'(Summoner\'s Rift) 	Mirrored One for All'
  83: 	'(Summoner\'s Rift)	Co-op vs AI Ultra Rapid Fire'
  91: 	'(Summoner\'s Rift) 	Doom Bots Rank 1'
  92: 	'(Summoner\'s Rift) 	Doom Bots Rank 2'
  93: 	'(Summoner\'s Rift) 	Doom Bots Rank 5'
  96: 	'(Crystal Scar) 	Ascension'
  98: 	'(Twisted Treeline) 	6v6 Hexakill'
  100: 	'(Butcher\'s Bridge) 	5v5 ARAM'
  300: 	'(Howling Abyss) 	King Poro'
  310: 	'(Summoner\'s Rift) 	Nemesis'
  313: 	'(Summoner\'s Rift) 	Black Market Brawlers'
  315: 	'(Summoner\'s Rift) 	Nexus Siege'
  317: 	'(Crystal Scar) 	Definitely Not Dominion'
  318: 	'(Summoner\'s Rift) 	All Random URF'
  325: 	'(Summoner\'s Rift) 	All Random'
  400: 	'(Summoner\'s Rift) 	5v5 Draft Pick'
  410: 	'(Summoner\'s Rift) 	5v5 Ranked Dynamic'
  420: 	'(Summoner\'s Rift) 	5v5 Ranked Solo'
  430: 	'(Summoner\'s Rift) 	5v5 Blind Pick'
  440: 	'(Summoner\'s Rift) 	5v5 Ranked Flex '
  450: 	'(Howling Abyss) 	5v5 ARAM'
  460: 	'(Twisted Treeline) 	3v3 Blind Pick'
  470: 	'(Twisted Treeline) 	3v3 Ranked Flex'
  600: 	'(Summoner\'s Rift) 	Blood Hunt Assassin'
  610: 	'(Cosmic Ruins) 	Dark Star'
  800: 	'(Twisted Treeline) 	Co-op vs. AI Intermediate Bot'
  810: 	'(Twisted Treeline) 	Co-op vs. AI Intro Bot'
  820: 	'(Twisted Treeline) 	Co-op vs. AI Beginner Bot'
  830: 	'(Summoner\'s Rift) 	Co-op vs. AI Intro Bot'
  840: 	'(Summoner\'s Rift) 	Co-op vs. AI Beginner Bot'
  850: 	'(Summoner\'s Rift) 	Co-op vs. AI Intermediate Bot'
  940: 	'(Summoner\'s Rift) 	Nexus Siege'
  950: 	'(Summoner\'s Rift) 	Doom Bots /w difficulty voting'
  960: 	'(Summoner\'s Rift) 	Doom Bots'
  980: 	'(Valoran City Park) 	Star Guardian Invasion: Normal'
  990: 	'(Valoran City Park) 	Star Guardian Invasion: Onslaught'
}

SEASON = {
  0: 	'Pre Season 3'
  1: 	'Season 3'
  2: 	'Pre Season 2014'
  3: 	'Season 2014'
  4: 	'Pre Season 2015'
  5: 	'Season 2015'
  6: 	'Pre Season 2016'
  7: 	'Season 2016'
  8: 	'Pre Season 2017'
  9: 	'Season 2017'
}

LANE = {
  BOTTOM: 'BOT'
  TOP: 'TOP'
  JUNGLE: 'JUNGLE'
  MID: ''
}

URL_STATIC = 'http://ddragon.leagueoflegends.com/cdn/6.24.1/img/champion/'

routes = (app) =>
  kayn = Kayn.Kayn('RGAPI-2b0b2fc6-a141-479c-8d53-3919585145bd')({
    region: 'br',
    debugOptions: {
      isEnabled: true,
      showKey: false,
    },
    requestOptions: {
      shouldRetry: true,
      numberOfRetriesBeforeAbort: 3,
      delayBeforeRetry: 1000,
      burst: true,
    },
    cacheOptions: {
      cache: null,
      ttls: {},
    },
  })


  app.get '/summoner/:nickname', (req, res) =>
    nick = req.params.nickname
    response = { }
    kayn.Summoner.by.name nick
      .then (summoner) =>
        response.summoner = summoner
        iconURL = "http://ddragon.leagueoflegends.com/cdn/6.24.1/img/profileicon/" + summoner.profileIconId + ".png"
        response.summoner.profileIcon = iconURL
        kayn.Matchlist.by.accountID summoner.accountId
          .query { endIndex: 15 }
          .then (r) =>
            response.matches = r.matches
            matches = response.matches
            matches.forEach (match, index) =>
              codeSeason = match.season
              response.matches[index].season = SEASON[codeSeason]
              codeQueue = match.queue
              map = QUEUES[codeQueue].split '\t'
              response.matches[index].queue = map[1]
              response.matches[index].map = map[0]
              if match.lane is 'BOTTOM'
                response.matches[index].lane = 'BOT'
              return
            res.json response
      .catch (err) =>
        res.status 412
          .json err: err
        return

  app.get '/match/:matchId', (req, res) =>
    matchId = req.params.matchId

    kayn.Match.get matchId
      .then (match) =>
        res.json match
        return
      .catch (err) =>
        res.status 412
          .json err: err
        return

  app.get '/summoner/:summonerId/queues/solo55', (req, res) =>
    summonerId = req.params.summonerId
    kayn.Leagues.by.summonerID summonerId
      .then (league) =>
        response = {}
        league.forEach (l, index) =>
          if l.queue = 'RANKED_SOLO_5x5' then response = l
          return
        res.json response

  app.get '/summoner/:summonerId/queues/flex55', (req, res) =>
    summonerId = req.params.summonerId
    kayn.Leagues.by.summonerID summonerId
      .then (league) =>
        response = {}
        league.forEach (l, index) =>
          if l.queue = 'RANKED_FLEX_SR' then response = l
          return
        res.json response



module.exports = routes
