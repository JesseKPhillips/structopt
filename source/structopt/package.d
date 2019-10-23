module structopt;

public import structopt.attributes;
public import std.getopt;
public import std.traits;

alias GetOption = std.getopt.Option;
alias Option = structopt.attributes.Option;

string GenerateGetopt(alias Options)() pure {
    import std.meta;
    import std.typecons;
    import std.format;
       import std.conv;
       auto ans = `getopt(args, `;
       static foreach(opt; FieldNameTuple!(typeof(Options))) {
        // getUDAs will obtain the User Defined Attribute
        // of the specified type
           ans ~= text("getUDAs!(", Options.stringof, ".", opt, ", Option)[0].cononical(),",
             " getUDAs!(", Options.stringof, ".", opt, ", Help)[0].msg, &", Options.stringof, ".", opt, ",");
    }

    return ans ~ ")";
}
