module structopt.package;

import std.traits;
import std.getopt;

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

    // D's mixin requires a complete
    // statement to be built
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
              " getUDAs!(", Options.stringof, ".", opt, ", Help)[0].msg, &", Options.stringof, ".", opt, ",")
        }

        return ans ~ ");";
    }

    // Pass in the struct to generate UDA for
    auto helpInfo = mixin(GenerateGetopt!props);

    
        defaultGetoptPrinter("Options: ",
          helpInfo.options);
        // Output to console:

        //Options:
        //-t --threads Number of threads to use.
        //      --file Input files
        //-h    --help This help information./
    
}

// -- These define the data type for the UDA

struct Help {
    string msg;
}

struct Option {
    string[] names;

    this(string[] names...) {
        this.names = names;
    }

    string cononical() {
        import std.algorithm;
        import std.conv;
        return names.joiner("|").to!string;
    }
}
