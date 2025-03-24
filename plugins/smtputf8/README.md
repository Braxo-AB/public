# Route some emails to a specific connector

As of version 8.0.4, EMG supports internationalized email addresses, as specified by RFCs 6530 and 6531.
The most important case is when the username part contains a non-ascii character, such as `åsa@example.se`.
Such destinations can only be used with SMTP servers supporting the `SMTPUTF8` extension.
If your default downstreams SMTP server supports that, you do not need to do anything.
However, you may have a situation where your default SMTP server does not support this, but you have a secondary server that does.
It may be more expensive, preventing it from being your primary server.
In this case you can use the plugin here.

## Usage

Let's say you have two outgoing SMTP servers, named `smtp-out-primary` and `smtp-out-utf8`.
You're using a routing file to route destinations containing the '@' character to `smtp-out-primary`:

````
>/.*@.*  smtp-out-primary
````

Now you tell EMG about this new plugin.

````
PLUGIN smtputf8 <
LIBRARY=smtputf8.pl
>
````

Next, let it redirect messages that require it.
You do this by adding a new line before the existing one.

````
!smtputf8
>/.*@.*  smtp-out-primary
````

If the destination address does not contain a '@' character, or the username contains only ascii characters, the plugin just returns 0 and let the rule(s) below make a decision.

