
This is TwelveCalc, an RPN integer calculator for people who want to work in dozenal (or 'duodecimal') notation.

It was primarily an experiment in using SwiftUI, with which I'm still pretty unfamiliar (you'll see that from the code itself I expect), but it's also a tool I needed to aid in my attempts to start thinking in dozenal numbers. Why am I doing that? Well, you're not the first to ask. Suffice it to say that many people have made compelling arguments for it over the years, and I was willing to give it a shot. But it's not easy! Sort of like trying to learn to type on a Dvorak keyboard after a lifetime typing QWERTY-style. In particular, I have found the notation that most dozenal enthusiasts adopt a bit distracting. Everyone else tends to use the same Arabic numerals as the decimalists (that's their word for normal, sensible people), with the addition of a couple new digits to stand for ten and eleven. That makes my head hurt, so I've adopted a different convention, and this little calculator is part of my plan to test how my idea works out.

The gist of it is this: throw out all the usual numerals entirely, and make a visually distinct set that satisfy a few important conditions:

 - They don't look like the Arabic numerals, so your brain doesn't inadvertently shift back into 'decimal-mode';
 - They already have Unicode code points, and are already in most Unicode-supporting fonts;
 - They don't look like the Roman characters that the European languages use, that's just confusing;
 - There's at least some historical basis, or they hark back in some reasonable way to an historical usage.

So what I landed on was a variation on an historical practice used in classical Greece, where some of the alphabetic characters were pressed into alternate service as numerals but putting a little apostrophe-like tic after the letter. I've modified that plan in a couple ways:

 - Drop the tic mark, assume the non-numeric text is in Roman characters, because that's what I use for most things;
 - Use omicron-bar ("Ō, LATIN CAPITAL LETTER O WITH MACRON"," Unicode 0147) to be a proper placeholder zero, something that had not yet caught on in Greece at the time;
 - Put chi and psi to work as numerals for ten and eleven.
 - Rename 'ten' to 'dek', and 'eleven' to 'elf'. Because I like how it sounds. Other dozenalists were doing it, and it's nice.
 
 So now you've got a complete kit for counting in dozenal numbers. You're welcome.
 
    zero    U+014C      Ō, LATIN CAPITAL LETTER O WITH MACRON
    one     U+0391      Α, GREEK CAPITAL LETTER ALPHA
    two     U+0392      Β, GREEK CAPITAL LETTER BETA
    three   U+0393}     Γ, GREEK CAPITAL LETTER GAMMA
    four    U+0394      Δ, GREEK CAPITAL LETTER DELTA
    five    U+0395      Ε, GREEK CAPITAL LETTER EPSILON
    six     U+03DA      Ϛ, GREEK LETTER STIGMA
    seven   U+0396      Ζ, GREEK CAPITAL LETTER ZETA
    eight   U+0397      Η, GREEK CAPITAL LETTER ETA
    nine    U+0398      Θ, GREEK CAPITAL LETTER THETA
    dek     U+03A7      Χ, GREEK CAPITAL LETTER CHI
    elf     U+03A8      Ψ, GREEK CAPITAL LETTER PSI
