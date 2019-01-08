import Web3 from 'web3'
import * as config from "../config/config"
import * as cc from "../config/constants"

console.log('config.web3_url=', config.web3_url)
console.log('config.acar_contract_addr=', config.acar_contract_addr)
//console.log('config.acar_abi_def=', config.acar_abi_def)

let web3wrapper = new Promise(function (resolve, reject) {
  var web3 = new Web3();
  var provider = new Web3.providers.HttpProvider(config.web3_url);
  web3.setProvider(provider);
  
  if (web3.isConnected()) {
    resolve({
      injectedWeb3: true,
      web3 () {
        return web3
      }
    })

  } else {
    reject(new Error(cc.MESSAGE_NOT_CONNECTED))
  }
})
  .then(result => {

    return new Promise(function (resolve, reject) {
      // Retrieve network ID
      result.web3().version.getNetwork((err, networkId) => {
        if (err) {
          console.log(err)
          reject(new Error(cc.MESSAGE_NOT_CONNECTED))
        } else {
          let token = result.web3().eth.contract(config.acar_abi_def);
          let tokenIns = token.at(config.acar_contract_addr);

          result = Object.assign({}, result, { networkId, token, tokenIns })

          //console.log('getweb3 result:', result);

          resolve(result)
        }
      })
    })
  })

export default web3wrapper
