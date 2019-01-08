'use strict'
const merge = require('webpack-merge')
const devEnv = require('./dev.env')

module.exports = merge(devEnv, {
  NODE_ENV: '"testing"',
  TIMEOUT: '5000',
  BASE_URL: '"127.0.0.1:3000"',
  EOSTRACE_URL: '"http://127.0.0.1:8080"'
})
