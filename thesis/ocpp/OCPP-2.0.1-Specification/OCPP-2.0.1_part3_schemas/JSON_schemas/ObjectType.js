(function() {

var fs = require('fs');
var utils = require('./utils.js');
function clean(f) {
   // Some of the names in the json files are invalid SPARK. replace them with something that isn't.
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
   retval = retval.replace(regexdelta, 'zzzDelta');
   retval = retval.replace(regexstring, 'zzzstring');
   retval = retval.replace(regexboolean, 'zzzboolean');
   retval = retval.replace(regexdotjson, '');
   retval = retval.replace(regex_json, '');
   return retval;
}

function cleanpropertyname(f) {
   const regextype = /type/g;
   const regexconstant = /constant/g;

   var retval = f.replace(regextype, 'zzztype');
   retval = retval.replace(regexconstant, 'zzzconstant');
   
   if (retval != f) {
      console.log('renaming ' + f + ' to ' + retval)
   } else {
      //console.log('not renaming ' + f + ' to ' + retval)
   }

   return retval;
}

function cleanfilename(f) {
   const regex15118 = /15118/g;
   const regex_json = /_json/g;
   const regexdotjson = /\.json/g;
   const regexdotslash = /\.\//g;
   var retval = f.replace(regex_json, '');
   retval = retval.replace(regexdotjson, '');
   retval = retval.replace(regexdotslash, '');
   return retval;
}

function createArrayType(name, schema) {
   console.log('62: createArrayType: name:', name, 'schema:', schema, 'schema.items.javaType:',  schema.items.javaType,  'schema.items.type', schema.items.type);

   var _outfile = cleanfilename('ocpp-' + name + 'TypeArray.ads').toLowerCase();

   var _buffer ="pragma SPARK_mode (on); \n\n";
   _buffer += ('with NonSparkTypes;\n')
   _buffer += ('with ocpp.integerType;\n')
   if (!!schema.items.javaType) {
      _buffer += ('with ocpp.' + schema.items.javaType + 'Type;\n\n')
   }

   var theType = ( !!schema.items.javaType ? schema.items.javaType : schema.items.type )

   _buffer += ('package ocpp.' + name + 'TypeArray is\n');

   _buffer += ('type Index is range 1 .. 10;\n')
   _buffer += ('type array_' + theType  + 'Type is array (Index) of ' + 'ocpp.' + theType + 'Type.T' + ';\n')
   _buffer += ('type T is record\n')
   _buffer += ('   content : array_' + theType + 'Type;\n')
   _buffer += ('end record;\n')

   _buffer += ('procedure Initialize(self: out ocpp.' + name + 'TypeArray.T)\n')
   _buffer += ('  with\n')
   _buffer += ('Global => null,\n')
   _buffer += ('Annotate => (GNATprove, Terminating);\n\n')

   _buffer += ('procedure FromString(msg: in NonSparkTypes.packet.Bounded_String;\n')
   _buffer += ('                     msgindex: in out Integer;\n')
   _buffer += ('                     self: out T;\n')
   _buffer += ('                     valid: out Boolean);\n\n')

   _buffer += ('procedure To_Bounded_String(msg: out NonSparkTypes.packet.Bounded_String;\n')
   _buffer += ('                   self: in T);\n\n')

   _buffer += ('end ocpp.' + name + 'TypeArray;\n')


   console.log('\ncreateArrayType: _buffer:\n', _buffer);
   fs.writeFile((_outfile), _buffer, function (err, file) {
      if (err) throw err;
      //console.log('Saved %s', outfile);
   });




   _outfile = cleanfilename('ocpp-' + name + 'TypeArray.adb').toLowerCase();
   _buffer ="pragma SPARK_mode (on); \n\n";

   _buffer +="with Ada.Strings; use Ada.Strings;\n\n";
   _buffer += ('package body ocpp.' + name + 'TypeArray is\n');
   _buffer += ('   procedure Initialize(self: out ocpp.' + name + 'TypeArray.T)\n\n')
   _buffer += ('   is\n')
   _buffer += ('   begin\n')
   _buffer += ('      for i in Index loop\n')
   _buffer += ('         ' + theType + 'Type.Initialize(self.content(i));\n')
   _buffer += ('         self.content(i).zzzArrayElementInitialized := False;\n')
   _buffer += ('      end loop;\n')
   _buffer += ('   end Initialize;\n\n')

   _buffer += ('   procedure FromString(msg: in NonSparkTypes.packet.Bounded_String;\n')
   _buffer += ('                        msgindex: in out Integer;\n')
   _buffer += ('                        self: out T;\n')
   _buffer += ('                        valid: out Boolean)\n')
   _buffer += ('   is\n')
   _buffer += ('      last: Natural;\n')
   _buffer += ('      tempIndex: Integer := msgIndex;\n')
   _buffer += ('      lastIndex: Integer;\n')
   _buffer += ('      tempBool: Boolean;\n')
   _buffer += ('   begin\n')
   _buffer += ('      valid := false;\n')
   _buffer += ('      for i in Index loop\n')
   _buffer += ('         ' + theType + 'Type.Initialize(self.content(i));\n')
   _buffer += ('      end loop;\n')
   _buffer += ('      ocpp.moveIndexPastToken(msg, \']\', tempIndex, lastIndex);\n')
   _buffer += ('      NonSparkTypes.put("first: "); NonSparkTypes.put(msgindex\'Image);\n')
   _buffer += ('      NonSparkTypes.put(" last:"); NonSparkTypes.put_line(lastIndex\'Image);\n')
   _buffer += ('      NonSparkTypes.put(" tempIndex:"); NonSparkTypes.put_line(tempIndex\'Image);\n')
   _buffer += ('      tempIndex := msgindex;\n')
      
      
      
      
      




   _buffer += ('      for i in Index loop\n')
   _buffer += ('         if i /= Index\'First\n')
   _buffer += ('         then\n')
   _buffer += ('           ocpp.moveIndexPastToken(msg, \',\', tempIndex, last);\n')
   _buffer += ('           if (tempIndex >= lastIndex) then\n')
   _buffer += ('              self.content(i).zzzArrayElementInitialized := false;\n')
   _buffer += ('              return; -- end of array\n')
   _buffer += ('           end if;\n')
   _buffer += ('           tempIndex := msgindex;')
   _buffer += ('           NonSparkTypes.put("moved past comma. tempIndex:"); NonSparkTypes.put_line(tempIndex\'Image);\n')
   _buffer += ('           if (last = 0) or (tempIndex > lastIndex) then\n')
   _buffer += ('               --put_line("39: no comma");\n')
   _buffer += ('               self.content(i).zzzArrayElementInitialized := false;\n')
   _buffer += ('               return; -- end of array\n')
   _buffer += ('            end if;\n')
   _buffer += ('         end if;\n')
   _buffer += ('         ' + theType + 'Type.parse(msg, tempIndex, self.content(i), tempBool);\n')
   _buffer += ('         self.content(i).zzzArrayElementInitialized := tempBool;\n')
   _buffer += ('         NonSparkTypes.put("parsed AdditionalInfoType. tempIndex:"); NonSparkTypes.put(tempIndex\'Image); NonSparkTypes.put_line(self.content(i).zzzArrayElementInitialized\'Image);\n')
   _buffer += ('         if self.content(i).zzzArrayElementInitialized = True then\n')
   _buffer += ('            valid := True; -- need at least one valid item in the array for parsing to succeed\n')
   _buffer += ('            msgIndex := tempIndex;\n')
   _buffer += ('         end if;\n')
   _buffer += ('      end loop;\n')
   _buffer += ('   end FromString;\n\n')

   _buffer += ('   procedure To_Bounded_String(msg: out NonSparkTypes.packet.Bounded_String;\n')
   _buffer += ('                            self: in T)\n')
   _buffer += ('   is\n')
   _buffer += ('      dummybounded: NonSparkTypes.packet.Bounded_String;\n')
   _buffer += ('   begin\n')
   /*
      for i in Index loop
         GetVariableDataType.To_Bounded_String(self.content(i), dummybounded);
         NonSparkTypes.packet.Append(Source => msg, New_Item => dummybounded,Drop => Right);
      end loop;
      */
   _buffer += ('      msg := NonSparkTypes.packet.To_Bounded_String("");\n')
   _buffer += ('      NonSparkTypes.packet.Append(Source => msg, New_Item => "[",Drop => Right);\n')
   _buffer += ('      for i in Index loop\n')
   _buffer += ('         exit when self.content(i).zzzArrayElementInitialized = False;\n')
   _buffer += ('         if i /= Index\'First then\n')
   _buffer += ('            NonSparkTypes.packet.Append(Source => msg, New_Item => ",",Drop => Right);\n')
   _buffer += ('         end if;\n')
   _buffer += ('         ' + theType + 'Type.To_Bounded_String(self.content(i), dummybounded);\n')
   _buffer += ('         NonSparkTypes.packet.Append(Source => msg, New_Item => dummybounded,Drop => Right);\n')
   _buffer += ('      end loop;\n')
   _buffer += ('      NonSparkTypes.packet.Append(Source => msg, New_Item => "]",Drop => Right);\n')

   _buffer += ('   end To_Bounded_String;\n\n')

   _buffer += ('end ocpp.' + name + 'TypeArray;\n')


   console.log('\ncreateArrayType: _buffer:\n', _buffer);
   fs.writeFile((_outfile), _buffer, function (err, file) {
      if (err) throw err;
      //console.log('Saved %s', outfile);
   });

}

function createStringTypes(schema, name) {
   //console.log('createStringType:', name, schema.properties)
   var propertyHasStrings = false
   for (var i in schema.properties) {
      var property = schema.properties[i]
      if (property.type === 'string') {
         propertyHasStrings = true
      }
   }

   if (propertyHasStrings === false) {
      return
   }

   var _outfile = name.toLowerCase() + 'strings.ads'
   var _buffer = '--pragma SPARK_Mode (Off);\n\n'
   _buffer += 'with Ada.Strings.Bounded;\n\n'
   _buffer += 'package ' + name + 'Strings is\n'
   
   for (var i in schema.properties) {
      var property = schema.properties[i]
      //console.log('property:', property)
      if (property.type === 'string') {
         //console.log('found string: ', i, property);
         _buffer += '   package str' + i + '_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => ' + (!!property.maxLength ? property.maxLength : 100) + ');\n'
         
      }
   }










   _buffer += 'end ' + name + 'Strings;'
   //console.log('_buffer:', _buffer)
   fs.writeFile((_outfile), _buffer, function (err, file) {
      if (err) throw err;
      console.log('Saved %s', _outfile);
   });
}

function includeStringTypes(schema, name) {
   var propertyHasStrings = false
   for (var i in schema.properties) {
      var property = schema.properties[i]
      if (property.type === 'string') {
         propertyHasStrings = true
      }
   }

   if (propertyHasStrings === false) {
      return ''
   }

   var _buffer = 'with ' + name + 'strings;\n'
   
   /*
   for (var i in schema.properties) {
      var property = schema.properties[i]
      //console.log('property:', property)
      if (property.type === 'string') {
         //console.log('found string: ', i, property);
         _buffer += 'with str' + i + '_t is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => ' + (!!property.maxLength ? property.maxLength : 100) + ');\n'
         
      }
   }
   */
   return _buffer
   //console.log('_buffer:', _buffer)

}

module.exports.parse = function (name, schema) {
   name = cleanfilename(name);

   console.log('parseObjectType: ', name);
   var _outfile
   if (name.endsWith('Request') || name.endsWith('Response')) {
      _outfile = cleanfilename('ocpp-' + name + '.ads');
   } else {
      _outfile = cleanfilename('ocpp-' + name + 'Type.ads');
   }
   //console.log('parseObjectType: _outfile: ', _outfile);
   var _buffer ="pragma SPARK_mode (on); \n\n";
   
   _buffer += ('with Ada.Strings.Fixed; use Ada.Strings.Fixed;\n')
   _buffer += ('with NonSparkTypes; use NonSparkTypes.action_t; \n')
   _buffer += ('with ocpp; use ocpp;\n')


   createStringTypes(schema, name)
   _buffer += includeStringTypes(schema, name)


    // include definitions for any types we need
   for (var property in schema.properties) {
      if (property === 'customData') {
         continue;
      }
     
      if (!!schema.properties[property]['type'] && schema.properties[property]['type'] === 'array') {
         console.log('207: property:', property, schema.properties[property]['type'], 'schema.properties[property]:', schema.properties[property]);
         createArrayType(property, schema.properties[property]);
         _buffer += ('with ocpp.' + property + 'TypeArray;\n')
      }
   }

   _buffer += utils.parseIncludes(schema);
   _buffer += '\n';

   _buffer += 'package ocpp.' + name + ' is\n';
   if (name.endsWith('Request') ) {
      _buffer += '   action : constant NonSparkTypes.action_t.Bounded_String := NonSparkTypes.action_t.To_Bounded_String("' + utils.parseAction(name) + '"); \n';
      _buffer += '   type T is new call with record\n';
      if (Object.keys(schema.properties).length === 1) {
         _buffer += '      unused : Integer;\n';
      }
   }
   else if (name.endsWith('Response') ){
      _buffer += '   type T is new callresult with record\n';
      console.log("schema.properties.length:", name, Object.keys(schema.properties).length);
      if (Object.keys(schema.properties).length === 1) {
         _buffer += '      unused : Integer;\n';
      }
   }
   else {
      _buffer += '   type T is record\n';
      _buffer += '      zzzArrayElementInitialized : Boolean := False;\n';
   }

   for (var property in schema.properties) {
      if (property === 'customData') {
         continue;
      }

      /*
      console.log("schema.properties[property]:", schema.properties[property] );
      console.log("Object.keys(schema.properties[property]):", Object.keys(schema.properties[property] ));
      console.log('Object.keys(schema.properties[property]["type"]):', schema.properties[property]["type"]);
      */
      var _type = schema.properties[property]['type'] 
      var _javaType = schema.properties[property]['javaType'] 

      switch (_type) {
         case 'array':
            _type = property + 'TypeArray.T';
            break;
         case 'string':
            if (!!_javaType && _javaType.endsWith('Enum') ) {
               _type = _javaType + 'Type.T';
            } else {
               _type = name + 'Strings.str' + property + '_t.Bounded_String';
            }
            break;
         case 'object':
            _type = schema.properties[property]['javaType'] + 'Type.T';
            break;
         case 'number':
            _type = 'Integer';
            break;
      }
      _buffer += '      ' + cleanpropertyname(property) + ' : ' + _type + ';\n'; 
   }
   _buffer += '   end record;';

   _buffer += '\n';
   _buffer += '   procedure Initialize(self: out ocpp.' + name + '.T)\n'
   _buffer += '   with\n'
   _buffer += '    Global => null,\n'
   _buffer += '    Annotate => (GNATprove, Terminating),\n'
   _buffer += '    Depends => (self => null);\n\n'

   _buffer += '   procedure parse(msg: in NonSparkTypes.packet.Bounded_String;\n'
   _buffer += '                msgindex: ' + ((!(name.endsWith("Request") || name.endsWith("Response"))) ? " in" : "") + ' out Integer;\n'
   _buffer += '                self: out ocpp.' + name + '.T;\n'
   _buffer += '                valid: out Boolean\n'
   _buffer += '               )\n'
   _buffer += '   with\n'
   _buffer += '    Global => null,\n'
   _buffer += '    Annotate => (GNATprove, Terminating),\n'
   _buffer += '    Depends => (\n'
   _buffer += '                valid => (msg' + ((!(name.endsWith("Request") || name.endsWith("Response"))) ? ", msgindex" : "") + '),\n'
   _buffer += '                msgindex => (msg' + ((!(name.endsWith("Request") || name.endsWith("Response"))) ? ", msgindex" : "") + '),\n'
   _buffer += '                self  => (msg' + ((!(name.endsWith("Request") || name.endsWith("Response"))) ? ", msgindex" : "") + ')\n'
   if (name.endsWith('Request') || name.endsWith('Response')) {
      _buffer += '),\n'
      _buffer += '    post => (if valid = true then\n'
      _buffer += '               (self.messagetypeid = ' + (name.endsWith('Request') ? '2' : '3') + ') and\n'
      _buffer += '               (NonSparkTypes.messageid_t.Length(self.messageid) > 0)';
      if (name.endsWith('Request') ) {
         _buffer += ' and\n';
         _buffer += '               (self.action = action) -- prove that the original packet contains the corresponding "action"\n'
      }
   }
   _buffer += '            );\n\n'
   _buffer += '   procedure To_Bounded_String(Self: in T;\n'
   _buffer += '                               retval: out NonSparkTypes.packet.Bounded_String)\n'
   _buffer += '      with\n'
   _buffer += ' Global => null,\n'
   _buffer += ' Annotate => (GNATprove, Terminating);\n'

   _buffer += 'end ocpp.' + name + ';';
   //console.log('\n\n\nbuffer:\n', _buffer, '\n\n');
   var outfile = 'ocpp-' + clean(name).toLowerCase() + '.ads';
   fs.writeFile((outfile), _buffer, function (err, file) {
      if (err) throw err;
      //console.log('Saved %s', outfile);
   });

   // source file
   _buffer = "pragma SPARK_mode (on); \n\n";
   _buffer += 'with ocpp;\n';
   _buffer += 'with ocpp.' + name + ';\n';
   _buffer += 'with Ada.Strings; use Ada.Strings;\n\n';
   _buffer += 'package body ocpp.' + name + ' is \n\n';
   _buffer += 'procedure findquotedstring_packet is new findquotedstring(\n'
   _buffer += '                                                             Max => NonSparkTypes.packet.Max_Length, \n'
   _buffer += '                                                             string_t => NonSparkTypes.packet.Bounded_String, \n'
   _buffer += '                                                             length => NonSparkTypes.packet.Length,\n'
   _buffer += '                                                             To_String => NonSparkTypes.packet.to_string,\n'
   _buffer += '                                                             To_Bounded_String =>  NonSparkTypes.packet.To_Bounded_String\n'
   _buffer += '                                                            );\n\n'
   _buffer += '   procedure Initialize(self: out ocpp.' + name + '.T)\n'
   _buffer += '   is\n';
   _buffer += '   begin\n';
   if (!((name.endsWith('Request') || name.endsWith('Response')))) {
      _buffer += '      self.zzzArrayElementInitialized := False;\n';
   }
   if (name.endsWith('Request') || name.endsWith('Response')) {
      _buffer += '      self.messageTypeId:= -1;\n';
      _buffer += '      self.messageId := NonSparkTypes.messageid_t.To_Bounded_String("");\n';
      if (Object.keys(schema.properties).length === 1) {
         _buffer += '      self.unused := -1;\n';
      }
   }
   if (name.endsWith('Request')) {
      _buffer += '      self.action := NonSparkTypes.action_t.To_Bounded_String("");\n';
   }

   for (var property in schema.properties) {
      if (property === 'customData') {
         continue;
      }

      var type = schema.properties[property]["type"];   // int, string
      var _javaType = schema.properties[property]['javaType'] 

      switch (type) {
         case 'number':
         case 'integer':
            _buffer += '      self.' + property + ' := -1;\n';
            break;
         case 'array':
            _buffer += '      ' + property + 'TypeArray.Initialize(self.' + property + ');\n';
            break;
         case 'string':
               if (!!_javaType && _javaType.endsWith('Enum')) { // eg: getBaseReportRequest.reportBase : ocpp.ReportBaseEnum
                  _buffer += '      self.' + cleanpropertyname(property) + ' := ' + _javaType + 'Type.' + clean(schema.properties[property]["enum"][0]) +';\n';
               } else {
                  _buffer += '      self.' + cleanpropertyname(property) + ' := ' + name + 'Strings.str' + property + '_t.To_Bounded_String("");\n';
               }
            break;
         case 'boolean':
            _buffer += '      self.' + cleanpropertyname(property) + ' := False;\n';
            break;
         default:
               _buffer += '      ' + _javaType + 'Type.Initialize(self.' + property + ');\n';
            break;

      }
   }
   _buffer += '\n';




   _buffer += '   end Initialize;\n\n';

   _buffer += '   procedure parse(msg:   in  NonSparkTypes.packet.Bounded_String;\n';
   _buffer += '                   msgindex:' + ((!(name.endsWith("Request") || name.endsWith("Response"))) ? " in" : "") + ' out Integer;\n';
   _buffer += '                   self: out ocpp.' + name + '.T;\n';
   _buffer += '                   valid: out Boolean\n';
   _buffer += '                  )\n';
   _buffer += '   is\n';

   for (var property in schema.properties) {
      if (property === 'customData') {
         continue;
      }
      var type = schema.properties[property]["type"];   // int, string
      var _javaType = schema.properties[property]['javaType'] 

      /*
      switch (type) {
         case "array":
            _buffer += '      str' + property + ': NonSparkTypes.packet.Bounded_String;\n';
            break;
         default:
            break;
      }
      */
   }

   _buffer += '      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String("");\n';
   _buffer += '      dummyInt: integer;\n';


   _buffer += '   begin\n';
   _buffer += '      Initialize(self);\n';

   if (name.endsWith('Request') || name.endsWith('Response')) {
/*
   procedure ParseMessageType(msg:   in  NonSparkTypes.packet.Bounded_String;
                              messagetypeid : out integer;-- eg. 2
                              index: in out Integer;
                              valid: out Boolean
                             );

   procedure ParseMessageId(msg:   in  NonSparkTypes.packet.Bounded_String;
                            messageid : out NonSparkTypes.messageid_t.Bounded_String;
                            index: in out Integer;
                            valid: out Boolean
                           );
*/

   
      _buffer += '      msgIndex := 1;\n'
      _buffer += '      ocpp.ParseMessageType(msg, self.messagetypeid, msgindex, valid);\n'
      _buffer += '      if (valid = false) then NonSparkTypes.put_line("413 Invalid ' + name + property + ' messagetypeid"); return; end if;\n\n'
      
      _buffer += '      ocpp.ParseMessageId(msg, self.messageid, msgindex, valid);\n'
      _buffer += '      if (valid = false) then NonSparkTypes.put_line("416 Invalid ' + name + property + ' messageid"); return; end if;\n\n'


/*
      ocpp.ParseAction(msg, msgindex, self.action, valid);
      checkValid(msg, msgindex, self, action, valid);
      */
      if (name.endsWith('Request')) {
         _buffer += '      ocpp.ParseAction(msg, msgindex, self.action, valid);\n'
         _buffer += '      if (valid = false) then NonSparkTypes.put_line("404 Invalid action"); return; end if; \n\n'
      }




      _buffer += '      checkValid(msg, msgindex, self, ' + (name.endsWith('Request') ? 'action, ' : '') + 'valid);\n'
      _buffer += '      if (valid = false) then NonSparkTypes.put_line("313 Invalid ' + name + property + '"); return; end if;\n\n'
      /*
         NonSparkTypes.put_line("313 Invalid SetVariablesResponsesetVariableResult"); 
         NonSparkTypes.put("self.messagetypeid:"); NonSparkTypes.put_line(self.messagetypeid'Image); 
         NonSparkTypes.put("self.messageid:"); NonSparkTypes.put_line(messageid_t.To_String(self.messageid)); 
         */
   }

   // parse each property
   for (var property in schema.properties) {
      if (property === 'customData') {
         continue;
      }

      var type = schema.properties[property]["type"];   // int, string
      var _javaType = schema.properties[property]['javaType'] 

      switch (type) {
         case 'integer':
            _buffer += '      ocpp.findQuotedKeyUnquotedValue(msg, msgIndex, valid, "' + property + '", dummyInt);\n';
            _buffer += '      if (valid = false) then NonSparkTypes.put_line("328 Invalid ' + name + property + '"); return; end if;\n'
            _buffer += '      self.' + cleanpropertyname(property) + ' := dummyInt;\n';
            break;
         case 'string':
               _buffer += '      ocpp.findQuotedKeyQuotedValue(msg, msgIndex, valid, "' + property + '", dummybounded);\n';
               _buffer += '      if (valid = false) then NonSparkTypes.put_line("333 Invalid ' + name + property + '"); return; end if;\n\n'
            if (!!_javaType && _javaType.endsWith('Enum')) { // eg: getBaseReportRequest.reportBase : ocpp.ReportBaseEnum
               _buffer += '      ocpp.' + _javaType + 'Type.FromString(NonSparkTypes.packet.To_String(dummybounded), Self.' + cleanpropertyname(property) + ', valid);\n';
               _buffer += '      if (valid = false) then NonSparkTypes.put_line("334 Invalid ' + name + property + '"); return; end if;\n'
            } else
            {
               _buffer += '      self.' + cleanpropertyname(property) + ' := ' + name + 'Strings.str' + property + '_t.To_Bounded_String(NonSparkTypes.packet.To_String(dummybounded), Drop => Right);\n';
            }
            
            break;
         case 'array':
            _buffer += '      ocpp.findQuotedKey(msg, msgIndex, valid, "' + property + '");\n';
            _buffer += '      if (valid = false) then NonSparkTypes.put_line("345 Invalid ' + name + property + '"); return; end if;\n\n'
            _buffer += '      ' + property + 'TypeArray.FromString(msg, msgindex, self.' + property + ', valid);\n';
            _buffer += '      if (valid = false) then NonSparkTypes.put_line("347 Invalid ' + name + property + '"); return; end if;\n'
            break;
         default:
            if (!!_javaType) {
               _buffer += '      ocpp.findQuotedKey(msg, msgIndex, valid, "' + property + '");\n';
               _buffer += '      if (valid = false) then NonSparkTypes.put_line("355 Invalid ' + name + property + '"); return; end if;\n\n'
               _buffer += '      ' + utils.parseType(schema.properties[property]) + 'Type.parse(msg, msgindex, self.' + property + ', valid);\n';
               _buffer += '      if (valid = false) then NonSparkTypes.put_line("357 Invalid ' + name + property + '"); return; end if;\n'
            }
            break;
      }
      _buffer += '\n';

   }
   _buffer += '      if (valid = false) then NonSparkTypes.put_line("365 Invalid ' + name + property + '"); return; end if;\n'



   _buffer += '      valid := true;\n'
   _buffer += '   end parse;\n\n';
   _buffer += '   procedure To_Bounded_String(Self: in T;\n';
   _buffer += '                               retval: out NonSparkTypes.packet.Bounded_String)\n';
   _buffer += '   is\n';
   _buffer += '      dummybounded: NonSparkTypes.packet.Bounded_String := NonSparkTypes.packet.To_Bounded_String(""); \n';

   // for every string type member variable, add a string buffer
   for (var property in schema.properties) {
      if (property === 'customData') {
         continue;
      }
      var type = schema.properties[property]["type"];   // int, string
      var _javaType = schema.properties[property]['javaType'] 

      switch (type) {
         case 'boolean':
         case 'number':
         case 'integer':
            break;
         case 'string':
            if (!!_javaType && _javaType.endsWith('Enum')) {
               _buffer += '      str' + property + ' : ' + _javaType + 'Type.string_t.Bounded_String;\n';
            }
            break;
         case "array":
            _buffer += '      str' + property + ': NonSparkTypes.packet.Bounded_String;\n';
            break;
         default:
            if (!!type) {
               _buffer += '      str' + property + ' : NonSparkTypes.packet.Bounded_String;\n';
            }
            break;
      }
   }

   _buffer += '   begin\n';
   for (var property in schema.properties) {
      if (property === 'customData') {
         continue;
      }
      var type = schema.properties[property]["type"];   // int, string
      var _javaType = schema.properties[property]['javaType'] 

      switch (type) {
         case 'boolean':
            break;
         case 'integer':
            break;
         case 'string':
            if (!!_javaType && _javaType.endsWith('Enum')) {
               _buffer += '      ' + _javaType + 'Type.ToString(Self.' + cleanpropertyname(property) + ', str' + property + ');\n';
            }
            break;
         case 'object':
            if (!!_javaType) {
               _buffer += '      ' + _javaType + 'Type.To_Bounded_String(Self.' + cleanpropertyname(property) + ', str' + property + ');\n';
            }
            break;
         case "array":
            _buffer += '      ' + property + 'TypeArray.To_Bounded_String(str' + cleanpropertyname(property) + ', self.' + property + ');\n';
            break;
         default:
            break;
      }
   }

   _buffer +=    '      retval := NonSparkTypes.packet.To_Bounded_String(""\n';
   
   if (name.endsWith('Request') ) {
      _buffer += '                                                      & "[2," & ASCII.LF\n';
      _buffer +=    '                                                      & \'"\'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & \'"\' & "," & ASCII.LF\n';
   }
   else if (name.endsWith('Response')){
      _buffer += '                                                      & "[3," & ASCII.LF\n';
      _buffer +=    '                                                      & \'"\'  &  NonSparkTypes.messageid_t.To_String(Self.messageid) & \'"\' & "," & ASCII.LF\n';
   }
   
   if (name.endsWith('Request') ) {
      _buffer += '                                                      & \'"\' & NonSparkTypes.action_t.To_String(Self.action) & \'"\' & "," & ASCII.LF\n';
      
   }
   _buffer +=    '                                                      & "{" & ASCII.LF\n';

   //console.log("schema.properties:", schema.properties, Object.keys(schema.properties).length);
   var propertyCounter = 0
   for (var property in schema.properties) {
      propertyCounter++
      if (property === 'customData') {
         continue;
      }
      var type = schema.properties[property]["javaType"];   // int, string
      if (!!type) {
         type += 'Type';
      } else {
         type = schema.properties[property]["type"];   // int, string
      }
      switch (type) {
         case 'boolean':
         case 'number':
         case 'integer':
            _buffer +=    '                                                      & "    " & \'"\' & "' + cleanpropertyname(property) + '" & \'"\' & ": "' +
                                                                                 ' & ' + 'Self.' + cleanpropertyname(property) + '\'Image';
            break;
         case 'object':
            _buffer +=    '                                                      & "    " & \'"\' & "' + property + '" & \'"\' & ": " & ASCII.LF' 
            break;
         case 'array':
               _buffer +=    '                                                      & "    " & \'"\' & "' + property + '" & \'"\' & ": " & NonSparkTypes.packet.To_String(str' + property + ')' 
            break;
         case 'string':
               _buffer +=    '                                                      & "    " & \'"\' & "' + property + '" & \'"\' & ": " & \'"\' & ' + name + 'Strings.str' + property + '_t.To_String(Self.' + cleanpropertyname(property) + ') & \'"\'' 
            break;
         default:
            if (type.endsWith('EnumType')) {
               _buffer +=    '                                                      & "       " & \'"\' & "' + property + '" & \'"\' & ":"  & \'"\' & ' + type + '.string_t.To_String(str' + property + ') & \'"\'' 
            } else if (type.endsWith('Type')) {
               _buffer +=    '                                                      & "    " & \'"\' & "' + property + '" & \'"\' & ":" & NonSparkTypes.packet.To_String(str' + property + ')' 
            } else {
               _buffer +=    '                                                      & "    " & \'"\' & "' + property + '" & \'"\' & ": "' + 
                                                                                    ' & \'"\' & ' + schema.properties[property]["javaType"] + 'Type.string_t.To_String(str' + property + ') & \'"\'';
            }
            break;
      }
      
      _buffer += ((propertyCounter === (Object.keys(schema.properties).length)) ? '' : ' & ","') + // append a comma to all but the last property
                                                                                 ' & ASCII.LF\n';


   }

   _buffer +=    '                                                      & "}" & ASCII.LF\n';


   if (name.endsWith('Request') || name.endsWith('Response')) {
      _buffer += '                                                      & "]"';
   }

   _buffer += ', Drop => Right);\n'
   _buffer += '   end To_Bounded_String;\n';
   


   _buffer += 'end ocpp.' + name + ';\n';
   outfile = 'ocpp-' + clean(name).toLowerCase() + '.adb';
   fs.writeFile((outfile), _buffer, function (err, file) {
      if (err) throw err;
      //console.log('Saved %s', outfile);
   });
}
}());
                        
