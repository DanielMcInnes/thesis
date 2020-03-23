(function() {

module.exports.parseType = function (_property) {
   const regex = /#\/definitions\//;
   var retval = '';

   if (_property.type) {
      retval += _property.type;
   }
   else {
      retval += _property['$ref'].replace(regex, '') + '.T';
   }

   return retval;
   }
}());

(function() {
module.exports.parseIncludes = function (_datafile) {
   const regex = /#\/definitions\//;
   var retval = '';
   for (var i in _datafile.properties) {
      var type = _datafile.properties[i]['$ref'];

      if (!!type) {
         retval += 'with ocpp.' + type.replace(regex, '') + '; use ocpp.' + type.replace(regex, '') + ';\n';
      }

   }

   return retval;
   }
}());

(function() {

module.exports.parseAction = function (_package) {
   console.log('parseAction: ', _package);
   const regex = /Request/g;
   var retval = _package.replace(regex, '');
   return retval;
   }
}());

