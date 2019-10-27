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
    auto ans = text("getopt(", args.stringof, ", ");
    static foreach(opt; FieldNameTuple!(typeof(Options))) {
        ans ~= text("getUDAs!(", Options.stringof, ".", opt, ", ");
        ans ~= text(Option.stringof, ")", "[0].cononical(),");
        ans ~= text(" getUDAs!(", Options.stringof, ".", opt, ", ");
        ans ~= text(Help.stringof, ")[0].msg,");
        ans ~= text(" &", Options.stringof, ".", opt, ",");
    }

    return ans ~ ")";
}
