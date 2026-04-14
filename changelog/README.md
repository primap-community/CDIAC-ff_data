# CHANGELOG

This directory contains "news fragments" for `towncrier`, i.e. short files that contain a small markdown-formatted bits of text that will be added to the CHANGELOG when it is next compiled using `towncrier`.

The CHANGELOG will also be read by users, so the
th description should be aimed to FAOSTAT data users instead of describing internal changes which are only relevant to developers. Merge requests in combination with our git history provides additional
developer-centric information.

Make sure to use phrases in the past tense and use punctuation, examples:

```
Added new dataset release v2017 available under doi:test.1234

Improved documentation of sector mapping.
```

Each file should have a name of the form `<MR>.<TYPE>.md`, where `<MR>` is the merge request number, and `<TYPE>` is one of:

* `version`: new version of the input dataset
* `feature`: new user facing features, like new command-line options and new behaviour.
* `improvement`: improvement of existing functionality, usually without requiring user intervention
* `fix`: fixes a bug.
* `docs`: documentation improvement, like rewording an entire section or adding missing docs.
* `deprecation`: feature deprecation.
* `breaking`: a change which may break existing uses, such as feature removal or behaviour change or data format or coverage change.
* `trivial`: fixing a small typo or internal change that might be noteworthy.

So for example: `123.feature.md`, `456.fix.md`.

Since you need the merge request number for the filename, you must submit a MR first. From this MR, you can get the MR number and then create the news file. A single MR can also have multiple news items, for example a given MR may add a feature as well as
deprecate some existing functionality.

If you are not sure what issue type to use, don't hesitate to ask in your MR.

`towncrier` preserves multiple paragraphs and formatting (code blocks, lists, and so on), but for entries other than features it is usually better to stick to a single paragraph to keep it concise.

You can also run `towncrier build --draft` to see the draft changelog that will be appended to [changelog.md]() on the next release.
