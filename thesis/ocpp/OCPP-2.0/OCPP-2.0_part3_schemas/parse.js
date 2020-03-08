var fs = require('fs');
/*
function error(err) {
  if (err) throw err;
  console.log('Saved!');
}
*/
function clean(f) {
   const regex = / /g;
   const regexbody = /body/gi;
   const regexperiod = /\./gi;
   const regexhyphen = /-/g;
   var retval = f.replace(regex, '_');
   retval = retval.replace(regexbody, 'ABody');
   retval = retval.replace(regexperiod, '_');
   retval = retval.replace(regexhyphen, '_');
   return retval;
}

function parseJsonFile(f) {
   var _datafile = require(f);
   console.log('parseJsonFile: _datafile:', _datafile.type);
   var _definitions = _datafile.definitions;
   var buffer ="";


   for (var i in _definitions) {
      if (i.endsWith('EnumType')) {

         buffer = '-- start ocpp' + i + '.ads\n';
         buffer += ('with Ada.Strings.Bounded;\n\n')
         buffer += 'package ocpp.' + i + ' is\n';
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
         buffer += ('                        valid : out Boolean);\n');
         buffer += ('   procedure ToString(attribute : in T;\n');
         buffer += ('                      str : out string_t.Bounded_String);\n');
         buffer += ('end ocpp.' + i + ';\n');
         buffer += ('-- end ocpp-' + i + '.ads\n');

         var outfile = 'ocpp-' + i.toLowerCase() + '.ads';
         fs.writeFile(outfile, buffer, function (err, file) {
            if (err) throw err;
            console.log('Saved %s', outfile);
         });



         buffer =  ('-- ocpp-' + i + '.adb\n\n');
         buffer += ('with ocpp.' + i + '; use ocpp.' + i + ';\n');
         buffer += ('with NonSparkTypes;\n\n');
         buffer += ('package body ocpp.' + i + ' is\n');
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
         buffer +=('end ocpp.' + i + ';\n');

         var outfile = 'ocpp-' + i.toLowerCase() + '.adb';
         fs.writeFile(outfile, buffer, function (err, file) {
            if (err) throw err;
            console.log('Saved %s', outfile);
         });

         //console.log('buffer:', buffer);

      }
   }
}

if (process.argv.length <= 2) {
   console.log("Usage: " + __filename + " path/to/directory");
   process.exit(-1);
}


parseJsonFile('./TransactionEventRequest_v1p0.json')
/*
 
//var _values = _enum.split(
console.log('*** enum: ', _enum);
console.log('*** enum[0]: ', _enum[0]);


for (var i in _enum) {
   console.log(i, _enum[i]);
}


 
var path = process.argv[2];

fs.readdir(path, function(err, items) {
    //console.log(items);
 
   for (var i=0; i<items.length; i++) {
      if (items[i].endsWith('json')) {	  
         //console.log(items[i]);
      }
   }
}
);
*/
