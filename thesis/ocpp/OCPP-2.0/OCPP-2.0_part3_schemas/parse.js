var fs = require('fs');

function parseJsonFile(f) {
   var _datafile = require(f);
   console.log('parseJsonFile: _datafile:', _datafile.type);
   var _definitions = _datafile.definitions;
   var buffer ="";


   for (var i in _definitions) {
      if (i.endsWith('EnumType')) {
         console.log('-- start ocpp-%s.ads', i);
         console.log('with Ada.Strings.Bounded;')
         console.log('package ocpp.%s', i, 'is');
         console.log('   type T is (');
         var maxlen = 0;
         for (var j in _definitions[i].enum) {
            if (_definitions[i].enum[j].length > maxlen) {
               maxlen = _definitions[i].enum[j].length;
            }

            var enumElement = _definitions[i].enum;
            console.log('     %s%s', _definitions[i].enum[j], (j == (_definitions[i].enum.length - 1)) ? '' : ','); // don't put a comma after the last enum
		   }
         console.log('   );')
         console.log();
         console.log('   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => %s);', maxlen);
         console.log('   procedure FromString(str : in String;');
         console.log('                        attribute : out T;');
         console.log('                        valid : out Boolean);');
         console.log('   procedure ToString(attribute : in T;');
         console.log('                      str : out string_t.Bounded_String);');
         console.log('end ocpp.%s;', i);
         console.log('-- end ocpp-%s.ads', i);
		   console.log();



         console.log('-- ocpp-%s.adb', i);
         console.log('with ocpp.%s; use ocpp.%s;', i, i);
         console.log('with NonSparkTypes;');
         console.log();
         console.log('package body ocpp.%s is', i);
         console.log('   procedure FromString(str : in String;');
         console.log('                        attribute : out T;');
         console.log('                        valid : out Boolean)');
         console.log('   is');
         console.log('   begin');
         for (var j in _definitions[i].enum) {
            var str = _definitions[i].enum[j];
            console.log('      %s (NonSparkTypes.Uncased_Equals(str, "%s")) then', (j == 0 ? 'if' : 'elsif'), str);
            console.log('         attribute := %s;', str);
            var enumElement = _definitions[i].enum;
         }


         console.log('      else ');
         console.log('         valid := false;');
         console.log('         return;');
         console.log('      end if;');
         console.log('      valid := true;');



         console.log('   end FromString;');
         console.log();

         console.log('   procedure ToString(attribute : in T;');
         console.log('                      str : out string_t.Bounded_String)');
         console.log('   is');
         console.log('      use string_t;');
         console.log('   begin');
         console.log('      case attribute is');
         for (var j in _definitions[i].enum) {
            var str = _definitions[i].enum[j];
            console.log('         when %s => str := To_Bounded_String("%s");', str, str);
         }
         console.log('      end case;');


         console.log('   end ToString;');
         console.log('end ocpp.%s;', i);
         console.log('-- end ocpp-%s.adb', i);


         console.log();
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
