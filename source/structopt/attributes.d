module structopt.attributes;

import std.traits;

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
