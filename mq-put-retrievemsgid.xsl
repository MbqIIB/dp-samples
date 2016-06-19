<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dp="http://www.datapower.com/extensions"
	extension-element-prefixes="dp" version="1.0">

<xsl:output method="xml" encoding="utf-8" />

<xsl:template match="/">

    <!-- PUT "THREE" test messages -->
    <xsl:variable name="put-result-1">
        <dp:url-open target="dpmq://QMGR/?RequestQueue=Q1.REPLY;ParseHeaders=true" 
            response="responsecode-ignore">
            <msg>1st msg</msg>
        </dp:url-open>
    </xsl:variable>

    <xsl:if test="$put-result-1/responsecode != '0'">
        <!-- error handling -->
        <dp:reject>MQ PUT ERROR</dp:reject>
    </xsl:if>

    <!-- extract mqmd -->
    <xsl:variable name="response-mqmd">
       <dp:parse select="$put-result-1//header[@name='MQMD']"/>
    </xsl:variable>


    <xsl:message dp:priority="critic">
        The message id of put is = <xsl:value-of select="$response-mqmd//MsgId" />
    </xsl:message>
        
</xsl:template>
</xsl:stylesheet>