require! {
  cheerio
  \moment-timezone : moment
  superagent: request
  \./events-url.ls
  \prelude-ls : {map, filter, fold, flatten}
}

module.exports =
  get-data: (cb)->
    url <~ events-url.get-url
    err, body <~ @get-html-of url
    cb @parse body
  get-html-of: (url, cb)->
    request
      .get url
      .end (err, {text}:res)->
        cb err, text
  parse: (body)->
    body
    |> @days
    |> map (day)~>
      day
      |> @times
      |> map (time)~>
        datetime: @moment day.name, time.time
        type: time.type
        name: time.name
    |> flatten
  days: (body)->
    $ = cheerio.load body
    $title = $ \#boost
      .find \h3
      .filter (_, it)-> $ it .text! is /イベントスケジュール$/
    days = $title
      .next-until \h3
      .filter \h4
      .filter (_, it)-> $ it .text! is /^\d{1,2}月\d{1,2}日/
      .map (_, it)->
        name: $ it .text!
        table: $ it .next!.find \table
      .get!
  times: ({table}:item)->
    $ = cheerio.load table
    $ table
      .find \tr
      .slice 1
      .map (_, it)->
        time: $ it .find \th.sub .text!
        type: $ it .find "td.icon img" .attr \alt
        name: $ it .find \td .not \.icon .text! |> (- /[「」]/g)
      .get!
  moment: (day, time)->
    this-month = moment!.tz \Asia/Tokyo .start-of \month
    target = moment "#{day.replace /^(\d{1,2})月(\d{1,2}).*/, "$1-$2"} #time", "MM-DD HH:mm" .tz \Asia/Tokyo
    target.add 1, \y if target.is-before this-month
    return target

