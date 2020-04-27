(function() {

module.exports.parseType = function (_property) {
   const regex = /#\/definitions\//;
   var _retval = _property["javaType"]
   if (!! _retval ) {
      _retval += 'Type.T';
   } else {
      _retval = _property["type"]
      if (_retval === 'array') {
         _retval = _property["items"]
      }
   }

   if (!! _property.type) {
      retval = _property.type;
   }
   else {
      retval = _property['$ref'].replace(regex, '') + '.T';
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

