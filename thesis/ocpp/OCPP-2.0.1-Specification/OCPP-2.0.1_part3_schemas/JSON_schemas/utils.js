(function() {

module.exports.parseAction = function (_package) {
   console.log('parseAction: ', _package);
   const regex = /Request/g;
   var retval = _package.replace(regex, '');
   return retval;
   }
}());

