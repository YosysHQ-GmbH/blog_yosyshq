Hugo Source for YosysHQ Blog
============================

Installing Hugo (Unbuntu 20.4 LTS)
----------------------------------

    $ sudo snap install hugo

Instructions for viewing locally
--------------------------------

    $ git clone --recursive git@github.com:YosysHQ-GmbH/blog_yosyshq.git
    $ cd blog_yosyshq
    $ hugo server

Now open http://localhost:1313/ in your browser.

Whenever you safe a change to a file, the perview in your browser is updated
in real time.

Instructions for building static files
--------------------------------------

Simply build the static files and placing them in `public/` is easy:

    $ hugo -e production

However, if you also want to push your changes it's recommended to use
the `build.sh` script instead (make sure `public/` doesn't exist yet when
running `build.sh` for the first time:

    $ bash build.sh

Finally, pushing your changes to the life website:

    $ bash publish.sh

