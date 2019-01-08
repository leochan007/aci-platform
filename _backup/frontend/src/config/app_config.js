const eostracer_url = process.env.EOSTRACE_URL;

const axios_conf = {
    baseURL: process.env.BASE_URL,
    headers:{
        'Content-Type': 'application/x-www-form-urlencoded',
        'Content-Type': 'application/json',
        "Access-Control-Allow-Headers": "Authorization,Origin, X-Requested-With, Content-Type, Accept"
    },
    timeout: process.env.TIMEOUT,
};

export {
    eostracer_url,
    axios_conf,
}
