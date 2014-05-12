== unraveled
[unraveled](unraveled.schenkc.com) is a clone of (ravelry)[www.ravelry.com].  Unraveled was made by (Candace Schenk)[schenkc.com] in the spring of 2014.


=== What is ravelry?

TO quote them: Ravelry is a place for knitters, crocheters, designers, spinners, weavers and dyers to keep track of their yarn, tools, project and pattern information, and look to others for ideas and inspiration.

=== unraveled's features

Unraveled is smaller in scope, with socail features more prominent.

* adding and tagging patterns

* searching, patterns, tags, and users

* photo and pdf uploading

* notifications

* messaging

* following

* collection other people's patterns

=== technologies used

The backend is Ruby on Rails.

The frontend has a little backbone.  All styling was done by hand using CSS.  The HTML is semantic.

* the form for adding a patter is a nested form, which makes associated tags, adds multiple photos, and file instruction upload.  File upload is handled using paperclip and AWS.

* searching is implamented using gp-search and displayed using kaminari

* notifications is implamented using a polymorphic model and some hand crafted callbacks.

* the messaging section is a full backbone.js installation.  Multiple collections of data are bootstrapped in.

=== TODO

* voting/rating list trending patterns and users

* password recovery/change email

* add icons

* photo carasels for patterns show page
