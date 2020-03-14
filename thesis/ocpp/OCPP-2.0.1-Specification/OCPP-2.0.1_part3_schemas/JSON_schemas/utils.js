(function() {

module.exports.parseAction = function (_package) {
   const regex = /Request_v1p0_json/g;
   console.log('parseAction: ', _package);
   var retval = _package.replace(regex, '');
   return retval;
   }
}());

