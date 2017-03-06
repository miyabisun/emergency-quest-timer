require! {
  express
  \../functions/emergency-quests.ls
}

quests <- emergency-quests.get-data

app = express!
  ..listen 80
  ..set \views, "#__dirname/../assets"
  ..set "view engine", \jade

