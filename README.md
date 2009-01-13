Hoster
=====

Summary
-------

A *cross-platform* gem that allows you to create, list, and modify local hostnames with ease. This gem was inspired by (and largely based on) the [ghost gem](http://github.com/bjeanes/ghost/tree/master) by Bodaniel Jeanes.

Hoster directly modifies the *hosts* file on you machine to add/remove entries. Because of this, Hoster must be executed as root user (or via *sudo*)


Usage
-----

    $ hoster add testsite.com (defaults to 127.0.0.1)
      
    $ hoster add testsite.com 192.168.1.150
      
    $ hoster modify testsite.com 192.168.1.149
      
    $ hoster remove testsite.com
      
    $ hoster list (prints entire hosts file)
    
    $ hoster list 127.0.0.1


Installation
------------

    sudo gem install sant0sk1-hoster --source http://gems.github.com/


License
-------

Copyright (c) 2009 Jerod Santo

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.