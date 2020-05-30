(function() {

var fs = require('fs');
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

   if (retval === 'All') {
      retval = 'zzzAll';
   }
   return retval;
}

function cleanfilename(f) {
   const regex15118 = /15118/g;
   var retval = f.replace(regex15118, 'a15118');
   return retval;
}


module.exports.parse = function(_definitions, i) {
   var buffer ="";
   var package = clean(i);

   buffer = '-- start ocpp' + i + '.ads\n';
   buffer += ('with Ada.Strings.Bounded;\n\n')
   buffer += 'package ocpp.' + clean(i) + ' is\n';
   buffer += '   type T is (\n';
   var maxlen = 0;
   for (var j in _definitions[i].enum) {
      if (_definitions[i].enum[j].length > maxlen) {
         maxlen = _definitions[i].enum[j].length;
      }

      var enumElement = _definitions[i].enum[j];
      buffer += '      ' + clean(enumElement); 
      if (j == (_definitions[i].enum.length - 1)) {
         buffer += '\n';// don't put a comma after the last enum
      } else {
         buffer += ',\n';
      }
   }
   buffer += ('   );\n\n')
   buffer += ('   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => ' + maxlen + ');\n');
   buffer += ('   procedure FromString(str : in String;\n');
   buffer += ('                        attribute : out T;\n');
   buffer += ('                        valid : out Boolean)\n');
   buffer += '      with\n'
   buffer += ' Global => null,\n'
   buffer += ' Annotate => (GNATprove, Terminating);\n'

   buffer += ('   procedure ToString(attribute : in T;\n');
   buffer += ('                      str : out string_t.Bounded_String)\n');
   buffer += '      with\n'
   buffer += ' Global => null,\n'
   buffer += ' Annotate => (GNATprove, Terminating);\n'
   buffer += ('end ocpp.' + clean(i) + ';\n');
   buffer += ('-- end ocpp-' + clean(i) + '.ads\n');

   var outfile = 'ocpp-' + i.toLowerCase() + '.ads';
   fs.writeFile(cleanfilename(outfile), buffer, function (err, file) {
      if (err) throw err;
      console.log('Saved %s', outfile);
   });

   buffer =  ('-- ocpp-' + i + '.adb\n\n');
   var temp = cleanfilename(i);
   buffer += ('with ocpp.' + temp + '; use ocpp.' + temp + ';\n');
   buffer += ('with NonSparkTypes;\n\n');
   buffer += ('package body ocpp.' + clean(i) + ' is\n');
   buffer += ('   procedure FromString(str : in String;\n');
   buffer += ('                        attribute : out T;\n');
   buffer += ('                        valid : out Boolean)\n');
   buffer += ('   is\n');
   buffer += ('   begin\n');
   for (var j in _definitions[i].enum) {
      var str = _definitions[i].enum[j];
      buffer +=('      ' + (j == 0 ? 'if' : 'elsif') + ' (NonSparkTypes.Uncased_Equals(str, "' + str + '")) then\n' );
      buffer +=('         attribute := ' + clean(str) + ';\n');
   }


   buffer +=('      else\n');
   buffer +=('         valid := false;\n');
   buffer +=('         return;\n');
   buffer +=('      end if;\n');
   buffer +=('      valid := true;\n');



   buffer +=('   end FromString;\n\n');

   buffer +=('   procedure ToString(attribute : in T;\n');
   buffer +=('                      str : out string_t.Bounded_String)\n');
   buffer +=('   is\n');
   buffer +=('      use string_t;\n');
   buffer +=('   begin\n');
   buffer +=('      case attribute is\n');
   for (var j in _definitions[i].enum) {
      var str = _definitions[i].enum[j];
      buffer +=('         when ' + clean(str) + ' => str := To_Bounded_String("' + str + '");\n'); 
   }
   buffer +=('      end case;\n');


   buffer +=('   end ToString;\n');
   buffer +=('end ocpp.' + clean(i) + ';\n');

   var outfile = 'ocpp-' + clean(i).toLowerCase() + '.adb';
   fs.writeFile((outfile), buffer, function (err, file) {
      if (err) throw err;
      console.log('Saved %s', outfile);
   });

   //console.log('buffer:', buffer);
}

}());

