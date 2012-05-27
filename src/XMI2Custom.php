<?php
class XMI2Custom
{
    public static function transform( $code )
    {
        $xml = new DOMDocument('1.0','UTF-8');
        $xml->loadXML($code);

        $xsl = new DOMDocument('1.0','UTF-8');
        $xsl->load(dirname(__FILE__). '/xmi-to-custom.xsl');

        return self::xsltransformation($xml, $xsl);
    }

    private static function xsltransformation($xml, $xsl)
    {
        $xslt = new XSLTProcessor();
        $xslt->importStylesheet($xsl);

        return $xslt->transformToXml($xml);
    }
}
