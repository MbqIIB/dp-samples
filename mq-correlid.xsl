<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dp="http://www.datapower.com/extensions"
	extension-element-prefixes="dp" version="1.0">

<xsl:output method="xml" encoding="utf-8" />

<xsl:template match="/">

    <!-- PUT "THREE" test messages -->
    <xsl:variable name="mqmd-1">
        <MQMD>
            <CorrelId><xsl:value-of select="'900000000000000000000000000000000000000000000009'"/></CorrelId>
        </MQMD>
    </xsl:variable>
    <xsl:variable name="headers-1">
        <header name="X-MQMD-Put"><dp:serialize select="$mqmd-1" omit-xml-decl="yes" /></header>
    </xsl:variable>
    <xsl:variable name="put-result-1">
        <dp:url-open target="dpmq://QMGR/?RequestQueue=Q1.REPLY;ParseHeaders=true" http-headers="$headers-1" response="responsecode-ignore">
            <msg>1st msg without CorrelId</msg>
        </dp:url-open>
    </xsl:variable>
    <xsl:variable name="put-result-2">
        <dp:url-open target="dpmq://QMGR/?RequestQueue=Q1.REPLY" http-headers="$headers-1" response="responsecode-ignore">
            <msg>2nd msg with CorrelId</msg>
        </dp:url-open>
    </xsl:variable>
    <xsl:variable name="put-result-3">
        <dp:url-open target="dpmq://QMGR/?RequestQueue=Q1.REPLY" http-headers="$headers-3" response="responsecode-ignore">
            <msg>3rd msg with CorrelId</msg>
        </dp:url-open>
    </xsl:variable>
    <xsl:message dp:priority="critic">
        The message id of 1st put is = <xsl:copy-of select="$put-result-1//header[@name='MQMD']/MDMD/MsgId" />
    </xsl:message>
    <!-- GET messages with CorrelId -->
    <xsl:variable name="mqmd">
        <MQMD>
            <!--<CorrelId><xsl:value-of select="$put-result//MQMD/MsgId"/></CorrelId>-->
            <CorrelId><xsl:value-of select="'900000000000000000000000000000000000000000000009'"/></CorrelId>
        </MQMD>
    </xsl:variable>
    
    <xsl:variable name="headers">
        <header name="X-MQMD-Get"><dp:serialize select="$mqmd" omit-xml-decl="yes" /></header>
    </xsl:variable>
    <!-- should get the 2nd message with CorrelId -->
    <dp:url-open target="dpmq://QMGR/?ReplyQueue=Q1.REPLY" http-headers="$headers" />
    <!-- should get the 3rd message with CorrelId -->
    <dp:url-open target="dpmq://QMGR/?ReplyQueue=Q1.REPLY" http-headers="$headers" />
        
</xsl:template>
</xsl:stylesheet>