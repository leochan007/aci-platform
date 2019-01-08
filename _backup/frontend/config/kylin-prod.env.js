'use strict'
const merge = require('webpack-merge')
const prodEnv = require('./prod.env')

module.exports = merge(prodEnv, {
  TIMEOUT: '10000',
  BASE_URL: '"https://credit.alphacario.com"',
  EOSTRACE_URL: '"https://tools.cryptokylin.io/#/tx/"'
})
