require! {
  superagent: request
  \./unix-time.ls
  \../config/time-servers.json : [server]
}

module.exports = main = (cb)->
  request
    .get "#server?#{unix-time!}"
    .end cb

