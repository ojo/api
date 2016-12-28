# API

* Production API URL: https://api.ojo.world
* The API is JSON API formatted: http://jsonapi.org/

## News Items

GET /api/v0/news_items

- [ ] TODO: Decide on a pagination style: https://coderwall.com/p/lkcaag/pagination-you-re-probably-doing-it-wrong

``` json
{
  "data": [
    {
      "id": "849",
      "type": "news-items",
      "attributes": {
        "title": "UNC walks out again",
        "subtitle": "",
        "body": "Attorney and United National Congress (UNC) Senator, Gerald Ramdeen, lead a walkout of UNC councillors at the Sangre Grande Regional Corporation this afternoon.\r\n<br>\r\nThe swearing-in ceremony of aldermen of the Corporation took place today, although the deadlock has not been resolved. Both the People\u2019s National Movement (PNM) and UNC secured four electoral districts.\r\n<br>\r\nIncumbent Terry Rondon, who faced objections from two councillors, was re-elected as chairman of the Corporation after the walkout.",
        "created-at": 1481835002,
        "photo-thumb-url": "http:\/\/s3.amazonaws.com\/ttrn-api-photos\/news_items\/photos\/000\/000\/849\/thumb\/Screen_Shot_2016-12-15_at_4.45.53_PM.png?1481835001",
        "photo-dominant-color": "#201f17",
        "photo-url": "http:\/\/s3.amazonaws.com\/ttrn-api-photos\/news_items\/photos\/000\/000\/849\/original\/Screen_Shot_2016-12-15_at_4.45.53_PM.png?1481835001",
        "straphead": "Swearing-in ceremony",
        "photo-caption": "",
        "category": "News"
      }
    },
    {
      "id": "848",
      "type": "news-items",
      "attributes": {
        "title": "Murder in Maraval",
        "subtitle": "",
        "body": "A 24-year-old man is dead following a shooting incident this morning in Maraval.\r\n<br>Around 3:00 am, Michael Sylvester was asleep in his Nissan Almera motor vehicle when he was approached by a group of men.\r\nSeveral explosions were heard and Sylvester was found bleeding from multiple gunshot injuries.\r\n<br>He was rushed to the Port of Spain General Hospital where he was pronounced dead on arrival.\r\n<br>Investigations are continuing.",
        "created-at": 1481826952,
        "photo-thumb-url": "http:\/\/s3.amazonaws.com\/ttrn-api-photos\/news_items\/photos\/000\/000\/848\/thumb\/Screen_Shot_2016-09-09_at_9.29.11_AM.png?1481826951",
        "photo-dominant-color": "#070502",
        "photo-url": "http:\/\/s3.amazonaws.com\/ttrn-api-photos\/news_items\/photos\/000\/000\/848\/original\/Screen_Shot_2016-09-09_at_9.29.11_AM.png?1481826951",
        "straphead": "",
        "photo-caption": "",
        "category": "News"
      }
    }
  ]
}
```

## News Item

GET /api/v0/news_items/:id

``` json
{
  "data": {
    "id": "100",
    "type": "news-items",
    "attributes": {
      "title": "Chinese High School To Visit Trinidad for Laventille Steelband Festival",
      "subtitle": "",
      "body": "Published: 4th August,2016<br><br>Students, parents and teachers of the Beijing Ritan High School of the Peoples Republic of China, one of the very few schools in China with a Steel Orchestra, will arrive in Trinidad on Friday (Aug 5) to witness the annual Laventille Steelband Festival Street Parade.<br><br>Now in it's 18th year, the festival is hosted by the Laven<span>tille Steelband Festival Foundation and will feature over 30 steelbands, including champion steel orchestra Desperadoes, Renegades, All Stars, Exodus, Phase 2, Invaders, Supernovas, Sound Specialists, UniStars, Serenaders, Pan Elders, Trinidad East side, Marsicans and many more.<br><br>The main purpose of the visit is for the Ritan High School to forge a strong relationship with a complementary school program in Trinidad and Tobago to help further develop Ritan's existing pan program, while broadening their understanding of the steelpan and the land of its birth.<br><br>Based on the successes of its championship steel orchestra, the Success Stars Pan Sounds and its well-established music program, the Success Laventille Secondary School was chosen to host an exchange with the students and teachers of the Ritan High School, who will return to China on Monday August 8.<\/span>",
      "created-at": 1470604462,
      "photo-thumb-url": "http:\/\/s3.amazonaws.com\/ttrn-api-photos\/news_items\/photos\/000\/000\/100\/thumb\/13914076_10153965869283681_4065238401158579977_o.jpg?1470604461",
      "photo-dominant-color": "#402813",
      "photo-url": "http:\/\/s3.amazonaws.com\/ttrn-api-photos\/news_items\/photos\/000\/000\/100\/original\/13914076_10153965869283681_4065238401158579977_o.jpg?1470604461",
      "straphead": "",
      "photo-caption": "",
      "category": "News"
    }
  }
}
```

## Now Playing

GET /api/v0/stations/now-playing

``` json
{
  "data": {
    "id": "2",
    "type": "now-playing",
    "attributes": {
      "title": "YOUR LOVE",
      "artist": "Nicki Minaj",
      "album": "STAR 947 - OJO",
      "media-type": "Song",
      "station-tag": "947fm",
      "started-at": 1481848562,
      "length-in-secs": 196,
      "artwork-dominant-color": "#b68896",
      "artwork-url-500": "http:\/\/s3.amazonaws.com\/ttrn-api-photos\/play_event_images\/files\/000\/000\/638\/large\/1340856e4af938e41543dec4cabd080b9846c26bd2c7ce0ff6529ef9cf68279ea551e48ccdb2d2b3e98fba62c9bad40678d84bae844f45c05283b5e491d1a8b0e790.JPG?1471015761",
      "artwork-url-300": "http:\/\/s3.amazonaws.com\/ttrn-api-photos\/play_event_images\/files\/000\/000\/638\/medium\/1340856e4af938e41543dec4cabd080b9846c26bd2c7ce0ff6529ef9cf68279ea551e48ccdb2d2b3e98fba62c9bad40678d84bae844f45c05283b5e491d1a8b0e790.JPG?1471015761",
      "artwork-url-100": "http:\/\/s3.amazonaws.com\/ttrn-api-photos\/play_event_images\/files\/000\/000\/638\/thumb\/1340856e4af938e41543dec4cabd080b9846c26bd2c7ce0ff6529ef9cf68279ea551e48ccdb2d2b3e98fba62c9bad40678d84bae844f45c05283b5e491d1a8b0e790.JPG?1471015761"
    }
  }
}
```

## Now Playing (Real-time)

Real-time metadata updates are provided through Firebase Cloud Messaging. The format of the Firebase notification key is "/topics/now-playing-#{station_tag}"

example keys:

* "/topics/now-playing-961fm"
* "/topics/now-playing-947fm"
* "/topics/now-playing-1077fm"

## (Discover) Events

GET /api/v0/events

``` json
TODO
```

GET /api/v0/events/:id

``` json
TODO
```
