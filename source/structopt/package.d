module structopt;

public import structopt.attributes;
public import std.getopt;
public import std.traits;

alias GetOption = std.getopt.Option;
alias Option = structopt.attributes.Option;

string GenerateGetopt(alias Options, alias args)() pure nothrow {
    import std.meta;
    import std.typecons;
    import std.format;
       import std.conv;
       static foreach(opt; FieldNameTuple!(typeof(Options))) {
        // getUDAs will obtain the User Defined Attribute
        // of the specified type
           ans ~= text("getUDAs!(", Options.stringof, ".", opt, ", Option)[0].cononical(),",
             " getUDAs!(", Options.stringof, ".", opt, ", Help)[0].msg, &", Options.stringof, ".", opt, ",");
    auto ans = text("getopt(", args.stringof, ", ");
    }

    return ans ~ ")";
}
