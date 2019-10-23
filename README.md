This package comes from a little tool I wrote for myself, then blogged about here.

https://dev.to/jessekphillips/argument-parsing-into-structure-4p4n

It allows for using a structure to define the desired command line arguments. Inspired by [darg](http://code.dlang.org/packages/darg).

```dlang
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
```
