var fs = require('fs');

function parseJsonFile(f) {
   var _datafile = require(f);
   console.log('parseJsonFile: _datafile:', _datafile.type);
   var _definitions = _datafile.definitions;
   //console.log(_definitions);

   for (var i in _definitions) {
      if (i.endsWith('EnumType')) {
         //console.log(i);
		 console.log('with Ada.Strings.Bounded;')
		 console.log('package ocpp.%s', i, 'is');
		 console.log('   type T is (');
		 for (var j in _definitions[i].enum) {
		    var enumElement = _definitions[i].enum;
		    console.log('     %s%s', _definitions[i].enum[j], (j == (_definitions[i].enum.length - 1)) ? '' : ','); // don't put a comma after the last enum
		 }
		 console.log('   );')
		 console.log();
         console.log('   package string_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 9);');
         console.log('   procedure FromString(str : in String;');
         console.log('                        attribute : out T;');
         console.log('                        valid : out Boolean);');
         console.log('   procedure ToString(attribute : in T;');
         console.log('                      str : out string_t.Bounded_String);');
		 console.log('end ocpp.%s;', i);
      }
   //var _enum = dataFile.definitions.ChargingStateEnumType.enum;
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
