require! {
  moment
  \prelude-ls : {filter, each}
  \../functions/emergency-quests.ls : main
}

data <- main.get-data
data
|> filter (.type) >> (is \緊急)
|> filter (.datetime.is-after moment!)
|> each ({datetime, type, name})->
  console.log "#{datetime.format "MM月DD日 HH:mm"}: #name"

