:- use_module(library(charsio)).
:- use_module(library(dcgs)).

/**

Ambiguous parsing example.

Inspired by ["Recreating uncensored Epstein PDFs from raw encoded
attachments"](https://neosmart.net/blog/recreating-epstein-pdfs-from-raw-encoded-attachments/),
I wanted to demonstrate how a stack of transformations with depth-first
search should improve on the 2^N expected performance, probably to
something like N!.

The problem, in brief, is that we are dealing with ambiguous characters,
which comprise an encoded binary. The best way to tell what the
ambiguous characters are is to try a decoding. In this case, the
encoding is Base64 which is very lenient. But the next layer decoding
is PDF, which is not as lenient. The hope is that as one is processing
the file, a decode error would fail, causing Prolog to backtrack to the
most recent choice point. In this way, we would be doing something more
like setting cylinders in a lock while lock-picking. This is because
we should encounter decode issues shortly after the ambiguous character
selection is made, rather than having to back up all the way to the start.

Because I don't actually want to decode Epstein attachment files myself,
this is simply a demonstration of the technique. I don't think there
is a PDF parser in Prolog but there is a built-in XML parser in Scryer,
and XML is another format where it should be feasible to detect a decode
problem without a lot of pain, so my example uses an XML input.
*/

ambiguate('l') --> "1". ambiguate('1') --> "l".
ambiguate(X) --> [X].

ambiguous([]) --> [].
ambiguous([X|Xs]) --> ambiguate(X), ambiguous(Xs).

%% ambiguate(+Text, -AmbiguousText) is multi.
%
% Ambiguate simulates ambiguities in Courier New text by treating 1s and
% ls as indeterminate. A solution is a possible reading of the text. All
% possible solutions are enumerated.
ambiguate(Text, AmbiguousText) :- phrase(ambiguous(AmbiguousText), Text).

