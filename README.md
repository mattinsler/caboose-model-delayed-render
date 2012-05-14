# caboose-model-delayed-render

  Caboose plugin that adds delayed rendering to
  [caboose-model](http://www.caboosejs.com/plugins/caboose-model).
  
  Model queries return a promise object that can be listened to for
  completion.  This plugin intercepts the `@render` method in controllers
  and waits for all view-accessible promises to complete before attempting
  to actually render.

## Installation

  From a caboose project directory

    $ caboose plugin install caboose-model-delayed-render

## Basic Usage

```coffeescript
import 'User'
import 'ApplicationController'

class UsersController extends ApplicationController
  index: ->
    @users = User.array()
    @render()
```

## License

(The MIT License)

Copyright (c) 2012 mattinsler &lt;mattinsler@gmail.com&gt;

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.