(function() {

module.exports.parseType = function (_property) {

   if (!! _property.type ) {
      if (_property.type === 'object' && !!_property['javaType']) {
         retval = _property['javaType'];
      } else {
         retval = _property.type;
      }
   }

   return retval;
   }
}());

(function() {
module.exports.parseIncludes = function (schema) {
   const regex = /#\/definitions\//;
   var retval = '';
   for (var i in schema.properties) {
      console.log("i:", i, schema.properties[i]);
      var type = schema.properties[i]['javaType'];

      if (!!type && type !== 'CustomData') {
         retval += 'with ocpp.' + type.replace(regex, '') + 'Type; use ocpp.' + type.replace(regex, '') + 'Type;\n';
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

