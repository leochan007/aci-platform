'use strict'
const merge = require('webpack-merge')
const prodEnv = require('./prod.env')

module.exports = merge(prodEnv, {
  NODE_ENV: '"development"',
  TIMEOUT: '10000',
  BASE_URL: '"http://127.0.0.1:3000"',
  EOSTRACE_URL: '"http://127.0.0.1:4200/search?q="'
})
