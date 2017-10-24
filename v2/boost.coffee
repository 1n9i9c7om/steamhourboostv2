_            = require 'lodash'
jsonfile     = require 'jsonfile'
moment       = require 'moment'
Promise      = require 'bluebird'
SteamAccount = require './steamaccount.coffee'
mysql = require('mysql');
HashMap = require('hashmap');

con = mysql.createConnection({
  host: "127.0.0.1",
  user: "steamboost",
  password: "**********",
  database: "steamboost"
});

`
accounts = new HashMap();
steamAccounts = new HashMap();
activeMap = new HashMap();
prevActiveMap = new HashMap();
`

realAccounts = []

# uff. sry but hey, at least it works.
# if you feel like improving this to use proper coffeescript, feel free to create a pull request and credit yourself here.
# code clean up by: 

`
function reloadAccountsArray()
{
`
realAccounts = []
`
activeMap.forEach(function (value, key)
{
prevActiveMap.set(key, value);
});

con.query("SELECT * FROM SteamAccount", function (err, result, fields) {
if (err) throw err;
accGames = [];
result.forEach(function (row)
{
console.log("Iterating through Steam Account " + row.username);
account = [{'username': row.username,'password': row.password,'sentry': row.sentry,'secret': row.secret,'games': accGames}];
accounts.set(row.username, account);
activeMap.set(row.username, row.IsActive);
});
pushAccountsToMap()
});
}

function pushAccountsToMap()
{
console.log("push to map");
accounts.forEach(function (value, key)
{
if(!steamAccounts.has(key))
{
`
steamAccounts.set(value[0].username, new SteamAccount value[0].username, value[0].password, value[0].sentry, value[0].secret, [730])
`
};
});
compareActiveMaps();
}

function compareActiveMaps()
{
activeMap.forEach(function (value, key)
{
if(prevActiveMap.get(key) != activeMap.get(key))
{
if(activeMap.get(key) == 1)
{
`
console.log "boosting account " + steamAccounts.get(key).name
steamAccounts.get(key).boost()
`
}
else
{
if(steamAccounts.get(key) != undefined)
{
`
console.log "stopping account " + steamAccounts.get(key).name
steamAccounts.get(key).logoff()
`
}
}
}
});
}

setInterval(reloadAccountsArray, 5000);`


restartBoost = ->
  console.log '\n---- Restarting accounts ----\n'
  Promise.map realAccounts, _.method 'restartGames'
  .then prepareRestartBoost

prepareRestartBoost = ->
  console.log "boosting started"
  reloadAccountsArray
  showPushedAccounts
  restartBoost

start = ->
  console.log '\n---- Starting to boost ----\n'
  reloadAccountsArray()
  console.log "accounts loaded"
  showPushedAccounts()
  Promise.map realAccounts, _.method 'boost'
  .then prepareRestartBoost

`
con.connect(function(err) {
if (err) throw err;
console.log("Connected!");
start
})
`