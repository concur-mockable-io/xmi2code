<?php

require_once 'src/XMI2Custom.php';

class DonkeyTest extends PHPUnit_Framework_TestCase
{
    /**
     * @var string
     */
    protected $result;

    protected function setUp()
    {
        $xmi_code     = file_get_contents(dirname(__FILE__) . '/sample.xmi');

        use synap;

        $transformer  = new XMI2Custom();
        $this->result = $transformer->transform($xmi_code);
    }

    protected function tearDown()
    {
    }

    public function testSchema()
    {
        $dom = new DOMDocument('1.0','UTF-8');
        $dom->loadXML( $this->result );
        $this->assertTrue($dom->schemaValidate(dirname(__FILE__) . '/custom.xsd'));
    }
}
