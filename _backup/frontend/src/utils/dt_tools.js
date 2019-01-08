import moment from 'moment-timezone';

function ts2dt_str(timestamp) {
  return moment(timestamp * 1000).format('YYYY-MM-DD HH:mm:ss')
}

function toLocalTime(_datetime, locale) {
  var localTime  = moment(_datetime).tz('Asia/Shanghai').format('YYYY-MM-DD HH:mm:ss')
  return localTime
}

function days_before(days) {
  return moment().subtract(days, 'days');
}

export {
  ts2dt_str,
  toLocalTime,
  days_before,
}
