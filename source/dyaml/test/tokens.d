
//          Copyright Ferdinand Majerech 2011.
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)

module dyaml.test.tokens;


version(unittest)
{

import std.array;
import std.file;

import dyaml.test.common;
import dyaml.token;


/**
 * Test tokens output by scanner.
 *
 * Params:  dataFilename   = File to scan.
 *          tokensFilename = File containing expected tokens.
 */
void testTokens(string dataFilename, string tokensFilename) @safe
{
    //representations of YAML tokens in tokens file.
    auto replace = [
        TokenID.directive: "%",
        TokenID.documentStart: "---",
        TokenID.documentEnd: "...",
        TokenID.alias_: "*",
        TokenID.anchor: "&",
        TokenID.tag: "!",
        TokenID.scalar: "_",
        TokenID.blockSequenceStart: "[[",
        TokenID.blockMappingStart: "{{",
        TokenID.blockEnd: "]}",
        TokenID.flowSequenceStart: "[",
        TokenID.flowSequenceEnd: "]",
        TokenID.flowMappingStart: "{",
        TokenID.flowMappingEnd: "}",
        TokenID.blockEntry: ",",
        TokenID.flowEntry: ",",
        TokenID.key: "?",
        TokenID.value: ":"
    ];

    string[] tokens1;
    string[] tokens2 = readText(tokensFilename).split();
    scope(exit)
    {
        static if(verbose){writeln("tokens1: ", tokens1, "\ntokens2: ", tokens2);}
    }

    auto loader = Loader.fromFile(dataFilename);
    foreach(token; loader.scan())
    {
        if(token.id != TokenID.streamStart && token.id != TokenID.streamEnd)
        {
            tokens1 ~= replace[token.id];
        }
    }

    assert(tokens1 == tokens2);
}

/**
 * Test scanner by scanning a file, expecting no errors.
 *
 * Params:  dataFilename      = File to scan.
 *          canonicalFilename = Another file to scan, in canonical YAML format.
 */
void testScanner(string dataFilename, string canonicalFilename) @safe
{
    foreach(filename; [dataFilename, canonicalFilename])
    {
        string[] tokens;
        scope(exit)
        {
            static if(verbose){writeln(tokens);}
        }
        auto loader = Loader.fromFile(filename);
        foreach(ref token; loader.scan()){tokens ~= to!string(token.id);}
    }
}

@safe unittest
{
    printProgress("D:YAML tokens unittest");
    run("testTokens",  &testTokens, ["data", "tokens"]);
    run("testScanner", &testScanner, ["data", "canonical"]);
}

} // version(unittest)
