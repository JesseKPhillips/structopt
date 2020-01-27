/**
 * Compile Time attributes for specifying proprites to std.getopt.
 *
 * These structs are utilized by the the generator to populate
 * getopt's properties.
 */
module structopt.attributes;

import std.traits;

@safe:

/**
 * Command Line Help Message for the arugement.
 */
struct Help {
    /**
     * Help Message.
     */
    string msg;
}

/**
 * Command Line Argument Option which causes assignement to this field.
 */
struct Option {
@safe:
    /**
     * All argument options.
     */
    string[] names;

    /**
     * Construct all options into an array.
     *
     * ```
     * @Option("help", "h")
     */
    this(string[] names...) {
        this.names = names.idup;
    }

    /**
     * Used by generator to translate array into getopt argument.
     */
    string cononical() {
        import std.algorithm;
        import std.conv;
        return names.joiner("|").to!string;
    }
    ///
    unittest {
        auto opt = Option("help", "h");

        assert(opt.names == ["help", "h"]);
        assert(opt.cononical() == "help|h");
    }
}
