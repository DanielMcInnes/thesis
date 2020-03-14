(function() {

var fs = require('fs');
var utils = require('./utils.js');
function clean(f) {
   const regex = / /g;
   const regexdotslash = /\.\//g;
   const regexbody = /body/gi;
   const regexperiod = /\./gi;
   const regexhyphen = /-/g;
   const regex15118 = /15118/g;
   const regexdelta = /delta/gi;
   const regexstring = /string/gi;
   const regexboolean = /boolean/gi;
   const regexdotjson = /\.json/gi;
   const regex_json = /_json/g;
   var retval = f.replace(regex, '_');
   retval = retval.replace(regexdotslash, '');
   retval = retval.replace(regexbody, 'ABody');
   retval = retval.replace(regexperiod, '_');
   retval = retval.replace(regexhyphen, '_');
   retval = retval.replace(regex15118, 'a15118');
   retval = retval.replace(regexdelta, 'zzzDelta');
   retval = retval.replace(regexstring, 'zzzstring');
   retval = retval.replace(regexboolean, 'zzzboolean');
   retval = retval.replace(regexdotjson, '');
   retval = retval.replace(regex_json, '');
   return retval;
}

function cleanfilename(f) {
   const regex15118 = /15118/g;
   const regex_json = /_json/g;
   var retval = f.replace(regex15118, 'a15118');
   retval = retval.replace(regex_json, '');
   return retval;
}

module.exports.parse = function (_filename) {
   var _datafile = require(_filename);
   var _package = clean(_filename);
   console.log('parseObjectType: ', _filename);
   var _outfile = cleanfilename('ocpp-' + _package + '.ads');
   console.log('parseObjectType: _outfile: ', _outfile);
   var _buffer ="pragma SPARK_mode (on); \n\n";
   
   _buffer += ('with Ada.Strings.Bounded;\n\n')
   _buffer += 'package ocpp.' + _package + ' is\n';
   if (_package.includes('Request') ) {
      _buffer += '   action : constant NonSparkTypes.action_t.Bounded_String := NonSparkTypes.action_t.To_Bounded_String("' + utils.parseAction(_package) + '"); \n';
   }
   //var obj = JSON.parse(_datafile.properties);
   var _properties = _datafile.properties;
   for (var i in _properties) {
      var _type = i.type;
      _buffer += '   ' + i + ' : ' + _properties[i].type + ';\n';
   }


   _buffer += 'end ' + _package + ';';
   console.log('\n\n\nbuffer:\n', _buffer, '\n\n');
   }
}());

