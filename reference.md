## Reference

### Command Line Interface

    cat some_kind_of_kaf_file.kaf | constituent-parser

This is an excerpt of an example output:

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

### Webservice

You can launch a webservice by executing:

    constituent-parser-server

After launching the server, you can reach the webservice at
<http://localhost:9292>.

The webservice takes several options that get passed along to
[Puma](http://puma.io), the webserver used by the component. The options are:

    -h, --help                Shows this help message
        --puma-help           Shows the options of Puma
    -b, --bucket              The S3 bucket to store output in
        --authentication      An authentication endpoint to use
        --secret              Parameter name for the authentication secret
        --token               Parameter name for the authentication token
        --disable-syslog      Disables Syslog logging (enabled by default)

### Daemon

The daemon has the default OpeNER daemon options. Being:

    Usage: constituent-parser-daemon <start|stop|restart> [options]

When calling constituent-parser without `<start|stop|restart>` the daemon will
start as a foreground process.

Daemon options:

    -h, --help                Shows this help message
    -i, --input               The name of the input queue (default: opener-constituent-parser)
    -b, --bucket              The S3 bucket to store output in (default: opener-constituent-parser)
    -P, --pidfile             Path to the PID file (default: /var/run/opener/opener-constituent-parser-daemon.pid)
    -t, --threads             The amount of threads to use (default: 10)
    -w, --wait                The amount of seconds to wait for the daemon to start (default: 3)
        --disable-syslog      Disables Syslog logging (enabled by default)

#### Environment Variables

These daemons make use of Amazon SQS queues and other Amazon services. For these
services to work correctly you'll need to have various environment variables
set. These are as following:

* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`
* `AWS_REGION`

For example:

    AWS_REGION='eu-west-1' language-identifier start [other options]

### Languages

The constituent parser supports the following languages:

* Dutch (nl) (If you have Alpino installed)
* English (en)
* French (fr)
* German (de)
* Italian (it)
* Spanish (es)
