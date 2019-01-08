import axios from 'axios'
import { axios_conf } from '@/config/app_config'

const service = axios.create(axios_conf)

service.interceptors.response.use(
    function(response) {
      return Promise.resolve(response)
    },
    function(error) {
      return Promise.reject(error)
    }
)

export default service
