require! {
  moment, fs
  \prelude-ls : {filter, each}
  \../functions/emergency-quests.ls : main
}

data <- main.get-data
data
|> JSON.stringify _, null, 2
|> fs.write-file-sync "#__dirname/../docs/events.json", _

