Constituent-Parser
------------------

The constituent parser wraps several other constituent parsers into a component that parses the 6 main opener languages. Each language uses it's own parser and core. For more information on the specific languages, please check the individual cores.

* [English, Spanish and French](https://github.com/opener-project/constituent-parser-base) - OpeNER
* [German](https://github.com/opener-project/constituent-parser-de) - Stanford Based
* [Dutch](https://github.com/opener-project/constituent-parser-nl-) - Alpino Based


### Confused by some terminology?

This software is part of a larger collection of natural language processing tools known as "the OpeNER project". You can find more information about the project at [the OpeNER portal](http://opener-project.github.io). There you can also find references to terms like KAF (an XML standard to represent linguistic annotations in texts), component, cores, scenario's and pipelines.

Quick Use Example
-----------------

Installing the constituent-parser can be done by executing:

    gem install opener-constituent-parser

Please bare in mind that all components in OpeNER take KAF as an input and output KAF by default.

### Command line interface

You should now be able to call the constituent parser as a regular shell command: by its name. Once installed the gem normalyl sits in your path so you can call it directly from anywhere.

This aplication reads a text from standard input in order to identify the language.

    cat some_kind_of_kaf_file.kaf | constituent-parser


This is an excerpt of an example output:

```
<!--he-->
      <t id="ter761">
        <span>
          <target id="t761" />
        </span>
      </t>
      <!--added-->
      <t id="ter762">
        <span>
          <target id="t762" />
        </span>
      </t>
      <!--.-->
      <t id="ter763">
        <span>
          <target id="t763" />
        </span>
      </t>
      <!--Tree edges-->
      <edge id="tre2051" from="nter1328" to="nter1327" />
      <edge id="tre2052" from="nter1329" to="nter1328" />
      <edge id="tre2053" from="nter1330" to="nter1329" />
      <edge id="tre2054" from="nter1331" to="nter1330" head="yes" />
      <edge id="tre2055" from="nter1332" to="nter1331" head="yes" />
      <edge id="tre2056" from="nter1333" to="nter1332" />

```

### Webservices

You can launch a language identification webservice by executing:

    constituent-parser-server

This will launch a mini webserver with the webservice. It defaults to port 9292, so you can access it at <http://localhost:9292>.

To launch it on a different port provide the `-p [port-number]` option like this:

    constituent-parser-server -p 1234

It then launches at <http://localhost:1234>

Documentation on the Webservice is provided by surfing to the urls provided above. For more information on how to launch a webservice run the command with the ```-h``` option.

### Daemon

Last but not least the constituent parser comes shipped with a daemon that can read jobs (and write) jobs to and from Amazon SQS queues. For more information type:

    constituent-parser-daemon -h


Description of dependencies
---------------------------

This component runs best if you run it in an environment suited for OpeNER components. You can find an installation guide and helper tools in the [OpeNER installer](https://github.com/opener-project/opener-installer) and an
[installation guide on the Opener Website](http://opener-project.github.io/getting-started/how-to/local-installation.html)

At least you need the following system setup:

### Depenencies for normal use:

* Jruby (1.7.9 or newer)
* Java 1.7 or newer (There are problems with encoding in older versions).
* Python 2.6

If you want to use the Dutch constituent parser you need to have:

* Alpino <http://www.let.rug.nl/vannoord/alp/Alpino/AlpinoUserGuide.html>

Language Extension
------------------

  TODO


Where to go from here
---------------------

* [Check the project websitere](http://opener-project.github.io)
* [Checkout the webservice](http://opener.olery.com/constituent-parser)

Report problem/Get help
-----------------------

If you encounter problems, please email support@opener-project.eu or leave an issue in the 
[issue tracker](https://github.com/opener-project/constituent-parser/issues).


Contributing
------------

1. Fork it <http://github.com/opener-project/constituent-parser/fork>
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


