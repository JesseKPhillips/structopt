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
    auto helpInfo = mixin(GenerateGetopt!props);

        defaultGetoptPrinter("Options: ",
          helpInfo.options);
        // Output to console:

        //Options:
        //-t --threads Number of threads to use.
        //      --file Input files
        //-h    --help This help information./
}
