# Slides

This repository hosts code for several presentations I've given/intend to give.
I use [`reveal-md`](https://github.com/webpro/reveal-md) to turn my Markdown files
into web-based presentations using [`reveal.js`](https://revealjs.com/).

Assuming you have `reveal-md` installed, any presentation here can be built 
using
```
reveal-md <path to .md file> -w
``` 
from the project root. All presentations are under `slides/`, each in their own
directory. This particular command watches the file, and opens the web browser
to the presentation.

# Deploying

Made simple using the `deploy.sh` script in the repository root. Make sure to
also pass a commit message!
