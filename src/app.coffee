express = require 'express'
bodyParse = require 'body-parser'

routes = require './routes'

app = express()


routes app

app.set 'json spaces', 4
app.use bodyParse.json()
app.listen 4040
