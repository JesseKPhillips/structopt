/**
 * This generative method creates a getopt call based on the
 * attributes assign to  a structure.
 *
 * ```
import structopt;

// Specify The Parameter Structure
struct Options
{
    @Option("threads", "t")
    @Help("Number of threads to use.")
    size_t threads;

    @Option("file")
    @Help("Input files")
    string[] files;
}

void main(string[] args) {
    Options props;

    // Pass in the struct to generate UDA for
    auto helpInfo = mixin(GenerateGetopt!(props, args));

        defaultGetoptPrinter("Options: ",
          helpInfo.options);
        // Output to console:

        //Options:
        //-t --threads Number of threads to use.
        //      --file Input files
        //-h    --help This help information./
}
 * ```
 */
module structopt;

public import structopt.attributes;
public import std.getopt;
public import std.traits;

/// Rename the Option struct of getopt
alias GetOption = std.getopt.Option;
/// Reastablish the name for the struct attributes
alias Option = structopt.attributes.Option;

/**
 * Generate the std.getopt method call.
 */
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
///
unittest {
    // Specify The Parameter Structure
    struct Options
    {
        @Option("threads", "t")
        @Help("Number of threads to use.")
        size_t threads;

        @Option("file")
        @Help("Input files")
        string[] files;
    }

    Options props;
    string[] arg = ["./structopt", "t", "24"];

    // Pass in the struct to generate UDA for
    auto helpInfo = mixin(GenerateGetopt!(props, arg));
    auto expected = [
        GetOption("-t", "--threads", "Number of threads to use.", false),
        GetOption("", "--file", "Input files", false),
        GetOption("-h", "--help", "This help information.", false)
    ];

    import std.algorithm;
    assert(helpInfo.options.equal(expected));

}
