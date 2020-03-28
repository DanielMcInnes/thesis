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
   
   _buffer += ('with Ada.Strings.Fixed; use Ada.Strings.Fixed;\n')
   _buffer += ('with NonSparkTypes; use NonSparkTypes.action_t; \n')
   _buffer += ('with ocpp; use ocpp;\n')
   _buffer += utils.parseIncludes(_datafile);
   _buffer += '\n';

   _buffer += 'package ocpp.' + _package + ' is\n';
   if (_package.includes('Request') ) {
      _buffer += '   action : constant NonSparkTypes.action_t.Bounded_String := NonSparkTypes.action_t.To_Bounded_String("' + utils.parseAction(_package) + '"); \n';
      _buffer += '   type T is new call with record\n';
   }
   else {
      _buffer += '   type T is new callresult with record\n';
   }
   var _properties = _datafile.properties;
   for (var i in _properties) {
      var _type = i.type;
      _buffer += '      ' + i + ' : ' + utils.parseType(_properties[i]) + ';\n';
   }
   _buffer += '   end record;';

   _buffer += '\n';
   _buffer += '   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;\n'
   _buffer += '                msgindex: in Integer;\n'
   _buffer += '                packet: in ocpp.' + _package + '.T;\n'
   _buffer += '                valid: out Boolean\n'
   _buffer += '               )\n'
   _buffer += '   with\n'
   _buffer += '    Global => null,\n'
   _buffer += '    Depends => (\n'
   _buffer += '                valid => (msg, msgindex, packet)\n'
   _buffer += '               ),\n'
   _buffer += '    post => (if valid = true then\n'
   _buffer += '               (packet.messagetypeid = 2) and\n'
   _buffer += '               (NonSparkTypes.messageid_t.Length(packet.messageid) > 0) and\n'
   _buffer += '               (packet.action = action) and\n'
   _buffer += '               (Index(NonSparkTypes.packet.To_String(msg), NonSparkTypes.action_t.To_String(action)) /= 0) -- prove that the original packet contains the corresponding "action"\n'
   _buffer += '            );\n\n'
   _buffer += '   procedure To_Bounded_String(Self: in T;\n'
   _buffer += '                               retval: out NonSparkTypes.packet.Bounded_String);\n'
   _buffer += 'end ocpp.' + _package + ';';
   console.log('\n\n\nbuffer:\n', _buffer, '\n\n');
   var outfile = 'ocpp-' + clean(_package).toLowerCase() + '.ads';
   fs.writeFile((outfile), _buffer, function (err, file) {
      if (err) throw err;
      console.log('Saved %s', outfile);
   });

   // source file
   _buffer = "pragma SPARK_mode (on); \n\n";
   _buffer += 'with ocpp.' + _package + ';\n';
   _buffer += 'package body ocpp.' + _package + ' is \n';

   _buffer += '   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;\n';
   _buffer += '                   msgindex: in Integer;\n';
   _buffer += '                   packet: in ocpp.' + _package + '.T;\n';
   _buffer += '                   valid: out Boolean\n';
   _buffer += '                  )\n';
   _buffer += '   is\n';
   _buffer += '   begin\n';
   _buffer += '      checkValid(msg, msgindex, packet, valid);\n'
   

   var _required = _datafile.required;
   for (var i in _required) {
      var j = _required[i];
      console.log('   required: ', j);
   }
    /*
   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;
                   msgindex: in out Integer;
                   packet: in out ocpp.BootNotification.Request;
                   valid: out Boolean
                  )
   is
      str : string := "reason";
      retval : boolean;
      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");
      tempPositive: integer;
      indexStartOfOptionalParameters: Integer;
   begin
      valid:= false;

   end parse;
*/
   _buffer += '   end parse;\n';

   _buffer += '   procedure To_Bounded_String(Self: in T;\n';
   _buffer += '                               retval: out NonSparkTypes.packet.Bounded_String)\n';
   _buffer += '   is\n';
   _buffer += '   begin\n';
   _buffer += '      retval := NonSparkTypes.packet.To_Bounded_String("blah");\n';
   _buffer += '   end To_Bounded_String;\n';
   


   _buffer += 'end ocpp.' + _package + ';\n';
   outfile = 'ocpp-' + clean(_package).toLowerCase() + '.adb';
   fs.writeFile((outfile), _buffer, function (err, file) {
      if (err) throw err;
      console.log('Saved %s', outfile);
   });
   console.log('\n\n\nbuffer:\n', _buffer, '\n\n');
   }
}());

