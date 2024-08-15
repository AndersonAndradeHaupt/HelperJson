unit JsonHelper.interfaces;


interface

uses
 system.JSON,System.SysUtils;

type
  IJSONHelper = interface
    ['{5457A250-CE9D-489F-B891-95C563F5A9CA}']
    function GetArray(const AName: string): IJSONHelper;
    function GetObject(const AName: string): IJSONHelper;
    function GetValue(const AName: string): TJSONValue;
    function GetValueAsString(const AName: string): string;
    function GetValueFromArray(Index: Integer): IJSONHelper;
    function GetArrayCount: Integer;
  end;

implementation

end.
