# Custom options over SMPP

Some operators want additional information sent as the custom TLVs between 0x1400 and 0xFFFF.
One way to do this is to add a `before_send()` plugin to the connector.
Such a plugin, as the one shown here, would set the `$sms->{SMPPOPTION}` to a string in the format `key:hexvalue`, where `hexvalue` is the hex encoded version of the value.
If multiple values need to be sent, `$sms->{SMPPOPTION}` can instead be set to an array of such strings.

